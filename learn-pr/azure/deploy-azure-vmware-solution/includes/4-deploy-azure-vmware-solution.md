After completing the planning steps, you can deploy the standard, single-zone Generation 1 Azure VMware Solution private cloud used in this walkthrough. Have your approved host quota, permanent management address plan, and portable VMware Cloud Foundation (VCF) subscription details ready. Generation 2 uses a different hosting-VNet and deployment workflow.

## Register the resource provider

Register `Microsoft.AVS` in the subscription where you'll deploy the private cloud. Use one of the following methods and confirm that registration completes before provisioning hosts. The additional `Microsoft.BareMetal` provider discussed in planning applies to the separate Generation 2 deployment path.

### Azure CLI

To register the resource provider by using the Azure CLI:

1. Start Azure Cloud Shell and select **Bash**.
1. Confirm that your signed-in account has the required access to the target subscription.
1. Replace the subscription placeholder, register the provider, and display its registration state:

    ```azurecli
    subscriptionId="REPLACE_WITH_AVS_SUBSCRIPTION_ID"

    az provider register \
      --namespace Microsoft.AVS \
      --subscription "$subscriptionId" \
      --wait

    az provider show \
      --namespace Microsoft.AVS \
      --subscription "$subscriptionId" \
      --query registrationState \
      --output tsv
    ```

1. Confirm that the final state is `Registered`. Resolve any error before continuing.

### PowerShell

To register the resource provider by using PowerShell:

1. Start Azure Cloud Shell and select **PowerShell**.
1. Select and confirm the intended subscription context. Don't assume that the current context is the subscription you plan to use.
1. Register the provider:

    ```powershell
    Register-AzResourceProvider -ProviderNamespace Microsoft.AVS
    ```

1. Confirm that the provider's registration state is `Registered` in the target subscription before continuing.

### Azure portal

To register the resource provider by using the Azure portal:

1. Search for **Subscriptions**.
1. Select the subscription for which you want to register the provider.
1. Select **Resource providers** and enter **Microsoft.AVS** in the search bar. If the provider isn't registered, select **Register** and wait for its state to become **Registered**.

    :::image type="content" source="../media/4-register-resource-provider.png" alt-text="Screenshot of resource-provider registration in the Azure portal.":::

## Deploy Azure VMware Solution using the Azure portal

For this Generation 1 deployment, make sure you have at least Contributor-level access to the subscription and approved quota for the selected region and host type. Azure permissions don't replace your portable VCF entitlement. Gather the Broadcom license/subscription key, site ID, serial number, expiration date, and deployed BYOL core count.

> [!IMPORTANT]
> This walkthrough creates billable resources in your Azure subscription. Confirm the deployment budget and retention plan before selecting **Create**. Closing a Bastion session or stopping the jumpbox doesn't remove the Bastion resource or stop its hourly charges. Complete all units before cleaning up a disposable deployment. Resource deletion doesn't cancel Azure reservations or the separately purchased Broadcom subscription.

Follow these steps:

1. In the Azure portal, select **Create a resource**, search for **Azure VMware Solution**, and open the private-cloud creation flow.
1. Confirm that you're using the Generation 1 creation experience for this walkthrough. Review the subscription, quota, licensing, and network prerequisites before continuing.
1. On **Basics**, complete the deployment settings. The following table describes the required choices:

    | Field | Value |
    | :----- | :----- |
    | **Subscription** | The subscription for the deployment. |
    | **Resource group** | The resource group for private cloud resources. Select an existing resource group or create a new one. |
    | **Resource name** | A name for the Azure VMware Solution private cloud. |
    | **Location** | A region with capacity for the selected Generation 1 host type and availability-zone design. |
    | **Size of host** | A supported base-cluster SKU for the initial deployment. Generation 1 AV64 hosts require an existing supported base cluster. |
    | **Host location** | Select **All hosts in one availability zone** for this walkthrough. A stretched private cloud requires the separate prerequisites and zone-specific connection design described in planning. |
    | **Number of hosts** | A standard cluster supports 3-16 hosts. A stretched cluster supports 6-16 hosts in total, equally divided across two zones with at least three per zone. Use the capacity assessment and storage policy to determine the actual count. |
    | **Portable VCF (BYOL)** | Configure the Broadcom subscription details for this private cloud. Enter only the deployed BYOL core count, not the full purchased entitlement unless all those cores are deployed here. |
    | **Address block for private cloud** | The permanent, non-overlapping management /22 selected during planning. Use permitted RFC1918 space excluding `172.17.0.0/16`, separate from workload and connected customer-VNet ranges. |

1. Select **Review + Create**, review the configuration, and select **Create**. Allow several hours for deployment. The documented estimate is four hours or more, not a completion guarantee.

1. When the deployment finishes, select the resource group, and then select the private cloud. The **Status** will show as **Succeeded**:

    :::image type="content" source="../media/4-private-cloud-succeeded.png" alt-text="Screenshot of a successful private-cloud deployment.":::

Deployment success and VCF registration status are separate checks.

