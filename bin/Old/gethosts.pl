#!/usr/bin/perl -w
 
use strict;
use warnings;
use VMware::VILib;
use VMware::VIRuntime;
 
# validate options, and connect to the server
Opts::parse();
Opts::validate();
Util::connect();
 
my $vmhosts = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name','summary']);
 
print "ESX(i) hosts residing on " . Opts::get_option('server') . "\n";
foreach(@$vmhosts) {
        print "\t" . $_->{'name'} . "\t" . $_->{'summary'}->config->product->fullName . "\n";
}
 
Util::disconnect();