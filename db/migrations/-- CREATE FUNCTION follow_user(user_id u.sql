-- CREATE FUNCTION follow_user(user_id uuid)
-- RETURNS followers
-- AS $$
--   INSERT followers
--     SET followers.user_id = user_id
--     RETURNING *;
-- $$ LANGUAGE sql VOLATILE STRICT SECURITY DEFINER;
-- create type followUserMutationInput as (user_id uuid, follower_id uuid);
-- CREATE FUNCTION follow_user(f followUserMutationInput)
-- RETURNS SETOF followers
-- AS $$
--   INSERT INTO followers (user_id, follower_id)
--     SELECT f.user_id, f.follower_id
--     RETURNING *;
-- $$ LANGUAGE sql STRICT VOLATILE;
-- DROP FUNCTION follow_user;
-- INSERT INTO users (name)
-- VALUES ('randall');
-- SELECT
--     pg_type.typname, 
--      pg_enum.enumlabel
-- FROM
--     pg_type 
-- JOIN
--     pg_enum ON pg_enum.enumtypid = pg_type.oid;
-- CREATE TYPE public.jwt_token as (
--   role text,
--   exp integer,
--   uuid uuid,
--   is_admin boolean,
--   username varchar
-- );
-- delete from public.followers;
DROP FUNCTION public.signup;
DROP TABLE IF EXISTS public.migrations;
DROP TABLE IF EXISTS public.tweets;
DROP TABLE IF EXISTS public.followers;
DROP TABLE IF EXISTS public.users;
DROP FUNCTION IF EXISTS public.authenticate;
DROP TABLE IF EXISTS private.migrations;
DROP TABLE IF EXISTS private.tweets;
DROP FUNCTION IF EXISTS private.follow_user;
DROP TABLE IF EXISTS private.followers;
DROP TABLE IF EXISTS private.users;
DROP TYPE public.jwt_token;
-- delete from private.followers;
-- DROP FUNCTION IF EXISTS authenticate;
-- CREATE EXTENSION IF NOT EXISTS pgcrypto;
-- INSERT into private.users values () pswhash = crypt('password', gen_salt('md5'));
-- INSERT INTO private.users (username, email, is_admin, password_hash)
-- VALUES (
--     'randolph',
--     'randallspencer+chuckster@gmail.com',
--     true,
--     crypt('password', gen_salt('md5'))
--   );
-- SELECT password_hash, crypt('password', password_hash) AS whaa FROM private.users where email = 'randallspencer+chuckster@gmail.com'