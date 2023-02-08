Administrators use public load balancers to map the public IP addresses and port numbers of incoming traffic to the private IP addresses and port numbers of virtual machines. The mapping can also be configured for response traffic from the virtual machines.

Load-balancing rules are used to specify how to distribute specific types of traffic across multiple virtual machines or services. You can use this approach to share the load of incoming web request traffic across multiple web servers.

#### Business scenario

Consider a scenario where internet traffic attempts to reach virtual machines in a web tier subnet that implements a public load balancer. Internet clients send webpage requests to the public IP address of a web app on TCP port 80. Azure Load Balancer intercepts the traffic and distributes the requests across the virtual machines in the load-balanced set according to the defined load-balancing rules. The following illustration highlights this scenario:

:::image type="content" source="../media/public-load-balancer-46d5d9fe.png" alt-text="Diagram showing how a public load balancer works as described in the text." border="false":::