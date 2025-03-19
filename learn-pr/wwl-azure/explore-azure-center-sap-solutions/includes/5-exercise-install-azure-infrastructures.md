To create a deployment with Azure Center for SAP solutions (ACSS) Azure infrastructure, sign in to the [Azure portal](https://portal.azure.com). Then, follow the **Create deployment** steps below, provided you have the pre-provisioned network and other prerequisites are in place.

Supplemental options for this lesson include:

- A detailed set of lab steps are available in AZ-120 GitHub lab Module 4: Design and implement an infrastructure to support SAP workloads on Azure - [Exercise 2: Deploy the infrastructure that will host SAP workloads in Azure by using Azure Center for SAP solutions](https://go.microsoft.com/fwlink/?linkid=2261024&clcid=0x409).
- Interactive Guides including clickable simulations are available for:
  - [Installing ACSS prerequisites](https://mslearn.cloudguides.com/guides/Azure%20Center%20for%20SAP%20solutions%20-%20Complete%20the%20prerequisites%20for%20deploying%20and%20registering%20SAP%20systems).
  - [Infrastructure deployment](https://mslearn.cloudguides.com/guides/Azure%20Center%20for%20SAP%20solutions%20-%20Deploy%20an%20SAP%20system) and the installation of the SAP software.

## Create deployment

1. In the search bar, enter and select **Azure Center for SAP solutions**.

1. On the Azure Center for SAP solutions landing page, select **Create a new SAP system**.

1. On the **Create Virtual Instance for SAP solutions** page, on the **Basics** tab, fill in the details for your project:

    - For **Subscription**, select the Azure subscription into which you're deploying the infrastructure.

    - For **Resource group**, select the resource group for all resources that the VIS creates.

1. Under **Instance details**, enter the details for your SAP instance:

    - For **Name** enter the three-character SAP system identifier (SID). The VIS uses the same name as the SID.

    - For **Region**, select the Azure region into which you're deploying the resources.

    - For **Environment type**, select whether your environment is production or nonproduction. If you select **Production**, you can deploy a distributed HA or non-HA S/4HANA system. It's recommended to use distributed HA deployments for production systems. If you select **Non-production**, you can use a single-server deployment.

    - For **SAP product**, keep the selection as **S/4HANA**.

    - For **Database**, keep the selection as **HANA**.

    - For **HANA scale method**, keep the selection as **Scale up**.

    - For **Deployment type**, [select and configure your deployment type](/azure/sap/center-sap-solutions/deploy-s4hana#deployment-types).

    - For **Network**, create the [network you created previously with subnets](/azure/sap/center-sap-solutions/prepare-network).

    - For **Application subnet** and **Database subnet**, map the IP address ranges as required. It's recommended to use a different subnet for each deployment. The names including **AzureFirewallSubnet**, **AzureFirewallManagementSubnet**, **AzureBastionSubnet**, and **GatewaySubnet** are reserved names within Azure and **shouldn't be used** as the subnet names.

1. Under **Operating systems**, enter the OS details:

    - For **Application OS image**, select the OS image for the application server.

    - For **Database OS image**, select the OS image for the database server.

1. Under **Administrator account**, enter your administrator account details:

    - For **Authentication type**, keep the setting as **SSH public**.

    - For **Username**, enter an SAP administrator username.

    - For **SSH public key source**, select a source for the public key. You can choose to generate a new key pair, use an existing key stored in Azure, or use an existing public key stored on your local computer. If you don't have keys already saved, it's recommended to generate a new key pair.

    - For **Key pair name**, enter a name for the key pair.

    - If you choose to use an **Existing public key stored in Azure**, select the key in **Stored Keys** input.

    - Provide the corresponding SSH private key from **local file** stored on your computer, or **copy paste** the private key.

    - If you choose to use an **Existing public key**, either provide the SSH public key from **local file** stored on your computer or **copy paste** the public key.

    - Provide the corresponding SSH private key from **local file** stored on your computer or **copy paste** the private key.

1. Under **SAP Transport Directory**, enter how you want to set up the transport directory on this SID. This is applicable for **Distributed with High Availability** and **Distributed** deployments only.

    - For **SAP Transport Options**, you can choose to **Create a new SAP transport Directory** or **Use an existing SAP transport Directory** or completely skip the creation of transport directory by choosing **Don't include SAP transport directory** option. Currently, only NFS on AFS storage account fileshares is supported.

    - If you choose to **Create a new SAP transport Directory**, this will create and mount a new transport fileshare on the SID. By default, this option creates an NFS on AFS storage account and a transport fileshare in the resource group where the SAP system will be deployed. However, you can choose to create this storage account in a different resource group by providing the resource group name in **Transport Resource Group**. You can also provide a custom name for the storage account to be created under the **Storage account name** section. Leaving the **Storage account name** blank creates the storage account with the service default name **`"SIDname""nfs""random characters"`** in the chosen transport resource group. Creating a new transport directory creates a ZRS-based replication for zonal deployments and LRS-based replication for nonzonal deployments. If your region doesn't support ZRS replication, deploying a zonal VIS leads to a failure. In such cases, you can deploy a transport fileshare outside ACSS with ZRS replication, and then create a zonal VIS where you select **Use an existing SAP transport Directory** to mount the precreated fileshare.

    - If you choose to **Use an existing SAP transport Directory**, select the pre-existing NFS fileshare under the **File share name** option. The existing transport fileshare is mounted only on this SID. The selected fileshare must be in the same region as that of the SAP system being created. Currently, file shares existing in a different region can't be selected. Under the **Private Endpoint** option, provide the associated private endpoint of the storage account where the selected fileshare exists.

    - You can skip the creation of the transport file share by selecting **Don't include SAP transport directory** option. The transport fileshare won't be created or mounted for this SID.

1. Under **Configuration Details**, enter the FQDN for your SAP system. For **SAP FQDN**, provide only the domain name for your system, such as *sap.contoso.com*

1. Under **User assigned managed identity**, provide the identity which ACSS uses to deploy infrastructure:

    - For **Managed identity source**, choose if you want the service to create a new managed identity, or use an existing identity. If you want the service to create a managed identity, select the checkbox that asks for your consent for the identity to be created and the contributor role access to be added for all resource groups.

    - For **Managed identity name**, enter a name for a new identity you want to create, or select an existing identity from the drop-down menu. If you're selecting an existing identity, it should have **Contributor** role access on the subscription or on Resource Groups related to the SAP system you're trying to deploy (That is, it requires Contributor access to the SAP application Resource Group, Virtual Network Resource Group, and Resource Group that has the existing SSHKEY). If you want to later install the SAP system using ACSS, we also recommend giving the **Storage Blob Data Reader and Reader** and **Data Access** roles on the Storage Account that has the SAP software media.

1. Select **Next: Virtual machines**.

1. In the **Virtual machines** tab, generate SKU size and total virtual machine count recommendations for each SAP instance from ACSS:

    - For **Generate Recommendation based on**, under **Get virtual machine recommendations**, select **SAP Application Performance Standard (SAPS)**.

    - For **SAPS for application tier**, provide the total SAPS for the application tier. For example, 30,000.

    - For **Memory size for database (GiB)**, provide the total memory size required for the database tier. For example, 1024. The value must be greater than zero, and less than or equal to 11,400.

    - Select **Generate Recommendation**.

    - Review the virtual machine size and count recommendations for ASCS, Application Server, and Database instances.

    - To change a SKU size recommendation, select the drop-down menu or select **See all sizes**. Filter the list or search for your preferred SKU.

    - To change the Application server count, enter a new count for **Number of virtual machines** under **Application virtual machines**.

        >[!NOTE]
        >The number of virtual machines for ASCS and Database instances isn't editable. The default number for each is **2**.
        >
        >ACSS automatically configures a database disk layout for the deployment. To view the layout for a single database server, make sure to select a virtual machine SKU. Then, select **View disk configuration**. If there's more than one database server, the layout applies to each server.

1. Select **Next: Visualize Architecture**.

1. In the **Visualize Architecture** tab, visualize the architecture of the VIS that you're deploying:

    - To view the visualization, make sure to configure all the inputs listed on the tab.

    - Optionally, select and drag resources or containers to move them around visually.

    - Select **Reset** to reset the visualization to its default state. That is, revert any changes you might have made to the position of resources or containers.

    - Select **Scale to fit** to reset the visualization to its default zoom level.

    - Select **Zoom in** to zoom into the visualization.

    - Select **Zoom out** to zoom out of the visualization.

    - Select **Download JPG** to export the visualization as a JPG file.

    - Select **Feedback** to share your feedback on the visualization experience.

        >[!NOTE]
        >The visualization doesn't represent all resources for the VIS that you're deploying, for instance it doesn't represent disks and NICs.

1. Select **Next: Tags**.

1. Optionally, enter tags to apply to all resources created by the ACSS process. These resources include the VIS, ASCS instances, Application Server instances, Database instances, virtual machines, disks, and NICs.

1. Select **Review + Create**.

1. Review your settings before deployment:

    - Make sure the validations have passed, and there are no errors listed.

    - Review the Terms of Service, and select the acknowledgment if you agree.

1. Select **Create**.

1. Wait for the infrastructure deployment to complete. Numerous resources are deployed and configured. This process takes approximately 7 minutes.

## Confirm deployment

To confirm a deployment is successful:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual Instances for SAP solutions**.

1. On the **Virtual Instances for SAP solutions** page, select the **Subscription** filter, and choose the subscription where you created the deployment.

1. In the table of records, find the name of the VIS. The **Infrastructure** column value shows **Deployed** for successful deployments.

>[!NOTE]
>If the deployment fails, delete the VIS resource in the Azure portal, then recreate the infrastructure.

By following these steps, you can create and deploy an SAP system Azure infrastructure on Azure using ACSS. Once the Azure infrastructure is deployed ACSS also guides the installation of SAP software.