1. Open **Manage > Portable VCF (BYOL)** and confirm that the base VCF subscription status is **Registered**.
1. Verify the expiration date and confirm that the registered core count exactly matches the physical cores of the deployed BYOL hosts in this private cloud.
1. If registration shows **Failed**, select **Reconfigure**, enter and save the registration details again, and confirm that the status becomes **Registered**. Contact Microsoft support if registration continues to fail.

> [!NOTE]
> These core-count checks apply to the base VCF subscription. Register any required VMware vDefend Firewall add-on separately and use its own licensing calculation. Don't assume that its core count equals the base VCF count.

Update and recheck the base VCF registration whenever you add or remove BYOL hosts, replace a key, or renew the subscription. For routine changes, use **Edit** under **VCF license details** on the **Portable VCF (BYOL)** page and save the updated details. Standard and stretched placement can't be converted after deployment. AV64 doesn't support the stretched-cluster option.

## Connect to an Azure virtual network

The Generation 1 private cloud isn't deployed inside your customer VNet. Connect the AVS-managed ExpressRoute circuit to an ExpressRoute gateway in that VNet so that a jumpbox can reach the private management interfaces.

For this **Azure VNet connect** walkthrough, use a VNet in the same subscription, resource group, and region as the private cloud, with non-overlapping address space. Reserve a dedicated `GatewaySubnet` of /27 or larger for a normal new gateway deployment. Don't attach an NSG, disable BGP route propagation, or apply a `0.0.0.0/0` user-defined route to this subnet. Choose a gateway SKU suited to the expected traffic and required features, including FastPath where appropriate.

1. Open the private cloud and select **Manage > Connectivity > Azure VNet connect**.
1. Select an existing suitable VNet or create a new one. Confirm the VNet and gateway-subnet address ranges before saving.
1. Select **Save** and wait for resource deployment to complete.

    :::image type="content" source="../media/4-azure-private-cloud-vnet-connect.png" alt-text="Screenshot of Azure VNet connect settings for a private cloud.":::

The helper deploys or reuses the following connectivity components:

| Component | Purpose |
| --- | --- |
| Customer VNet and `GatewaySubnet` | Hosts the Azure-side gateway and customer resources in their respective subnets. The Gen1 private cloud remains outside this VNet. |
| ExpressRoute virtual network gateway | Connects the VNet to the AVS-managed ExpressRoute circuit. Its SKU affects throughput and feature availability. |
| AVS ExpressRoute authorization | Permits the gateway connection to use the AVS circuit. Authorization isn't divided into inbound and outbound traffic directions. |
| Gateway connection | Binds the gateway to the AVS circuit and carries traffic in both directions when routing and policy permit. |
| Gateway public-IP configuration | Supports Azure-managed gateway operation. It isn't an internet peering endpoint for AVS workload traffic. |

The current manual ExpressRoute gateway portal workflow uses an auto-assigned Standard public IP. Depending on the workflow, there might not be a separate customer-visible public-IP resource to manage. Don't confuse gateway public-IP configuration with public IPs assigned to AVS workloads or with the Bastion public IP.

After deployment, inspect the gateway and connection resources, confirm their successful state, and check the gateway SKU against your requirements. **Azure VNet connect** configures resources but isn't a record of the current connection state. A successful deployment still needs end-to-end connectivity checks.

The next unit configures the on-premises Global Reach connection. For now, use a jumpbox in the connected VNet to access the private vCenter Server and NSX Manager interfaces.

## Create an Azure Bastion resource

Azure Bastion provides browser-based RDP access to the Windows jumpbox without giving the VM a public IP address. From that jumpbox, you'll open the private vCenter Server and NSX Manager interfaces.

After hybrid connectivity is configured, your organization can retain Bastion as an approved alternate management path. Its path to the Gen1 private cloud still depends on the Azure-to-AVS connection.

> [!IMPORTANT]
> Check the routing for this public Basic Bastion deployment before creating it and again after enabling hybrid connectivity. A default route injected into its VNet through ExpressRoute or VPN that forces internet traffic on-premises can break Bastion. User-defined routing on `AzureBastionSubnet` isn't supported. If your approved design requires forced tunneling, design a compatible management path before continuing. Don't disable BGP propagation on `GatewaySubnet` or change AVS-managed routes to work around this limitation.

An NSG on `AzureBastionSubnet` is optional. If your network policy requires one, include all required Bastion service flows rather than allowing only client HTTPS and jumpbox RDP. Keep these rules scoped to the Bastion subnet and the documented service tags or networks.

The following table summarizes the service flows for the public Bastion deployment:

| Direction at the Bastion subnet | Source | Destination | Protocol and destination ports |
| --- | --- | --- | --- |
| Inbound | Permitted client public IP ranges, or the Internet service tag where approved | Bastion | TCP 443 |
| Inbound | GatewayManager service tag | Bastion | TCP 443 |
| Inbound | AzureLoadBalancer service tag | Bastion | TCP 443 |
| Inbound and outbound | VirtualNetwork service tag | VirtualNetwork service tag | Ports 8080 and 5701, with the NSG protocol set to Any |
| Outbound | Bastion | Target VM private addresses | Ports 22 and 3389, with the NSG protocol set to Any |
| Outbound | Bastion | AzureCloud service tag | TCP 443 |
| Outbound | Bastion | Internet service tag | Port 80, with the NSG protocol set to Any |

