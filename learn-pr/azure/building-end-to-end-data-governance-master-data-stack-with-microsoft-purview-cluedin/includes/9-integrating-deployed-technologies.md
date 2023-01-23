Integrating the different technologies just deployed. 

At this point, you should have all resources running and operational. Although the integration between CluedIn and Purview is already operational, we do need to setup some of the other integrations in their respetice user interfaces. 

In your previous exercise you may have noticed that when installing the ADLS Gen2 instance, we also prepopulated the instance with the data necessary for the exercise. Therefore, right now, there is nothing we need to setup in the ADLS Gen2 instance. 

Let's login to Microsoft Purview. You can do this by choosing the Purview Account in your resource group and then clicking the Open Purview Studio link. This will open Purview in a new tab. You can close the Purview Account in the Azure Portal as we will not need this for the rest of the exercise. 

Click on your Data Map on the left hand side menu and click Register. Choose ADLS Gen2 from the selection and in the drop down, select the instance called Data Governance that was created in the previous step. 

Next, setup a scan to scan the files every 1 hour and then trigger an initial scan. This will typically take many minutes to scan the files in the ADLS Gen2 instance. 

After the scan is complete, you should validate that everything was success by making sure that there are 10 assets in your Purview instance. 

You can now open your CluedIn instance by navigating to the CluedIn-AMA Managed Application. Within that application in the Azure Portal there will be a Parameters and Outputs menu option. Click on that, scroll down to the bottom of the page and you will see a url to your own private instance of CluedIn. Copy that into a new browser tab and press enter. 

Login with your credentials and you will be met with this home screen. 

The Purview integration was already established in the previous step, so navigate to your Intergations -> Data Sources -> Ingestion Endpoints menu option, in which you should see your Purview assets already listed. These are essentially placeholders that have been setup to received data through HTTPS endpoints that can be discovered by clicking on "Create Ingestion Endpoint".

Note: There is also another way of achieving this same result, which is to search the Purview Catalog from Azure Data Factory and create Azure Data Factory Data Flows from the Azure Data Factory studio to CluedIn Ingestion Endpoints. 

You will now be given the option to choose from either using CluedIn or Azure Data Factory to be responsible for the fetching of data from the Purview Asset's metadata. By choosing CluedIn, it will generate a public HTTPS endpoint, behind a Bearer JWT Token (which can be generated through the CluedIn UI). For this exercise we will be choosing Azure Data Factory. With this choice, the appropriate Azure Data Factory Data Pipeline will be automatically created for you, including the credentials found in Purview, a schedule, and the data movement will start immediately. You can of course augment this pipeline if necessary, but this will be done directly in Azure Data Factory Studio. 

You will also be given the option to "Automatically Map" or "Manually Map" in CluedIn. Automatic mapping will use CluedIn's inbuilt automapping feature to attempt to standardise the terminology to inbuilt CluedIn Domains by default. For example, if we see a file called Business.xlsx, we will attempt to standardise that to the inbuilt Domain called Organization. You can easily override this if necessary, or you can even install the Common Data Model from Microsoft as to standardise to it as well. In addition to this, CluedIn will use the Schema that Microsoft Purview has detected and will even attempt to standardise the column names as well, for example first, firstName, first_name. 

The Microsoft Purview scans will have also identified the Primary and Foreign keys in the data and you can see in the mapping of CluedIn that these have already been used to fill in the different parts of mapping for CluedIn as well. 

Because of this, we can simply click the Process tab and the Process button and start to submit the data into the CluedIn platform. 

Within a couple of moments you should have progress on the data being ingested, and if you are requiring some metrics on this you can navigate to Data Sources -> Monitoring. 

Due to CluedIn being hosted within Azure Kubernetes Service, you do have the possiblity to scale this environment up to process the data faster. 

Repeat the steps above for bringing in the other assets from Purview. 

You will notice that CluedIn is not asking you to map files to files, but rather Domains to Domains. The value of this is that we do not have to manually wire and ETL files together, but rather have the CluedIn do this in an automated way by simply flagging foreign keys and primary keys. This is only made possible due to the schemaless nature of CluedIn. 

This is also why you can add these assets from Purview (ADLS Gen2) in any order that you want - it will all end up in the same state. 


If all steps were followed, you should end up with the result that you have 1000 Organizations, 1000 Person and 300 PowerPoint Domains. 

Validation of value:

 - What was originally 100 assets in Purview, should now be 3 different domains, with 2300 records. 
 - For each respective Domain, the column names should be standardised so we are not talking in different langauge for what is essentially, semantically, the same thing. 
 - We should have records that have merged together from across the different sources. 
