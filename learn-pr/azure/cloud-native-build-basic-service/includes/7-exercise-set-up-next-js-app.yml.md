This exercise takes you through the process of creating and configuring a Next.js-based web service that relies on Prisma to provide access to Azure Database for PostgreSQL.

> [!NOTE]
> Prisma is a more recently developed object-relational mapper library, which provides an alternative approach to data modeling from the one offered by Sequelize.

In this exercise, you'll:

* Configure a Next.js application.
* Deploy an Azure App Service web app hosting the Next.js application.
* Validate the functionality of the Next.js application.

## Prerequisites

To perform this exercise, you need:

* An Azure subscription.
* A Microsoft account or a Microsoft Entra account with the Global Administrator role in the Microsoft Entra tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
* To have completed the first exercise of this module. You'll use the Azure PostgreSQL database you created and configured in that exercise.

## Configure a Next.js application

In this task, you'll clone a GitHub repo containing a sample Next.js code and customize it to connect to the existing Azure PostgreSQL database.

1. If needed, start a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) and sign in to access the Azure subscription you're using in this module.
1. In the Azure portal, start a Bash session within the **Cloud Shell** by selecting its icon in the toolbar next to the search text box.
1. From the Bash session on the **Cloud Shell** pane, run the following command to clone the GitHub repo containing the sample Next.js application code that you'll use in this exercise:

    ```azurecli
    cd ~/
    git clone https://github.com/MicrosoftDocs/mslearn-cloud-native-apps.git
    ```

1. Run the following command to switch to the directory containing the clone of the GitHub repo:

    ```azurecli
    cd ~/mslearn-cloud-native-apps/m03u07/
    ```

1. Run the following command to display the content of the **./prisma/schema.prisma** file containing the definition of the data model corresponding to the **inventory** table in the **cnainventory** database:

    ```azurecli
    cat ./prisma/schema.prisma
    ```

    The **schema.prisma** file has the following content:

    ```json
    // This is your Prisma schema file,
    // learn more about it in the docs: https://pris.ly/d/prisma-schema
    
    datasource db {
      provider = "postgresql"
      url      = env("DATABASE_URL")
    }
    
    generator client {
      provider = "prisma-client-js"
    }
    
    model inventory {
      id        Int @id
      name      String
      quantity  Int
      date      DateTime
    }
    ```

