Consider the following workflow definition:

_.github/workflows/workflow.yml_:

```yaml
name: workflow

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  deploy-sandbox:
    uses: /.github/workflows/deploy.yml
    with:
      environmentName: Sandbox
    secrets:
      client-id: ${{ secrets.AZURE_CLIENT_ID }}
      tenant-id: ${{ secrets.AZURE_TENANT_ID }}
      subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

  deploy-production:
    uses: /.github/workflows/deploy.yml
    needs: deploy-sandbox
    with:
      environmentName: Production
    secrets:
      client-id: ${{ secrets.AZURE_CLIENT_ID }}
      tenant-id: ${{ secrets.AZURE_TENANT_ID }}
      subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

_.github/workflows/deploy.yml_:

```yaml
name: deploy

on:
  workflow_call:
    inputs:
      environmentName:
        required: true
        type: string
    secrets:
      AZURE_CLIENT_ID:
        required: true
      AZURE_TENANT_ID:
        required: true
      AZURE_SUBSCRIPTION_ID:
        required: true

jobs:
  deploy:
    environment: ${{ inputs.environmentType }}
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: azure/login@v1
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
    - uses: azure/arm-deploy@v1
      with:
        failOnStdErr: false
        deploymentName: ${{ github.run_number }}
        resourceGroupName: ${{ inputs.environmentName }}_rg
        template: ./deploy/main.bicep
        parameters: deploy/parameters.${{ inputs.environmentName }}.json
```

The Git repository's _deploy_ folder also contains the Bicep file and parameter files.
