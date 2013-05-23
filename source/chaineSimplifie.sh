if [[ $# -ne 3 ]]
then
		echo "usage : $0 <dossierImage> <dossierDecoupe> <dossierDecoupeTxt>" 
		exit 1
fi

dir=`dirname $0`

dossierImage=$1
dossierDecoupe=$2
dossierDecoupeTxt=$3
adir=`pwd`
cd $dir
make
cd $adir
$dir/multidetect.sh $dossierImage $dossierDecoupeTxt
$dir/couper.sh $dossierImage $dossierDecoupe $dossierDecoupeTxt