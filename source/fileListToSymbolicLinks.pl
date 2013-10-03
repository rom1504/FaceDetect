# perl fileListToSymbolicLinks.pl ../donnees/directoryList.txt ../donnees/photos ../donnees/photosDecoupees/ ../donnees/informations/

# take a directory list file, a photo directory, a cut photo directory and an information directory
# remove the symbolic link in photo directory and the directories in cut photo directory and information directory that aren't in the list of directory anymore
# make new symbolic link in the photo directory for the directory that are new in the list of directory (ie that don't already exist in the photo directory)

use strict;
if((scalar @ARGV)!=4)
{
	print("usage: $0 <directoryList> <photosDirectory> <cutPhotosDirectory> <informationDirectory>\n");
	exit(1);
}
use File::Path qw(remove_tree);

my $directoryList=$ARGV[0];
my $photosDirectory=$ARGV[1];
my $cutPhotosDirectory=$ARGV[2];
my $informationDirectory=$ARGV[3];

# 1) récupérer liste de lien symbolique dans le photos directory
my @oldList;
opendir(DIR, $photosDirectory) or die $!;
while (my $file = readdir(DIR))
{
	next if ($file =~ m/^\./);
	my $s=readlink($photosDirectory."/".$file);
	if($s ne "") {push(@oldList,$s);}
}
closedir(DIR);

# 2) récupérer la liste de fichier
open(my $fdirectoryList,"<",$directoryList);
my @newList=<$fdirectoryList>;
close($fdirectoryList);
@newList=map {$_=~s/\s$//;$_} @newList;


# 3) générer les 2 complémentaires
my @toAddList;
my @toDeleteList;

sub exists_
{
	my ($e,$l)=@_;
	foreach my $le (@{$l}) {if($le eq $e) {return 1;}}
	return 0;
}

sub complementary
{
	my ($a,$b)=@_;
	my @c;
	foreach my $e1 (@{$a}) {if(!exists_($e1,$b)) {push(@c,$e1);}}
	return @c;
}

@toAddList=complementary(\@newList,\@oldList);
@toDeleteList=complementary(\@oldList,\@newList);



# 4) supprimer et créer les liens symboliques en fonction du complémentaire concerné

# remove
opendir(DIR, $photosDirectory) or die $!;
while (my $file = readdir(DIR))
{
	next if ($file =~ m/^\./);
	my $s=readlink($photosDirectory."/".$file);
	if($s eq "") {next;}
	if(exists_($s,\@toDeleteList))
	{
		unlink($photosDirectory."/".$file);
		remove_tree($cutPhotosDirectory."/".$file);
		remove_tree($informationDirectory."/".$file);
	}
}
closedir(DIR);


# find new names (numbers)
my @newNames;
my $i=0;
while((scalar @newNames)<(scalar @toAddList))
{
	if(!(-e $photosDirectory."/".$i)) {push(@newNames,$i);}
	$i++;
}

# create
for(my $i=0;$i<(scalar @toAddList);$i++)
{
	my $f=@toAddList[$i];
	symlink $f,$photosDirectory."/".@newNames[$i];
}

