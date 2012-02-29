use strict;
use warnings;

use Test::More;

use File::Basename qw/fileparse/;
use File::Temp;
use File::chdir;

use Alien::Base::ModuleBuild::Repository::LOCAL;

my $repo = bless { location => 't' }, 'Alien::Base::ModuleBuild::Repository::LOCAL';
$repo->init; # this hack fixes the internal representation of location, usually called by Repository->new

my @files = $repo->list_files;
my $this_file = fileparse __FILE__;

ok( grep { $_ eq $this_file } @files, "found this file" );

{
  my $tempdir = File::Temp->newdir;
  local $CWD = "$tempdir";

  $repo->get_file($this_file);
  ok( -e $this_file, "copied this file to temp dir" );
}

done_testing;

