After AVS is deployed, network connectivity becomes the next step for a successful deployment. The AVS solution deploys onto dedicated, bare metal servers. Those bare metal servers are given to a single customer. The bare metal servers need to connect to the Azure network backbone so customers can make use of Azure resources. The AVS provided ExpressRoute helps the environment talk to Azure services. To reach on-premises, a customer provided ExpressRoute circuit is needed, along with an ExpressRoute Global Reach configuration. 

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

Use Azure Bastion to log into the jump host VM you created in the last unit. Once logged in, open a web browser. Navigate and log into both vCenter and NSX-T Manager. The Azure portal will provide the vCenter IP address, the NSX-T Manager console's IP addresses, and credentials used for deployment. From there, select the AVS private cloud. Then select **Identity > Default** in the **Overview** view.

## Configure NSX-T Manager components

AVS deploys with NSX-T Manager as the software-defined network layer. The networking environment has two gateways:
    - NSX-T Tier-0 gateway configured in Active/Active mode.
    - NSX-T Tier-1 gateway configured in Active/Standby mode.

Both gateways allow connections between logical switch segments. Additionally, these gateways provide East-West and North-South connectivity.

After AVS is deployed, the NSX-T components are configured under **Workload Networking** in the Azure portal. Use of the Azure portal provides a simplified view of the management pane for NSX-T operations. If you're unfamiliar with NSX-T Manager, configure AVS networking using this method. If you're familiar with the NSX-T Manager, the console view within vSphere can be used to configure the advanced network settings and features.

There are four options that can be configured for NSX-T Manager in AVS using the Azure portal:

- **Segments** - Network segments can be created that display in NSX-T Manager and vCenter.
- **DHCP** - A DHCP server or DHCP relay can be created if DHCP will be in use.
- **Port mirroring** – Port mirroring can be created to help troubleshoot network issues.
- **DNS** – A DNS forwarder can be created to send DNS requests to a DNS server for resolution.

:::image type="content" source="../media/4-nsxt-workload-networking.png" alt-text="Screenshot showing where to configure NSX-T in the Azure portal.":::

## Create an NSX-T Manager network segment in the Azure portal

VMs either created in or migrated to AVS should be attached to an NSX-T networking segment. An NSX-T segment can be created from the AVS console within the Azure portal. These NSX-T networking segments are connected to the default Tier-1 gateway. Workloads on these segments will have East-West and North-South connectivity. After the segment is created, it displays in NSX-T Manager and vCenter.

1. In the AVS private cloud under **Workload Networking**, select **Segments > Add**.

    :::image type="content" source="../media/4-add-new-nsxt-segment.png" alt-text="Screenshot of how to add an NSX-T Manager network segment in the Azure portal.":::

1. Provide details for the new logical networking segment:

    :::image type="content" source="../media/4-create-new-segment-details.png" alt-text="Screenshot showing where to provide details for the network segment.":::

    | Field | Value |
    | ----- | ----- |
    | **Segment name** | Name of the logical switch visible in vCenter. |
    | **Subnet gateway** | Gateway IP address for the logical switch's subnet with a subnet mask. VMs are attached to the logical switch and all VMs connecting to this switch belong in the same subnet. Additionally, all VMs attached to this logical networking segment must carry an IP address from the same networking segment.
    | **DHCP (optional)** | DHCP ranges for the logical networking segment. A DHCP server or DHCP relay must be configured to use DHCP on the logical networking segments.
    | **Connected gateway** | This gateway is selected by default and read only. |
    | **T1** | Name of the Tier-1 gateway in NSX-T Manager. Segments created through ASV only connect to the default Tier-1 gateway. Workloads of these segments have East-West and North-South connectivity. More Tier-1 gateways can only be created through NSX-T Manager. Tier-1 gateways created in NSX-T Manager are not visible in the Azure VMware Solution console. |
    | **Type** | Overlay network segment supported by AVS. |

1. Select **OK** to create and attach the logical networking segment to the Tier-1 gateway. This segment will now be visible in AVS, NSX-T Manger, and vCenter.

## Create a DHCP server or DHCP relay in the Azure portal

A DHCP server or relay can be created directly from the AVS console within the Azure portal. The DHCP server or relay will connect to the Tier-1 gateway, which is created when AVS is deployed. All segments where DHCP ranges are provided will be part of the DHCP components of NSX-T. After a DHCP server or DHCP relay has been created, a subnet or range must be defined on an NSX-T segment level to consume the DHCP services.

1. In the AVS private cloud, under **Workload Networking**, select **DHCP > Add**.

