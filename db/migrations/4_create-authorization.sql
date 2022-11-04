DROP function IF EXISTS public.authenticate;
CREATE function public.authenticate(email text, password text) returns public.jwt_token as $$
declare account private.user;
begin
select a.* into account
from private.user as a
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