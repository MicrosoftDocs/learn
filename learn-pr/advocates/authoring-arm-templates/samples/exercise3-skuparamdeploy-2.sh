templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addSkuParameter-"$today

az deployment group create \
  --name $DeploymentName \
  --resource-group $RG \
  --template-file $templateFile \
  --parameters storageSKU=Standard_GRS storageName={your-unique-name}