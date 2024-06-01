Before you can use Azure Maps on a webpage, you need an Azure Maps account. In this unit, you use the Azure CLI to create an Azure Maps account. Then, you get a key that the web SDK needs to access the Maps account.

### Activate the sandbox

The process of signing in to activate the sandbox runs outside the learning module. You're automatically returned to the module after you sign in.

Use the following steps to activate the sandbox:

1. Select **Sign in to activate Sandbox**.  Enter your credentials to authenticate.

1. If prompted, select **Review permissions**.

    :::image type="content" source="../media/sandbox-review-permissions.png" alt-text="Screenshot that shows the sandbox, with the Review Permissions button highlighted.":::

1. Verify the permissions settings, and select **Accept**.

    :::image type="content" source="../media/sandbox-accept-permissions.png" alt-text="Screenshot that shows the sandbox, with permissions details and the Accept button highlighted.":::

The message **Sandbox activated!** appears, and you can continue with the learning module.

## Create an Azure Maps account

Activate the sandbox, and then run this command to create a new Azure Maps account:

```console
az maps account create --name pollution_map --resource-group <rgn>[sandbox resource group name]</rgn> --accept-tos --sku g2 --kind gen2
```

> [!NOTE]
> The output message is informative only. You don’t need to take additional action.

## Retrieve the primary key

Azure Maps accounts are secured with Microsoft Entra ID or by using a key. Later in this module, you use a key to give the web SDK access to your Maps account. You can get the key by using the Azure CLI.

Run this command to view the keys that are associated with your Maps account:

```azurecli
az maps account keys list --name pollution_map --resource-group <rgn>[sandbox resource group name]</rgn>
```

Copy and save the value of `primaryKey` without the quotation marks. You use this key value later in the module.

In this unit, you created an Azure Maps account and got the primary key. Next, let's build the app!
