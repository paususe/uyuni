%define rhnroot /usr/share/rhn
Summary: Various utility scripts and data files for RHN Satellite installations
Name: spacewalk-admin
# This src.rpm is cannonical upstream
# You can obtain it using this set of commands
# git clone git://git.fedorahosted.org/git/spacewalk.git/
# cd satellite/admin
# make test-srpm
URL:     https://fedorahosted.org/spacewalk
Version: 0.1
Release: 1%{?dist}
Source0: %{name}-%{version}.tar.gz
License: GPLv2
Group: Applications/Internet
BuildRoot: %{_tmppath}/%{name}-root
Requires: spacewalk-base
Requires: perl-URI, perl(MIME::Base64)
Requires: sudo
Obsoletes: satellite-utils <= 5.2
Obsoletes: rhn-satellite-admin <= 5.2
BuildArch: noarch

%description
Various utility scripts and data files for Spacewalk installations.

%prep
%setup

%install
rm -rf $RPM_BUILD_ROOT
make -f Makefile.admin install PREFIX=$RPM_BUILD_ROOT

(cd $RPM_BUILD_ROOT/usr/bin && ln -s validate-sat-cert.pl validate-sat-cert)

mkdir -p $RPM_BUILD_ROOT%{_mandir}/man3/
/usr/bin/pod2man validate-sat-cert.pod | gzip -c - > $RPM_BUILD_ROOT%{_mandir}/man3/validate-sat-cert.3.gz
chmod 0644 $RPM_BUILD_ROOT%{_mandir}/man3/validate-sat-cert.3.gz

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%dir %{rhnroot}
/etc/init.d/rhn-satellite
/usr/bin/validate-sat-cert.pl
/usr/bin/validate-sat-cert
/usr/bin/rhn-config-satellite.pl
/usr/bin/rhn-config-schema.pl
/usr/bin/rhn-config-tnsnames.pl
/usr/bin/rhn-populate-database.pl
/usr/bin/rhn-generate-pem.pl
/usr/bin/rhn-load-ssl-cert.pl
/usr/bin/rhn-deploy-ca-cert.pl
/usr/bin/rhn-install-ssl-cert.pl
/sbin/rhn-sat-restart-silent
%{rhnroot}/RHN-GPG-KEY
%{_mandir}/man3/validate-sat-cert.3.gz

%changelog
* Mon Aug  4 2008 Jan Pazdziora 0.1-1
- removed version and sources files

* Wed May 21 2008 Michael Mraka <michael.mraka@redhat.com> 5.2.0-3%{?dist}
- fixed * expansion in rhn-populate-database.pl

* Tue May 20 2008 Jan Pazdziora - 5.2.0-2%{?dist}
- rebuild via dist-cvs

* Thu Dec 20 2007 Justin Sherrill <jsherril@redhat.com>
- Adding rhn-sat-restart-silent sript in order for the webUI restart to work

* Wed Oct  6 2004 Robin Norwood <rnorwood@redhat.com>
- switch to using a Makefile instead of specifying each script

* Mon Aug  2 2004 Robin Norwood <rnorwood@redhat.com>
- add more perl scripts
- need to change this to use a Makefile RSN

* Tue Jul  6 2004 Robin Norwood <rnorwood@redhat.com>
- add perl scripts for web based install

* Fri Oct 31 2003 Chip Turner <cturner@redhat.com>
- add symlink of validate-sat-cert -> validate-sat-cert.pl

* Tue Aug 20 2002 Cristian Gafton <gafton@redhat.com>
- make it a noarch package

* Mon Jun  3 2002 Chip Turner <cturner@redhat.com>
- new versions

* Thu Apr 25 2002 Chip Turner <cturner@redhat.com>
- Initial build.
