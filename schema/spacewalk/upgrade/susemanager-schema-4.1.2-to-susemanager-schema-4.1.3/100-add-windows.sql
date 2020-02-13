insert into rhnArchType (id, label, name) values
	(sequence_nextval('rhn_archtype_id_seq'), 'msu', 'MSU')
	ON CONFLICT(label) DO NOTHING;

insert into rhnArchType (id, label, name) values
	(sequence_nextval('rhn_archtype_id_seq'), 'msi', 'MSI')
	ON CONFLICT(label) DO NOTHING;

insert into rhnChannelArch (id, label, name, arch_type_id) values
	(sequence_nextval('rhn_channel_arch_id_seq'), 'channel-amd64-msu', 'AMD64 Windows updates', lookup_arch_type('msu'))
	ON CONFLICT(label) DO NOTHING;

insert into rhnChannelArch (id, label, name, arch_type_id) values
	(sequence_nextval('rhn_channel_arch_id_seq'), 'channel-amd64-msi', 'AMD64 Windows installers', lookup_arch_type('msi'))
	ON CONFLICT(label) DO NOTHING;

INSERT into suseServerContactMethod (id, label, name, rank) values
	(3, 'windows', 'server.contact-method.windows', 30)
	ON CONFLICT(label) DO NOTHING;

insert into rhnPackageArch (id, label, name, arch_type_id) values
	(sequence_nextval('rhn_package_arch_id_seq'), 'amd64-msu', 'amd64-msu', lookup_arch_type('msu'))
	ON CONFLICT(label) DO NOTHING;

insert into rhnPackageArch (id, label, name, arch_type_id) values
	(sequence_nextval('rhn_package_arch_id_seq'), 'amd64-msi', 'amd64-msi', lookup_arch_type('msi'))
	ON CONFLICT(label) DO NOTHING;

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnChannelPackageArchCompat (channel_arch_id, package_arch_id) values 
	(LOOKUP_CHANNEL_ARCH('channel-amd64-msu'), LOOKUP_PACKAGE_ARCH('amd64-msu'));

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnChannelPackageArchCompat (channel_arch_id, package_arch_id) values 
	(LOOKUP_CHANNEL_ARCH('channel-amd64-msi'), LOOKUP_PACKAGE_ARCH('amd64-msi'));

insert into rhnContentSourceType (id, label) values
	(sequence_nextval('rhn_content_source_type_id_seq'), 'msu')
	ON CONFLICT (label) DO NOTHING;

insert into rhnContentSourceType (id, label) values
	(sequence_nextval('rhn_content_source_type_id_seq'), 'msi')
	ON CONFLICT (label) DO NOTHING;

insert into rhnServerArch (id, label, name, arch_type_id) values
	(sequence_nextval('rhn_server_arch_id_seq'), 'amd64-windows', 'amd64 Windows', lookup_arch_type('msu'))
	ON CONFLICT (label) DO NOTHING;

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnPackageUpgradeArchCompat (package_arch_id, package_upgrade_arch_id, created, modified) values (LOOKUP_PACKAGE_ARCH('amd64-msu'), LOOKUP_PACKAGE_ARCH('amd64-msu'), current_timestamp, current_timestamp);

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnPackageUpgradeArchCompat (package_arch_id, package_upgrade_arch_id, created, modified) values (LOOKUP_PACKAGE_ARCH('amd64-msi'), LOOKUP_PACKAGE_ARCH('amd64-msi'), current_timestamp, current_timestamp);

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnServerPackageArchCompat
(server_arch_id, package_arch_id, preference) values
(LOOKUP_SERVER_ARCH('amd64-windows'), LOOKUP_PACKAGE_ARCH('amd64-msu'), 0);

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnServerPackageArchCompat
(server_arch_id, package_arch_id, preference) values
(LOOKUP_SERVER_ARCH('amd64-windows'), LOOKUP_PACKAGE_ARCH('amd64-msi'), 0);

insert into rhnPackageProvider (id, name) values
	(sequence_nextval('rhn_package_provider_id_seq'), 'Microsoft Corp' )
	ON CONFLICT(id) DO NOTHING;

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnChildChannelArchCompat (parent_arch_id, child_arch_id)
values (LOOKUP_CHANNEL_ARCH('channel-amd64-msu'), LOOKUP_CHANNEL_ARCH('channel-amd64-msu'));

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnChildChannelArchCompat (parent_arch_id, child_arch_id)
values (LOOKUP_CHANNEL_ARCH('channel-amd64-msi'), LOOKUP_CHANNEL_ARCH('channel-amd64-msi'));

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnServerChannelArchCompat (server_arch_id, channel_arch_id) values
(LOOKUP_SERVER_ARCH('amd64-windows'), LOOKUP_CHANNEL_ARCH('channel-amd64-msu'));

-- TODO MICROSOFTWINDOWS This is not idempotent
insert into rhnServerChannelArchCompat (server_arch_id, channel_arch_id) values
(LOOKUP_SERVER_ARCH('amd64-windows'), LOOKUP_CHANNEL_ARCH('channel-amd64-msi'));
