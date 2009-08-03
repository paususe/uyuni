--
-- Copyright (c) 2008 Red Hat, Inc.
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
--
--
--

create sequence rhn_confchantype_id_seq;

create table
rhnConfigChannelType
(
	id		numeric not null
			constraint rhn_confchantype_id_pk primary key
--				using index tablespace [[64k_tbs]]
				,
	label		varchar(64) not null
			constraint rhn_confchantype_label_uq unique,
	name		varchar(64) not null,
        priority        numeric default(0) not null,
	created		timestamp default(current_timestamp) not null,
	modified	timestamp default(current_timestamp) not null
);

create index rhn_confchantype_label_id_idx
	on rhnConfigChannelType( label, id )
--	tablespace [[64k_tbs]]
;

