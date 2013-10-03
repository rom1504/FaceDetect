if [[ $# -ne 4 ]]
then
		echo "usage : $0 <directoryList> <dossierImage> <dossierDecoupe> <dossierDecoupeTxt>" 
		exit 1
fi

dir=`dirname $0`

directoryList=$1
dossierImage=$2
dossierDecoupe=$3
dossierDecoupeTxt=$4

mkdir -p $dossierDecoupe
mkdir -p $dossierDecoupeTxt


echo compilation:
adir=`pwd`
cd $dir
make
cd $adir
echo recherche:
perl $dir/fileListToSymbolicLinks.pl $directoryList $dossierImage $dossierDecoupe $dossierDecoupeTxt
echo detection:
bash $dir/multidetect.sh $dossierImage $dossierDecoupeTxt
echo decoupage:
bash $dir/couper.sh $dossierImage $dossierDecoupe $dossierDecoupeTxt
