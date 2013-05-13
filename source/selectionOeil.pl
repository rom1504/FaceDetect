use strict;
use File::Copy;
use File::Remove 'remove';
use File::Basename;
use List::Util ('max','min');

if((scalar @ARGV)!=4)
{
	print("usage: $0 <dossierSource> <dossierOeilTxt> <dossierOeilIdentifie> <dossierOeilSelectionne>\n");
	exit 1;
}
my ($source,$txt,$identifie,$selectionne,$identifieTemp)=@ARGV;

foreach ($txt,$identifie,$selectionne,$identifieTemp."/1",$identifieTemp."/2")
{
	if(!(-d "$_")) { mkdir -p "$_"; }
	else { remove(\1,"$_/*"); }
}

sub enregistrer
{
	my ($fichier,$identifie,$txt,$selectionne,$modele)=@_;
	my $f=basename $fichier;
	open(my $r,"../bin/facedetect $fichier $identifie/$f $modele |");
	my @yeux=<$r>;
	close($r);
	if((scalar @yeux)==2)
	{
		open(my $ftxt,">",$txt."/".$f.".txt");
		my @oeil1=split("\t",$yeux[0]);# où séparer oeil gauche oeil droite ? (sans facereco via la position en y ? oui semble bien) ou via ordre ? ( gauche premier ? )
		my @oeil2=split("\t",$yeux[1]);
		if(abs($oeil1[1]-$oeil2[1])<max($oeil1[3],$oeil2[3])*0.5 && abs($oeil1[0]-$oeil2[0])>min($oeil1[2],$oeil2[2]))
		{
			print($ftxt $yeux[0]);
			print($ftxt $yeux[1]);
			copy $fichier,$selectionne."/".$f;
			close($ftxt);
			return 1;
		}
	}
	remove "$identifie/$f";
	return 0;
}

# finir afin de pouvoir utiliser plusieurs modèle (si un marche ça suffit et on ne prend que ça pour cette image) : faire bien afin de pouvoir généraliser facilement à plus de 2 modèles, en fonction des résultats ensuite envisager de faire qq chose comme ça pour multidetect (afin d'avoir un maximum de recall et de précision)

my @fichiers=glob("$source/*");
my @modeles=("../modele/haarcascade_eye_tree_eyeglasses.xml","../modele/haarcascade_eye.xml");
foreach my $fichier (@fichiers) { foreach my $modele (@modeles) { if(enregistrer($fichier,$identifie,$txt,$selectionne,$modele)) { last; } } }