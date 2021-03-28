insert into rhnPackageProvider (id, name)
    (select sequence_nextval('rhn_package_provider_id_seq'), 'Microsoft' from dual
    where not exists (select 1 from rhnPackageProvider where name = 'Microsoft'));

insert into rhnArchType (id, label, name) values
	(sequence_nextval('rhn_archtype_id_seq'), 'windows', 'Windows')
	ON CONFLICT(label) DO NOTHING;

insert into rhnChannelArch (id, label, name, arch_type_id) values
    (sequence_nextval('rhn_channel_arch_id_seq'), 'channel-amd64-windows', 'AMD64 Windows updates', lookup_arch_type('windows'))
	ON CONFLICT(label) DO NOTHING;

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnChannelPackageArchCompat (channel_arch_id, package_arch_id)
    values (LOOKUP_CHANNEL_ARCH('channel-amd64-windows'), LOOKUP_PACKAGE_ARCH('amd64-windows'));

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnChildChannelArchCompat (parent_arch_id, child_arch_id)
    values (LOOKUP_CHANNEL_ARCH('channel-amd64-windows'), LOOKUP_CHANNEL_ARCH('channel-amd64-windows'));

insert into rhnContentSourceType (id, label) values
    (sequence_nextval('rhn_content_source_type_id_seq'), 'windows')
	ON CONFLICT(label) DO NOTHING;

insert into rhnPackageArch (id, label, name, arch_type_id) values
    (sequence_nextval('rhn_package_arch_id_seq'), 'amd64-windows', 'amd64-windows', lookup_arch_type('windows'))
	ON CONFLICT(label) DO NOTHING;

insert into rhnPackageUpgradeArchCompat (package_arch_id, package_upgrade_arch_id, created, modified) values
    (LOOKUP_PACKAGE_ARCH('amd64-windows'), LOOKUP_PACKAGE_ARCH('amd64-windows'), current_timestamp, current_timestamp)
	ON CONFLICT(label) DO NOTHING;

insert into rhnServerArch (id, label, name, arch_type_id) values
    (sequence_nextval('rhn_server_arch_id_seq'), 'amd64-windows', 'amd64 Windows', lookup_arch_type('windows'))
	ON CONFLICT(label) DO NOTHING;

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnServerChannelArchCompat (server_arch_id, channel_arch_id) values
    (LOOKUP_SERVER_ARCH('amd64-windows'), LOOKUP_CHANNEL_ARCH('channel-amd64-windows'));

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnServerPackageArchCompat
    (server_arch_id, package_arch_id, preference) values
    (LOOKUP_SERVER_ARCH('amd64-windows'), LOOKUP_PACKAGE_ARCH('amd64-windows'), 0);

commit;
