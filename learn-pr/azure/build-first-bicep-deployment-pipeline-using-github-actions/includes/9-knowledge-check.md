The R&D team at your toy company has asked you to help them with their workflow definition. Here's the YAML file:

```yaml
on:
  push:
    branches:
      - main
    paths:
      - 'deploy/**'

name: AzureBicepSample

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    - uses: azure/arm-deploy@v1
      with:
        resourceGroupName: ${{ env.AZURE_RESOURCEGROUP_NAME }}
        template: ./deploy/main.bicep
        parameters: environmentType=${{ env.ENVIRONMENT }}
```