1. Select either **DHCP Server** or **DHCP Relay**. Provide a name for the server or relay and provide three IP addresses. For a DHCP relay, only one IP address is required.

    :::image type="content" source="../media/4-add-dhcp-server-relay.png" alt-text="Screenshot showing how to add either a DHCP server or a DHCP relay into the AVS private cloud.":::

1. Complete the DHCP configuration by providing DHCP ranges on the logical segments like previously configured and then select **OK**.

## Configure port mirroring in the portal

Port mirroring can be configured to monitor network traffic. Port mirroring involves forwarding a copy of each network packet from one network switch port to another. Port mirroring places a protocol analyzer on the port that receives all mirrored data. Port mirroring analyzes traffic from a source, a VM, or a group of VMs, and then sends the traffic to a destination.

To set up port mirroring in the AVS console, you'll create source and destination VMs or VM groups. The source group either has a single VM or multiple VMs where the network traffic is mirrored.

1. In the AVS private cloud, under **Workload Networking**, select **Port mirroring > VM groups > Add**.
1. Name the VM group, select the VMs, and then **Ok**.
1. Repeat these steps to create the destination VM group.

    :::image type="content" source="../media/4-add-port-mirroring-vm-groups.png" alt-text="Screenshot showing where to configure port mirroring related to destination VMs or VM groups.":::

1. Create a port mirroring profile next by defining the traffic direction for source and destination VM groups.
1. Make sure both the source and destination VM groups are created.
1. Select **Port mirroring >** Add and then provide:

    :::image type="content" source="../media/4-add-port-mirroring-profile.png" alt-text="Screenshot showing how to add the port mirroring profile.":::

    | Field   | Value |
    | :---------- | :------------------ |
    | Port mirroring name | Name for the profile. |
    | Direction | Select ingress, egress, or bi-directional. |
    | Source | Select source VM group. |
    | Destination | Select destination VM group. |
    | Description | Provide a description for the port mirroring configuration. |

1. Select **Ok** to complete the profile. The profile and VM groups will now be visible in the AVS console.

## Add a VM on an NSX-T network segment

Deploy a VM to test network connectivity in the AVS vCenter. This VM will help verify connectivity the following ways:

- Network connectivity to and from the internet.
- Network connectivity to and from Azure virtual networks.
- Network connectivity to and from on-premises environments.

Deploy the VM as you would in any vSphere environment:
- Attach the VM to one of the network segments previously created in NSX-T Manager. 
- VMs can receive network configuration from a DHCP server or the network configuration can be statically configured.

## Configure a DNS forwarder in the Azure portal
You'll configure a DNS forwarder. Specific DNS requests will be forwarded to a designated DNS server for resolution. A DNS forwarder is associated with a default DNS zone and up to three FQDN zones.

To set up a DNS forwarder in the Azure VMware Solution console, you'll:

1. Configure a default DNS zone and FQDN zone. When a DNS query is received, a DNS forwarder compares the domain name with the domain names in the FQDN DNS zone.
1. You'll configure a default DNS zone and FQDN zone to send DNS queries to the upstream server. When a DNS query is received, the DNS forwarder compares the domain name in the query with the FQDN DNS zones' domain names. If a match is found, the query is forwarded to the DNS servers specified in the FQDN DNS zone. If no match is found, the query is forwarded to the DNS servers specified in the default DNS zone. A default zone must be defined before you configure an FQDN zone.
1. In your Azure VMware Solution private cloud, under Workload Networking, select DNS > DNS zones > Add.

    :::image type="content" source="../media/4-nsxt-workload-networking-dns-zones.png" alt-text="Screenshot showcasing where to configure DNS zones under workload networking.":::

1. Select either **Default DNS zone** or **FQDN zone** and provide:

    - **DNS zone**: a name and up to three DNS server Ip addresses in the format of 8.8.8.8
    - **FQDN zone**: a name, the FQDN domain, and up to three DNS server IP addresses in the format of 8.8.8.8

1. To configure the DNS service, select the **DNS service** tab, select **Add**, and then provide:

    :::image type="content" source="../media/4-nsxt-workload-networking-configure-dns-service-2.png" alt-text="Screenshot showing how to configure the DNS service.":::

    - A name for the DNS service.
    - Enter the IP address for the DNS service.
    - Select the default DNS zone that you created under the DNS zones tab.
    - Select the FQDN zones that you added under the DNS zones tab.
    - Select the **Log level**.

1. Select **Ok**. The DNS service was added successfully.

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