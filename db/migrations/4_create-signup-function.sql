DROP FUNCTION IF EXISTS SIGNUP;
-- CREATE FUNCTION SIGNUP(username TEXT, email TEXT, password TEXT) RETURNS jwt_token AS $$
--   DECLARE token_information public.jwt_token;
--     BEGIN
--       INSERT INTO private.users (name, email, password)
--       VALUES ($1, $2, crypt($3, gen_salt('md5')));
--       SELECT 'anonymous',
--         extract(
--           epoch
--           from now() + interval '7 days'
--         ),
--         uuid,
--         is_admin,
--         username
--         INTO token_information
--       FROM private.users
--       WHERE email = $2;
--       RETURN token_information::public.jwt_token;
-- END;
-- $$ LANGUAGE PLPGSQL VOLATILE SECURITY DEFINER;
-- grant permissions to be able to sign up
--
-- GRANT EXECUTE ON FUNCTION SIGNUP(username TEXT, email TEXT, password TEXT) TO anonymous;
CREATE FUNCTION SIGNUP(username TEXT, email TEXT, password TEXT) RETURNS jwt_token AS $$
DECLARE token_information jwt_token;
BEGIN
INSERT INTO private.users (username, email, password_hash)
VALUES ($1, $2, crypt($3, gen_salt('bf', 8)));
SELECT 'anonymous',
  extract(
    epoch
    from now() + interval '7 days'
  ),
  uuid,
  is_admin,
  private.users.username INTO token_information
FROM private.users
WHERE users.email = $2;
RETURN token_information::jwt_token;
END;
$$ LANGUAGE PLPGSQL VOLATILE SECURITY DEFINER;
-- grant permissions to be able to sign up
--
GRANT EXECUTE ON FUNCTION SIGNUP(username TEXT, email TEXT, password TEXT) TO anonymous;