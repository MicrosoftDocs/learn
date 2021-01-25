Before you can use the two Azure Maps APIs for geocoding and weather forecasting, you'll need an Azure Maps account. In this unit, you'll use the Azure CLI to create an Azure Maps account. Then, you'll get a key that the application requires to access the account.

### Activate the sandbox

The process of signing in to activate the sandbox runs outside the learning module. You're automatically returned to the module after you sign in.

To activate the sandbox:

1. Select **Sign in to activate Sandbox**.  Enter your credentials to authenticate.

1. If prompted, select **Review permissions**.

    :::image type="content" source="../media/sandbox-review-permissions.png" alt-text="Screenshot that shows the sandbox, with the Review Permissions button highlighted.":::

1. Verify the permissions settings, and select **Accept**.

    :::image type="content" source="../media/sandbox-accept-permissions.png" alt-text="Screenshot that shows the sandbox, with permissions details and the Accept button highlighted.":::

The message **Sandbox activated!** appears, and you can continue with the learning module.

## Create an Azure Maps account

In the sandbox, run the following command to create a new Azure Maps account:

```azurecli
az maps account create \
  --name weatherservice \
  --resource-group <rgn>[sandbox resource group name]</rgn> \
  --accept-tos
```

> [!NOTE]
> The output message that's shown after you run this command is informative only. You don’t need to take any additional action.

### Get the primary key

Azure Maps accounts are secured by either an Azure Active Directory instance or a primary key. We'll run the following Azure CLI command to get the primary key. Later in this module, you'll use the key to give a function app that's hosted in Azure Functions access to your Azure Maps account.

To view the keys list and get the primary key, run this command:

```azurecli
az maps account keys list \
  --name weatherservice \
  --resource-group <rgn>[sandbox resource group name]</rgn>
```

In the output, note the value of **primaryKey** to use later. Don't include the quotation marks.

In this unit, you created an Azure Maps account and obtained the primary key. Next, you'll create a Twilio account.
