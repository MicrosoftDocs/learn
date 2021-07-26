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
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master

    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}

    - name: Azure CLI script
      uses: azure/CLI@v1
      with:
        inlineScript: |
          az deployment group create --resource-group github-action-arm-rg --template-file ./deploy/main.bicep -p environmentType=Test
```