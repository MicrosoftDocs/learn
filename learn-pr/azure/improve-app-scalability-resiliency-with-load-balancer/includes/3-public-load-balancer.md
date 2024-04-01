As the solution architect for the healthcare portal, you need to distribute the load from the client browsers over the virtual machines in your web farm. You need to set up a load balancer and configure the virtual machines to be balanced.

A public load balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of a virtual machine in the back-end pool. The responses are then returned to the client. By applying load-balancing rules, you can distribute specific types of traffic across multiple virtual machines or services.

## Distribution modes

By default, Azure Load Balancer distributes network traffic equally among virtual machine instances. The following distribution modes are also possible if a different behavior is required:

- **Five-tuple hash**: The default distribution mode for Load Balancer is a five-tuple hash. The tuple is composed of source IP, source port, destination IP, destination port, and protocol type. Because the source port is included in the hash and the source port changes for each session, clients might be directed to a different virtual machine for each session.
  
    :::image type="content" source="../media/3-load-balancer-distribution.svg" alt-text="Diagram showing how hash-based distribution works." border="false":::

- **Source IP affinity**: This distribution mode is also known as *session affinity* or *client IP affinity*. To map traffic to the available servers, the source IP affinity mode uses a two-tuple hash (from the source IP address and destination IP address) or a three-tuple hash (from the source IP address, destination IP address, and protocol type). The hash ensures that requests from a specific client are always sent to the same virtual machine behind the load balancer.

    :::image type="content" source="../media/3-load-balancer-session-affinity.svg" alt-text="Diagram showing how session affinity works." border="false":::

## Choose a distribution mode

In the healthcare-portal example, imagine that a developer requirement of the presentation tier is to use in-memory sessions to store the signed-in user's profile as the user interacts with the portal.

In this scenario, the load balancer must provide source IP affinity to maintain a user's session. The profile is stored only on the virtual machine to which the client first connects, because that IP address is directed to the same server. When you create the load-balancer endpoint, you must specify the distribution mode by using the following PowerShell example:

```powershell
$lb = Get-AzLoadBalancer -Name MyLb -ResourceGroupName MyResourceGroup
$lb.LoadBalancingRules[0].LoadDistribution = 'sourceIp'
Set-AzLoadBalancer -LoadBalancer $lb
```

To add session persistence through the Azure portal:

1. In the Azure portal, select your Load Balancer resource.
1. In the **Load balancing rules** page under the *Settings* pane, select the relevant load balancing rule.

    :::image type="content" source="../media/3-load-balancer-rules.png" alt-text="Screenshot showing how to select a load balancing rule in the Azure portal.":::

1. In the *load balancing rule settings* page change the value for **Session persistence** from **None** to **Client IP**.

:::image type="content" source="../media/3-screenshot-session-persistence.png" alt-text="Screenshot showing how to set IP affinity in the Azure portal." :::

## Load Balancer and Remote Desktop Gateway

Remote Desktop Gateway is a Windows service that you can use to enable clients on the internet to make Remote Desktop Protocol (RDP) connections through firewalls to Remote Desktop servers on your private network. The default five-tuple hash in Load Balancer is incompatible with this service. If you want to use Load Balancer with your Remote Desktop servers, use source IP affinity.

## Load Balancer and media upload

Another use case for source IP affinity is media upload. In many implementations, a client initiates a session through a TCP protocol and connects to a destination IP address. This connection remains open throughout the upload to monitor progress, but the file is uploaded through a separate UDP protocol.

With the five-tuple hash, the load balancer likely sends the TCP and UDP connections to different destination IP addresses and the upload won't finish successfully. Use source IP affinity to resolve this issue.
