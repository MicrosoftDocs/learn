A load balancer rule defines how traffic is distributed to the backend pool. The rule maps a given frontend IP and port combination to a set of backend IP addresses and port combination. Before configuring the rule, create the frontend, backend, and health probe. This diagram shows a rule that routes frontend TCP connections to a set of backend web (port 80) servers. The rule uses a health probe that checks on HTTP port 80.

:::image type="content" source="../media/add-load-balancer-rules-f4d9b188.png" alt-text="Screenshot of the load-balancing rule page. The name, IP version, Frontend IP address, protocol, port, backend port, backend pool, and health probe are shown.":::


Load balancing rules can be used in combination with NAT rules. For example, you could use NAT from the load balancer’s public address to TCP 3389 on a specific virtual machine. This allows remote desktop access from outside of Azure.