The target Windows jumpbox needs a separate inbound TCP 3389 rule from the `AzureBastionSubnet` address range through its applicable NSG and guest firewall. Don't open RDP to the public internet. The jumpbox also needs private routes and permitted HTTPS access to the AVS management endpoints. These target-VM rules don't replace the Bastion service rules.

Before deploying Bastion, check the selected VNet's Azure Private DNS zone links. Don't use a VNet linked to private zones with these exact names: `management.azure.com`, `blob.core.windows.net`, `core.windows.net`, `vaultcore.windows.net`, `vault.azure.net`, or `azure.com`. They can interfere with the service endpoints Bastion needs.

A supported private-endpoint zone such as `privatelink.blob.core.windows.net` isn't the same as the conflicting `blob.core.windows.net` zone. If a conflict exists, have the DNS and network owners resolve it or select a suitable management VNet before continuing. Don't delete shared zones as part of this exercise.

To create an Azure Bastion resource:

1. In the Azure portal, search for **Bastions**.
1. Select **Create** in the menu bar.
1. On **Create a Bastion**, use the following settings for this public Basic deployment:

    | Field | Value |
    | ----------- | -------- |
    | **Subscription** | Use the subscription containing the connected customer VNet for this walkthrough. |
    | **Resource group** | Use the resource group containing the VNet for this walkthrough. |
    | **Name** | Specify a name for the new Bastion resource. |
    | **Region** | Use the region of the customer VNet. |
    | **Tier** | Select **Basic**. This provides the functionality we need for this example. You can always upgrade Bastion to **Standard** to have more instance counts. |
    | **Instance Count** | Defaults to 2 when **Basic** is chosen. |
    | **Virtual network** | Select the customer VNet connected to the private cloud. |
    | **Subnet** | Create a dedicated subnet named `AzureBastionSubnet`, with an address range of /26 or larger, such as /25 or /24. Don't deploy the jumpbox or other resources into this subnet. |
    | **Public IP address** | Create a public IP in the Bastion region for HTTPS access to Bastion over port 443. The jumpbox doesn't need a public IP. |
    | **Public IP address name** | Provide a name for the public IP-address resource. |
    | **Public IP address SKU** | Use **Standard**, as required for this public Basic deployment. |
    | **Assignment** | Use **Static**, as required for this public-IP configuration. |

1. Select **Review + create**, review the settings, and select **Create**. Wait for the Bastion deployment to complete.

## Create an Azure VM to use as a jumpbox VM

Deploy a Windows jumpbox in an ordinary VM subnet of the connected customer VNet. Keeping it in the same VNet and subscription as Bastion is a simplifying choice for this exercise, not a universal AVS requirement. Don't place it in `GatewaySubnet` or `AzureBastionSubnet`, and don't assign it a public IP address.

Have the jumpbox's Windows username and password available for this browser-based RDP walkthrough. The account must have permission to sign in through Remote Desktop, for example as an approved local administrator or a member of Remote Desktop Users, subject to the VM's sign-in policies. Azure Contributor access and AVS CloudAdmin credentials don't provide a Windows sign-in. Delegated operators also need read access to the VM, its NIC, and the Bastion resource. The subscription Contributor used in this walkthrough already has that Azure read access for resources in the subscription.

Apply the jumpbox access rules described in the Bastion prerequisites. Connect through Bastion in the Azure portal over TLS, then use the jumpbox's private HTTPS path to vCenter Server and NSX Manager.

A hub-and-spoke design can use Bastion with a target VM in a peered VNet, provided the required connectivity and permissions exist. That alternative doesn't remove the need for a route from the jumpbox to AVS.

## Use Azure Bastion and sign in to vCenter and NSX Manager

Azure permissions to manage the AVS resource are separate from vCenter Server and NSX permissions. The AVS CloudAdmin role is restricted and doesn't provide unrestricted vCenter administrator or ESXi root access. Microsoft manages platform upgrades and service-owned networking.

1. In the Azure portal, open the jumpbox VM resource and select **Connect** > **Bastion**. Use **RDP** on the default port **3389** and the **Username and password** authentication method. Enter the jumpbox's Windows credentials and select **Connect**. After the Windows desktop opens, use the separate VMware credentials in the following steps.
1. Find the private cloud's vCenter Server and NSX Manager addresses and initial credentials under **Manage > VMware credentials**.
1. Open each management HTTPS endpoint from the jumpbox and sign in for approved setup.

> [!IMPORTANT]
> Protect the initial credentials and never include passwords or license keys in screenshots or shared learning materials. Configure supported external identity integration and least-privilege access. Keep the local vCenter CloudAdmin account for emergency access rather than routine administration or service integration.

Use the supported Run Command and identity workflows when an operation exceeds the customer role's direct permissions. Azure Contributor doesn't grant unrestricted VMware administration.

Keep these resources for the remaining connectivity and NSX units. If this is a disposable learning deployment, use the cleanup guidance in the module summary only after completing the entire module.
