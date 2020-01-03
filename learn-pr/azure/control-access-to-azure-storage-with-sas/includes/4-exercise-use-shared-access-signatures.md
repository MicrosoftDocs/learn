   1. Add code to build an ad-hoc SAS URI for the external access page.
    1. Add client-side code to call the secure access page.
    1. Test the image can be displayed.
    1. Test the access is lost after 1 minute.



create storage account

az storage account create \
    --name medicalrecords \
    --access-tier hot \
    --kind StorageV2 \
    --resource-group azure-files

az storage container create \
    --name patient-images \
    --account-name medicalrecords \
    --public-access blob

git clone https://github.com/PhilStollery/mslearn-control-access-to-azure-storage-with-sas.git sas

az storage blob upload-batch \
    --source . \
    --destination patient-images \
    --account-name medicalrecords \
    --pattern *.jpg


end=`date -d "90 minutes" '+%Y-%m-%dT%H:%MZ'`
az storage blob generate-sas \
    --account-name medicalrecords \
    --container-name patient-images \
    --name patient-116139-nq8z7f.jpg \
    --permissions r \
    --expiry $end \
    --https-only



patient-32589.jpg

se=2020-01-03T15%3A21Z&sp=r&spr=https&sv=2018-11-09&sr=b&sig=P7HZYS3dJm%2BAeYM7Hg/Rva5j37sNSSA4lekrh4QkjkA%3D
    