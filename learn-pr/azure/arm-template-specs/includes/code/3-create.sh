az ts create \
  --name StorageWithoutSAS \
  --location westus \
  --display-name "Storage account with SAS disabled" \
  --description "This template spec creates a storage account, which is preconfigured to disable SAS authentication." \
  --version 1.0 \
  --template-file azuredeploy.json
  --template-file main.bicep