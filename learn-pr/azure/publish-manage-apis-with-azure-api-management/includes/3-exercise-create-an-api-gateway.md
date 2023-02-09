To share an API, you must first configure an API gateway.

In the shoe company example, NorthWind Shoes has decided to share an inventory API with partners. This API enables partners to access inventory and product information.

Here, you'll create an API gateway to publish an inventory app that exposes an OpenAPI endpoint.

## Deploy the ShoeCompany Web API

You've developed a .NET Core app that generates inventory and product information. The app includes Swashbuckle to generate OpenAPI Swagger documentation.

To save time, let's start by running a script to host our RESTful API in Azure. The script performs the following steps:

- Create an Azure App Service plan in the free tier
- Create a Web API within an Azure App Service, configured for Git deployment from a local repo
- Set account-level deployment credentials for our app
- Configure Git locally
- Deploy our Web API to our App Service instance

1. Run the following git command in the Cloud Shell to clone the GitHub repo that contains the source for our app.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-publish-manage-apis-with-azure-api-management.git
    ```

1. After the operation has completed, open your local repo folder and list its contents by running the following commands.

    ```bash
    cd mslearn-publish-manage-apis-with-azure-api-management
    ls -l
    ```

   One of the files is setup.sh. As its name suggests, it's the script we'll run to set up our test API. 

1. Enter the following command to run this script. It will generate a public web app that exposes an OpenAPI interface.

    ```bash
    bash setup.sh
    ```

    The script takes about a minute to run. During deployment, all dependencies needed for our app to run are automatically installed on the remote App Service. The output lists all the operations. When the script finishes, the last two lines are URLs that you'll use to test the app deployment.

1. To test that our app deployed correctly, copy the first URL (Swagger URL) from Cloud Shell and paste it into a new tab of your browser.

   The browser should display the swagger UI for our app and declare the following RESTful endpoints:

    - **api/inventory** generates a list of products and the number in stock
    - **api/inventory/{productid}** returns the number in stock for the specified product ID (an integer)
    - **api/Products** generates a list of products
    - **api/Products/{productid}** returns the details for the specified product ID

    :::image type="content" source="../media/3-swagger.png" alt-text="Overview of API management." loc-scope="third-party"::: <!-- no-loc -->

1. Finally, copy the second URL (Swagger JSON URL) from the Cloud Shell output, and save it somewhere such as Notepad. You'll need this URL in the next exercise.

## Deploy an API gateway

The final task in this exercise is to create an API gateway in the Azure portal. In the next exercise, you'll use this gateway to publish your API.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. In **Azure services**,  or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the resource menu, select **Integration**, and in the results, select **API management**. The **Install API Management gateway** pane appears.

1. In the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --------- | --------- |
    | **Project details** |
    | Subscription | Concierge Subscription |
    | Resource group | Select the resource group <rgn>[sandbox resource group name]</rgn> |
    | **Instance details** |
    | Region | Select one of the following regions: North Central US, West US, West Europe, North Europe, Southeast Asia, and Australia East. The Consumption tier used in this exercise is available in these regions. |
    | Resource Name | `apim-NorthWindShoes<random number>`, replacing `random number` with your own series of numbers to ensure that the name is globally unique. |
    | Organization Name | `NorthWindShoes`. This name is used to identify your resources in the developer portal. |
    | Administrator Email | If it doesn't display your Azure account email address by default, select your email from the dropdown list. |
    | Pricing Tier | `Consumption` |

   > [!NOTE]
   > The consumption plan is much faster to generate output during the testing process. The overall experience is very similar to the other pricing tiers and the resources will be deleted automatically when the sandbox expires.

1. Select **Review+create** to validate your settings.

1. When validation has passed, select **Create**. Deployment may take several minutes to complete. When deployment has completed, you'll see the gateway listed in the Azure resources. You'll also receive an email message. It may take several minutes for deployment to complete.

1. When deployment is complete, select **Go to resource** to view the pane for your API Management service.
