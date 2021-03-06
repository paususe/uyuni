--
-- Copyright (c) 2019 SUSE LLC
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
--

CREATE TABLE rhnPackageExtraTag
(
    package_id  NUMBER NOT NULL
                    CONSTRAINT rhn_pkg_extratags_pid_fk
                       REFERENCES rhnPackage (id)
                       ON DELETE CASCADE,
    key_id      NUMBER NOT NULL
                       REFERENCES rhnPackageExtraTagKey (id)
                       ON DELETE CASCADE,
    value       VARCHAR2(2048) NOT NULL,
    created     timestamp with local time zone
                    DEFAULT (current_timestamp) NOT NULL,
    primary key (package_id, key_id)
)
;
