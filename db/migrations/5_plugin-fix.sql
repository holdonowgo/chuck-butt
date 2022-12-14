-- COMMENT ON TABLE "private"."follower" IS E'@name followers';
COMMENT ON CONSTRAINT "fk_follower_id" ON "private"."follower" IS E'@fieldName follower_user';
