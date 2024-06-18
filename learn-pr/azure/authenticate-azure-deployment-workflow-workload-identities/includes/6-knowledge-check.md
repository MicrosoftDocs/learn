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
        client-id: 'A123b4567c-1234-1a2b-2b1a-1234abc12345'
        tenant-id: 'b31a1123-3210-10ab-23bc-123c1b32a012'
        subscription-id: 'B123a4567c-1234-2b1a-1b2b-11a2b01b2b3c0'
    - uses: azure/arm-deploy@v1
      with:
        resourceGroupName: MyResourceGroup
        template: ./deploy/main.bicep
```

The workflow returns the following error message:

```output
Error:  Unable to get ACTIONS_ID_TOKEN_REQUEST_URL env variable. Please make sure to give write permissions to id-token in the workflow.
```
