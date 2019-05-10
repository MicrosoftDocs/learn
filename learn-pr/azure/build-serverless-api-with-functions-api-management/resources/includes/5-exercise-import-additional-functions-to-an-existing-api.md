
## Append Azure Function App to an existing API

Follow the steps below to append Azure Function App to an existing API

1. In your **Azure API Management** service instance, select **APIs** from the menu on the left

1. Choose an API you want to import an Azure Function App to. Click ... and select **Import** from the context menu

  ![Screenshot of the showing the importing of an existing Azure Function App.](../media/4-append-azure-function-app-01.png)

1. In the pop-up window, click **Browse**

 ![Screenshot of the showing the importing of an existing Azure Function App.](../media/5-append-azure-function-app-02.png)

1. Click on the **Function App** section to choose from the list of available Function Apps.

 ![Screenshot of the showing the importing of an existing Azure Function App.](../media/5-append-azure-function-app-03.png)

1. Find the second Function App you want to import Functions from, click on it and press **Select**

 ![Screenshot of the showing the importing of an existing Azure Function App.](../media/3-import-azure-function-app-04.png)

1. Select the second Function App (Order)

 ![Screenshot of the showing the second Azure Function App to bring into an existing API ](../media/5-append-azure-function-app-05.png)

1. Click **Import**

 ![Screenshot of the showing the second Azure Function App to import into an existing API ](../media/5-append-azure-function-app-06.png)

## Authorization

The import of an Azure Function App automatically generates:

- Host key inside the Function App with the name apim-{your Azure API Management service instance name},
- Named value inside the Azure API Management instance with the name {your Azure Function App instance name}-key, which contains the created host key

## Access Azure Function App host key

1. Navigate to your Azure Function App instance
1. Select **Function App settings** from the overview
1. The key is located in the **Host Keys** section

## Access the named value in Azure API Management

Navigate to your Azure API Management instance and select **Named values** from the menu on the left. The Azure Function App key is stored there.

## Test the function in Azure

Use cURL to test the deployed function. Using the URL that you copied from the previous step, append the query string &name=<yourname> to the URL, as in the following example: In this case the API created earlier is called **Demo Store API** and the Function App is **func-App-instance**

```bash
curl -v -X GET "https://apim-store-instance.azure-api.net/func-App-instance/Product"
-H "Ocp-Apim-Subscription-Key: {subscription key}"

curl -v -X GET "https://apim-store-instance.azure-api.net/func-App-instance/Order"
-H "Ocp-Apim-Subscription-Key: {subscription key}"
```

As you can see both the APIs are exposed via the same endpoint
