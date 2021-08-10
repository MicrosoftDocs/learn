az ts create \
  --name ToyCosmosDBAccount \
  --version 2.0 \
  --version-description "Adds Cosmos DB role-based access control." \
  --template-file azuredeploy.json
  --template-file main.bicep