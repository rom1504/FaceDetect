dossierImage=../entree/xuan
dossierDecoupe=../sortie/decoupe
dossierDecoupeTxt=../sortie/decoupetxt
dossierIdentifie=../sortie/identifie
# racine=/home/rom1504/Bureau/test2/
# dossierImage=$racine/arangertel12
# dossierDecoupe=$racine/decoupe
# dossierDecoupeTxt=$racine/decoupetxt
# dossierIdentifie=$racine/identifie
rm $dossierDecoupe/*
rm $dossierDecoupeTxt/*
rm $dossierIdentifie/*

dir=`dirname $0`

echo compilation:
adir=`pwd`
cd $dir
make
cd $adir
echo detection:
$dir/multidetect.sh $dossierImage $dossierDecoupeTxt $dossierIdentifie
echo decoupage:
$dir/couper.sh $dossierImage $dossierDecoupe $dossierDecoupeTxt
