DROP FUNCTION IF EXISTS private.follow_user;
DROP TYPE IF EXISTS followUserMutationInput;
CREATE TYPE followUserMutationInput as (user_id uuid, follower_id uuid);
CREATE FUNCTION private.follow_user(f followUserMutationInput) RETURNS SETOF private.follower AS $$
INSERT INTO private.follower (user_id, follower_id)
SELECT f.user_id,
  f.follower_id
RETURNING *;
$$ LANGUAGE sql VOLATILE STRICT SECURITY DEFINER;
