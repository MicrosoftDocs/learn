create storage account



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
    