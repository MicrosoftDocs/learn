
A virtual network _service endpoint_ provides the identity of your virtual network to the Azure service. After service endpoints are enabled in your virtual network, you can secure Azure service resources to your virtual network by adding a _virtual network rule_ to the resources.

Today, Azure service traffic from a virtual network uses public IP addresses as source IP addresses. With service endpoints, service traffic switches to use virtual network private addresses as the source IP addresses when accessing the Azure service from a virtual network. This switch allows you to access the services without the need for reserved public IP addresses that are typically used in IP firewalls.

### Things to know about service endpoints

Review the following characteristics of service endpoints.

- Service endpoints can extend your virtual network identity to your Azure services to secure your service resources.

- You secure your Azure service resources to your virtual network by using virtual network rules.

- Virtual network rules can remove public internet access to resources, and allow traffic only from your virtual network.

- Service endpoints always take service traffic directly from your virtual network to the service on the Microsoft Azure backbone network.

- Service endpoints are configured through the subnet. No extra overhead is required to maintain the endpoints.

The following illustration shows a virtual machine connecting to the Azure service through a service endpoint. A virtual machine in a subnet accesses an Azure Storage account through a service endpoint. Virtual network rules allow the virtual machine to access the Azure service resource, but not communicate with the internet.

:::image type="content" source="../media/service-endpoint-addresses-a027197f.png" alt-text="Diagram of a virtual machine in a subnet connecting to an Azure service through a service endpoint." border="false":::

### Things to consider when using service endpoints

There are several scenarios where using service endpoints can be advantageous. Review the following points and think about how you can implement service endpoints in your configuration.

- **Consider improved security for resources**. Implement service endpoints to improve the security of your Azure service resources. When service endpoints are enabled in your virtual network, you secure Azure service resources to your virtual network with virtual network rules. The rule improves security by fully removing public internet access to resources, and allowing traffic only from your virtual network.

- **Consider optimal routing for service traffic**. Routes in your virtual network that force internet traffic to your on-premises or network virtual appliances also typically force Azure service traffic to take the same route as the internet traffic. This traffic control process is known as _forced-tunneling_. Service endpoints provide optimal routing for Azure service traffic to allow you to circumvent forced tunneling.

- **Consider direct traffic to the Microsoft network**. Use service endpoints to keep traffic on the Azure backbone network. This approach allows you to continue auditing and monitoring outbound internet traffic from your virtual networks, through forced-tunneling, without impacting service traffic. Learn more about [user-defined routes and forced-tunneling](/azure/firewall/forced-tunneling).

- **Consider easy configuration and maintenance**. Configure service endpoints in your subnets for simple setup and low maintenance. You no longer need reserved public IP addresses in your virtual networks to secure Azure resources through an IP firewall. There are no NAT or gateway devices required to set up the service endpoints.

> [!NOTE]
> With service endpoints, the virtual machine IP addresses switch from public to private IPv4 addresses. Existing Azure service firewall rules that use Azure public IP addresses stop working after the switch. Ensure Azure service firewall rules allow for this switch before you set up service endpoints. You might also experience temporary interruption to service traffic from this subnet while configuring service endpoints.