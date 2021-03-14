IT management at Contoso were concerned about exposure of company and customer data to the internet. You were asked to evaluate whether Private Link would be a good choice for enabling private access to Azure resources.

In this module, you learned how Private Link works with Private Endpoint to enable private access. You learned that Private Endpoint takes an IP address from a subnet of your Azure virtual network and maps that address to an Azure resource. You now have a private connection between your virtual network—and all of its peered networks—and the Azure resource. All traffic uses the private Microsoft Azure backbone network, not the public internet.

You also learned how Private Link Service enables private access to your custom Azure services. As long as your custom service runs behind a standard load balancer, you can enable Private Link on the service. Consumers of your service can now access the service privately via Private Endpoints in their own virtual networks.

Yes, you can create secure access to Azure services without using Private Link. Such access requires a more complex network architecture that includes firewalls, gateways, network security groups, access control, and more. Even with all these tools in place, Azure resources still expose a public IP address to the internet.

With Private Link, you need only provision a private endpoint that maps to the Azure resource you want to access. Private Link does the rest. You recommend these products to IT management as a way of providing private and secure access to Azure services for both employees and customers.

## Learn more

Here are some links to more information about Private Link:

- [Private Link](https://azure.microsoft.com/services/private-link?azure-portal=true)
- [Azure Private Link pricing](https://azure.microsoft.com/pricing/details/private-link?azure-portal=true)
- [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=private-link&regions=all)
- [Azure updates](https://azure.microsoft.com/updates/?product=private-link)
- [SLA for Azure Private Link](https://azure.microsoft.com/support/legal/sla/private-link/v1_0/)