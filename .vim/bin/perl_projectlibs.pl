use strict;
use warnings;

use Getopt::Long;

die "no arguments" unless @ARGV;

my @libs;

GetOptions("libdir" => \@libs);

my $file = shift;
my $args = @ARGV ? " " . join " ", @ARGV : "";
my $libs_str = join " ", @libs;

my @lines = `perl -c -M'Project::Libs lib_dirs => [qw/$libs_str/]' $file$args 2>&1`;

foreach my $line (@lines) {

    chomp($line);
    my ($file, $lineno, $message, $rest);

    if ($line =~ /^(.*)\sat\s(.*)\sline\s(\d+)(\.|,\snear\s\".*\")$/) {

        ($message, $file, $lineno, $rest) = ($1, $2, $3, $4);
        $message .= $rest if ($rest =~ s/^,//);
        print "$file:$lineno:$message\n";

    } else {
        next
    };

}
