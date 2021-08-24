The R&D team at your toy company has asked you to help them with their pipeline definition. Here's the YAML file:

```yaml
trigger:
  branches:
    include:
    - main
    - releases/*
  paths:
    include:
    - templates
    exclude:
    - templates/README.md
 
pool:
  vmImage: ubuntu-latest

steps:
- task: AzureCLI@2
  inputs:
    azureSubscription: ResearchSubscription
    scriptType: 'bash'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az deployment group create \
        --resource-group ResearchDevelopment \
        --template-file deploy/main.bicep \
        --parameters environmentType=Production
```
