## Configure public load balancer

As the solution architect for the healthcare portal. You would like to distribute the load from the client browsers over the VMs within your web farm. You will need to setup a load balancer and configure the VMs to be balanced

A public Load Balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of a VM in the backend pool. The responses from that VM are then returned to the client. You can distribute specific types of traffic across multiple VMs or services, by applying load-balancing rules.

### Distribution Modes

By default, Azure Load Balancer distributes network traffic equally among VM instances. The following distribution modes are also possible if different behavior is required:

| Distribution Mode | Details |
|-------------------|---------|
| **Hash Based** | The default distribution mode for Azure Load Balancer is a 5-tuple hash. The tuple is composed of the source IP, source port, destination IP, destination port, and protocol type.  |
| **Source IP Affinity** | This distribution mode is also known as session affinity or client IP affinity. The mode uses a 2-tuple (source IP and destination IP) or 3-tuple (source IP, destination IP, and protocol type) hash to map traffic to the available servers. This provides a sticky session with the VM behind the load balancer  |

## Choose Distribution Mode

Using the healthcare portal example. Imagine that a requirement of the presentation tier is to use in memory sessions to store the profile of the logged in user whilst they are interacting with the portal. In this scenario the load balancer must provide source IP affinity to maintain a users session as the profile will only be stored on the initial VM the client first connected to. When we create the load balancer we must specify the distribution mode this can easily be done using the PowerShell example below.

```Powershell
    Set-AzureLoadBalancedEndpoint -ServiceName MyService -LBSetName LBSet1 -Protocol TCP -LocalPort 80 -ProbeProtocolTCP -ProbePort 8080 –LoadBalancerDistribution sourceIP
```

This will allow the continued use of in memory sessions within the presentation tier of the application.

------------------Should I continue to write why source ip is a necessary evil and the downsides of enabling it