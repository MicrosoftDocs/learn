templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addfunction-"$today

az deployment group create \
  --name $DeploymentName \
  --resource-group $RG \
  --template-file $templateFile \
  --parameters storageName={your-Prefix-name}