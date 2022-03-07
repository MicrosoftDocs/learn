az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.json \
               appServicePlanInstanceCount=5