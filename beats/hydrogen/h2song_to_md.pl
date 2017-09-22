#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use XML::Simple;

my $file = shift || die "need filename as argument";

my $data = XMLin($file, ForceArray => 1);

my @tok = split(/\./, $file);
pop @tok;
my $name = join('.', @tok);


#print Dumper $data;
#exit;


my $bpm = $data->{'bpm'}[0];

my %inst_list = ();

my %final_inst_list = ();

for my $inst ( @{$data->{'instrumentList'}[0]{'instrument'}}) {
    my $id = $inst->{'id'}[0];
    my $name = $inst->{'name'}[0];
    $inst_list{$id} = $name;
}

#print Dumper \%inst_list;

for my $pat (@{$data->{'patternList'}[0]{'pattern'}}) {
    #print $pat->{'name'}[0] ."\n";
    for my $n ( @{$pat->{'noteList'}[0]{'note'}}) {
       my $i = $n->{'instrument'}[0] ;
       $final_inst_list{$inst_list{$i}} = 1;
    }

}
#print Dumper \%final_inst_list;


print "# $name\n\n";

print "## BPM: $bpm\n\n";

print "### Instruments\n\n";

for my $i (keys %final_inst_list) {
    print $i ."\n\n";
}


