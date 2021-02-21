After AVS is deployed, network connectivity becomes the next step for a successful deployment. The AVS solution deploys onto bare metal hosts. The bare metal hosts need to connect to the Azure network backbone so customers can make use of Azure resources. The AVS provided ExpressRoute helps the environment talk to Azure services. To reach on-premises, a customer provided ExpressRoute circuit is needed, along with an ExpressRoute Global Reach configuration. 

## Create an ExpressRoute virtual network gateway for AVS

In the previous unit, you either created a virtual network or configured an existing network for AVS. An ExpressRoute virtual network gateway is created next. The AVS ExpressRoute uses this virtual network gateway to send network traffic to Azure services.

1. In an existing or new resource group, select **+ Add** to add a new resource.
1. In the **Search the Marketplace** text box, type in **Virtual network gateway** and select the resource.
1. On the **Virtual Network Gateway** page, select **Create**.
1. On the **Basics** tab, provide values for the fields and select **Review + create**.

:::image type="content" source="../media/4-create-virtual-network-gateway-expressroute.png" alt-text="Screenshot showing the required information to deploy an ExpressRoute virtual network gateway for AVS connectivity to Azure services.":::

| Field | Value |
| ----- | ----- |
| Subscription | Pre-populated with the subscription where the virtual network is deployed. |
| Resource group | Pre-populated with the resource group where the virtual network is deployed. |
| Name | Enter a name for the virtual network gateway. |
| Region | Select the region of the virtual network and AVS deployment. |
| Gateway type | Select **ExpressRoute**. |
| SKU | Use the default value at **Standard*. |
| Virtual network | Select the virtual network previously created. |
| Gateway subnet address range | Pre-populated when selecting the virtual network. Leave this setting at the default value. |
| Public IP address | Select **Create new**. |

## Peer the AVS ExpressRoute to the virtual network gateway

You'll need to connect the AVS ExpressRoute to Azure. This connection allows access Azure services like Azure Backup, Azure Monitor, Azure Security Center, and so on.

1. Select the AVS private cloud created during the previous unit.
1. Under **Manage**, select **Connectivity**.
1. Select the **ExpressRoute** tab.
1. Copy the authorization key.
1. If there isn't an authorization key, you'll need to create one by selecting **+ Request an authorization key**.

    :::image type="content" source="../media/4-request-auth-key.png" alt-text="Screenshot demonstrating how to request an authorization key for ExpressRoute peering.":::

1. Select the virtual network gateway created in the previous step and under **Settings**, select **Connections**.
1. On the **Connections** page, select **+ Add**.
1. On the **Add connection page**, provide values for the following fields, and select **OK**.

    | Field | Value |
    | ----- | ----- |
    | Name | Enter a name for the connection. |
    | Connection type | Select ExpressRoute. |
    | Redeem authorization | Make sure this box is selected. |
    | Virtual network gateway | Use the virtual network gateway created previously. |
    | Authorization key | Copy and paste the authorization key from the ExpressRoute tab inside the resource group. |
    | Peer circuit URI | Copy and paste the ExpressRoute ID from the ExpressRoute tab in the resource group. |

1. After all fields are filled, a connection between the ExpressRoute circuit and virtual network is created.

## Use Azure Bastion and sign into vCenter and NSX-T

Log into the Azure Bastion host created in the last unit. Once logged in, open a web browser. Navigate to and log into both vCenter and NSX-T Manager.

The Azure portal will provide the vCenter IP address, the NSX-T Manager console's IP addresses, and credentials used for deployment. Select the AVS private cloud. Then select **Identity > Default** in the **Overview** view.

## Create the first network segment on AVS in NSX-T Manager

NSX-T Manager is used to create new network segments in the AVS private cloud. The defined CIDR network address block shouldn't overlap with anything in Azure or on-premises.

1. Select **Networking > Segments** and then select **Add Segment** in NSX-T Manager.

    :::image type="content" source="../media/4-nsxt-segments-overview.png" alt-text="Screenshot demonstrating how to add a network segment into NSX-T Manager.":::

