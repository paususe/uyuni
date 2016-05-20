-- functional index for rhnServer

CREATE UNIQUE INDEX rhn_server_maid_uq
  ON rhnServer
  (CASE WHEN machine_id IS NULL THEN NULL ELSE machine_id END);