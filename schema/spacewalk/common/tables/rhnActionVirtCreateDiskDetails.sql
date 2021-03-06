--
-- Copyright (c) 2018 SUSE LLC
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
--
-- Red Hat trademarks are not licensed under GPLv2. No permission is
-- granted to use or replicate Red Hat trademarks that are incorporated
-- in this software or its documentation.
--

CREATE TABLE rhnActionVirtCreateDiskDetails
(
    id                   NUMBER NOT NULL
                             CONSTRAINT rhn_action_virt_create_disk_details_id_pk
                                 PRIMARY KEY,
    type                 VARCHAR2(15),
    device               VARCHAR2(10),
    template             VARCHAR2(256),
    size                 NUMBER,
    bus                  VARCHAR2(10),
    pool                 VARCHAR2(256),
    source_file          VARCHAR2(1024),
    idx                  NUMBER,
    action_id            NUMBER NOT NULL
                             CONSTRAINT rhn_action_virt_create_disk_details_aid_fk
                                 REFERENCES rhnActionVirtCreate (action_id)
                                 ON DELETE CASCADE
)
ENABLE ROW MOVEMENT
;

CREATE INDEX rhn_action_virt_create_disk_details_id_idx
    ON rhnActionVirtCreateDiskDetails (id)
    TABLESPACE [[4m_tbs]];

CREATE SEQUENCE rhn_action_virt_create_disk_details_id_seq;
