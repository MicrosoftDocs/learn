New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFileName `
  -WhatIf `
  -WhatIfResultFormat ResourceIdOnly
