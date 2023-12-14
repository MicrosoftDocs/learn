In this exercise, you configure a container registry instance for a secure connection from a container app.

The following Azure resources must be available in your Resource group named RG1:

- A Container Registry instance that contains one image.
- A Virtual Network with subnets.
- Service Bus Namespace

> [!IMPORTANT]
> The previous unit (Prepare your app deployment tools and resources) includes a Setup section that describes how to configure the recourses for this guided project module. If necessary, go back and follow the Setup instructions.

You've been asked to configure your Azure resources to meet the following requirements:

- Your resource group must include a user-assigned managed identity.
- Your container registry must be able to use the managed identity to pull artifacts.
- Access for the managed identity must be limited using the principle of least privilege.
- Your container registry must be accessible from a private endpoint on VNET1/PESubnet.

You complete the following tasks during this exercise:

1. Configure a user-assigned managed identity.

1. Configure your container registry with AcrPull permissions for the managed identity.

1. Configure your container registry with a private endpoint connection.

1. Verify the configuration.

> [!NOTE]
> Before continuing, ensure that you've completed the Setup section of the *Prepare your app deployment tools and resources* unit.

## Configure a user-assigned managed identity

Complete the following steps to configure a user-assigned managed identity.

1. Open your Azure portal

1. On the portal menu, select **+ Create a resource**.

1. On the Create a resource page, in the Search services and marketplace text box, enter **managed identity**

1. In the filtered list of resources, select **User Assigned Managed Identity**.

1. On the User Assigned Managed Identity page, select **Create**.

1. On the Create User Assigned Managed Identity page, specify the following information:

    - Subscription: Specify the Azure subscription that you're using for this guided project.
    - Resource group: **RG1**
    - Region: **Central US**
    - Name: **uai-apl2003**

1. Select **Review + create**.

1. Select **Create**.

## Configure Container Registry with AcrPull permissions for the managed identity

Complete the following steps to configure Container Registry with AcrPull permissions for the managed identity.

1. In the Azure portal, open your Container Registry resource.

1. On the left-side menu, select **Access Control (IAM)**.

1. On the Access Control (IAM) page, select **Add role assignment**.

1. Search for the AcrPull role, and then select **AcrPull**.

1. Select **Next**.

1. On the Members tab, to the right of Assign access to, select **Managed identity**.

1. Select **+ Select members**.

1. On the Select managed identities page, under Managed identity, select **User-assigned managed identity**, and then select the user-assigned managed identity created for this project.

    For example: `uai-apl2003`.

1. On the Select managed identities page, select **Select**.

1. On the Members tab of the Add role assignment page, select **Review + assign**.

1. On the Review + assign tab, select **Review + assign**.

1. Wait for the role assignment to be added.

## Configure Container Registry with a private endpoint connection

1. Ensure that your Container Registry resource is open in the portal.

1. Under Settings, select **Networking**.

1. On the Private access tab, select **+ Create a private endpoint connection**.

1. On the Basics tab, under Project details, specify the following information:

    - Subscription: Specify the Azure subscription that you're using for this guided project.
    - Resource group: **RG1**
    - Name: **pe-acr-apl2003**
    - Region: Ensure that **Central US** is selected.

1. Select **Next: Resource**.

1. On the Resource tab, ensure the following information is displayed:

    - Subscription: Ensure that the Azure subscription that you're using for this guided project is selected.
    - Resource type: Ensure that **Microsoft.ContainerRegistry/registries** is selected.
    - Resource: Ensure that the name of your registry is selected.
    - Target sub-resource: Ensure that **registry** is selected.

1. Select **Next: Virtual Network**.

1. On the Virtual Network tab, under Networking, ensure the following information is displayed:

    - Virtual network: Ensure that **`VNET1`** is selected
    - Subnet: Ensure that **`PESubnet`** is selected.

1. Select **Next: DNS**.

1. On the DNS tab, under Private DNS Integration, ensure the following information is displayed:

    - Integrate with private DNS zone: Ensure that **Yes** is selected.
    - Private DNS Zone: Notice that **(new) privatelink.azurecr.io** is specified.

1. Select **Next: Tags**.

1. Select **Next: Review + create**.

1. On the Review + create tab, when you see the Validation passed message, select **Create**.

1. Wait for the deployment to complete.

## Check your work

In this task, you verify that your configuration meets the specified requirements.

1. In the Azure portal, open your Container Registry resource.

1. On the Access Control (IAM) page, select **Role assignments**.

1. Verify that the role assignments list shows the **AcrPull** role assigned to the User-assigned Managed Identity resource.

1. On the left-side menu, under Settings, select **Networking**.

1. On the Networking page, select the **Private access** tab.

1. Under Private endpoint, select the private endpoint that you created.

    For example, select **per-acr-apl2003**

1. On the Private endpoint page, under Settings, select **DNS configuration**.

1. Verify the following DNS setting:

    - Private DNS zone: set to **privatelink.azurecr.io**.

1. On the left-side menu, select **Overview**.

1. Verify the following setting:

    - Virtual network/subnet: set to **VNET1/PESubnet**.
