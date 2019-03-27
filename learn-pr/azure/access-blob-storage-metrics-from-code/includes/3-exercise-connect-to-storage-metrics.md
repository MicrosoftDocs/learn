Before you begin writing code that retrieves and displays metrics in an app, you want to connect to the REST API and observe data that is available. To do this, you'll use the **curl** command line tool to send a request.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a Storage Account

You must start by creating the Azure Storage account that will send data to Azure Monitor. Follow these steps:

1. Go to the [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and in the navigation on the left, click **Create a resource**.
1. In the **Search the marketplace** textbox, type **Storage Account** and then press Enter.
1. In the list of results, click **Storage Account**, and then click **Create**.
1. In the **Storage account name** textbox, type a unique name. This must be all lower case and unique to Azure. For example, you could use **&lt;yourname&gt;videostorage** if that is not already in use. Make a note of the name you use.
1. In the **Location** drop-down list, select a location near you.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Leave all other fields at their default values, and then click **Review + create**.
1. Review the configuration and then click **Create**.

## Obtain the required values

In order to obtain metrics from Azure Monitor that relate to your new Storage account, you must identify that Storage account uniquely in your request. You do this by including the storage account name, resource group name, and subscription ID in the request URL. You already know the name of the storage account but you must determine the resource group name and the subscription ID. Follow these steps:

1. When the Storage account has been created, in the portal, click **All resources** and then click the Storage account you just created.
1. Carefully make a note of the following GUID values, which are shown at the top of the **Overview** page:
    - Resource group.
    - Subscription ID.

    ![Obtaining the resource group name and subscription ID](../media/3-obtain-rg-and-subscription-ids.png)

## Send queries to the REST API

A REST API responds to requests sent through the HTTP protocol. For this reason, we can use the **curl** tool to send those requests and receive data in JSON format. To do this you need to pass an authentication token with your request and formulate the request URL carefully. Follow these steps:

1. In the Cloud Shell on the right, to obtain an authentication token, type the following command and then press Enter:

    ```bash
    AUTH_HEADER="Authorization: Bearer $(az account get-access-token --query accessToken -o tsv)"
    ```

1. To store the necessary identifiers and names, enter the following commands, substituting the values you determined above:

    ```bash
    SUB_ID="<Subscription ID>"
    RG_NAME="<Resource Group Name>"
    SA_NAME="<Storage Account Name>"
    ```

1. To formulate the correct URL for a query to list metrics, type the following command and then press Enter:

    ```bash
    LIST_METRICS_URL="https://management.azure.com/subscriptions/$SUB_ID/resourceGroups/$RG_NAME/providers/Microsoft.Storage/storageAccounts/$SA_NAME/providers/microsoft.insights/metricdefinitions?api-version=2018-01-01"
    ```

1. To make a query against the REST API, type the following command and then press Enter. Examine the results and identify the available metrics:

    ```bash
    curl -s -H "$AUTH_HEADER" "$LIST_METRICS_URL" | jq
    ```

    > [!NOTE] In this **curl** command, the **-s** option suppresses the progress bar and the -H option passes the authentication token. The JSON results are piped to the **jq** tool for a more readable presentation.

1. To formulate the correct URL for a query to list metrics, type the following command and then press Enter:

    ```bash
    AVAILABILITY_URL="https://management.azure.com/subscriptions/$SUB_ID/resourceGroups/$RG_NAME/providers/Microsoft.Storage/storageAccounts/$SA_NAME/providers/microsoft.insights/metrics?metricnames=Availability&aggregation=Average&interval=PT1H&api-version=2018-01-01"
    ```

1. To make a query against the REST API, type the following command and then press Enter. Examine the results and identify the available metrics:

    ```bash
    curl -s -H "$AUTH_HEADER" "$AVAILABILITY_URL" | jq
    ```

1. Examine the results. You can also make requests for other metrics that were listed in the first query results.
