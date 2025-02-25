
Static web apps are a concept in web site design that has become popular. They consist of content sent directly to a user's browser that doesn't require any code to be executed on the server. Static web apps consist of HTML and CSS. They also often include JavaScript code, which executes on the client-side, not the server. Web developers often find that static web apps:

- Can be developed quickly with frameworks like Bootstrap, Jekyll, and AngularJS.
- Are simple to scale because no state changes on the server.
- Encourage separation between user interface code and back-end functionality.

Azure Static Web Apps is a service in Azure designed to make it simpler to code and deploy static web apps to Azure for production. Azure Static Web Apps supports continuous deployment by monitoring a code repository in GitHub or Azure DevOps. When you make a change to the web site code, and push your change to the repository, Azure Static Web Apps spots the change and automatically builds and deploys the new site to Azure. Immediately, your change becomes available to users.

:::image type="content" source="../media/3-azure-static-web-apps-overview.png" alt-text="Diagram showing how Azure Static Web Apps eases the deployment of static web apps from repositories." lightbox="../media/3-azure-static-web-apps-overview.png":::

Because the Data API Builder (DAB) is designed to work seamlessly with Azure Static Web Apps, it's simple to host your database APIs in this service. All you have to do is use the configuration file to tell DAB about your Azure Static Web Apps instance and deploy it to a repository. Azure Static Web Apps will host your API and users can start calling its methods.

## Create a static web app

Start by navigating to the [Azure portal](https://portal.azure.com?azure-portal=true) and selecting **Create a resource**. In the search bar, enter **Static Web App**. When the **Static Web App** card appears, select it and then select **Create**.

Next, choose your **Subscription** and either select an existing **Resource Group** or create a new one. In the **Name** textbox, enter a descriptive name for your app. You need to select the **Plan type**. For personal projects, you can use the **Free** plan, while for production apps, the **Standard** plan is recommended.

:::image type="content" source="../media/3-create-azure-static-web-app.png" alt-text="Screenshot showing how to complete the wizard to create a static web app in the Azure portal." lightbox="../media/3-create-azure-static-web-app.png":::

Under **Deployment details**, specify the type of repository that contains your app. You need to sign into GitHub or select the repository and branch in Azure DevOps. Finally, review your settings by selecting **Review + create**, and then select **Create** to complete the process.

## Create a Data API builder configuration file

To deploy your database API to Azure Static Web Apps, you must create the DAB configuration file correctly. You can complete this task with two command line tools:

- `swa`: Use this CLI to initialize a new DAB configuration file.
- `dab`: Use this CLI to add one or more databases to the file.

Before you begin, either clone the GitHub repository to your local machine, or use GitHub Codespaces to open a command prompt in GitHub itself.

1. To initialize the DAB configuration file in the root folder of the repository, run the following command.

    ```dotnetcli
    swa db init --database-type "<database-type>"
    ```

    Replace `<database type>` with your database server. For example, if your database is hosted in Azure SQL Database, use `mssql`. If it's in MySQL, use `mysql`.
1. To add a database to the configuration file, run the following command.

    ```dotnetcli
    dab add "<database-name>" --source "<schema>.<table>" --permissions "anonymous:*" -config "swa-db-connections/staticwebapp.database.config.json"
    ```

    Replace `<database-name>` with a descriptive name and `<schema>.<table>` with the schema and table name in your database.

These steps create a configuration file in the repository named **swa-db-connections/staticwebapp.database.config.json**. Review this file before you commit your changes to the repository.

## Configure the connection to the database

To configure the connection to the database in your static web app, start by opening the static web app in the [Azure portal](https://portal.azure.com?azure-portal=true). Navigate to the **Settings** section and select **Database connection**. Under **Production**, choose to link an existing database. Select the appropriate database type, resource group, and database name. Finally, choose your preferred authentication type and link the database.

> [!NOTE]
> We recommend you use a system-assigned managed identity or user-assigned managed identity to authenticate because the connection string doesn't include an authorization key.

## Validate access to the API

To validate access to the API, start by opening the static web app you created in the [Azure portal](https://portal.azure.com?azure-portal=true). Navigate to the **Essentials** section and select the **URL** to browse the website. In the browser's address bar, add `/data-api` to the URL and press *Enter*. 

You should see a page indicating that the DAB container is healthy. To browse entities from your database, append `/data-api/rest/` to the URL. This sends an HTTP GET request and display the JSON response.
