At this point, you should have all resources running and operational. Although the integration between CluedIn and Purview is already operational, we do need to set up the other integrations.

## ADLS Gen 2

In the previous exercise you may have noticed that when installing the ADLS Gen2 instance, we also prepopulated the instance with the data necessary for the exercise. Therefore, right now, there's nothing we need to setup in the ADLS Gen2 instance.

## Microsoft Purview

1. Let's sign in to Microsoft Purview. You can do this by choosing the Purview Account in your resource group and then selecting the Open Purview Studio link. This will open Microsoft Purview in a new tab.

1. Select your Data Map on the left hand side menu and select Register. Choose ADLS Gen2 from the selection and in the drop-down, select the instance called Data Governance that was created in the previous step. 

1. Next, set up a scan to scan the files every 1 hour and then trigger an initial scan. This will typically take many minutes to scan the files in the ADLS Gen2 instance.

1. After the scan is complete, you should validate that everything was success by making sure that there are 10 assets in your Purview instance.

## CluedIn

1. You can now open your CluedIn instance by navigating to the CluedIn-AMA Managed Application. Within that application in the Azure portal there will be a Parameters and Outputs menu option. Select that, scroll down to the bottom of the page and you'll see a url to your own private instance of CluedIn. Copy that into a new browser tab and press enter.

1. Sign in with your credentials and you'll be met with this home screen. 

1. The Purview integration was already established in the previous step, so navigate to your **Intergations** -> **Data Sources** -> **Ingestion Endpoints** menu option, in which you should see your Purview assets already listed. These are essentially placeholders that have been set up to received data through HTTPS endpoints that can be discovered by selecting on "Create Ingestion Endpoint".

    >[!NOTE]
    > You could also search the Purview Catalog from Azure Data Factory and create Azure Data Factory Data Flows from the Azure Data Factory studio to CluedIn Ingestion Endpoints.

1. You'll now be given the option to choose from either using CluedIn or Azure Data Factory to be responsible for the fetching of data from the Purview Asset's metadata.  For this exercise, we'll be choosing Azure Data Factory. With this choice, the appropriate Azure Data Factory Data Pipeline will be automatically created for you, including the credentials found in Purview, a schedule, and the data movement will start immediately. You can of course augment this pipeline if necessary, but this will be done directly in Azure Data Factory Studio.

    >[!TIP]
    > By choosing CluedIn, it would generate a public HTTPS endpoint, behind a Bearer JWT Token (which can be generated through the CluedIn UI).

1. Select the Process tab and the Process button and start to submit the data into the CluedIn platform.

    >[!NOTE]
    > We do not need to automatically or manually map data as Microsoft Purview scans have already identified the Primary and Foreign keys in the data.

1. Within a couple of moments you should have progress on the data being ingested, and if you're requiring some metrics on this you can navigate to Data Sources -> Monitoring. 

1. Repeat the steps above for bringing in the other assets from Purview.  You'll notice that CluedIn isn't asking you to map files to files, but rather Domains to Domains. The value of this is that we don't have to manually wire and ETL files together, but rather have the CluedIn do this in an automated way by flagging foreign keys and primary keys. This is only made possible due to the schemaless nature of CluedIn.  This is also why you can add these assets from Purview (ADLS Gen2) in any order that you want - it will all end up in the same state. 

1. Once you've completed these steps for all assets, you should have 1000 Organizations, 1000 Person and 300 PowerPoint Domains.

## Validation of value

- What was originally 100 assets in Purview, should now be three different domains, with 2300 records. 
- For each respective Domain, the column names should be standardized so we aren't talking in different languages for what is essentially, semantically, the same thing. 
- We should have records that have merged together from across the different sources. 
