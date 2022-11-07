DROP FUNCTION IF EXISTS public.signup;
DROP FUNCTION IF EXISTS public.authenticate;
DROP TYPE IF EXISTS public.jwt_token;
CREATE TYPE public.jwt_token as (
  role text,
  exp integer,
  uuid uuid,
  is_admin boolean,
  username varchar
);
CREATE FUNCTION public.signup(
  username TEXT,
  email TEXT,
  password TEXT,
  bio TEXT,
  dob DATE,
  profile_img TEXT,
  bg_img TEXT
) RETURNS jwt_token AS $$
DECLARE token_information jwt_token;
BEGIN
INSERT INTO private.user (
    username,
    email,
    password_hash,
    bio,
    dob,
    profile_img,
    bg_img
  )
VALUES (
    $1,
    $2,
    crypt($3, gen_salt('md5')),
    $4,
    $5,
    $6,
    $7
  );
SELECT 'anonymous',
  extract(
    epoch
    from now() + interval '7 days'
  ),
  u.uuid,
  u.is_admin,
  u.username INTO token_information
FROM private.user as u
WHERE u.email = $2;
RETURN token_information::jwt_token;
END;
$$ LANGUAGE PLPGSQL VOLATILE SECURITY DEFINER;
-- grant permissions to be able to sign up
--
GRANT EXECUTE ON FUNCTION signup(username TEXT, email TEXT, password TEXT, bio TEXT, dob DATE, profile_img TEXT, bg_img TEXT) TO anonymous;
CREATE function public.authenticate(email text, password text) returns public.jwt_token as $$
declare account private.user;
begin
select a.* into account
from private.user as a
where a.email = authenticate.email;
if account.password_hash = crypt(password, account.password_hash) then return (
  'person_role',
  extract(
    epoch
    from now() + interval '7 days'
  ),
  account.uuid,
  account.is_admin,
  account.username
)::public.jwt_token;
else return null;
end if;
end;
$$ language plpgsql strict security definer;