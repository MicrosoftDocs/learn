$servicePrincipal = New-AzADServicePrincipal `
  -DisplayName MyPipeline `
  -Role Contributor `
  -Scope '/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyWebsite'