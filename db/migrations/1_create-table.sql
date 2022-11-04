CREATE EXTENSION IF NOT EXISTS pgcrypto;
DROP TABLE IF EXISTS private.post CASCADE;
DROP TABLE IF EXISTS private.follower CASCADE;
DROP TABLE IF EXISTS private.user CASCADE;
DROP TABLE IF EXISTS private.retweet CASCADE;
DROP TABLE IF EXISTS private.timeline CASCADE;
DROP TABLE IF EXISTS private.bookmark CASCADE;
DROP TABLE IF EXISTS private.comment CASCADE;
CREATE TABLE IF NOT EXISTS private.user (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  username varchar NOT NULL CHECK (username <> '') UNIQUE,
  email text NOT NULL CHECK (email <> '') UNIQUE,
  is_admin boolean DEFAULT(false),
  password_hash text NOT NULL,
  bio text,
  dob date,
  created_at timestamptz DEFAULT current_timestamp,
  profile_img text DEFAULT('https://i.imgur.com/1Q9ZQ1r.png'),
  bg_img text DEFAULT('https://i.imgur.com/1Q9ZQ1r.png')
);
CREATE TABLE IF NOT EXISTS private.post (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  content varchar(280) NOT NULL CHECK (content <> ''),
  user_id uuid NOT NULL,
  created_at timestamptz DEFAULT current_timestamp,
  img text,
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.user(uuid)
);
CREATE TABLE IF NOT EXISTS private.retweet (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid NOT NULL,
  tweet_id uuid NOT NULL,
  created_at timestamptz DEFAULT current_timestamp,
  content varchar(280) NOT NULL CHECK (content <> ''),
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.user(uuid),
  CONSTRAINT fk_tweet_id FOREIGN KEY(tweet_id) REFERENCES private.post(uuid)
);
CREATE TABLE IF NOT EXISTS private.timeline (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  tweet_id uuid NOT NULL,
  retweet_id uuid NOT NULL,
  created_at timestamptz DEFAULT current_timestamp,
  CONSTRAINT fk_tweet_id FOREIGN KEY(tweet_id) REFERENCES private.post(uuid),
  CONSTRAINT fk_retweet_id FOREIGN KEY(retweet_id) REFERENCES private.retweet(uuid)
);
CREATE TABLE IF NOT EXISTS private.bookmark (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid NOT NULL,
  tweet_id uuid NOT NULL,
  created_at timestamptz DEFAULT current_timestamp,
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.user(uuid),
  CONSTRAINT fk_tweet_id FOREIGN KEY(tweet_id) REFERENCES private.post(uuid)
);
CREATE TABLE IF NOT EXISTS private.comment (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  post_id uuid NOT NULL,
  user_id uuid NOT NULL,
  comment text NOT NULL,
  created_on timestamptz DEFAULT current_timestamp,
  CONSTRAINT fk_post_id FOREIGN KEY(post_id) REFERENCES private.post(uuid),
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.user(uuid)
);
CREATE TABLE IF NOT EXISTS private.follower (
  uuid uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  follower_id uuid NOT NULL CHECK (follower_id <> user_id),
  CONSTRAINT fk_follower_id FOREIGN KEY(follower_id) REFERENCES private.user(uuid),
  user_id uuid NOT NULL CHECK (user_id <> follower_id),
  CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES private.user(uuid)
);