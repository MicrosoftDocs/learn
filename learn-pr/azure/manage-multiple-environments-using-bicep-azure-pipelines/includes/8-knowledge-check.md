Consider the following pipeline definition and pipeline template:

*azure-pipelines.yml*:

```yaml
trigger: none

pool:
  vmImage: ubuntu-latest

stages:

- template: deploy.yml
  parameters:
    environmentName: Sandbox

- template: deploy.yml
  parameters:
    environmentName: Production
```

*deploy.yml*:

```yaml
parameters:
- name: environmentType
  type: string

stages:
- stage: Deploy
  jobs:
  - job: Deploy
    steps:
    - checkout: self
    - task: AzureCLI@2
        name: DeployBicepFile
        displayName: Deploy Bicep file
        inputs:
        azureSubscription: SharedServiceCOnnection
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
            az deployment group create \
            --name $(Build.BuildNumber) \
            --resource-group ${{parameters.environmentType}}_rg \
            --template-file main.bicep \
            --parameters parameters.${{parameters.environmentType}}.json
```
