Deploying Azure Bastion transforms your virtual network from exposing individual VM management ports to providing a centralized, secure gateway. The deployment process creates the Bastion host infrastructure, configures networking components, and enables the features you selected during planning.

## Prepare the virtual network

Before creating the Bastion resource, you prepare the target virtual network with required networking components. The deployment process requires a dedicated subnet named exactly **AzureBastionSubnet** with a minimum /26 address prefix. This subnet name is case-sensitive and mandatory—the Bastion deployment fails if the subnet has any other name.

To create the AzureBastionSubnet, navigate to your virtual network in the Azure portal, select **Subnets**, and add a new subnet with the name AzureBastionSubnet and a CIDR range that provides at least 64 IP addresses. For example, if your virtual network uses 10.0.0.0/16, you might allocate 10.0.1.0/26 for the Bastion subnet. This subnet must not overlap with existing subnets in the virtual network.

You also create a Standard SKU static public IP address. In the Azure portal, create a new Public IP address resource with SKU set to Standard and assignment set to Static. The public IP provides the external endpoint for user connections to the Bastion service. Tag this resource appropriately to identify its purpose and relationship to the Bastion deployment.

## Deploy the Bastion host

Azure Bastion deploys through the Azure portal, Azure CLI, Azure PowerShell, or infrastructure-as-code templates. The portal provides the most straightforward experience for initial deployments.

To deploy through the portal, navigate to your virtual network and select **Bastion** from the security section. Select **Create a Bastion** to launch the deployment wizard. Configure the following settings:

- **Name**: Provide a descriptive name such as bastion-hub-prod
- **Region**: Must match the virtual network's region
- **Tier**: Select Developer, Basic, Standard, or Premium based on your planning decisions
- **Instance count**: For Standard or Premium, specify the number of host units (2–50)
- **Virtual network**: Select the virtual network containing the AzureBastionSubnet
- **Subnet**: Automatically populated with AzureBastionSubnet
- **Public IP address**: Select the Standard static public IP you created

The deployment process typically completes in 5–10 minutes. During this time, Azure deploys the Bastion infrastructure, configures networking, and validates the subnet and public IP configuration.

## Configure advanced features

After the basic Bastion deployment completes, you configure advanced features based on your SKU and requirements. These features enable native client support, shareable links, and session recording capabilities.

### Enable native client support

Native client support (Standard and Premium SKUs) allows users to connect using standard RDP clients and SSH tools through an Azure CLI tunnel. This feature preserves existing workflows for users who rely on specific RDP client configurations, clipboard operations, or file transfer capabilities.

To enable native client support, navigate to your Bastion resource in the Azure portal and select **Configuration**. Toggle **Native Client Support** to **Enabled** and select **Apply**. This configuration change takes a few minutes to propagate.

With native client support enabled, users install the Azure CLI bastion extension and use the `az network bastion tunnel` command to establish a local port tunnel. They then connect their RDP client to localhost on the specified port, and the Bastion service forwards the connection to the target VM.

### Configure shareable links

Shareable links (Standard and Premium SKUs) generate time-limited URLs that provide browser-based access without requiring Azure portal credentials. This capability supports contractor access, vendor troubleshooting scenarios, or temporary access grants.

Enable shareable links in the Bastion **Configuration** page by toggling **Shareable Link** to **Enabled**. After enabling this feature, you generate links for specific virtual machines through the VM's Connect blade. Each shareable link includes an expiration time and optionally restricts access to specific credentials.

### Enable session recording

Session recording (Premium SKU only) captures complete RDP and SSH session activity to an Azure Storage account. This feature supports compliance requirements, security investigations, and audit trails.

To configure session recording, you first create or designate an Azure Storage account with blob storage. This account should have appropriate access controls and retention policies aligned with your compliance requirements. Navigate to the Bastion resource, select **Session Recording** under Monitoring, and specify the storage account and container. Toggle session recording to **Enabled** and configure the recording scope (all sessions or specific users/groups).

Recorded sessions appear as individual files in the designated storage container. Each recording includes the complete session activity in a format that can be replayed for review. Configure storage lifecycle management policies to automatically archive or delete recordings after your required retention period.

## Configure network security group rules

The AzureBastionSubnet requires a network security group with specific inbound and outbound rules to support Bastion operations. While you can associate a new or existing NSG with the subnet, the rules must permit required traffic flows.

Required inbound rules:

| Priority | Name | Source | Source Ports | Destination | Destination Ports | Protocol | Action |
|----------|------|--------|--------------|-------------|-------------------|----------|--------|
| 100 | AllowHttpsInbound | Internet | * | * | 443 | TCP | Allow |
| 110 | AllowGatewayManagerInbound | GatewayManager | * | * | 443 | TCP | Allow |
| 120 | AllowAzureLoadBalancerInbound | AzureLoadBalancer | * | * | 443 | TCP | Allow |
| 130 | AllowBastionHostCommunication | Virtual network | * | Virtual network | 8080, 5701 | * | Allow |

Required outbound rules:

| Priority | Name | Source | Source Ports | Destination | Destination Ports | Protocol | Action |
|----------|------|--------|--------------|-------------|-------------------|----------|--------|
| 100 | AllowSshRdpOutbound | * | * | Virtual network | 22, 3389 | * | Allow |
| 110 | AllowAzureCloudOutbound | * | * | AzureCloud | 443 | TCP | Allow |
| 120 | AllowBastionCommunication | Virtual network | * | Virtual network | 8080, 5701 | * | Allow |
| 130 | AllowHttpOutbound | * | * | Internet | 80 | * | Allow |

These rules enable user connectivity (inbound 443 from Internet), Azure management operations (GatewayManager, AzureCloud), and Bastion-to-VM communication (outbound 22 and 3389). Omitting any of these required rules causes connection failures or deployment issues.

## Scale host unit capacity

For Standard and Premium SKUs, you configure the number of host units to handle expected concurrent session load. Each instance supports 20 concurrent RDP sessions or 40 concurrent SSH sessions, so a deployment with 4 instances accommodates up to 80 simultaneous RDP connections or 160 SSH connections.

To adjust host unit count, navigate to the Bastion resource, select **Configuration**, and modify the **Instance count** value. Azure deploys more host units or deallocates excess units based on your specification. This operation takes several minutes and doesn't interrupt active sessions.

Consider scaling proactively before expected usage increases rather than reactively when performance degrades. Scaling down reduces costs but should account for typical peak usage patterns rather than only current load.

## Verify the deployment

After deployment and configuration complete, verify that Bastion operates correctly before removing public IP addresses from target VMs. Check the Bastion resource **Overview** page to confirm the **Provisioning state** shows **Succeeded** and the **Status** shows **Running**.

Test connectivity by navigating to a target virtual machine, selecting **Connect**, and choosing **Bastion** from the connection options. Enter valid credentials for the VM and verify that a browser-based RDP or SSH session opens successfully. If native client support is enabled, test the tunnel command to confirm the configuration works as expected.

Review the AzureBastionSubnet's NSG flow logs to confirm traffic flows match expected patterns—inbound 443 from user IP addresses, outbound 3389 or 22 to target VM IP addresses, and Azure service tag communication.

Contoso Manufacturing deployed Bastion with Standard SKU in the hub virtual network, configured four host units for capacity, and enabled native client support. Factory engineers tested connections to VMs in spoke VNets using both browser and native RDP client methods. After the admins confirm successful connectivity, the security team prepared to remove public IP addresses from factory VMs.

Now that you deployed and configured Azure Bastion, you're ready to connect to virtual machines using browser-based and native client methods.
