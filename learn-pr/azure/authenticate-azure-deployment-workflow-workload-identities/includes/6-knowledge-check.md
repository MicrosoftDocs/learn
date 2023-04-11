Your colleague is using workload identities with a GitHub deployment workflow. The following code is the workflow definition file:

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
    - uses: actions/checkout@v3
    - uses: azure/login@v1
      with:
        client-id: '555e8321-44fb-4fbe-a009-77c9b5a9ef87'
        tenant-id: 'e091bbec-9737-44a1-afd2-48fc1fd84adf'
        subscription-id: 'ff979187-9cfb-4e3f-ac42-4868c6a3e4f5'
    - uses: azure/arm-deploy@v1
      with:
        resourceGroupName: MyResourceGroup
        template: ./deploy/main.bicep
```

The workflow returns the following error message:

```output
Error:  Unable to get ACTIONS_ID_TOKEN_REQUEST_URL env variable. Please make sure to give write permissions to id-token in the workflow.
```
