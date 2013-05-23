if [[ $# -ne 3 ]]
then
		echo "usage : $0 <dossierImage> <dossierDecoupe> <dossierDecoupeTxt>" 
		exit 1
fi

dir=`dirname $0`
dossierImage=$1
dossierDecoupe=$2
dossierDecoupeTxt=$3

for i in $dossierDecoupeTxt/*
do
# 	echo $i
	perl $dir/couper.pl $i $dossierImage $dossierDecoupe
done
