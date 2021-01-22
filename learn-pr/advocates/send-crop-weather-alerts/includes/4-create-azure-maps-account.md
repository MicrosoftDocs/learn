Before you can use the two Azure Maps APIs for geocoding and weather forecasting, you'll need an Azure Maps account. In this unit, you'll use the Azure CLI to create an Azure Maps account, and get a key that's required by the app to access the account.

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

1. Activate the sandbox by using the button on this page. The sandbox will give you access to free Azure resources for the duration of this module.

1. To create a new Azure Maps account, run this command:

    ```azurecli
    az maps account create \
      --name weatherservice \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --accept-tos
    ```

    > [!NOTE]
    > The output message that's shown after you running this command is informative. You don’t need to take any additional action.

## Get the primary key

Azure Maps accounts are secured by either an Azure Active Directory instance or a primary key. You get the key by using the Azure CLI. Later in this module, you'll use the key to give an Azure function app access to your Azure Maps account.

1. To view the keys list and get the primary key, run this command:

    ```azurecli
    az maps account keys list \
      --name weatherservice \
      --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

1. Note the value of the *primaryKey* for later use. The value does not include the quotation marks.

In this unit, you created an Azure Maps account and obtained the primary key. Next, you'll create a Twilio account.
