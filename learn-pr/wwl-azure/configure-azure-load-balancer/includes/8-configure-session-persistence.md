By default, Azure Load Balancer distributes network traffic equally among multiple VM instances. The load balancer uses a five-tuple (source IP, source port, destination IP, destination port, and protocol type) hash to map traffic to available servers. It provides stickiness only within a transport session.

:::image type="content" source="../media/five-tuple-hash-214cf64b.png" alt-text="Illustration of hash-based distribution with a load balancer and 3 virtual machines.":::


Session persistence specifies how traffic from a client should be handled. The default behavior (None) is that successive requests from a client may be handled by any virtual machine. You can change this behavior.

 -  **None (default)** specifies any virtual machine can handle the request.
 -  **Client IP** specifies that successive requests from the same client IP address will be handled by the same virtual machine.
 -  **Client IP and protocol** specifies that successive requests from the same client IP address and protocol combination will be handled by the same virtual machine.

> [!NOTE]
> Keeping session persistence information is important in applications that use a shopping cart. Can you think of any other applications?
