New-AzTemplateSpec `
  -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
  -Name ToyCosmosDBAccount `
  -Location westus `
  -DisplayName 'Cosmos DB account' `
  -Description "This template spec creates a Cosmos DB account that meets our company's requirements." `
  -Version '1.0' `
  -TemplateFile azuredeploy.json
  -TemplateFile main.bicep