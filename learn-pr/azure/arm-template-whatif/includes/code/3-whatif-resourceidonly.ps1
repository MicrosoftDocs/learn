New-AzResourceGroupDeployment `
  -ResourceGroupName ToyStorage `
  -TemplateFile $templateFileName `
  -WhatIf `
  -WhatIfResultFormat ResourceIdOnly
