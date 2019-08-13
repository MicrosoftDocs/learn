You can add Functions to Azure API Management, to present them to users as parts of a single API.

In your online store company, your developers have created multiple Azure Functions as micro-services. Each function implements a small part of the store's functionality. You want to assemble these functions into single API.

Here, you will create a new API Management instance and then add a Product Details function to it.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create functions

In this exercise, you will add an Azure Function to Azure API Management. Later you will add a second Function to the same resource in order to create a single serverless API from multiple Functions. Let's start by using a script to create the Functions:

1. To clone the functions project, in the Cloud Shell on the right, execute this command:

    <!-- TODO: the URL in this git clone command must be updated when the correct location is known -->
    <!-- TODO: For testing purposes, I expose the code in a repo on my account. We need to update when the real repo is available -->

    ```bash
    git clone https://github.com/AndrewJByrne/bbab38fa-6d69-461a-99be-1b60d8d4b676.git OnlineStoreFuncs
    ```

1. To run the script that sets up the necessary Azure resources, execute these commands:

    ```bash
    cd OnlineStoreFuncs
    bash setup.sh
    ```

    <!-- TODO: You need to explain what the script is doing and let the learners view it in a browser. You also need to set expectations about how long the script runs for. On my test, it takes "a few minutes to run" (6+). Ideally we'd show a picture of the function apps and functions within them, to give the learner a feeling for what is happening.  -->

## Test the product details function

<!-- TODO: Explain why we are testing the function -->
Now, test the Product Details Function. This function is not part of  API Management yet:

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
<!-- TODO: I prefer select over click for Accessibility reasons -->
1. Click **All Resources** and then click the product function. <!-- TODO: Break this up into two instructions. The second instruction should be more explicit and tell the learner to select the App Service with the name beginning with ProductFunction. Should also explain the naming convention used.  -->
1. Under **Functions**, click **ProductDetails**, and then click **Test**. <!-- TODO ... as highlighted in the following screenshot -->

    ![Test the ProductDetails function](../media/3-test-product-details-function.png)

1. In the **HTTP method** drop-down list, select **GET**, and then click **Add parameter**.
1. In the **name** textbox, type **id** and in the **value** textbox, type **3**.
1. Click **Run** and then examine the results in the **Output** box.

    ![Test results from the ProductDetails function](../media/3-test-results.png)

    The output pane displays the details of a product in JSON format. You can also test the function with IDs 1 and 2 for different products.

1. At the top of the page, click **</> Get function URL**. Notice that the URL is the name of the function within the **azurewebsites.net** domain. Make a note of this URL for later comparison. <!-- TODO: Given that we've asked them to save off the function URL, consider mentioning or showing  them how to test with it in their favorite browser -->

## Create a new API Management instance

Now that we have a working Function, let's create the API Management resource:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Create a resource > Integration > API management**, and then click **Create**.
1. In the API Management service window, enter these settings and then click **Create**:

    | Setting | Value |
    | --- | --- |
    | Name | Use a unique name within the **azure-api.net** domain |
    | Subscription | Concierge |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Location | Choose either **West Europe** or **Southeast Asia** | <!-- NOTE: these are the only two locations that are supported by both the sandbox and the consumption tier --> <!-- TODO: You have to tell the learner that fact.  -->
    | Organization name | OnlineStore |
    | Administrator email | Use the default value |
    | Pricing tier | Consumption |
    | | | 

    ![Screenshot of the Azure portal showing the Create a new API management instance.](../media/3-create-api-mgmt-instance.png)

<!-- NOTE: this is currently resulting in a sandbox policy error. Engineering must review the policies -->

<!-- TODO: I know it might feel obvious to us, but we need to tell learners that this step takes some time and to wait for it to complete successfully before continuing. FYI - validating this took a long time to complete for me. -->

## Import an Azure Function App as a new API 

<!-- TODO: You introduce the concept of creating a product for the function. What does that mean? Is it an APIM concept? Explain to the learner -->
Now, we can add the **Product Details** function to the API Management instance and create a product for it:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All resources** and then click your **Azure API Management** service instance.
1. Under **API Management**, click **APIs** and then, under **Add a new API**, click **Function App**.

    ![Adding an Azure Function App](../media/3-import-azure-function-app.png)

1. To select your function, click **Browse** and then click on the **Function App** section.

    ![Selecting an existing Function App](../media/3-import-azure-function-app-03.png)

1. In the list of Function Apps, click the **ProductFunction** and then click **Select**.
1. Ensure that **ProductDetails** is checked, and then click **Select**.
1. In the **API URL suffix** textbox, type **products**, and then click **Create**. 

    ![Completing the import of a Function App](../media/3-complete-import-of-function.png)

## Test the OnlineStore product

You now have a functional product details API in the API Management instance that you created. Let's test that API, by using the API Management tools in the Azure portal:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All resources** and then click your **Azure API Management** service instance.
1. Under **API Management**, click **APIs** and then click the **ProductFunction** API.
1. In the list of operations, click **GET ProductDetails** and then click the **Test** tab.

    ![Browsing to the test tool](../media/3-browse-the-test-tool.png)

1. Under **Query parameters**, click **Add parameter**.
1. In the **name** textbox, type **id**.
1. In the **value** textbox, type **1**, and then click **Send**.

    ![Testing the Product Details API](../media/3-complete-the-product-details-test.png)

1. In the **HTTP response**, notice that the details of a product have been returned in JSON format. Also notice the **HTTP request** was sent to a destination within the **azure-api.net** domain. This location is different to the **azurewebsites.net** domain where the original function app is hosted.
