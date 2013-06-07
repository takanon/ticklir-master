use strict;
use warnings;
use Encode;
use Text::Xslate;
use Getopt::Long;
use Data::Section::Simple;

GetOptions(
	'id=s' => \my $id,
	'open=s' => \my $open,
	'start=s' => \my $start,
	'name-format=s' => \my $name_format,
);

my $xslate = Text::Xslate->new(
	path => [ Data::Section::Simple->new->get_data_section() ],
);
while (<>) {
	chomp;
	my $place = $_;
	my $name = $name_format ? sprintf($name_format, $place) : $place;
	print $xslate->render('base.tx', +{
		id    => $id++,
		open  => $open,
		start => $start,
		place => encode('UTF-8', $place),
		name  => encode('UTF-8', $name),
	});
}

__DATA__
@@ base.tx
    - id: <:= $id :>
      name: <:= $name :>
      open: <:= $open :>
      start: <:= $start :>
      place: <:= $place :>
      no_countdown_tweet: 1
