az deployment group what-if \
  --resource-group $resourceGroupName \
  --template-file $templateFile \
  --result-format FullResourcePayloads