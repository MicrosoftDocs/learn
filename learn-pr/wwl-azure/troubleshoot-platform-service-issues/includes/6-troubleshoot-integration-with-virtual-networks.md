## Troubleshoot subnet delegation issues

When you delegate a subnet to an Azure service, you allow that service to perform basic configuration of the subnet. This would allow a customer to integrate your Azure service into their virtual network.

If a customer cannot configure a particular property, it is likely that the deployment model for that Azure service has been defined to not support changes to that property.

## Integration of platform-as-a-service services with virtual networks

Azure services can have their network access limited to your virtual network infrastructure including peered virtual networks and on-premises networks. This is defined per Azure service.

If the Azure service is not accessible, consider the following points:

- If the instance of the service is deployed inside the virtual network, it can only be accessed from the virtual network or from on-premises networks.

- If you are using a private endpoint, the instance of the service is effectively part of your virtual network and only accessible to the virtual network.

- Virtual network service tags allow you to deny traffic to your Azure service to or from public endpoints. In the following diagram all traffic to Azure Storage and Azure SQL Database is allowed, but any other outbound traffic is denied.

   :::image type="content" source="../media/6-deny-outbound-traffic.png" alt-text="Deny most outbound traffic.":::

## Troubleshoot Azure Private Endpoint connectivity problems

Perform the following steps to Troubleshoot Azure Private Endpoint connectivity problems:

- In [Private Link Center](https://portal.azure.com/), select **Private endpoints**, and select the endpoint that you want to troubleshoot.

   :::image type="content" source="../media/6-private-link-center.png" alt-text="Private Link Center.":::

- Verify that the connection is approved and that the IP address and DNS settings are correct.

   :::image type="content" source="../media/6-private-endpoint-metrics.png" alt-text="Private endpoint metrics.":::

- Select **Metrics** and verify that data is moving in and out.

- Select the client VM, select **Connection troubleshoot**, select the **Outbound connections** tab, and select **Test by FQDN**.

- In the test results, verify the DNS settings and the network security group (NSG) outbound rules.

- If the Private Endpoint and source VM are on different, non-peered, VNETs, check connectivity between the VNETs.

- Check the configuration of the private link and, if necessary, run through the steps in [Troubleshoot Azure Private Link connectivity problems](/azure/private-link/troubleshoot-private-link-connectivity).

- Try to find the specific issue by trying to connect from inside and outside the VNET with different virtual machines and connecting to different services.

- If using a load balancer, check if the backend pool is healthy.

- If the connection is unresolved, contact [Azure Support](https://portal.azure.com/).
