Your financial organization needed to continue running its credit-checking web service on-premises for regulatory compliance, even though it has already migrated many systems into the cloud. You wanted to find a way to call this web service securely from cloud components. But, you wanted to avoid the complexity of setting up and maintaining a virtual private network, or opening extra ports on your on-premises firewall. By using an Azure Relay namespace, you provided a destination in Azure, where cloud components can call the service. The namespace forwards requests to the on-premises web service and returns responses.

You could use a virtual private network or Azure ExpressRoute to create secure connections between cloud-hosted components and on-premises systems. However, these methods impose an extra layer of complexity and more administrative load on your team. Azure Relay is an excellent alternative for connecting your applications.

## Learn more

To learn more about Azure Relay, see the following articles:

- [What is Azure Relay?](/azure/service-bus-relay/relay-what-is-it)
- [Get started with Relay hybrid connections HTTP requests in .NET](/azure/service-bus-relay/relay-hybrid-connections-http-requests-dotnet-get-started)
- [Get started with Relay hybrid connections WebSocket in .NET](/azure/service-bus-relay/relay-hybrid-connections-dotnet-get-started)
- [Azure Relay hybrid connections protocol](/azure/service-bus-relay/relay-hybrid-connections-protocol)