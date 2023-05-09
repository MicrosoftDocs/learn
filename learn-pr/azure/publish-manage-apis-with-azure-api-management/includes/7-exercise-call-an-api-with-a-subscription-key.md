A subscription key is one way to restrict access to an API.

In the shoe company example, NorthWind Shoes are working with a supplier and want them to directly access the Inventory API. Partner access must be restricted using a subscription key for all calls to the API.

Here, you'll obtain a subscription key for your API. You'll then test access to the API with and without the subscription key.

## Obtain subscription key

Partners are given their key as part of an onboarding process. In this exercise, you'll add a subscription specifically for the NorthWindShoes API. Once you've got a key, you follow a standard process for using the key in API calls.

1. On the Azure portal menu or from the **Home** page, select **All resources**, and then select your API Management instance.

1. In the left menu pane, under **APIs**, select **Subscriptions**.

1. Select **+ Subscription**, and enter the following values for each setting. Then select **Create**.

    | Setting | Value |
    | --------- | --------- |
    | Name | `NorthWind` |
    | Display name | `NorthWind subscription`|
    | Scope | Select **API**,  and then select **NorthWindShoes Products** from the dropdown list.

1. Select the context menu (...) for the **Northwind subscription**, and then select **Show/hide keys**.

1. Select the **Click to copy** button for the **PRIMARY KEY**.

1. Save this key somewhere, such as Notepad.

## Use subscription key in API call

The next step is to use the subscription key to test developer access to your published API.

1. Run the following command in Cloud Shell to access the **Products** operation in your API, replacing `<apim gateway>` with the name of your gateway.

   ```bash
   curl https://<apim gateway>.azure-api.net/api/Products
   ```

   You'll get a **401, Access denied due to missing subscription key** message.

1. You'll now repeat your curl request, this time including your subscription key.

1. Run the following command in Cloud Shell, replacing `<primary key>` with the key you saved earlier, and replacing `<apim gateway>` with the name of your gateway.

   ```bash
   curl --header "Ocp-Apim-Subscription-Key: <primary key>" https://<apim gateway>.azure-api.net/api/Products
   ```

   You should now be able to access the API, and see a list of products returned to the console.
