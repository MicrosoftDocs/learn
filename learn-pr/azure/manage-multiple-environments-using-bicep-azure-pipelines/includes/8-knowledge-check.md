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
- name: environmentName
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
        azureSubscription: SharedServiceConnection
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
            az deployment group create \
            --name $(Build.BuildNumber) \
            --resource-group ${{parameters.environmentName}}_rg \
            --template-file deploy/main.bicep \
            --parameters deploy/parameters.${{parameters.environmentName}}.json
```

The Git repository's *deploy* folder also contains the Bicep file and parameter files.