1. Run the following command to display the content of the **.env** file, which stores the connection string to the Azure PostgreSQL database, including the values representing the name of the PostgreSQL server, the name of the administrative account, and its password (that's the `DATABASE_URL` referenced in the **./prisma/schema.prisma** file):

    ```azurecli
    cat ./.env
    ```

    The file includes the connection string entry in the following content:

    ```javascript
    DATABASE_URL="postgresql://USER_NAME%40SERVER_NAME:PASSWORD@SERVER_NAME.postgres.database.azure.com:5432/cnainventory"
    ```

1. Run the following command to display the content of the **index.tsx** file containing the Next.js script, which queries the content of the **inventory** table in the **cnainventory** database based on the information derived from Prisma:

    ```azurecli
    cat ./pages/index.tsx
    ```

    > [!NOTE]
    > The **index.tsx** file has the following content:

    ```javascript
    declare global {
      namespace NodeJS {
        interface Global {
          prisma: any;
        }
      }
    }

    import prisma from '../lib/prisma';
    import Head from "next/head";

    export const getServerSideProps = async ({ req }) => {
      const inventory = await prisma.inventory.findMany({
      })
      return { props: {inventory} }
    }

    export default ({ inventory }) =>
      <div>
        <Head>
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <meta charSet="utf-8" />
          <title>Next.js with Azure PostgreSQL inventory data</title>
          <meta name="title" content="Next.js with Azure PostgreSQL inventory data" />
          <meta
            name="description"
            content="Next.js with Azure PostgreSQL inventory data"
          />
          <meta property="og:type" content="website" />
          <meta property="og:title" content="Next.js with Azure PostgreSQL inventory data" />
          <meta
            property="og:description"
            content="Next.js with Azure PostgreSQL inventory data"
          />
        </Head>
        <div className="w-full text-center bg-blue-800 flex flex-wrap items-center">
          <div className="text-3xl w-1/2 text-white mx-2 md:mx-auto py-10">
            Next.js - PostgreSQL inventory data
          </div>
        </div>
        <div className="bg-gray-200 py-10">
          {inventory.map(({id, name, quantity, date}) => (
            <div
              className="flex bg-white shadow-lg rounded-lg mx-2 md:mx-auto mb-10 max-w-2xl"
              key={id}
            >
              <div className="flex items-start px-4 py-6">
                <div className="">
                  <div className="inline items-center justify-between">
                    <h2 className="text-lg font-bold text-gray-900 -mt-1">
                      {id}
                    </h2>
                    <small className="text-sm text-gray-700 object-right">
                      Id: {id}
                    </small>
                    <small className="ml-3 text-gray-700 text-sm">
                      Name: {name}
                    </small>
                    <small className="ml-3 text-gray-700 text-sm">
                      Quantity: {quantity}
                    </small>
                    <small className="ml-3 text-gray-700 text-sm">
                      Date: {date.toString().substring(0,10)}
                    </small>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div
    ```

    > [!NOTE]
    > The script relies on Prisma to query the content of the database and uses React to display individual records from the inventory table, including their respective data.

1. Run the following commands to retrieve the values of the Cosmos DB SQL API endpoint and the corresponding access key, and store them in temporary variables:

    ```azurecli
    RG1NAME=postgresql-db-RG
    SERVER_NAME=$(az postgres server list --resource-group $RG1NAME --query "[0].name" --output tsv)
    USER_NAME='Student'
    PASSWORD='Pa55w0rd1234'
    ```

1. Run the following commands to replace the placeholders in the **.env** file with the values you set in the previous step:

    ```azurecli
    sed -i "s/SERVER_NAME/$SERVER_NAME/g" ./.env
    sed -i "s/USER_NAME/$USER_NAME/" ./.env
    sed -i "s/PASSWORD/$PASSWORD/" ./.env
    ```

1. Run the following command to validate that the **.env** file contains the actual values of the Azure PostgreSQL server and its administrative credentials:

    ```azurecli
    cat ./.env
    ```

    > [!NOTE]
    > At this point, you'd typically run `npm run install` and `npm run-script build`. Because of versioning issues, this isn't directly available in Azure Cloud Shell. You'll remediate this by running the build following the deployment.

## Deploy an Azure App Service web app hosting the Next.js application

As in the previous exercise, you could, at this point, containerize the newly customized Next.js app. However, for the sake of simplicity, you'll deploy it to an Azure App Service. This will provide a quick way to validate its functionality and ensure that containerizing it is a viable option.

> [!NOTE]
> You could deploy the same application to any other Azure service that provides the Node.js runtime environment, including Azure VMs, Azure Container Instances, or Azure Kubernetes Service.

1. Within the web browser window displaying the Azure portal, from the Bash session on the **Cloud Shell** pane, run the following commands to create a resource group that will host the Azure web app, into which you will deploy the Next.js application:

    ```azurecli
    RG1NAME=postgresql-db-RG
    LOCATION=$(az group show --resource-group $RG1NAME --query location --output tsv)
    RG2NAME=cna-nextjs-RG
    az group create --name $RG2NAME --location $LOCATION
    ```

1. Run the following commands to create an Azure App Service plan that will host the new Azure web app:

    ```azurecli
   SPNAME=nextjs-sp
   az appservice plan create --name $SPNAME --resource-group $RG2NAME --sku B1
    ```

1. Run the following commands to create a Node.js-based Azure web app:

    ```azurecli
    WEBAPPNAME=nextjs$RANDOM$RANDOM
    az webapp create --name $WEBAPPNAME --resource-group $RG2NAME --plan $SPNAME --runtime "NODE|12-lts"
    ```

1. Run the following commands to reinitialize the local Git repository and commit all the changes in the main branch:

    ```azurecli
    cd ~/wp2104-m03u07/
    git init
    git add -A
    git commit -m "Initial Commit"
    ```

1. Run the following commands to set up user-level deployment credentials:

    ```azurecli
    DEPLOYMENTUSER=m03u07User$RANDOM
    DEPLOYMENTPASS=m03u07Pass$RANDOM$RANDOM
    az webapp deployment user set --user-name $DEPLOYMENTUSER --password $DEPLOYMENTPASS
    ```

1. Run the following commands to identify the user-level deployment credentials. Make sure to record their values because you'll need them later in this exercise:

    ```azurecli
    echo $DEPLOYMENTUSER
    echo $DEPLOYMENTPASS
    ```

1. Run the following command to identify the Azure web app deployment URL that you'll use as the target of the `git push` command:

    ```azurecli
    DEPLOYMENTURL=$(az webapp deployment source config-local-git --name $WEBAPPNAME --resource-group $RG2NAME --output tsv)
    ```

1. Run the following command to configure the remote repo named **azure**, representing the deployment URL you identified in the previous step:

    ```azurecli
    git remote add azure $DEPLOYMENTURL
    ```

1. Run the following commands to push the content of the master branch to the Azure web app, when prompted for the password that's part of the user-level deployment credentials you recorded previously in this task:

    ```azurecli
    git push --set-upstream azure master
    ```

    > [!NOTE]
    > Wait for the deployment to complete. This should take about ten minutes. Once the deployment completes, you should receive a message stating that the deployment was successful.

1. Close the **Cloud Shell** pane.

## Validate the functionality of the Next.js application

In this task, you'll validate the functionality of the Next.js application deployed to an Azure web app.

1. In the web browser window displaying the Azure portal, use the **Search resources, services, and docs** text box at the top of the Azure portal page to search for **App Services**.
1. On the **App Services** blade, in the list of App Service instances, select the entry representing the Azure web app you deployed in the previous task of this exercise. 

    > [!NOTE]
    > The web app name will have the **nextjs** prefix. You can also identify it by reviewing the output of the deployment you completed in the previous task.

1. On the blade displaying the properties of the web app, in the vertical menu, in the **Development Tools** section, select the **App Service Editor (Preview)** entry, and then on the **App Service Editor (Preview)**, select **Go**.
1. On the **App Service Editor** interface, in the vertical menu, select the **Open Console** icon, which is directly after the **Start** icon.

    :::image type="content" source="../media/7-next-js-web-app-console.png" alt-text="Screenshot of the console pane of the App Service Editor interface of the Azure web app.":::

1. From the console prompt, run the following command to build the Next.js application you pushed to the Azure web app:

    ```cmd
    npm run-script build
    ```

1. Wait for the build process to complete.

    :::image type="content" source="../media/7-next-js-web-app-build.png" alt-text="Screenshot of the completed build process in the App Service Editor console of the Azure web app.":::

1. Close the web browser tab displaying the **App Service Editor** page.
1. On the Azure portal blade displaying the properties of the web app, in the vertical menu, select the entry labeled **Overview**. On the **Essentials** pane, select the link labeled **URL**. This will automatically open another web browser tab displaying the newly deployed Azure web app.
1. Verify that the web browser page displays the **Next.js - PostgreSQL inventory data** page with the inventory items retrieved from the Azure PostgreSQL database.

    :::image type="content" source="../media/7-next-js-web-app-deployed.png" alt-text="Screenshot of the page of the deployed Azure web app containing the listing of the inventory items.":::

## Results

Congratulations! You've completed the third and final exercise of this module. In this exercise, you created and configured a Next.js-based app that relies on Prisma to provide access to Azure Database for PostgreSQL.

## Clean up the resources

To avoid unnecessary charges from usage of Azure resources, you should delete the **postgresql-db-RG**, **cna-express-RG**, and **cna-nextjs-RG** resource groups you created throughout the exercises of this module. To do so, in the Azure portal, navigate to the blade of each of these resource groups, and select the **Delete resource group** entry in the toolbar. In the **TYPE THE RESOURCE GROUP NAME** textbox, enter the name of the resource group, and then select **Delete**.
