#!/bin/sh

/usr/lib/rpm/perl.req $* | grep -E -v '(Net::LDAP|Crypt::SmbHash|CGI|Unicode::MapUTF8|smbldap_tools|Carp|Convert::ASN1|Getopt::Long|Getopt::Std|IO::Socket|POSIX|Time::Local|strict)'
