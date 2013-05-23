if [[ $# -lt 2 || $# -gt 3 ]]
then
		echo "usage : $0 <dossierImage> <dossierDecoupeTxt> [<dossierIdentifie>]" 
		exit 1
fi

dir=`dirname $0`
dossierImage=$1
dossierDecoupeTxt=$2
if [[ $# -eq 3 ]]
then
	dossierIdentifie=$3
fi

for i in $dossierImage/*
do
	nom=`basename $i`
	if [[ ! ( -e $dossierDecoupeTxt/$nom.txt ) ]]
	then
		echo $i
		if [[ $# -eq 3 ]]
		then
			$dir/../bin/facedetect $i $dir/../modele/haarcascade_frontalface_alt.xml $dossierIdentifie/$nom > $dossierDecoupeTxt/$nom.txt 
		else
			$dir/../bin/facedetect $i $dir/../modele/haarcascade_frontalface_alt.xml > $dossierDecoupeTxt/$nom.txt 
		fi
	fi
done
