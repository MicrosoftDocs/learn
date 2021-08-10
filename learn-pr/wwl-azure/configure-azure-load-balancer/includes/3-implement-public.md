There are two types of load balancers: **public** and **internal**.

A public load balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of the VM. Mapping is also provided for the response traffic from the VM. By applying load-balancing rules, you can distribute specific types of traffic across multiple VMs or services. For example, you can spread the load of incoming web request traffic across multiple web servers.

The diagram shows internet clients sending webpage requests to the public IP address of a web app on TCP port 80. Azure Load Balancer distributes the requests across the three VMs in the load-balanced set.

:::image type="content" source="../media/public-load-balancer-46d5d9fe.png" alt-text="Diagram showing how public load balancer works. Incoming requests on port 80 are sent to the public load balancer. The LB sends requests on port 80 to three VMs in the web tier subnet.":::
