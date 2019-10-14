oldfile=$1
newfile=$2

month=`date +%B`
year=`date +%Y`

prefix="frozenskys"

archivefile=$prefix.$month.$year.tar

# Check for existence of a compressed archive matching the naming convention
if [ -e $archivefile.gz ]
then
    echo "Archive file $archivefile already exists..."
    echo "Adding file '$oldfile' to existing tar archive..."

    # Uncompress the archive, because you can't add a file to a
    # compressed archive
    gunzip $archivefile.gz

    # Add the file to the archive
    tar --append --file=$archivefile $oldfile

    # Recompress the archive
    gzip $archivefile

# No existing archive - create a new one and add the file
else
    echo "Creating new archive file '$archivefile'..."
    tar --create --file=$archivefile $oldfile
    gzip $archivefile
fi

# Update the files outside the archive
mv $newfile $oldfile

