New-AzTemplateSpec `
  -Name StorageWithoutSAS `
  -Location westus `
  -DisplayName 'Storage account with SAS disabled' `
  -Description 'This template spec creates a storage account, which is preconfigured to disable SAS authentication.' `
  -Version '1.0' `
  -TemplateFile azuredeploy.json
  -TemplateFile main.bicep