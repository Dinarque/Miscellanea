#!/usr/bin/perl

use Data::Dumper;
use XML::Simple;


my %term2form;
my %term2head;

my $YateaXML = XML::Simple->new();

my $yatea = $YateaXML->XMLin($ARGV[0]);

#  print Dumper($yatea);
# exit;

foreach $term (@{$yatea->{"LIST_TERM_CANDIDATES"}->{"TERM_CANDIDATE"}}) {
#     print $term->{"ID"} . " : " . $term->{"FORM"} . "\n";
    $term2form{$term->{"ID"}} = $term->{"FORM"};

    if (defined $term->{"SYNTACTIC_ANALYSIS"}) {
# 	print $term->{"ID"} . " : " . $term->{"SYNTACTIC_ANALYSIS"}->{"HEAD"} . "\n";
	$term2head{$term->{"ID"}} = $term->{"SYNTACTIC_ANALYSIS"}->{"HEAD"};
	$term2head{$term->{"ID"}} =~ s/\s*\n\s*//g;
# 	print $term->{"ID"} . " : " . $term2head{$term->{"ID"}} . "\n";
    }
}

binmode(STDOUT, ":utf8");
foreach $term (keys %term2head) {
    print $term2form{$term} . " : " . $term2form{$term2head{$term}} . "\n";
}
