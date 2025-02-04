New-AzResourceGroupDeployment `
  -Name main `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.json `
  -appServicePlanInstanceCount 5