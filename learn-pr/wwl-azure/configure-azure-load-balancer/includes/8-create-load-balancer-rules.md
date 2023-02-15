You can define load-balancing rules to specify how traffic is distributed to your back-end pools. Each rule maps a front-end IP address and port combination to a set of back-end IP address and port combinations.

:::image type="content" source="../media/add-load-balancer-rules-f4d9b188.png" alt-text="Screenshot that shows how to create load-balancing rules in the Azure portal.":::

### Things to know about load-balancing rules

Let's take a closer look at how to configure load-balancing rules for your back-end pools.

- To configure a load-balancing rule, you need to have a frontend, backend, and health probe for your load balancer.

- To define a rule in the Azure portal, you configure several settings:
   - **IP version** (IPv4 or IPv6)
   - **Front-end IP address**, **Port*, and **Protocol** (TCP or UDP)
   - **Back-end pool** and **Back-end port**
   - **Health probe**
   - **Session persistence**

- By default, Azure Load Balancer distributes network traffic equally among multiple virtual machines.

   Azure Load Balancer uses a five-tuple hash to map traffic to available servers. The tuple consists of the source IP address, source port, destination IP address, destination port, and protocol type. The load balancer provides stickiness only within a transport session.

- **Session persistence** specifies how to handle traffic from a client. By default, successive requests from a client are handled by any virtual machine in your pool.

   You can modify the session persistence behavior as follows:
   - **None (default)**: Any virtual machine can handle the request.
   - **Client IP**: Successive requests from the same client IP address are handled by the same virtual machine.
   - **Client IP and protocol**: Successive requests from the same client IP address and protocol combination are handled by the same virtual machine.

   > [!NOTE]
   > Maintaining session persistence information is important for applications that implement a shopping cart. Can you think of other applications that might benefit from session persistence?

- Load-balancing rules can be used in combination with NAT rules.

   Consider a scenario where you use NAT from a load balancer's public address to TCP port 3389 on a specific virtual machine. By combining your NAT rule with load-balancing rules, you can enable remote desktop access from outside of Azure.