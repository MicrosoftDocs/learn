This exercise provides an overview of integrating a Next.js with an IoT data pipeline. For more information about these topics, refer to:

* [Export IoT data to cloud destinations using data export](https://docs.microsoft.com/azure/iot-central/core/howto-export-data?tabs=javascript?azure-portal=true)
* [How to use analytics to analyze device data](https://docs.microsoft.com/azure/iot-central/core/howto-create-analytics?azure-portal=true)

In this exercise, you'll:

* Clone a GitHub repo containing a sample Next.js code and customize it to process the existing Cosmos DB-resident IoT data.
* Deploy an Azure web app hosting the Next.js application.
* Validate the functionality of the Azure web app.

## Prerequisites

To perform this exercise, you need:

* An Azure subscription.
* A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
* To have completed the exercise units **Set up Azure Cosmos DB** and **Integrate Azure Cosmos DB with the IoT data pipeline**.

In this exercise, you'll use an existing Next.js application code that retrieves IoT telemetry data from the Cosmos DB collection you implemented in the previous exercise unit of this module.

## Configure a Next.js application

In this task, you'll configure a sample Next.js application that retrieves data from a Cosmos DB collection.

1. Start a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) and sign in to access the Azure subscription you'll be using in this module.
1. In the Azure portal, in the toolbar, select the **Cloud Shell** icon located next to the search box.

    > [!NOTE]
    > Alternatively, you can access Cloud Shell directly by navigating to [https://shell.azure.com](https://shell.azure.com?azure-portal=true).
    
1. If you're prompted to select either **Bash** or **PowerShell**, select **Bash**.

    > [!NOTE]
    > If this is the first time you're starting **Cloud Shell** and you're presented with the **You have no storage mounted** message, select the subscription you're using in this lab, and then select **Create storage**.
  
1. From the Bash session in the **Cloud Shell** pane, run the following command to clone the GitHub repo containing the sample Next.js application code you'll use in this exercise:

   ```bash
   git clone https://github.com/polichtm/wp2104-m05u08.git
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following command to switch to the directory containing the clone of the GitHub repo:
  
   ```bash
   cd wp2104-m05u08/
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following command to display the content of the **index.js** file containing the Next.js script that establishes a connection to the Cosmos DB account you created in the first exercise of this module and queries the content of the **iotcollection** in the **iotdb** database, which you created in the second exercise of this module:

   ```bash
   cat ./pages/index.js
   ```
   The **index.js** file has the following content:

   ```jscript
   const CosmosClient = require("@azure/cosmos").CosmosClient;
   import config from "../config";
   import Head from "next/head";

   Home.getInitialProps = async function () {
     const { endpoint, key, database, container } = config;

     const client = new CosmosClient({ endpoint, key });

     const databaseID = client.database(database);
     const containerID = databaseID.container(container);

     if (endpoint) {
       console.log(`Querying container:\n${containerID}`);
       const querySpec = {
         query: "SELECT * FROM c",
       };

       const { resources: items } = await containerID.items
         .query(querySpec)
         .fetchAll();
       return { CosmoIoTData: items };
     }
   };

   export default function Home({ CosmoIoTData }) {
     return (
       <div>
         <Head>
           <meta name="viewport" content="width=device-width, initial-scale=1" />
           <meta charSet="utf-8" />
           <title>Next.JS with Azure Cosmos DB IoT telemetry data</title>
           <meta name="title" content="Next.JS with Azure Cosmos DB IoT telemetry data" />
           <meta
             name="description"
             content="Next.JS with Azure Cosmos DB IoT telemetry data"
           />
           <meta property="og:type" content="website" />
           <meta property="og:title" content="Next.JS with Azure Cosmos DB IoT telemetry data" />
           <meta
             property="og:description"
             content="Next.JS with Azure Cosmos DB IoT telemetry data"
           />
         </Head>
         <div className="w-full text-center bg-blue-800 flex flex-wrap items-center">
           <div className="text-3xl w-1/2 text-white mx-2 md:mx-auto py-10">
             NextJS - CosmosDB IoT telemetry data
           </div>
         </div>
         <div className="bg-gray-200 py-10">
           {CosmoIoTData.map(({id, pk, deviceId, timestamp, temperature }) => (
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
                       DeviceId: {deviceId}
                     </small>
                     <small className="ml-3 text-gray-700 text-sm">
                       Timestamp: {timestamp}
                     </small>
                     <small className="ml-3 text-gray-700 text-sm">
                       Temperature: {temperature}
                     </small>
                   </div>
                 </div>
               </div>
             </div>
           ))}
         </div>
       </div>
     );
   ```

1. From the Bash session in the **Cloud Shell** pane, run the following command to display the content of the **config.js** file, whose purpose is to store the values representing the Cosmos DB SQL API endpoint, the corresponding access key, and the target database and container hosting the IoT data you collected in the previous exercise of this module:

   ```bash
   cat ./config.js
   ```
   
      > [!NOTE]
      > The names of the database and container are already prepopulated. Next, you'll set the values of the endpoint and the corresponding access key.
      
1. From the Bash session in the **Cloud Shell** pane, run the following commands to retrieve the values of the Cosmos DB SQL API endpoint and the corresponding access key, and then store them in temporary variables:

   ```bash
   RG1NAME=cosmos-db-RG
   ACCOUNTNAME=$(az cosmosdb list --resource-group $RG1NAME --query "[0].name" --output tsv)
   ENDPOINT=$(az cosmosdb show --name $ACCOUNTNAME --resource-group $RG1NAME --query "locations[0].documentEndpoint" --output tsv)
   KEY=$(az cosmosdb keys list --name $ACCOUNTNAME --resource-group $RG1NAME --query "primaryMasterKey" --output tsv)
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to replace the placeholders in the **config.js** file with the values you retrieved in the previous step:
   
   ```bash
    ENDPOINT="$(echo $ENDPOINT | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"
    sed -i 's/"COSMOS_DB_SQL_API_ENDPOINT"/"'"$ENDPOINT"'"/' ./config.js

    KEY="$(echo $KEY | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"
    sed -i 's/"COSMOS_DB_ACCESS_KEY"/"'"$KEY"'"/' ./config.js
    ```
    
1. From the Bash session in the **Cloud Shell** pane, run the following command to validate that the **config.js** file contains the actual values of the Cosmos DB SQL API endpoint and the corresponding access key:
   
   ```bash
   cat ./config.js
   ```
   
    > [!NOTE]
    > At this point, you should know more about how to install the dependency packages and build the application. Because of versioning issues, you won't be able to run the build in Azure Cloud Shell. Instead, you'll perform this task following the deployment.

## Deploy an Azure web app hosting the Next.js application

In this task, you'll deploy the newly configured Next.js application to an Azure web app and validate its functionality.

> [!NOTE]
> You could deploy the same application to any other Azure service that provides a Node.js runtime environment, including Azure VMs, Azure Container Instances, or Azure Kubernetes Service.

1. Within the web browser window displaying the Azure portal, from the Bash session in the **Cloud Shell** pane, run the following commands to create a resource group that will host the Azure web app, into which you'll deploy the Next.js application:
   
   ```bash
   RG1NAME=cosmos-db-RG
   LOCATION=$(az group show --resource-group $RG1NAME --query location --output tsv)
   RG2NAME=nextjs-webapp-RG
   az group create --name $RG2NAME --location $LOCATION
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to create an Azure App Service plan that will host the new Azure web app:
   
   ```bash
   SPNAME=nextjs-webapp-sp
   az appservice plan create --name $SPNAME --resource-group $RG2NAME --sku S1
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to create the new Azure web app:
  
   ```bash
   WEBAPPNAME=nextjs$RANDOM$RANDOM
   az webapp create --name $WEBAPPNAME --resource-group $RG2NAME --plan $SPNAME
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to reinitialize the local Git repository and commit all changes in the main branch:
   
   ```bash
   git config --global user.email "user1@adatum.com"
   git config --global user.name "Adatum User"
   git init
   git add -A
   git commit -m "Initial Commit"
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to set up user-level deployment credentials:
   
   ```bash
   DEPLOYMENTUSER=m05u08User$RANDOM
   DEPLOYMENTPASS=m05u08Pass$RANDOM$RANDOM
   az webapp deployment user set --user-name $DEPLOYMENTUSER --password $DEPLOYMENTPASS
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to identify the user-level deployment credentials (make sure to record their value, because you'll need them later in this exercise):

   ```bash
   echo $DEPLOYMENTUSER
   echo $DEPLOYMENTPASS
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to identify the Azure web app deployment URL that you'll use as the target of the `git push` command:

   ```bash
   RG2NAME=nextjs-webapp-RG
   WEBAPPNAME=$(az webapp list -resource-group $RG2NAME --query "[0].name" --output tsv)

   DEPLOYMENTURL=$(az webapp deployment source config-local-git --name $WEBAPPNAME --resource-group $RG2NAME --output tsv)
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following command to configure the remote repo named **azure**, representing the deployment URL you identified in the previous step:

   ```bash
   git remote add azure $DEPLOYMENTURL
   ```
   
1. From the Bash session in the **Cloud Shell** pane, run the following commands to create the **master** branch based on the **main** branch and push its content to the Azure Web app (when prompted for the password that is part of the user-level deployment credentials you recorded previously in this task):

   ```bash
   git checkout -b master
   git push --set-upstream azure master
   ```
   
      > [!NOTE]
      > Wait for the deployment to complete.
      
1. Close the **Cloud Shell** pane.

## Validate the functionality of the Azure web app

In this task, you'll validate the functionality of the Azure web app hosting the Next.js application.

1. In the web browser window displaying the Azure portal, use the **Search resources, services, and docs** text box at the top of the Azure portal page to search for **App Services**.
1. On the **App Services** blade, in the list of App Service instances, select the entry representing the Azure web app you deployed in the previous task of this exercise.
1. On the blade displaying the properties of the web app, in the vertical menu, in the **Development Tools** section, select the **App Service Editor (Preview)** entry. Then, on the **App Service Editor (Preview)**, select **Go**.
1. On the **App Service Editor** page, in the vertical menu, select the **Open Console** icon (the second one from the end).
1. From the console prompt, run the following command:
   
   ```bash
   npm run build
   ```
   
 1.  This command builds the Next.js application you pushed to the Azure web app.
 
     :::image type="content" source="../media/8-next.js-web-app-build.png" alt-text="Screenshot of the start of the build process in the App Service Editor console of the Azure web app.":::
  
1. Wait for the build process to complete.
      
      :::image type="content" source="../media/8-next.js-web-app-build-completed.png" alt-text="Screenshot of the completed build process in the App Service Editor console of the Azure web app.":::
  
1. Close the web browser tab displaying the **App Service Editor** page.
1. On the Azure portal blade displaying the properties of the web app, in the vertical menu, select the first entry, labeled **Overview**. On the **Essentials** pane, select the link labeled **URL**.

      > [!NOTE]
      > This will automatically open another web browser tab displaying the newly deployed Azure web app.
      
1. Verify that the web browser page displays the **Next.js - Cosmos DB IoT telemetry data** page with the listing of the IoT telemetry data points retrieved from the Azure Cosmos DB collection.

     :::image type="content" source="../media/8-next.js-web-app-deployed.png" alt-text="Screenshot of the page of the deployed Azure web app containing the listing of the Azure Cosmos DB items.":::

## Results

Congratulations! You completed the third exercise of this module. You created an Azure function that logs an HTTP request payload, configured and validated IoT telemetry rules of an Azure IoT Central application, created an Azure Storage account that will store IoT telemetry, and configured and validated data export of an Azure IoT Central application.

## Clean up the resources

To avoid unnecessary charges from using Azure resources, you should delete the **cosmos-db-RG** and **nextjs-webapp-RG** resource groups you created in this exercise. To do so, in the Azure portal, navigate to the blade of each of these resource groups, and select the **Delete resource group** entry in the toolbar. In the **TYPE THE RESOURCE GROUP NAME** text box, enter the name of the resource group, and then select **Delete**.
