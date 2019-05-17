Azure SQL Database and SQL Server include tools to identify and classify data. 

Your organizations CRM data including customer data, financial information, and business information is stored in an Azure SQL Database. This database has recently been migrated from an old version of SQL Server on-premises to the Azure SQL Database service.

In the unit, you'll classify data in the CRM database.

## Apply data classifications in Azure SQL Database

With the Azure SQL Database you created in the previous unit, you'll run through creating a SQL Information Protection sensitivity label & information type, then apply some of the classification recommendations.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the All Resources view of the portal, select the Azure SQL Database named **mycrmDb**.

1. In the left menu, under **Security**, select **Advanced Data Security**.

1. On the **Advanced Data Security** dashboard, select **Data Discovery & Classification (preview)**.

    ![Screenshot of the Advanced Data Security dashboard, highlighting the Data Discovery & Classification (preview) section](../media/ads-dashboard.png)

1. On the **Data Discovery and Classification (preview)** panel, select the **Configure**. You will see a list of the built-in sensitivity labels.

    ![Screenshot of the Data Discovery & Classification (preview), highlighting the configure button](../media/ddc-configure.png)

    > [!NOTE]
    > The permissions required on the tenant root group to modify or create the classification taxonomies are not available through the Microsoft Learn Sandbox.

    ![Screenshot of Create and manage sensitivity labels options](../media/sensitivity-labels.png)

1. On the SQL Information Protection (preview) panel, select the **Manage Information Types** option. You will see a list of the built-in information types.

    ![Screenshot of the information types available](../media/information-types.png)

1. In the window that opens, select the **OK** button at the bottom to return to the SQL Information Protection (preview) panel.

1. In the interface at the top of the SQL Information Protection (preview) panel, select the cross to close the panel and return to the Data Discovery and Classification (preview) panel.

1. In the Data Discovery and Classification (preview) panel, select **Classification**.

    ![Screenshot of the classification recommendations](../media/classification.png)

1. In the Classification interface, select the **15 columns with classification recommendations** dialogue at the bottom of the window.

1. Select the **Select all** checkbox to the left-hand side of the **Schema** dropdown box at the top of the window, now select the **Accept selected recommendations** button above it.

1. The selected columns now appear in the **classified columns** section.

    ![Screenshot of selecting a highly confidential sensitivity label](../media/highly-confidential.png)

1. Now change the **SENSITIVITY LABEL** for the **Contact Info** information types to **Highly Confidential - GDPR**, select **Save** at the top left of the Data Discovery & Classification (preview) panel.

    ![Screenshot of the overview dashboard](../media/overview.png)

1. In the Data Discovery and Classification (preview) panel, select **Overview**. You'll now see the columns you've classified separated out by their sensitivity label and information type. Currently Advanced Data Security has only identified 5 tables out of 12 contain sensitive data.

You have now classified data stored in the SQL database using the recommended classifications from ADS. However, this does not cover all the data. You will now run through adding a manual classification to some other tables and columns in the database.

## Add a manual data classification in Azure SQL Database

1. In the Data Discovery and Classification (preview) panel, select **Classification**.

1. In the Classification interface, select the **Add classification** button in the menu bar at the top of the window.

1. In the Add Classification window, select Schema name **SalesLT**, table name **ProductDescription**, Column name **Description (nvarchar)**, Information type Other, and Sensitivity level **Public**.

1. Select the **Add Classification** button at the bottom of the window to add the classification.

1. Repeat steps 2 and 3, this time select Schema name **SalesLT**, table name **Product**, Column name **ListPrice (money)**, Information type Financial, and Sensitivity level **General**.

1. Select the **Add Classification** button at the bottom of the window to save the classification.

1. In the Data Discovery and Classification (preview) panel, select **Save** to save the manual classifications. Now select the cross to return to the **Advanced Data Security** panel.

You've created an Azure SQL Database and then classified data stored in it using both the recommendations provided by ADS and subsequently adding some manual classifications. It's important to remember that ADS may not provide recommendations to cover the entire database. In the scenario you have just completed, the manual classifications were completed to protect business sensitive data which had not been picked up on the ADS scan.
