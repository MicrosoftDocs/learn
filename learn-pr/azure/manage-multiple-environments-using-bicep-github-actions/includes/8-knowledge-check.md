Consider the following workflow definition:

*.github/workflows/workflow.yml*:

```yaml
name: workflow

on: 
  push:
    branches: 
      - main
  workflow_dispatch:

jobs:
  deploy-sandbox:
    uses: mygithubuser/myworkflow/.github/workflows/deploy.yml@main
    with:
      environmentName: Sandbox
    secrets:
      AZURE_CREDENTIALS: ${{ secrets.AZURE_CREDENTIALS }}

  deploy-production:
    uses: mygithubuser/myworkflow/.github/workflows/deploy.yml@main
    needs: deploy-sandbox
    with:
      environmentName: Production
    secrets:
      AZURE_CREDENTIALS: ${{ secrets.AZURE_CREDENTIALS }}
```

*.github/workflows/deploy.yml*:

```yaml
name: deploy

on:
  workflow_call:
    inputs:
      environmentName:
        required: true
        type: string
    secrets:
      AZURE_CREDENTIALS:
        required: true

jobs:
  deploy:
    environment: ${{ inputs.environmentType }}
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    - uses: azure/arm-deploy@v1
      with:
        failOnStdErr: false
        deploymentName: ${{ github.run_number }}
        resourceGroupName: ${{ inputs.environmentName }}_rg
        template: ./deploy/main.bicep
        parameters: deploy/parameters.${{ inputs.environmentName }}.json
```
\
The Git repository's *deploy* folder also contains the Bicep file and parameter files.
