In this exercise, you deploy a container app from an image in the Azure Container Registry to the Azure Container Apps platform.

The following Azure resources must be available in your Resource group named RG1:

- A Container registry instance that contains one image.
- A Virtual network with subnets.
- A Service Bus Namespace
- A Managed Identity
- A Private endpoint

You've been asked to configure a container app that meets the following requirements:

- Is deployed to VNET1/ACASubnet.
- Pulls an image from a container registry.
- Authenticates using a user-assigned managed identity (uai-az2003).
- Uses Container App to connect to a Service Bus instance using the .NET client type.
- The app can run up to two replicas that are added whenever there are 10,000 HTTP concurrent requests.

You complete the following tasks during this exercise:

1. Create a container app that uses an ACR image

1. Configure the container app to authenticate using the user assigned identity

1. Configure a connection between the container app and Service Bus

1. Configure HTTP scale rules

1. Verify the configuration

## Create a container app that uses an ACR image

Complete the following steps to create a container app that uses an ACR image.

1. Open your Azure portal.

1. On the portal menu, select **+ Create a resource**.

1. On the top search bar, in the Search textbox, enter **container app**

1. In the search results under Services, select **Container Apps**.

1. Select **Create**.

1. On the Basics tab, specify the following:

    - Subscription: Specify the Azure subscription that you're using for this guided project.
    - Resource group: **RG1**
    - Container app name: **aca-az2003**
    - Region: Select the Region specified for VNET1 (Central US).

        The container app needs to be in the same region/location as the virtual network so you can choose VNET1 for the managed environment. For this guided project, keep all of your resources in the region/location specified for your resource group.

    - Container Apps Environment: Select **Create new**.

1. On the Create Container Apps Environment page, select the **Networking** tab, and then specify the following:

    - Use your own virtual network: Select **Yes**.
    - Virtual network: Select **VNET1**.
    - Infrastructure subnet: **ACASubnet**.

    > [!NOTE]
    > If the ACASubnet subnet is not listed, open your virtual network resource, adjust the subnet address range to **10.0.2.0/23** and retry the steps to create the Container App.

1. On the Create Container Apps Environment page, select **Create**.

1. On the Create Container App page, select the Container tab, and then specify the following:

    - Use quickstart image: Ensure that this setting is not selected. If it is selected, **uncheck** this setting.
    - Name: Enter **aca-az2003**
    - Image source: Ensure that **Azure Container Registry** is selected.
    - Registry: Select your container registry. For example: **acraz2003cah.azurecr.io**
    - Image: Select **aspnetcorecontainer**
    - Image tag: Select **latest**

1. Select **Review + create**.

1. Once verification has Passed, select **Create**.

1. Wait for the deployment to complete.

    > [!NOTE]
    > This deployment normally takes 3-5 minutes to complete, but may take up to 10 minutes.

## Configure the container app to authenticate using the user assigned identity

Complete the following steps to configure the container app to authenticate using the user assigned identity.

1. On the Azure portal, open the Container App that you created.

1. Under Settings, select **Identity**.

1. Select the tab for **User assigned**.

1. Select **Add user assigned managed identity**.

1. On the Add user assigned managed identity page, select **uai-az2003**, and then select **Add**.

## Configure a connection between the container app and Service Bus

Complete the following steps to configure a connection between the container app and Service Bus.

1. On the Azure portal, ensure that you have your Container App open.

1. Under Settings, select **Service Connector (Preview)**.

1. Select **Connect to your Services**.

1. On the Create connection page, specify the following:

    - Service type: Select **Services Bus**.
    - Client type: Select **.NET**.

1. Select **Next: Authentication**.

1. On the Authentication tab, select **User assigned managed identity**.

1. Ensure that the correct subscription and user assigned managed identity are selected.

    Subscription: The Azure subscription that you're using for this guided project.
    User assigned managed identity: **uai-az2003**

1. To change tabs, select **Review + Create**.

1. Once the Validation passed message appears, select **Create**.

1. Wait for the connection to be created.

    It can take a minute before the Service Connector page updates with the new connection.

## Configure HTTP scale rules

1. Ensure that your Container App is open in the portal.

1. On the left-side menu under Application, select **Revisions and replicas**.

1. Notice the Name assigned to your active revision.

1. On the left-side menu under Application, select **Containers**.

1. To the right of **Based on revision**, ensure that your active revision is selected.

1. At the top of the page, select **Edit and deploy**.

1. At the bottom of the page, select **Next : Scale**.

1. Configure the Min / max replicas as follows:

    - Set Min replicas: 0
    - Set Max replicas: 2

1. Under Scale rule, select **+ Add**.

1. On the Add scale rule page, specify the following:

    - Rule name: Enter **scalerule-http**
    - Type: Select **HTTP scaling**.
    - Concurrent requests: Set the value to **10,000**.

1. On the Add scale rule page, select **Add**.

1. On the Create and deploy new revision page, select **Create**.

1. Ensure that your new scale rule is displayed.

## Check your work

In this task, you verify that your configuration meets the specified requirements.

1. In the Azure portal, ensure that your Container App resource is open.

1. On the left-side menu, under Settings, select **Deployment**.

1. At the top of the page, ensure that the Continuous deployment tab is selected.

1. Verify that the expected Registry settings are reported:

    - Repository source: **Azure Container Registry**
    - Registry: the name of your Container Registry (for example: acraz2003cah)
    - Image: **aca-az2003**

1. Close the Container App page.

1. Open your Container Apps Environment resource.

1. Verify that your Container App uses the proper subnet as follows:

    - On the Overview page, verify that Virtual Network is set to **VNET1**.
    - On the Overview page, verify that Infrastructure subnet is set to **ACASubnet**.

1. In the Azure portal, open the Cloud Shell and the switch to PowerShell.

1. Run the following command:

    ```azurecli
    az containerapp connection show [--connection]
                                    [--name]
                                    [--resource-group]
    
    ```

    For example:

    ```azurecli
    az containerapp connection show --connection servicebus_b2a10 --name aca-az2003 --resource-group RG1  
    ```

1. Verify that the targetService properties match the specified configuration.

To verify your HTTP scale rule, you would need to run testing software that's able to simulate 10,000 concurrent HTTP requests and ensure that container replicas are created.
