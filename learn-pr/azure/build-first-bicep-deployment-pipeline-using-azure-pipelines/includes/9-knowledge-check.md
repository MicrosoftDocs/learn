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
  - task: AzureResourceManagerTemplateDeployment@3
    inputs:
      connectedServiceName: ResearchSubscription
      location: westus3
      resourceGroupName: ResearchDevelopment
      csmFile: deploy/main.bicep
      overrideParameters: >
        -environmentType Production
```
