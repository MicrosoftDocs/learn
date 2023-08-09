In this exercise, you deploy a sample web API, and you configure an API gateway. You'll publish the web API to your gateway in a later unit.

In the shoe company example, NorthWind Shoes has decided to share an inventory API with partners. This API enables partners to access inventory and product information.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Deploy the ShoeCompany web API

You've developed a .NET Core app that generates inventory and product information. The app includes Swashbuckle to generate OpenAPI Swagger documentation.

To save time, let's start by running a script to host our RESTful API in Azure. The script performs the following steps:

- Create an Azure App Service plan in the free tier
- Create a web API within an Azure App Service, configured for Git deployment from a local repo
- Set account-level deployment credentials for our app
- Configure Git locally
- Deploy our web API to our App Service instance

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. In the Azure taskbar, select the Cloud Shell icon to open Azure Cloud Shell.

    :::image type="content" source="../media/3-cloud-shell-icon.png" alt-text="Screenshot of Cloud Shell icon in taskbar.":::

1. Run the following `git` command in the Cloud Shell to clone the GitHub repo and download the source code for our app.

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

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. In **Azure services**,  or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the resource menu, select **Integration**, and in the results, select **API Management**. The **Create API Management service** pane appears.

1. In the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --------- | --------- |
    | **Project details** |
    | Subscription | Select your subscription.|
    | Resource group | Select a new or existing resource group. A resource group is a logical container that holds related resources for an Azure solution.  |
    | **Instance details** |
    | Region | Select an available region. |
    | Resource Name | `apim-NorthWindShoes<random number>`, replacing `random number` with your own series of numbers to ensure that the name is globally unique. |
    | Organization Name | `NorthWindShoes`. The name of your organization for use in the developer portal and email notifications. (The developer portal and notifications aren't available in all service tiers.)|
    | Administrator Email | The email address to receive all system notifications.   |
    | Pricing Tier | `Consumption` |

   > [!NOTE]
   > The Consumption tier provides fast deployment for testing and has a pay-for-use pricing model. The overall API management experience is similar to the other pricing tiers.

1. Select **Review + create** to validate your settings.

1. When validation has passed, select **Create**. Deployment may take several minutes to complete.

1. When deployment has completed, you'll see the API Management instance listed in the Azure resources. Select **Go to resource** to view the pane for your API Management service.
