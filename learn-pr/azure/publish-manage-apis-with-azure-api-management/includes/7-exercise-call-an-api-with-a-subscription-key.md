A subscription key is used to restrict access to an API.

In the shoe company example, NorthWind Shoes are working with a supplier and want them to directly access the Inventory API. Partner access must be secure, and use a subscription key for all calls to the API.

Here, you'll find the subscription key for your API. You'll then test access to the API with and without the subscription key.

## Obtain subscription key
Partners are given their key as part of an onboarding process. In this exercise, you'll use the administrator key. Once you've got a key, you follow the same process for using the key in API calls.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu or from the **Home** page, select **All resources**, and then click your API gateway.
1. Under the **APIs**, click **Subscriptions**.
1. Click the context menu (...) for the **Built-in all-access subscription**, and then click **Show/hide keys**.
1. Click the **Click to copy** button for the **PRIMARY KEY**.
1. Save this key somewhere, such as Notepad.

## Use subscription key in API call
The next step is to use the subscription key to test developer access to your published API.

1. Run the following command in the Cloud Shell to access the **Products** operation in your API, replacing `<apim gateway>` with the name of your gateway.
1. 
   ```bash
   curl https://<apim gateway>.azure-api.net/api/Products
   ```
1. You'll get a **401, Access denied due to missing subscription key** message.
1. You'll now repeat your curl request, this time including your subscription key.
1. Run the following command in the Cloud Shell, replacing `<primary key>` with the key you saved earlier, and replacing `<apim gateway>` with the name of your gateway.
   ```bash
   curl --header "Ocp-Apim-Subscription-Key: <primary key>" https://<apim gateway>.azure-api.net/api/Products
   ```
1. You should now be able to access the API, and see a list of products returned to the console.
