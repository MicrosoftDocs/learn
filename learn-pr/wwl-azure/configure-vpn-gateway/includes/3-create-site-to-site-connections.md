
As we reviewed in the previous section, VPN gateway connections are available in different configurations. In this module, we review the steps to configure a site-to-site connection in the Azure portal. The following flowchart highlights the seven high-level steps for this configuration. Six of the seven steps are completed in Azure and one is completed on-premises.

:::image type="content" source="../media/gateway-steps-aebd935e.png" alt-text="Flowchart that shows the high-level steps to configure a site-to-site connection." border="false":::

The complete process to create a VPN gateway for a site-to-site connection can take up to 45 minutes.

### Things to know about site-to-site configuration

Before we start looking at the configuration details, there are few notes to review.

- In this module, we don't review the details for Steps 1 and 2. You can review how to create these resources in other training modules:

   - [Configure virtual networks](/training/modules/configure-virtual-networks/)
   - [Configure virtual networks: Create subnets](/training/modules/configure-virtual-networks/3-create-subnets)
   - [Configure Azure DNS](/training/modules/configure-azure-dns/)

- **Step 1: Create virtual networks and subnets**. By now, you should be familiar with creating virtual networks and subnets. To complete this step, work with your on-premises network administrator to reserve an IP address range for this virtual network.

- **Step 2: Specify the DNS server (optional)**. DNS isn't required to create a site-to-site connection. However, if you need name resolution for resources that are deployed to your virtual network, you should specify a DNS server in the virtual network configuration.

- **Step 6: Configure the VPN device**. The on-premises step is needed only when configuring a site-to-site connection. If you're following these steps to create another type of VPN gateway configuration, you might not need to complete this step.

> [!Important]
> Take time to carefully plan your network configuration before you begin the implementaton. Identifying your IP addresses before you begin configuration is critical. Consider a scenario where a duplicate IP address range exists on both sides of your VPN connection. In this case, traffic won't route as expected. Create a map of IP addresses and ranges to ensure all traffic flows as expected.