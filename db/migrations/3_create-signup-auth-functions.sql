DROP FUNCTION IF EXISTS public.signup;
DROP FUNCTION IF EXISTS public.authenticate;
DROP TYPE IF EXISTS public.jwt_token;
CREATE TYPE public.jwt_token as (
  role TEXT,
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
GRANT EXECUTE ON FUNCTION public.signup(username TEXT, email TEXT, password TEXT, bio TEXT, dob DATE, profile_img TEXT, bg_img TEXT) TO PUBLIC;
COMMENT ON FUNCTION public.signup(TEXT, TEXT, TEXT, TEXT, DATE, TEXT, TEXT) is 'Registers a single user and creates an account.';
CREATE FUNCTION public.authenticate(email TEXT, password TEXT) returns public.jwt_token as $$
DECLARE account private.user;
BEGIN
SELECT a.* into account
FROM private.user as a
WHERE a.email = authenticate.email;
IF account.password_hash = crypt(password, account.password_hash) then return (
  'person_role',
  extract(
    epoch
    from now() + interval '7 days'
  ),
  account.uuid,
  account.is_admin,
  account.username
)::public.jwt_token;
ELSE return null;
END IF;
END;
$$ LANGUAGE PLPGSQL STRICT SECURITY DEFINER;
GRANT EXECUTE ON FUNCTION public.authenticate(email TEXT, password TEXT) TO PUBLIC;
COMMENT ON FUNCTION public.authenticate(TEXT, TEXT) is 'Creates a JWT token that will securely identify a person and give them certain permissions. This token expires in 7 days.';
