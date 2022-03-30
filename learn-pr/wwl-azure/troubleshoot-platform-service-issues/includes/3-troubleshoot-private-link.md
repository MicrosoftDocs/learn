Connectivity between your private network and an Azure PaaS service could be blocked by a misconfigured private link or misconfigured firewall.

## Troubleshoot Azure Private Link connectivity problems

Azure Private Link provides a link from your virtual network to the Azure PaaS services over the Microsoft backbone network rather than over the public Internet.

## Deployment troubleshooting

To choose the source IP address for the Private Link service, you must first disable private link service network policies.

When creating a Private Link service using the Azure portal the privateLinkServiceNetworkPolicies setting is automatically disabled. If this is manually enabled, you should disable it using Azure PowerShell or Azure CLI before selecting the source IP address.

```azurecli
az network vnet subnet update \

  --name default \

  --resource-group demoResourceGroup \

  --vnet-name demoVirtualNetwork \

  --disable-private-link-service-network-policies true

```

### Connectivity troubleshooting

- Browse [Private Link Center](https://portal.azure.com/) in the Azure portal.

   :::image type="content" source="../media/3-private-endpoints.png" alt-text="Screenshot of Private endpoints.":::

- Verify that the **Alias** and **Resource ID** for the private link service are correct.

- Verify that the **Visibility** of the private link service is correct.

- Verify that the **Load balancer** for the private link service is correct, select the load balance, and verify the **Frontend IP configuration**, the **Backend pools**, and the **Load balancing rules** are correct.

- In the private link service, select **Metrics** and verify that data is moving when you attempt to connect to the private link service.

For more information on troubleshooting Azure Private Link connectivity problems, see [Troubleshoot Azure Private Link connectivity problems](https://d.docs.live.net/24a4efeb4d82f583/Desktop/7.%09https:/docs.microsoft.com/azure/private-link/troubleshoot-private-link-connectivity).

## Troubleshoot Firewalls for PaaS services

Azure Firewall is intended to filter network traffic to protect your resources. A misconfigured firewall can lead to legitimate traffic also being blocked.

When troubleshooting firewall issues ensure that you include the following steps:

- Review the [Azure Firewall](/azure/firewall/firewall-faq) FAQ and ensure that firewalls are correctly configured.

- For Azure storage firewalls review any error messages and also download and review the storage diagnostics logs and resolve any issues. 

