DROP function IF EXISTS public.authenticate;
DROP TYPE IF EXISTS public.jwt_token;
CREATE TYPE public.jwt_token as (
  role text,
  exp integer,
  uuid uuid,
  is_admin boolean,
  username varchar
);
CREATE function public.authenticate(email text, password text) returns public.jwt_token as $$
declare account private.users;
begin
select a.* into account
from private.users as a
where a.email = authenticate.email;
if account.password_hash = crypt(password, account.password_hash) then return (
  'person_role',
  extract(
    epoch
    from now() + interval '7 days'
  ),
  account.uuid,
  account.is_admin,
  account.username
)::public.jwt_token;
else return null;
end if;
end;
$$ language plpgsql strict security definer;