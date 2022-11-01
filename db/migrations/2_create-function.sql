DROP FUNCTION IF EXISTS private.follow_user;
DROP TYPE IF EXISTS private.followUserMutationInput;
CREATE TYPE private.followUserMutationInput as (user_id uuid, follower_id uuid);
CREATE FUNCTION private.follow_user(f followUserMutationInput) RETURNS SETOF private.followers AS $$
INSERT INTO private.followers (user_id, follower_id)
SELECT f.user_id,
  f.follower_id
RETURNING *;
$$ LANGUAGE sql VOLATILE STRICT SECURITY DEFINER;