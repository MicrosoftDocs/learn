New-AzTemplateSpec `
  -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
  -Name ToyCosmosDBAccount `
  -Version '2.0' `
  -VersionDescription 'Adds Cosmos DB role-based access control.' `
  -TemplateFile azuredeploy.json
  -TemplateFile main.bicep