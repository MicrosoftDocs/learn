az deployment group what-if \
  --resource-group ToyStorage \
  --template-file $templateFile \
  --result-format ResourceIdOnly