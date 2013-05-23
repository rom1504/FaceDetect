use strict;
use File::Copy;
use File::Basename;
if((scalar @ARGV)!=3)
{
	print("usage: $0 <fichierDecoupeTxt> <dossierImage> <dossierDecoupe>\n");
	exit(1);
}
my $nf=$ARGV[0];
my $dossierImage=$ARGV[1];
my $dossierDecoupe=$ARGV[2];
basename($nf) =~ /^((.+)\.(?:jpg|jpeg))\.txt$/i;
my $bn=$dossierImage."/".$1;
my $sbn=$2;
my $i=0;
open(my $fw,">",$nf."_tmp");
open(my $f,"<",$nf);
my $i;
while(my $ligne=<$f>)
{
	$i++;
	$ligne =~ s/\s+$//;
	my @coords=split("\t",$ligne);
	if((scalar @coords) eq 4)
	{
		my $nn="$dossierDecoupe/$sbn"."_"."$i.jpg";
		print($nn."\n");
		copy($bn,$nn);
		system("mogrify -crop $coords[2]x$coords[3]+$coords[0]+$coords[1] $nn");
		print($fw $ligne."\t".$nn."\n");
	}
	else
	{
		print($fw $ligne."\n");
	}
}
close($f);
close($fw);
move($nf."_tmp",$nf);