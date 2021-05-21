New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFileName `
  -storagePrefix whatif `
  -storageSKU Standard_LRS `
  -WhatIfResultFormat FullResourcePayloads `
  -Whatif