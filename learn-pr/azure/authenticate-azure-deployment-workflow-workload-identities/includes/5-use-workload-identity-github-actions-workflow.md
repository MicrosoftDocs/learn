TODO

## Configure your GitHub Actions workflow

Your GitHub Actions workflow definition needs to include two changes when you use a workload identity.

First, you need to allow your workflow to request sign-in tokens from Azure AD. In your workflow definition you add the `permissions` property:

```yaml
permissions:
  id-token: write
  contents: read
```

Next, when you need your workflow to sign in to Azure, you use the `azure/login` action as normal. But, instead of providing any secrets, you specify three properties:

| Property | Description |
|-|-|
| `client-id` | The application ID for the application registration. Ensure you use the application ID and not the object ID. |
| `tenant-id` | The unique identifier for your Azure AD tenant (directory). |
| `subscription-id` | The Azure subscription ID that you'll deploy to. |

```yaml
# Login step
- uses: azure/login@v1
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

The following workflow definition shows a complete Bicep deployment workflow:

TODO