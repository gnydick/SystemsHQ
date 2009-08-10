#!/usr/bin/perl

use strict;

$|=1;

my $section = shift;

my $template="%--shortname--%:
  syshq_nav_section: $section
  view: true
  position: %--position--%
  name: %--name--%";

my $position = 1;


while (<STDIN>)
{
	chomp;
	my $name = $_;
	my $shortname = $name;
	$shortname =~ s/ //g;
	$shortname = $section.'_'.$position.'_'.$shortname;
	my $new_entry = $template;
	$new_entry =~ s/%--shortname--%/$shortname/;
	$new_entry =~ s/%--name--%/$name/;
	$new_entry =~ s/%--position--%/$position/;
	print $new_entry."\n\n";
	$position++;
}
	
