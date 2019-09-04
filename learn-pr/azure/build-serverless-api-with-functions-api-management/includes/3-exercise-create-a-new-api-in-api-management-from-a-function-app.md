You can add Functions to Azure API Management, to present them to users as parts of a single API.

In your online store company, your developers have created multiple Azure Functions as microservices. Each function implements a small part of the store's functionality. You want to assemble these functions into single API.

Here, you will create a new API Management instance and then add a Product Details function to it.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create functions

In this exercise, you will add an Azure Function to Azure API Management. Later you will add a second function to the same resource in order to create a single serverless API from multiple functions. Let's start by using a script to create the functions:

1. To clone the functions project, in the Cloud Shell on the right, execute this command:

    <!-- TODO: the URL in this git clone command must be updated when the correct location is known -->
    <!-- TODO: For testing purposes, I expose the code in a repo on my account. We need to update when the real repo is available -->

    ```bash
    git clone https://github.com/AndrewJByrne/bbab38fa-6d69-461a-99be-1b60d8d4b676.git OnlineStoreFuncs
    ```

1. Run the following commands in the Cloud Shell to set up the necessary Azure resources we need for this exercise. 

    ```bash
    cd OnlineStoreFuncs
    bash setup.sh
    ```

    The `setup.sh` script creates the two function apps in the sandbox resource group that we've activated for this module. As the following graphic illustrates, each app hosts a single function - `OrderDetails` and `ProductDetails` respectively. the script also sets up a storage account that the functions need. The functions both have URLs in the **azurewebsites.net** domain. The function names include random numbers for uniqueness. The script takes a few minutes to complete.

    ![Results of the setup.sh script](../media/3-script-results.png)


## Test the product details function

Now, let's test the ProductDetails function, to see how it behaves before we add it to API Management:

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account with which you activated the sandbox.
1. Select **All Resources**.
1. Under **Functions**, select **ProductDetails**, and then select **Test**, as highlighted in the following screenshot: 

    ![Test the ProductDetails function](../media/3-test-product-details-function.png)
1. In the **HTTP method** drop-down list, select **GET**, and then select **Add parameter**.
1. In the **name** textbox, type *id* and in the **value** textbox, type *3*.
1. Select **Run** and then examine the results in the **Output** box.

    ![Test results from the ProductDetails function](../media/3-test-results.png)

    The output pane displays the details of a product in JSON format. You can also test the function with IDs 1 and 2 for different products.

1. At the top of the page, select **</> Get function URL**. Notice that the URL is the name of the function within the **azurewebsites.net** domain. Make a note of this URL for later comparison. 

> [!NOTE]
> You can use this URL to test the function in your browser. Append the query string `&id=1` to request a product.

## Create a new API Management instance

Now that we have a working function. To expose it as an API, we'll create an API Management instance:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Create a resource > Integration > API management**, and then select **Create**.
1. In the API Management service window, enter these settings and then select **Create**:

    | Setting | Value |
    | --- | --- |
    | Name | Use a unique name within the **azure-api.net** domain |
    | Subscription | Concierge |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Location | Choose either the **West Europe** or **Southeast Asia** region. **NOTE:** These locations are the only two that are supported by both the sandbox and the consumption tier | 
    | Organization name | OnlineStore |
    | Administrator email | Use the default value |
    | Pricing tier | Consumption |
    | | | 

    ![Screenshot of the Azure portal showing the Create a new API management instance.](../media/3-create-api-mgmt-instance.png)

1. Wait for the deployment to complete. It may take several minutes.

## Import an Azure Function App as a new API 

Now,we can add the **ProductDetails** function to the API Management instance:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select your **Azure API Management** service instance.
1. Under **API Management**, select **APIs** and then, under **Add a new API**, select **Function App**.

    ![Adding an Azure Function App](../media/3-import-azure-function-app.png)

1. To select your function, select **Browse** and then select the **Function App** section.

    ![Selecting an existing Function App](../media/3-import-azure-function-app-03.png)

1. In the list of Function Apps, select the **ProductFunction** and then choose **Select**.
1. Ensure that **ProductDetails** is checked, and then choose **Select**.
1. In the **API URL suffix** textbox, type **products**, and then select **Create**. 

    ![Completing the import of a Function App](../media/3-complete-import-of-function.png)

## Test the OnlineStore product

You now have a functional product details API in the API Management instance that you created. Let's test that API, by using the API Management tools in the Azure portal:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select your **Azure API Management** service instance.
1. Under **API Management**, select **APIs** and then select the **ProductFunction** API.
1. In the list of operations, select **GET ProductDetails** and then select the **Test** tab.

    ![Browsing to the test tool](../media/3-browse-the-test-tool.png)

1. Under **Query parameters**, select **Add parameter**.
1. In the **name** textbox, enter *id*.
1. In the **value** textbox, enter *1*, and then select **Send**.

    ![Testing the Product Details API](../media/3-complete-the-product-details-test.png)

1. In the **HTTP response**, notice that the details of a product have been returned in JSON format. Also notice the **HTTP request** was sent to a destination within the **azure-api.net** domain. This location is different to the **azurewebsites.net** domain where the original function app is hosted.
