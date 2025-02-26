Workbooks provide a canvas for creating interactive visual reports. In this exercise, you'll create a new workbook, add some descriptive text and a parameter to query all of the resources in a selected subscription. By the end of this unit, you'll have a report that shows the distribution of your resources on a map.

## Deploy resources for the exercise using the Azure CLI

The first thing we'll do is activate the Azure sandbox and deploy an ARM template containing all the Azure resources we need for this exercise.

1. Activate the Azure sandbox. When the sandbox is activated, a resource group with the name `learn-{guid}` is created for you to use. This resource group will be visible in the Azure portal, or through CLI commands such as `az group list`.
1. In the Azure Cloud Shell, get the name of the resource group that was generated for your sandbox.

    ```azurecli
    az group list
    ```

1. The output contains a row with the name of the resource group. The name starts with "learn-".

    :::image type="content" source="../media/3-cloud-shell-resourcegroup-name.png" alt-text="Screenshot of Cloud Shell displaying resource group name for sandbox.":::
1. Copy the name of the resource group by right-clicking on the name and selecting **Copy**.
1. Enter this command to define the resource group. (Right-click and select **Paste** to paste the resource group name. You may have to remove any extra characters around the resource group name.)

    ```azurecli
    resourceGroup="<your resource group name>"
    ```

1. Run these commands to deploy the Azure resource group and resources:

    ```azurecli
       git clone https://github.com/MicrosoftDocs/ms-learn-azure-monitor-workbooks.git 
       cd ms-learn-azure-monitor-workbooks/Resources/
       az deployment group create --resource-group $resourceGroup --template-file deploy-resources.bicep
    ```

1. When you're prompted for a password, enter a password that complies with the password requirements. For example, enter "Learn@123456". The password must:
    - Be at least 12 characters long
    - Contain at least 3 out of the following four characteristics:
        - one lower case letter
        - one upper case letter
        - one number
        - one special character, not including \ or -.
1. Wait while the resources that you need for the module are deployed. This will take a few minutes.
1. You can sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to see the resources deployed in your sandbox for this learn module.
1. On the **Home** page, select **Resource groups**, or search for "Resource groups" in the search bar at the top of the page.
1. Select the "learn" resource group created when the sandbox was activated.
1. Look through the list of resources and see the resources created for this exercise.

    :::image type="content" source="../media/3-portal-resources.png" alt-text="Screenshot of the resources in a resource group.":::

## Create a new workbook

1. From the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) home page, search for and select **Monitor**.
1. Select **Workbooks** from the left pane.
1. Select **+ New** from the top toolbar.
    :::image type="content" source="../media/3-portal-new-workbook.png" alt-text="Screenshot that shows the New workbook icon Azure Workbooks page.":::
1. Add descriptive text to the top of the workbook:
    1. Select **Add** and then **Add Text**.

        :::image type="content" source="../media/3-add-text.png" alt-text="Screenshot that shows the Add text button in an Azure workbook.":::

    1. The Azure Workbook text editor uses markdown format. Enter text into the editor. You can copy this text if you would like.

        ```azurecli
            # Learn module exercise workbook
            **Select a subscription from the drop-down below.**
        ```

    1. Select **Done editing**. You now have a simple workbook with text.

    :::image type="content" source="../media/3-workbook-with-text.png" alt-text="Screenshot of a new Azure workbook with text.":::

## Add a subscription picker to your workbook

1. Select **Edit** from the right side of the section you created.

    :::image type="content" source="../media/3-workbook-with-text-edit-button.png" alt-text="Screenshot that shows the edit button from a section of a workbook.":::
1. Select **Add**, and then **Add parameters**.

    :::image type="content" source="../media/3-add-parameters.png" alt-text="Screenshot that shows the add parameters button in a workbook.":::
1. Select **Add Parameter**.
1. In the **New Parameter** window:
    1. In both the **Parameter name** and **Display name** fields, enter "Subscription".
    1. In the **Parameter type** field, select **Subscription picker**.
    1. Select the **Required** checkbox.

    :::image type="content" source="../media/3-parameter-settings.png" alt-text="Screenshot that shows the parameter settings in a workbook.":::
    1. Select **Save**, and then **Done editing**.
1. Select **Done editing** again. You now have a workbook with a **Subscription** drop-down picker.

    :::image type="content" source="../media/3-workbook-with-subscription-picker.png" alt-text="Screenshot that shows an Azure workbook with a subscription picker drop-down list.":::

## Add a map to show the distribution of the subscription's resources

1. Select **Edit** from the top toolbar.
1. Select the subscription from the **Subscription** drop-down.
1. Select **Add Query**.

    :::image type="content" source="../media/3-add-query.png" alt-text="Screenshot that shows the add query icon in a workbook.":::

1. In the **Data source** field, select **Azure Resource Graph**.
1. In the **Subscription** field, under **Resource parameters**, select the **Subscription** checkbox.
1. Add this query to the **Subscriptions Azure Resource Graph Query** section:

    ```azurecli
        resources
       | summarize count() by location
    ```  

    :::image type="content" source="../media/3-query.png" alt-text="Screenshot that shows a query being configured in a workbook.":::

1. Select **Run Query**.
1. You'll see the results of your query in a table below the query.
1. To show your resources in a map, in the **Visualization** field on top of the query, select **Map**.
1. In the **Map Settings** window, keep the default map settings, and select **Save and close**.
1. Select **Advanced settings** at the top of the query, and enter "Resource distribution per region" in the **Chart title**.
1. Select **Done editing**. You now have a workbook that lets the user select a subscription and displays all of the resources in that subscription in a map.

    :::image type="content" source="../media/3-workbook-with-map.png" alt-text="Screenshot that shows an Azure workbook with a map displaying a subscription's resources.":::

1. Select **Save As**.
1. Enter a **Name** for your workbook, select the **Subscription** and **Resource group**, and select **Apply**.
