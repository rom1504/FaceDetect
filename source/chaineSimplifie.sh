if [[ $# -ne 3 ]]
then
		echo "usage : $0 <dossierImage> <dossierDecoupe> <dossierDecoupeTxt>" 
		exit 1
fi

dir=`dirname $0`

dossierImage=$1
dossierDecoupe=$2
dossierDecoupeTxt=$3

mkdir -p $dossierDecoupe
mkdir -p $dossierDecoupeTxt


echo compilation:
adir=`pwd`
cd $dir
make
cd $adir
echo detection:
bash $dir/multidetect.sh $dossierImage $dossierDecoupeTxt
echo decoupage:
bash $dir/couper.sh $dossierImage $dossierDecoupe $dossierDecoupeTxt
