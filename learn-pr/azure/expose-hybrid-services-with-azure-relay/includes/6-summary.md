Your financial organization needed to continue running its credit-checking web service on-premises for regulatory compliance, even though it has migrated many systems into the cloud. You wanted to find a way to call this web service securely from cloud components. However, you didn't need the complexity of setting up and maintaining a virtual private network, or opening extra ports on the firewalls. By using an Azure Relay namespace, you provided a destination in Azure, where cloud components could call the service. The namespace forwards requests to the on-premises web service and returns responses. 

You can use a virtual private network or Azure ExpressRoute to create secure connections between cloud-hosted components and on-premises systems. However, these methods impose an extra layer of complexity and more administrative load on your team. Azure Relay is simple to configure and secure.

## Learn more

- [What is Azure Relay?](https://docs.microsoft.com/azure/service-bus-relay/relay-what-is-it)
- [Get started with Relay Hybrid Connections HTTP requests in .NET](https://docs.microsoft.com/azure/service-bus-relay/relay-hybrid-connections-http-requests-dotnet-get-started)
- [Get started with Relay Hybrid Connections WebSockets in .NET](https://docs.microsoft.com/azure/service-bus-relay/relay-hybrid-connections-dotnet-get-started)
- [Azure Relay Hybrid Connections protocol](https://docs.microsoft.com/azure/service-bus-relay/relay-hybrid-connections-protocol)