

The use of private virtual IP addresses used in functionalities like SQL Server Always On or HANA System Replication requires the configuration of an Azure load balancer. The load balancer uses probe ports to determine the active DBMS node and route the traffic exclusively to that active database node.

When there's a failover of the database node, there's no need for the SAP application to reconfigure. Instead, the most common SAP application architectures reconnect against the private virtual IP address. Meanwhile, the load balancer reacts to the node failover by redirecting the traffic against the private virtual IP address to the second node.

In highly available configurations, the incoming traffic to the DBMS VM is always routed through the load balancer. The outgoing traffic route from the DBMS VM to the application layer VM depends on the configuration of the load balancer.

The load balancer offers an option of DirectServerReturn. If that option is configured, the traffic directed from the DBMS VM to the SAP application layer isn't routed through the load balancer. Instead, it goes directly to the application layer. When DirectServerReturn isn't configured, the return traffic to the SAP application layer is routed through the load balancer.

Microsoft recommends that you configure DirectServerReturn combined with load balancers that are positioned between the SAP application layer and the DBMS layer. This configuration reduces network latency between the two layers.

As mentioned earlier, you should use Azure load balancer Standard in order to benefit from its integration with Accelerated Networking. In addition, its High Availability Ports feature considerably simplifies the configuration of load-balancing rules.
