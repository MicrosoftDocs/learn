(Get-AzTemplateSpec `
  -ResourceGroupName MyResourceGroup `
  -Name MyTemplateSpec `
  -Version 1.0 `
).Versions[0].MainTemplate