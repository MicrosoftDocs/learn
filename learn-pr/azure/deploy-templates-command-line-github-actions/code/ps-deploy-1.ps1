$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addSkuParameter-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName What-if `
  -TemplateFile $templateFile `
  -storagePrefix whatif `
  -storageSKU Standard_LRS `
  -WhatIfResultFormat ResourceIdOnly `
  -Mode Complete `
  -Confirm `
  -Whatif