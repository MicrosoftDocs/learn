az ts create \
  --name ToyCosmosDBAccount \
  --location westus \
  --display-name "Cosmos DB account" \
  --description "This template spec creates a Cosmos DB account that meets our company's requirements." \
  --version 1.0 \
  --template-file azuredeploy.json
  --template-file main.bicep