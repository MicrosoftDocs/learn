 Workbooks provide a canvas for creating interactive visual reports. In this exercise, you will create a new workbook, add some descriptive text and a parameter to query your resources. By the end of this unit, you will have a report that shows the distribution of your resources on a map.

## Deploy resources for the exercise using the Azure CLI

The first thing we will do is activate the Azure sandbox and deploy an ARM template containing all the Azure resources we need for this exercise.

1. Activate the Azure sandbox. When the sandbox is activated, a resource group is created for you to use.
1. In the Azure Cloud shell, get the name of the resource group that was generated for your sandbox.
    ```azurecli
    az group list
    ```
1. The output contains a row with the name of the resource group. The name starts with "learn-".

    :::image type="content" source="../media/3-cloud-shell-resourcegroup-name.png" alt-text="Screenshot of cloud shell displaying resource group name for sandbox.":::
1. Copy the name of the resource group. (You may need to highlight the text and right-click on your mouse to copy the text.)
1. Enter this command to define the resource group. (You may need to erase some extraneous characters from around the resource group name.)

    ```azurecli
    resourceGroup="<your resource group name>"
    ```

1. Run these commands to deploy the Azure resource group and resources:

    ```azurecli
       git clone https://github.com/MicrosoftDocs/ms-learn-azure-monitor-workbooks.git
       cd ms-learn-azure-monitor-workbooks/Resources/
       az deployment group create --resource-group $resourceGroup --template-file deploy-resources.bicep
    ```

1. When you are prompted for a password, enter a password that complies with the password requirements. For example, enter "Learn@123456". Write this password down, you will need it later. The password must:
    - Be at least 12 characters long
    - Contain at least 3 out of the following 4 characteristics:
    - one lower case letter
    - one upper case letter
    - one number
    - one special character, not including \ or -.
1. The resources that you need for the module are now deployed. Wait until the process completes.
1. Log into the Azure portal.
1. On the **Home** page, enter "Resource groups" into the search bar at the top.
1. Select the resource group that we just created.
1. Look through the list of resources and select the App Service plan.

    :::image type="content" source="../media/3-portal-select-app-service.png" alt-text="Screenshot of selecting the App Service from the resource group.":::

1. On the top toolbar, select **Browse**.

    :::image type="content" source="../media/3-portal-browse-app-service.png" alt-text="Screenshot of the browser button from the App Service page.":::

1. Populate the app service with some activities to generate some data for our example. On the **List of To-Do Items** page, create some items, edit them, or mark some as complete.

    :::image type="content" source="../media/3-app-service-tasks.png" alt-text="Screenshot that shows tasks for the app service for workbooks learn module.":::
1. Now, we are ready to create a workbook.

## Create a new workbook

1. From the Azure portal home page, search for and select **Monitor**.
1. Select **Workbooks** from the left pane.
1. Select **+ New** from the top toolbar.
    :::image type="content" source="../media/3-portal-new-workbook.png" alt-text="Screenshot that shows the New workbook icon Azure Workbooks page.":::
1. Add descriptive text to the top of the workbook:
    1. Select **Add** and then **Add Text**.

        :::image type="content" source="../media/3-add-text.png" alt-text="Screenshot that shows the Add text button in an Azure workbook.":::

    1.  The Azure Workbook text editor uses markdown format. Enter text into the editor. You can copy this text if you would like.

    ```
        # Learn module exercise workbook
        ## Select a subscription from the drop-down below.
    ```

    1. Select **Done editing**.
    1. You now have a simple workbook with text.

    :::image type="content" source="../media/3-workbook-with-text.png" alt-text="Screenshot of a new Azure workbook with text.":::

## Add a subscription picker to your workbook

1. Select **Edit** from the right side of the section you just created.

    :::image type="content" source="../media/3-workbook-with-text-edit-button.png" alt-text="Screenshot that shows the edit button from a section of a workbook.":::
1. Select **Add**, and then **Add parameters**.

    :::image type="content" source="../media/3-add-parameters.png" alt-text="Screenshot that shows the add parameters button in a workbook.":::
1. Select **Add Parameter**.
1. In the **New Parameter** window:
    - In both the **Parameter name** and **Display name** fields, enter "Subscription".
    - In the **Parameter type** field, select **Subscription picker**.
    - Select the **Required** checkbox.

    :::image type="content" source="../media/3-parameter-settings.png" alt-text="Screenshot that shows the parameter settings in a workbook."::: 
    - Select **Save**, and then **Done editing**.
1. Select **Done editing** again.
1. You now have a workbook with a **Subscription** drop-down picker.

    :::image type="content" source="../media/3-workbook-with-subscription-picker.png" alt-text="Screenshot that shows an Azure workbook with a subscription picker drop down list.":::

## Add a map to show the distribution of the subscription's resources

1. Select **Edit** from the top toolbar.
1. Select the subscription from the **Subscription** drop-down.
1. Select **Add Query**.

    :::image type="content" source="../media/3-add-query.png" alt-text="Screenshot that shows the add query icon in a workbook.":::

1. In the **Data source** field, select **Azure Resource Graph**.
1. In the **Subcription** field, under **Resource parameters**, select the **Subscription** checkbox.
1. Add this query to the **Subscriptions Azure Resource Graph Query** section:

    ```
    resources
   | summarize count() by location
    ```  

    :::image type="content" source="../media/3-query.png" alt-text="Screenshot that shows a query being configured in a workbook.":::

1. Select **Run Query**.
1. You will see the results of your query in a table below the query.
1. To show your resources in a map, in the **Visualization** field on top of the query, select **Map**.
1. In the **Map Settings** window, keep the default map settings, and select **Save and close**.
1. Select **Advanced settings** at the top of the query, and enter "Resource distribution per region" in the **Chart title**.
1. Select **Done editing**.
1. You now have a workbook that lets the user select a subscription and displays all of the resources in that subscription in a map.
    :::image type="content" source="../media/3-workbook-with-map.png" alt-text="Screenshot that shows an Azure workbook with a map displaying a subscription's resources.":::
1. Select **Save**.
1. Enter a name for your workbook, and select the resource group and subscription.
1. 