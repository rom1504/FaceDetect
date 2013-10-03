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

list=`find -L $dossierImage -type f | sed 's,^'$dossierImage'/,,'`

for nom in $list
do
	if [[ ! ( -e $dossierDecoupeTxt/$nom.txt ) ]]
	then
		echo $nom
		dirf=`dirname $nom`
		mkdir -p $dossierDecoupeTxt/$dirf
		
		if [[ $# -eq 3 ]]
		then
			mkdir -p $dossierIdentifie/$dirf
			$dir/../bin/facedetect $dossierImage/$nom $dir/../modele/haarcascade_frontalface_alt.xml $dossierIdentifie/$nom > $dossierDecoupeTxt/$nom.txt 
		else
			$dir/../bin/facedetect $dossierImage/$nom $dir/../modele/haarcascade_frontalface_alt.xml > $dossierDecoupeTxt/$nom.txt 
		fi
	fi
done
