DROP FUNCTION IF EXISTS private.follow_user;
CREATE FUNCTION private.follow_user(f followUserMutationInput) RETURNS SETOF private.follower AS $$
INSERT INTO private.follower (user_id, follower_id)
SELECT f.user_id,
  f.follower_id
RETURNING *;
$$ LANGUAGE sql VOLATILE STRICT SECURITY DEFINER;