1. Select **Add Segment**.
1. Enter a name for the network segment.
1. Select the Tier-1 Gateway (TNTxx-T1) as the **Connected Gateway**. 
1. Leave the **Type** as Flexible.
1. Select the pre-configured overlay **Transport Zone** (TNTxx-OVERLAY-TZ).
1. Then select **Set Subnets**.

    :::image type="content" source="../media/4-nsxt-create-segment-specs.png" alt-text="Screenshot demonstrating how to create NSX-T Manager segment specifications.":::

1. Enter the IP address of the gateway.
1. Select **Add**. The IP address needs to be on a non-overlapping RFC1918 address block, which ensures connection to the VMs on the new segment.

    :::image type="content" source="../media/4-nsxt-create-segment-gateway.png" alt-text="Screenshot of how to create an NSX-T Manager network segment gateway.":::

1. Select **Apply**.
1. Select **Save**.
1. Select **No** to decline the option that configures the segment.

    :::image type="content" source="../media/4-nsxt-create-segment-continue-no.png" alt-text="Screenshot showcasing that the segment is successfully created and that you must select no to continue.":::

1. Confirm the presence of the new network segment. **ls01** is the new network segment in the following example.
    - In NSX-T Manager, select **Networking > Segments**.

    :::image type="content" source="../media/4-nsxt-new-segment-overview-2.png" alt-text="Screenshot showing the new network segment created in NSX-T Manager.":::

    - in vCenter, select **Networking > SDDC-Datacenter**.

    :::image type="content" source="../media/4-vcenter-with-ls01-2.png" alt-text="Screenshot showing how to select the networking segments of the software defined datacenter":::

## Configure DHCP services to advertise to the NSX-T segment - optional task

DHCP services may be required for IP address assignments in applications and workloads.
DHCP can be created and managed in AVS using one of two ways:

- If NSX-T hosts the DHCP server, create a DHCP server so traffic can be relayed.

- If using a third-party or external DHCP server, a DHCP relay service will need to be created. A DHCP IP address range must be specified. DHCP doesn't work for VMs on the VMware HCX L2 stretch network when the DHCP server is in the on-premises datacenter. By default, NSX blocks all DHCP requests from traversing the L2 stretch.

### Create a DHCP server for NSX-T Manager
If NSX-T is used to host the DHCP server, a DHCP server needs to be created. A network segment is added where the DHCP IP address range is specified.

1. In NSX-T Manager, select **Networking > DHCP** and then select **Add Server**.
1. Select **DHCP** for the **Server Type**, provide the server name and IP address, and then select **Save**.

    :::image type="content" source="../media/4-dhcp-server-settings.png" alt-text="Screenshot demonstrating where the DHCP server is specified, the IP address that's configured, and where the settings are saved.":::

1. Select **Tier 1 Gateways**.
1. Select the vertical ellipsis on the Tier-1 gateway.
1. Select **Edit**.

    :::image type="content" source="../media/4-edit-tier-1-gateway.png" alt-text="Screenshot showing how to edit the Tier 1 gateway for the new DHCP segment.":::

1. Select **No IP Allocation Set** to add a subnet.

    :::image type="content" source="../media/4-add-subnet.png" alt-text="Screenshot showing how to add a subnet to the no IP allocation set.":::

1. Select **DHCP Local Server** for **Type**.
1. Select **Default DHCP** for the **DHCP Server**.
1. Select **Save** twice.
1. Select **Close Editing**.

### Add a network segment in NSX-T Manager

1. Select **Networking > Segments** and then select **Add Segment** in NSX-T Manager.

    :::image type="content" source="../media/4-nsxt-segments-overview.png" alt-text="Screenshot showing how to add a new networking segment into NSX-T Manager.":::

