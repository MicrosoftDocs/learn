In this exercise, you configure an Azure Stream Analytics output for Power BI and a second output for [Azure Synapse Analytics](/azure/synapse-analytics/overview-what-is). [Power BI](/power-bi/fundamentals/power-bi-overview) provides a platform for visualizing and analyzing aggregated data in a near-real-time analytics pipeline built on Azure Event Hubs, Azure Stream Analytics, and Power BI.

1. From your Stream Analytics job's blade in the [Azure portal](https://portal.azure.com/), select **Outputs** in the left-hand navigation menu.

    ![The Outputs link is selected in the left-hand menu.](../media/outputs-link.png 'Outputs link')

2. On the Outputs blade, select **+ Add** in the top toolbar, then select **Power BI** to create a new Power BI output.

    ![The Add button and Power BI menu item are highlighted.](../media/stream-analytics-add-output-link.png 'Add output - Power BI')

3. In the **New Output** blade, select the **Authorize** button to authorize a connection from Stream Analytics to your Power BI account.

    ![The Authorize button is highlighted in the New Output blade.](../media/stream-analytics-new-output-authorize.png 'New Output')

4. When prompted, sign in to your Power BI account, which is the same username and password you were provided with and used to log in to the Azure portal.

    ![The Power BI sign-in form is displayed.](../media/power-bi-sign-in.png 'Power BI Sign In')

5. After successfully signing in to your Power BI account, the New Output blade will update to show you are currently authorized.

    ![The New Output blade has been updated to show the user is authorized to Power BI.](../media/stream-analytics-new-output-authorized.png 'Authorized')

6. In the **New Output** blade, configure the following:

    - **Output alias:** Enter "powerBIAlerts".
    - **Authentication mode:** Select "User token".
    - **Group workspace:** Select "My Workspace" (if you do not see this option, select the "User token" authentication mode first).
    - **Dataset name:** Enter "ContosoAutoVehicleAnomalies".
    - **Table name:** Enter "Alerts".

        ![The New Output form is filled out with the previously mentioned settings entered into the appropriate fields.](../media/stream-analytics-new-output.png 'New Output')

7. Select **Save** on the bottom of the form when you have finished entering the values.

## Create an Azure Synapse Analytics output

1. Select **+ Add** in the top toolbar a second time and select **Azure Synapse Analytics (formerly SQL DW)** to create a new Synapse Analytics output.

    ![The Azure Synapse Analytics menu item is highlighted.](../media/stream-analytics-add-output-synapse-link.png "Add output - Azure Synapse Analytics")

2. In the **New Output** blade, configure the following:

    - **Output alias:** Enter "synapse".
    - **Select Azure Synapse Analytics from your subscriptions:** Selected.
    - **Subscription:** Select the subscription you are using for this lab.
    - **Database:** Select "ContosoAuto". Make sure your correct Synapse workspace name appears under "Server name".
    - **Table:** Enter `dbo.VehicleAverages`
    - **Authentication mode:** Select "Connection string".
    - **Username:** Enter `asa.sql.admin`
    - **Password:** Enter the SQL admin password value you entered when deploying the lab environment.

        ![The New Output form filled out with the previously mentioned settings entered into the appropriate fields.](../media/synapse-new-output.png "New Output")

3. Select **Save** on the bottom of the form when you have finished entering the values.
