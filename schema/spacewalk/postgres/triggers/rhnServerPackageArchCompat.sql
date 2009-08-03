create or replace function rhn_sp_ac_mod_trig_fun() returns trigger as
$$
begin
	new.modified := current_timestamp;
 	return new;
end;
$$ language plpgsql;

create trigger
rhn_sp_ac_mod_trig
before insert or update on rhnServerPackageArchCompat
for each row
execute procedure rhn_sp_ac_mod_trig_fun();


