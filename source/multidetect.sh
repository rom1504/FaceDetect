if [[ $# -ne 3 ]]
then
		echo "usage : $0 <dossierImage> <dossierIdentifie> <dossierDecoupeTxt>" 
		exit 1
fi

dossierImage=$1
dossierIdentifie=$2
dossierDecoupeTxt=$3

for i in $dossierImage/*
do
	echo $i
	nom=`basename $i`
	../bin/facedetect $i $dossierIdentifie/$nom ../modele/haarcascade_frontalface_alt.xml > $dossierDecoupeTxt/$nom.txt 
done