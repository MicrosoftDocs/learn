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
        client-id: '44445555-eeee-6666-ffff-7777aaaa8888'
        tenant-id: 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
        subscription-id: 'ffff5f5f-aa6a-bb7b-cc8c-dddddd9d9d9d'
    - uses: azure/arm-deploy@v1
      with:
        resourceGroupName: MyResourceGroup
        template: ./deploy/main.bicep
```

The workflow returns the following error message:

```output
Error:  Unable to get ACTIONS_ID_TOKEN_REQUEST_URL env variable. Please make sure to give write permissions to id-token in the workflow.
```
