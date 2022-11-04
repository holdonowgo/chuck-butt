DROP FUNCTION IF EXISTS public.signup;
DROP TYPE IF EXISTS public.jwt_token;
CREATE TYPE public.jwt_token as (
  role text,
  exp integer,
  uuid uuid,
  is_admin boolean,
  username varchar
);
CREATE FUNCTION public.signup(username TEXT, email TEXT, password TEXT) RETURNS jwt_token AS $$
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
  uuid,
  is_admin,
  username INTO token_information
FROM private.user
WHERE email = $2;
RETURN token_information::jwt_token;
END;
$$ LANGUAGE PLPGSQL VOLATILE SECURITY DEFINER;
-- grant permissions to be able to sign up
--
GRANT EXECUTE ON FUNCTION signup(username TEXT, email TEXT, password TEXT) TO anonymous;