1. Select **Add Segment**.
1. Enter a name for the network segment.
1. Select the Tier-1 Gateway (TNTxx-T1) as the **Connected Gateway**.
1. Leave the **Type** as Flexible.
1. Select the pre-configured overlay **Transport Zone** (TNTxx-OVERLAY-TZ).
1. Then select **Set Subnets**.

    :::image type="content" source="../media/4-nsxt-create-segment-specs.png" alt-text="Create segment specs.":::

1. Enter the IP address of the gateway.
1. Select **Add**. The IP address needs to be on a non-overlapping RFC1918 address block, which ensures network connectivity to VMs on the new segment.

    :::image type="content" source="../media/4-nsxt-create-segment-gateway.png" alt-text="Screenshot showing how to create a segment gateway for the new networking segments in NSX-T Manager.":::

1. Select **Apply**.
1. Select **Save**.
1. Select **No** to decline the option to continue configuring the segment.

    :::image type="content" source="../media/4-nsxt-create-segment-continue-no.png" alt-text="Screenshot showing how to decline the option to continue configuring the new networking segment within NSX-T Manager":::

1 Confirm the presence of the new network segment. In this example, ls01 is the new network segment.
- Select **Networking > Segments** in NSX-T Manager.
    :::image type="content" source="../media/4-nsxt-new-segment-overview-2.png" alt-text="Screenshot showing the new network segment within NSX-T Manager.":::

- Select **Networking > SDDC-Datacenter** in vCenter.
    :::image type="content" source="../media/4-vcenter-with-ls01-2.png" alt-text="Screenshot showing the new networking segment within the vSphere software defined datacenter.":::

### Create DHCP relay service for a third-party external DHCP server

If a third-party external DHCP server is used, a DHCP relay service needs to be created. The DHCP IP address range must be specified in NSX-T Manager.

1. Select **Networking > DHCP**.
1. Select **Add Server** in NSX-T Manager.
1. Select **DHCP Relay** for the **Server Type**.
1. Provide the server name and IP address.
1. Select **Save**.

    :::image type="content" source="../media/4-create-dhcp-relay.png" alt-text="Screenshot of showing how to create a third-party external DHCP relay service in NSX-T Manager.":::

1. Select **Tier 1 Gateways**.
1. Select the vertical ellipsis on the Tier-1 gateway.
1. Select **Edit**.

    :::image type="content" source="../media/4-edit-tier-1-gateway.png" alt-text="Screenshot showing how to edit the Tier 1 Gateway to add the DHCP relay service in NSX-T Manager.":::

1. Select **No IP Allocation Set** to define the IP address allocation.

    :::image type="content" source="../media/4-edit-ip-address-allocation.png" alt-text="Screenshot showing how the Tier 1 Gateway is configured for the third-party DHCP relay service in NSX-T Manager.":::

1. Select **DHCP Server** for **Type**.
1. For the **DHCP Server**, select **DHCP Relay**.
1. Select **Save**.
1. Select **Save** again.
1. Select **Close Editing**.

### Configure the DHCP IP address range to use

1. Select **Networking > Segments** in NSX-T Manager.
1. Select the vertical ellipsis on the segment name.
1. Select **Edit**.
1. Select **Set Subnets** to specify the DHCP IP address for the subnet.

    :::image type="content" source="../media/4-network-segments.png" alt-text="Screenshot showing where to set subnets for the DHCP IP address range to use.":::

1. Modify the gateway IP address and enter the DHCP range IP.

    :::image type="content" source="../media/4-edit-subnet.png" alt-text="Screenshot of showing how to edit the gateway IP address and the DHCP range IP.":::

1. Select **Apply**.
1. Select **Save** and note the segment is assigned a DHCP server pool.

    :::image type="content" source="../media/4-assigned-to-segment.png" alt-text="Screenshot showing that the segment is assigned to a DHCP server pool.":::

### Send DHCP requests to an on-premises DHCP server

A security segment profile may need to be created for specific DHCP requests. Requests may need to be sent from AVS VMs to an on-premises DHCP server. If that's needed, you'll need to follow these instructions:

