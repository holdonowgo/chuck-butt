CREATE EXTENSION IF NOT EXISTS pgcrypto;
DROP TABLE IF EXISTS private.tweets CASCADE;
DROP TABLE IF EXISTS private.followers CASCADE;
DROP TABLE IF EXISTS private.users CASCADE;
CREATE TABLE IF NOT EXISTS private.users (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  username varchar NOT NULL CHECK (username <> ''),
  email text NOT NULL CHECK (email <> ''),
  is_admin boolean DEFAULT(false),
  password_hash text NOT NULL
);
CREATE TABLE IF NOT EXISTS private.tweets (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  content varchar(280) NOT NULL CHECK (content <> ''),
  user_id uuid NOT NULL,
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.users(uuid)
);
CREATE TABLE IF NOT EXISTS private.followers (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  follower_id uuid NOT NULL CHECK (follower_id <> user_id),
  CONSTRAINT fk_follower_id FOREIGN KEY(follower_id) REFERENCES private.users(uuid),
  user_id uuid NOT NULL CHECK (user_id <> follower_id),
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.users(uuid)
);