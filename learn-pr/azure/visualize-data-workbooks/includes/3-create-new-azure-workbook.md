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
1. Copy the name of the resource group.
1. Enter this command to define the resource group.

    ```azurecli
    resourceGroup="<your resource group name>"
    ```

1. Run these commands to deploy the Azure resource group and resources:

    ```azurecli
       git clone https://github.com/MicrosoftDocs/ms-learn-azure-monitor-workbooks.git
       cd ms-learn-azure-monitor-workbooks/Resources/
       az deployment group create --resource-group $resourceGroup --template-file deploy-resources.bicep
    ```

1. When you are prompted for a password, enter a password that complies with the password requirements. For example, enter `Learn@123456`. Write this password down, you will need it later. The password must:
    - Be at least 12 characters long
    - Contain at least 3 out of the following 4 characteristics:
    - one lower case letter
    - one upper case letter
    - one number
    - one special character, not including `\` or `-`.
1. The resources that you need for the module are now deployed. Wait until the process completes.
1. Log into the Azure portal.
1. On the **Home** page, enter "Resource groups" into the search bar at the top.
1. Select the resource group that we just created.
1. Look through the list of resources and select the App Service plan.

:::image type="content" source="../media/3-portal-select-app-service.png" alt-text="Screenshot of selecting the App Service from the resource group.":::

1. On the top toolbar, select **Browse**.

:::image type="content" source="../media/3-portal-browse-app-service.png" alt-text="Screenshot of the browser button from the App Service page.":::

1. Populate the App service with some activities to generate some data for our example. On the **List of To-Do Items** page, create some items, edit them, or mark some as complete.
1. Now, we can go ahead with creating a workbook.

## Create a workbook
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Add some descriptive text
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Add a control to let the user pick a subscription
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Add map visualization
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->


## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video
