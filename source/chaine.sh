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
echo compilation:
make
echo detection:
./multidetect.sh $dossierImage $dossierIdentifie $dossierDecoupeTxt
echo decoupage:
./couper.sh $dossierImage $dossierDecoupe $dossierDecoupeTxt