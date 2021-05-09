insert into rhnPackageProvider (id, name)
    (select sequence_nextval('rhn_package_provider_id_seq'), 'Microsoft' from dual
    where not exists (select 1 from rhnPackageProvider where name = 'Microsoft'));

commit;
