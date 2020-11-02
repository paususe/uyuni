INSERT INTO rhnVirtualInstanceType (id, name, label)
SELECT sequence_nextval('rhn_vit_id_seq'), 'NetBox', 'netbox'
WHERE NOT EXISTS ( SELECT 1 FROM rhnVirtualInstanceType WHERE label = 'netbox' AND name = 'NetBox');
