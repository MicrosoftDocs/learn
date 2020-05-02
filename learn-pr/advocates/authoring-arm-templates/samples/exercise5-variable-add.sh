templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addVariable-"$today

az deployment group create \
  --name $DeploymentName \
  --resource-group $RG \
  --template-file $templateFile \
  --parameters storagePrefix={your-Prefix-name}