1. Sign in to the on-premises vCenter.
1. Under **Home** select **HCX**.
1. Select **Network Extension** under **Services**.
1. Select the network extension to support DHCP requests from AVS to on-premises.
1. Take note of the destination network name.

    :::image type="content" source="../media/4-hcx-find-destination-network.png" alt-text="Screenshot of a network extension in VMware vSphere Client.":::

1. Select **Networking > Segments > Segment Profiles** in NSX-T Manager.
1. Select **Add Segment Profile**.
1. Select **Segment Security**.

    :::image type="content" source="../media/4-add-segment-profile.png" alt-text="Screenshot of how to add a segment profile in NSX-T Manager.":::

1. Provide a name and a tag.
1. Set the **BPDU Filter** toggle to ON.
1. Set all the DHCP toggles to OFF.

    :::image type="content" source="../media/4-add-segment-profile-bpdu-filter-dhcp-options.png" alt-text="Screenshot showing the BPDU Filter toggled on and the DHCP toggles off.":::

1. Remove all the MAC addresses under the **BPDU Filter Allow List**.
1. Select **Save**.

    :::image type="content" source="../media/4-add-segment-profile-bpdu-filter-allow-list.png" alt-text="Screenshot showing MAC addresses in the BPDU Filter Allow List.":::

1. Under **Networking > Segments > Segments**, enter the definition network name.

    :::image type="content" source="../media/4-networking-segments-search.png" alt-text="Screenshot showcasing where to enter name of networking segment security segment for vSphere in NSX-T Manager.":::

1. Select the vertical ellipsis on the segment name and select **Edit**.

    :::image type="content" source="../media/4-edit-network-segment.png" alt-text="Screenshot showing where to edit the NSX-T Manager network segment.":::

1. Change the **Segment Security** to the segment profile created earlier.

    :::image type="content" source="../media/4-edit-segment-security.png" alt-text="Screenshot showing how to change the segment security to the segment profile created earlier.":::

## Add a VM on an NSX-T network segment

Deploy a VM to test network connectivity in the AVS vCenter. This VM will help verify connectivity the following ways:

- Network connectivity to and from the internet.
- Network connectivity to and from Azure virtual networks.
- Network connectivity to and from on-premises environments.

Deploy the VM as you would in any vSphere environment:
- Attach the VM to one of the network segments previously created in NSX-T Manager. 
- VMs can receive network configuration from a DHCP server or the network configuration can be statically configured.

## Test the NSX-T segment connectivity

Log into the VM created in the previous step and verify connectivity:

- Ping an IP on the internet.
- Go to an internet site in a web browser.
- Ping an internal VM that sits on the Azure virtual network.

If each test works, AVS is now functional. Going through these steps means you've successfully established connectivity to and from an Azure virtual network, and the internet.

## Establish an ExpressRoute Global Reach connection to on-premises VMware environment

Global Reach will connect your on-premises VMware environment to the AVS private cloud. Connectivity is established between the AVS ExpressRoute and a new or existing ExpressRoute to an on-premises environment.

### Pre-requisites

There are a few pre-requisites that need to be met before configuring ExpressRouteGlobal Reach.

1. The AVS ExpressRoute needs established connectivity to and from Azure within the AVS private cloud.
2. A separate ExpressRoute circuit used to connect on-premises environments to Azure.
3. A /29 non-overlapping network address block for ExpressRoute Global Reach peering.
4. All gateways, including the ExpressRoute provider's service, need to support 4-byte Autonomous System Number (ASN). AVS uses 4-byte public ASNs for advertising network routes.

### Create an ExpressRoute Global Reach authorization key in the private cloud

1. From the AVS private cloud **Overview**, under **Manage**, select **Connectivity > ExpressRoute > Request an authorization key**.

    :::image type="content" source="../media/4-request-auth-key.png" alt-text="Screenshot showing how to request an auth key for an ExpressRoute circuit.":::

