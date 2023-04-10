At this point, you should have all resources running and operational as individual technologies. In this part of the learning module, we'll be bringing the pieces together.

## ADLS Gen 2

First we'll set up the storage account, and the data we'll be investigating.

## Investigating the data

Download the following files it to your local drive. You'll find seven files representing different sample datasets across common master data domains:

* [Companies.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/Arca/Companies.csv)
* [Contacts.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/Experian/Contacts.csv)
* [ContactsAddLater.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/Experian/ContactsAddLater.csv)
* [Products.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/Navision/Products.csv)
* [Employees.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/Salesforce/Employees.csv)
* [Persons.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/Xero/Persons.csv)
* [YellowSystems/Products.csv](https://download.microsoft.com/download/e/3/0/e3081045-e628-4267-9ac4-f73e46f84e81/YellowSystems/Products.csv)

### Companies.csv

Notice in the data, that we have 10 rows of data containing a list of different companies. We have columns for an ID, Name, Website, Address and a Person_Id. 

:::image type="content" source="../media/companies-csv-sample-inline.png" alt-text="Screenshot of sample data in Companies.csv." lightbox="../media/companies-csv-sample.png" :::

Notice that the addresses of many of the companies are similar with for example "188, Quuen St Brisbane" and "188 queen street brisbane". These addresses are fictitious, but we can clearly see that there's a data quality issue that we're hoping to fix.

The "person_id" column is referring to the identifier of an Employee of which is somewhere within one of the other files and hence we'll be create what CluedIn calls **Edges** or **Relationships** between this column and the column of another Domain.

### Contacts.csv

Notice in the data, that we have 10 rows of data containing 10 fictitious employees. We have columns for an ID, First_Name, Last_Name, Full_Name, Email, Job.

:::image type="content" source="../media/contacts-csv-sample-inline.png" alt-text="Screenshot of sample data in Contacts.csv." lightbox="../media/contacts-csv-sample.png" :::

We can also clearly see that the Job column has a data quality issue in it where we're receiving data that has different ways to spell the different Job Titles of the employees.

For the learning module, pay particular attention to Lorain Andrzej, as, as we start to look through the other files, there's no a single identifier that we can use to stitch her record together consistently. Most notable, notice her email address ends with "@wtb.gov.au" and she has an ID value of "1".

### ContactsAddLater.csv

This file contains more employees, but contains some of the same data quality issues that are present on the Contacts.csv file.

:::image type="content" source="../media/contacts-add-later-csv-sample-inline.png" alt-text="Screenshot of sample data in ContactsAddLater.csv." lightbox="../media/contacts-add-later-csv-sample.png":::

### Products.csv

Notice in the data, we have 10 rows of data containing 10 fictitious products. We have columns for a SKU, Name and Size. One thing to notice as you look across the other Products.csv file from YellowSystems (under the YellowSystems folder) is that there's no Identifier that can be used to uniquely stitch the products together and we'll need to use a fuzzy merging approach later in the exercise.

:::image type="content" source="../media/navision-products-csv-sample-inline.png" alt-text="Screenshot of sample data in Products.csv." lightbox="../media/navision-products-csv-sample.png":::

### YellowSystemsProducts.csv

Notice that we have 10 rows of data containing the same 10 fictitious products mentioned in the Products.csv file under the Navision folder. However we can see that we don't have a SKU column that we may have been able to use to stitch the products together. Instead we have columns for an ItemId, Name, and CompanyId. Most likely, we can use the CompanyId to connect to the companies mentioned in the Companies.csv above.

:::image type="content" source="../media/yellow-systems-products-csv-sample-inline.png" alt-text="Screenshot of sample data in the YellowSystems Products.csv." lightbox="../media/yellow-systems-products-csv-sample.png":::

### Employees.csv

Notice in this file that we have the same 10 employees however we do have different identifiers, column names and details. We have columns for FName, LName, Full, Email, Person_Id. If we take a look at Lorain Andrzej in this file, unfortunately we don't have an Identifier of "1" or an email that ends in "wtb.gov.au" but rather we could assume that the email column and the person_id column could both be used to uniquely identify these employees.

:::image type="content" source="../media/salesforce-employees-csv-sample-inline.png" alt-text="Screenshot of sample data in Employees.csv." lightbox="../media/salesforce-employees-csv-sample.png":::

We can also see that the names of the columns, although similar to those in the Contacts.csv and ContactsAddLater.csv, that they're different. If we were to not address this, it would most likely lead to some confused downstream users of the data.

### Persons.csv

Finally, notice in the file that we have the same 10 employees however we once again have different identifiers, column names, and details. We have columns for ID, First, Last, Email, Full_Name, Gender, IP_Address, and PID.

:::image type="content" source="../media/xero-persons-csv-sample-inline.png" alt-text="Screenshot of sample data in Persons.csv." lightbox="../media/xero-persons-csv-sample.png" :::

Once again, if we look at Lorain, we can see that this time her email ends with "yahoo.com". However we can see that she does have an identifier of "1" and a column called "pid" that has a value that we did see in the Employees.csv file above. It's most likely that we could use different identifiers from each file to stitch this together - however on the surface that would be quite a tricky SQL statement or Python script to create.

## Upload the data to the ADLS Gen2

1. Navigate to the Storage Account that you created in the earlier part of the module.
1. Navigate to your Container Storage in the left menu, and either select an existing Container, or create a new one called **cluedintrial**.
1. Inside the cluedintrial container, create a new directory called **raw** upload the downloaded files one at a time to the container using the **Upload** button.

    :::image type="content" source="../media/upload-data-to-storage-account.png" alt-text="Screenshot of the sample data being uploaded in ADLS Gen2":::

1. Ones all your files are uploaded, navigate to **Security + networking > Networking** in your ADLS Gen2 account.
1. Choose **Enabled from selected virtual networks** under **Public network access**.
1. In the **Exceptions** section, select **Allow trusted Microsoft services to access this storage account** and select **Save**.

    :::image type="content" source="../media/register-adls-gen2-networking.png" alt-text="Screenshot that shows the details to provide firewall access.":::

## Azure Key Vault

Here we'll set permissions for Microsoft Purview and Azure Data Factory to be able to access your Azure Key Vault:

1. Open your Azure Key Vault in the Azure portal, and select **Access policies** in the menu.
1. Select **Create** to  make a new policy.
1. Select **Get** and **List** from the **Secret permissions** list. Then select **Next**.

    :::image type="content" source="../media/key-vault-access-policy-inline.png" alt-text="Screenshot that shows the get and list operations selected under the secret permissions list.":::

1. Search for and select your Microsoft Purview account on the **Principal** page.
1. Select **Next**, and then select **Next** again to get to the **Review + Create** page. Then select **Create**.
1. Repeat these steps for your Azure Data Factory account, so that your Azure Data Factory account also has **Get** and **List** permissions on secrets in your Azure Key Vault.

Now we'll create the secure credentials that Microsoft Purview and Azure Data Factory will use to access your ADLS Gen2 account:

1. Open your ADLS Gen2 storage account in the Azure portal, and select **Access keys** from the menu under **Security + networking**.
1. Select the **Show** button for one of the keys, then copy the key value.
1. Open your Azure Key Vault, and select **Secrets** from the menu under **Objects**.
1. Select the **Generate/Import** button to create a new secret.
1. Give your secret a name, and save the name for later use.
1. For **Secret value** paste the key value from your ADLS Gen2 storage account.
1. Select **Create**.

## Microsoft Purview

### Connect with Azure Key Vault

1. Still in the **Management** menu, select **Credentials**.
1. Select **Manage Key Vault connections**.
1. Select **New**.
1. Give your connection a friendly name, and then search for and select the key vault where you gave your Microsoft Purview account permissions earlier.
1. Select **Create**.
1. Close the **Manage Key Vault connections** window and select the **+ New** button in the credentials window.
1. Give your new credential a friendly name like "adlsgen2key" and select the **Account key** authentication method from the drop down.
1. Select the key vault connection you just created.
1. The **Secret name** will be the name of the secret you created in Azure Key Vault to house your ADLS Gen2 account key.
1. Select **Create**.

### Register and scan data sources

1. Sign in to Microsoft Purview. You can do this by choosing the Microsoft Purview Account in your resource group and then selecting the Open Microsoft Purview Governance Portal button. This will open Microsoft Purview in a new tab.

1. Select your Data Map on the left hand side menu and select Register. Choose ADLS Gen2 from the selection and in the drop-down, then select the instance that was created in the previous step.

1. Select **Register**.

1. After registering your account, select the **New Scan** icon under the **ADLS Gen2 data source**.

    :::image type="content" source="../media/register-adls-gen2-new-scan.png" alt-text="Screenshot that shows the screen to create a new scan":::

1. Provide a **Name** for the scan, select the account key credential you created earlier under **Credential**, and choose the appropriate collection for the scan (the root collection or your current subcollection), and select **Test connection**. On a successful connection, select **Continue**.

    :::image type="content" source="../media/register-adls-gen2-managed-identity.png" alt-text="Screenshot that shows the managed identity option to run the scan.":::

1. Select the **cluedintrial** folder you created earlier to scan.

1. Choose the system default scan rule set.

1. Set your scan to run once, and select **Continue**, then **Save and Run**. It will take only a few minutes to scan these files.

1. You can check the scan by selecting your ADLS Gen2 resource in the data map, choosing **View details**, and looking at the **Last run status** of the most recent scan. Wait until it is completed.

1. After the scan is complete, you should validate that everything was success by selecting your ADLS Gen2 resource in Microsoft Purview and making sure that there are assets discovered. You can see the number of discovered assets listed above the scan details.

1. If you search in Microsoft Purview for Contacts.csv, then you should find your assets in Microsoft Purview.

    :::image type="content" source="../media/contacts-csv-purview.png" alt-text="Screenshot of the Contacts.csv asset in Microsoft Purview.":::

### Connect with Azure Data Factory

1. Select **Management** in the Microsoft Purview menu, then select **Data Factory** under **Lineage connections**.

1. Select **New** and create a connection to your Data Factory.

    :::image type="content" source="../media/purview-azure-data-factory.png" alt-text="Screenshot of a data factory connection in Microsoft Purview.":::

    This allows Microsoft Purview to create automated lineage for you based off the ADF scheduled pipelines you have for pulling in the data from the source systems into the raw folder regularly, and also allows the lineage that CluedIn will create during data processing.

### Flagging assets that can sync with CluedIn

1. In Microsoft Purview, open the data catalog and select **Glossary**. Then select **New term**.

1. Select the System default template, and then create a new term **CluedInSource**. Set status to **Approved**, and select **Create**.

    :::image type="content" source="../media/new-glossary-term.png" alt-text="Screenshot of the Microsoft Data Catalog new glossary term page, showing a new CluedInSource term.":::

1. Create a second glossary term called **CluedInADFAuto** that we'll use later in this guide.

1. Return to the data catalog, search for and select all seven assets. Then select **View selected**.

    :::image type="content" source="../media/bulk-edit-assets.png" alt-text="Screenshot of the Microsoft Data Catalog browse, showing products.csv selected, and seven assets selected for bulk editing.":::

1. Select **Bulk edit**.

1. Set attribute to **Term**, operation to **Add** and new value to **CluedInSource**, then select **Apply**.

1. Add a second term attribute to add the **CluedInADFAuto** glossary tag.

## CluedIn

1. You can now open your CluedIn instance by navigating to the CluedIn-AMA Managed Application. You can find the URL for your CluedIn instance either from the email you received from CluedIn, or by opening CluedIn in the Azure portal and selecting **Parameters and Outputs** and finding the **cluedInInstanceAddress**. Copy that into a new browser tab and press enter.

    :::image type="content" source="../media/cluedin-login-page.png" alt-text="Screenshot of the CluedIn sign in page.":::

1. Sign in with your credentials you used in the installation process and you'll be met with this home screen.

    :::image type="content" source="../media/cluedin-home.png" alt-text="Screenshot of the CluedIn home screen page.":::

### Connect CluedIn to Microsoft Purview

1. In your CluedIn Studio, go to **Settings** section, under **Administration**.

1. In the middle of the page, fill in these values:
    1. Purview: Base Url - which will be formatted like `https://<your purview instance>.purview.azure.com`
    1. Purview: Client ID - the Application (client) ID from your service principal
    1. Purview: Client Secret - the client secret value from setting up your service principal.
    1. Purview: Tenant ID- the Azure Tenant ID where your Microsoft Purview account lives.
    1. Purview: Collection Name - the name of the collection where your data assets are housed.

    :::image type="content" source="../media/purview-cluedin-settings.png" alt-text="Screenshot of the CluedIn Administration page.":::

1. Toggle on the settings for **Purview SyncDataSources** and **Purview PollDataSources**. This will integrate the data sources from Microsoft Purview with CluedIn.

1. You'll also notice a setting called **Purview : Sync CluedIn Data Sources Keywords**. Set this to **CluedInSource**. CluedIn will now be polling every 60 seconds to find Microsoft Purview assets that have been tagged with a Glossary Term that matches the filter.

1. Wait at least 60 seconds for CluedIn to poll the data sources in your Microsoft Purview resource.

1. In CluedIn, go to the **Datasources** section under **Integration** in CluedIn and you'll notice that your 7 files are now showing in CluedIn. However, there will only be the metadata that is registered.

    :::image type="content" source="../media/CluedIn_DataSources_Purview.png" alt-text="Screenshot of the CluedIn integrations screen, showing the data sources.":::

# Connect CluedIn to Azure Data Factory

Next, we'll provide CluedIn with the credentials of our Azure Data Factory so CluedIn can also automate the construction of the Azure Data Factory pipelines to copy the data into CluedIn.

1. In the Azure portal, open your Data Factory instance and select **Access Control IAM**. Grant your service principal the **Data Factory Contributor** role to allow it to create pipelines and triggers.

1. In your CluedIn Studio, select the **Settings** section, under **Administration**. Fill in the Azure Data Factory details:
    1. Purview : Azure Data Factory Base Url - will be formatted like: `https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.DataFactory/factories/{factoryName}/`
    1. Purview : Azure Data Factory Client ID - the Application (client) ID from your service principal
    1. Purview : Azure Data Factory Client Secret - the client secret value from setting up your service principal.
    1. Purview: Azure Data Factory Tenant ID- the Azure Tenant ID where your Azure Data Factory account lives.

1. Toggle on the setting for **Purview : Azure Data Factory Pipeline Automation**. This will use our Azure Data Factory instance to copy our data into CluedIn.

1. You'll also notice that there's a setting called **Search Filter for Azure Data Factory Pipelines**. Make sure it is set to **CluedInADFAuto**.

1. We tagged our resources for this earlier, but you'll need to wait at least 60 seconds after set up to see the results.
1. Return to the **Datasources** section under **Integration** in CluedIn and you'll now notice that all of your items in the list now have a new entry under them. When you select them will take you through to a preview of the data we have for our scenario.

## Congratulations!

Great work! We've integrated all the pieces of our data technology stack! Give yourself a pat on the back before moving on to the next section. This is the most difficult part. Everything else is just using the tools we've put in place.