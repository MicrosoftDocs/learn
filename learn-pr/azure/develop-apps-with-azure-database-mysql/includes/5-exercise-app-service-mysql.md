In this unit, you'll build and deploy a sample PHP application to Azure App Service, and integrate it with Azure Database for MySQL - Flexible Server on the back end.

## STEP 1 - Create an Azure Database for MySQL flexible server

First, we'll provision a MySQL flexible server with public access connectivity, configure firewall rules to allow the application to access the server, and create a production database.

We'll use the Azure portal to walk through the MySQL - Flexible Server create experience.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. On the Azure portal menu, or from the Home page, select **Create a resource**.

1. In the search box, search for and select **Azure Database for MySQL Flexible Server**.

1. In the **Azure Database for MySQL Flexible Server** create page, select **Create**.

1. In the **Basics** tab, enter the following information:

    | Setting | Suggested Value |
    | ------------ | ---------------- |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown, select the resource group starting with **learn-** |
    | Server name | Enter a globally unique name that identifies your flexible server. |
    | Workload type | Select **For development or hobby projects** |
    | Admin username | Enter your admin username to be used while connecting to the flexible server. |
    | Password | Enter your admin username to be used while connecting to the flexible server. |

    Keep the default values for all other settings.

1. After you've filled this information, navigate to the **Networking** tab.

    :::image type="content" source="../media/flexible-server-basics.png" alt-text="Screenshot showing Flexible Server create blade, with red box around Networking tab.":::

1. In the **Networking** tab, select **Public access (allowed IP addresses)** connectivity method and check **Allow public access from any Azure service within Azure to this server** as shown in the following screenshot.

    :::image type="content" source="../media/flexible-server-networking.png" alt-text="Screenshot showing Flexible Server networking blade, with red box around Public access connectivity.":::

1. Select **Review + create** to review your flexible server configuration.

1. Select **Create** to provision the server. Provisioning can take a few minutes.

1. After the deployment is done, select **Go to resource** to view the Azure Database for MySQL flexible server's **Overview** page.

For the remainder of this exercise, we'll use the Azure Cloud Shell on the right to run the commands.

To create a new MySQL production database *sampledb* to use with the PHP application, run the following command:

```azurecli
az mysql flexible-server db create \
--resource-group <rgn>[Sandbox resource group name]</rgn> \
--server-name <your-mysql-server-name> \
--database-name sampledb
```

## STEP 2 - Build your application

For the purposes of this exercise, we'll use a sample PHP application that displays and manages a product catalog. The application provides basic functionalities like viewing the products in the catalog, adding new products, updating existing item prices and removing products.

We'll directly clone the coded app and learn how to deploy it on Azure App Service.

**Note:** To learn more about the application code, go ahead and explore the app in the GitHub repository!

1. To clone the sample application repository and change to the repository root, run the following commands:

    ```azurecli
    git clone https://github.com/Azure-Samples/php-mysql-app-service.git
    cd php-mysql-app-service
    ```

1. Run the following command to ensure that the default branch is `main`.

    ```azurecli
    git branch -m main
    ```

## STEP 3 - Create and configure an Azure App Service Web App

In Azure App Service (Web Apps, API Apps, or Mobile Apps), an app always runs in an App Service plan. An App Service plan defines a set of compute resources for a web app to run. In this step, we'll create an Azure App Service plan and an App Service web app within it, which will host the sample application.

1. To create an App Service plan in the Free pricing tier, run the following command:

    ```azurecli
    az appservice plan create --name plan-learn \
    --resource-group <rgn>[Sandbox resource group name]</rgn> \
    --location centralus \
    --sku FREE --is-linux
    ```

1. If you want to deploy an application to Azure web app using deployment methods like FTP or Local Git, you need to configure a deployment user with username and password credentials. After you configure your deployment user, you can take advantage of it for all your Azure App Service deployments.

    ```azurecli
    az webapp deployment user set \
    --user-name <your-deployment-username> \
    --password <your-deployment-password>
    ```

1. To create an App Service web app with PHP 8.0 runtime and to configure  the Local Git deployment option to deploy your app from a Git repository on your local computer, run the following command.

    **Note**: Replace `<your-app-name>` with a globally unique app name (valid characters are a-z, 0-9, and -).

    ```azurecli
    az webapp create \
    --resource-group <rgn>[Sandbox resource group name]</rgn> \
    --plan plan-learn \
    --name <your-app-name> \
    --runtime "PHP|8.0" \
    --deployment-local-git
    ```

    > [!IMPORTANT]
    > In the Azure CLI output, the URL of the Git remote is displayed in the deploymentLocalGitUrl property, with the format `https://<username>@<app-name>.scm.azurewebsites.net/<app-name>.git`. Save this URL, as you'll need it later.

1. Next we'll configure the MySQL flexible server database connection settings on the Web App.

    The `config.php` file in the sample PHP application retrieves the database connection information (server name, database name, server username and password) from environment variables using the `getenv()` function. In App Service, to set environment variables as **Application Settings** (*appsettings*), run the following command:

    ```azurecli
    az webapp config appsettings set \
    --name <your-app-name> \
    --resource-group <rgn>[Sandbox resource group name]</rgn> \
    --settings DB_HOST="<your-server-name>.mysql.database.azure.com" \
    DB_DATABASE="sampledb" \
    DB_USERNAME="<your-mysql-admin-username>" \
    DB_PASSWORD="<your-mysql-admin-password>" \
    MYSQL_SSL="true"
    ```

## STEP 4 - Deploy your application using Local Git

Now, we'll deploy the sample PHP application to Azure App Service using the Local Git deployment option.

1. Since you're deploying the main branch, you need to set the default deployment branch for your App Service app to main. To set the DEPLOYMENT_BRANCH under **Application Settings**, run the following command:

    ```azurecli
    az webapp config appsettings set \
    --name <your-app-name> \
    --resource-group <rgn>[Sandbox resource group name]</rgn> \
    --settings DEPLOYMENT_BRANCH='main'
    ```

1. Verify that you are in the application repository's root directory.

1. To add an Azure remote to your local Git repository, run the following command.

    **Note:** Replace `<deploymentLocalGitUrl>` with the URL of the Git remote that you saved in the **Create an App Service web app** step.

    ```azurecli
    git remote add azure <deploymentLocalGitUrl>
    ```

1. To deploy your app by performing a `git push` to the Azure remote, run the following command. When Git Credential Manager prompts you for credentials, enter the deployment credentials that you created in **Configure a deployment user** step.

    ```azurecli
    git push azure main
    ```

The deployment may take a few minutes to succeed.

## STEP 5 - Test your application

Finally, test the application by browsing to `https://<app-name>.azurewebsites.net`, and then add, view, update or delete items from the product catalog.

Congratulations! You have successfully deployed a sample PHP application to Azure App Service and integrated it with Azure Database for MySQL - Flexible Server on the back end.