1. Enter a name for the authorization key. 
1. Select **Create**.

    :::image type="content" source="../media/4-provide-name-auth-key-create.png" alt-text="Screenshot of entering name of authorization key and selecting create.":::

1. The new key appears in the list of authorization keys for the private cloud after creation.

    :::image type="content" source="../media/4-new-auth-key-private-cloud.png" alt-text="Screenshot showing the ExpressRoute Global Reach authorization key.":::

1. Use the authorization key, ExpressRoute ID, and a /29 address block to complete the peering.

## Peer the AVS private cloud to on-premises using authorization key in the Azure portal

The AVS ExpressRoute circuit can be peered to the on-premises circuit after the authorization key is created. The peering can be configured using the Azure portal. This method will require the resource ID and authorization key of the AVS private cloud ExpressRoute circuit for peering.

1. Select the AVS private cloud.
1. From the private cloud **Overview**, under **Manage**, select **Connectivity > ExpressRoute Global Reach > Add**.

    :::image type="content" source="../media/4-expressroute-global-reach-tab.png" alt-text="Screenshot showing how to configure ExpressRoute and add the authorization key.":::

1. Create an on-premises cloud connection by using one of the following methods:
    - Select the ExpressRoute circuit from the list.
    - Copy and paste the circuit ID.

1. Select **Connect**.
1. The new connection will show in the on-premises cloud connections list.

## Peer the AVS private cloud to on-premises using authorization key in the Azure CLI

The AVS ExpressRoute circuit is peered to the on-premises circuit after an authorization key is created. The peering can be configured using the Azure CLI in Cloud Shell. This method will require the resource ID and authorization key of the AVS private cloud ExpressRoute.

1. Sign in to the Azure portal using the same subscription as the on-premises ExpressRoute circuit.
1. Open an Azure CLI Cloud Shell.
1. Leave the shell as Bash.
1. Use your specific information:
    1. Resource ID
    1. Authorization key
    1. /29 CIDR network block.
1. Enter the Azure CLI command below to create the authorization key.

    ```azurecli
    az network express-route auth create --circuit-name <Circuit2Name> -g <Circuit2ResourceGroupName> -n <AuthorizationName>
    ```

1. The Azure CLI output will look like this:

    ```azurecli
    {
      "authorizationKey": "<authorizationKey>",
      "authorizationUseStatus": "Available",
      "etag": "W/\"cfd15a2f-43a1-4361-9403-6a0be00746ed\"",
      "id": "/subscriptions/<SubscriptionID>/resourceGroups/<Circuit2ResourceGroupName>/providers/Microsoft.Network/expressRouteCircuits/<Circuit2Name>/authorizations/<AuthorizationName>",
      "name": "<AuthorizationName>",
      "provisioningState": "Succeeded",
      "resourceGroup": "<Circuit2ResourceGroupName>",
      "type": "Microsoft.Network/expressRouteCircuits/authorizations"
    }
    ```

1. Make note of the resource ID and authorization key to peer the circuit.
1. Run the following command against the first circuit, passing in the second circuit's resource ID and authorization key.

    ```azurecli
    az network express-route peering connection create -g <ResourceGroupName> --circuit-name <Circuit1Name> --peering-name AzurePrivatePeering -n <ConnectionName> --peer-circuit <Circuit2ResourceID> --address-prefix <__.__.__.__/29> --authorization-key <authorizationKey>
    ```
When this operation is complete, you'll have connectivity between on-premises and AVS through the two ExpressRoute circuits.

## Verify on-premises network connectivity to the AVS private cloud

You should see where ExpressRoute connects to the NSX-T network segments and the AVS management segments in the edge router. Each environment is different. There may be a need to allow routes to propagate back to the on-premises network.

Some environments have firewalls protecting ExpressRoute circuits. If there are no firewalls, try to ping the AVS vCenter server or a VM on the NSX-T segment from on-premises. Additionally, from the VM on the NSX-T segment, resources should be to reach the on-premises environment.