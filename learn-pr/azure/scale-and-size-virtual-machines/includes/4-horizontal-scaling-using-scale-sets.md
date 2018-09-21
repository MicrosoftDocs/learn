You can get the resources you need using either one large virtual machine or several small VMs with a load balancer to distribute requests among the VMs.

The VM pool has the nice advantage that you can add or remove VMs quickly when demand changes. In the toy company scenario, this strategy would be useful to handle unexpected spikes in demand. You could add VMs to the pool when demand increased and remove them when demand returned to normal. The pool also gives you redundancy; if one VM fails, the others can continue to handle requests with no interruption in service.

In this section, you will see how to provision multiple VMs using scale sets and how to automatically add and remove instances in response to changing demand. 

## What is horizontal scaling?

*Horizontal scaling* is the process of adding or removing virtual machines from a pool to adjust the amount of available resources. Adding machines is called _scaling out_, and removing machines is called _scaling in_. Solutions that use horizontal scaling include a load balancer or gateway to distribute requests among the VMs in the pool. The following illustration shows an example of changing the number of virtual machine instances.

![An illustration showing scaling out the resources to handle demand and scaling in the resources to reduce costs.](../media/4-ScaleInOut.png)

This technique works best for applications that can be run across multiple, identical servers. For example, you can duplicate your web server and web pages on multiple VMs, and they will all give the same response no matter which server receives the request. On the other hand, a VM that runs your backend database is not an ideal candidate because running multiple copies of the database requires some effort to keep the copies in sync.

## What is a scale set?

A *scale set* is a pool of identical virtual machines, a load balancer or gateway to distribute requests, and an optional set of rules that control when VMs are added or removed from the pool. Here, "identical" means that each VM in the set is created using the same image and has the same size.

You have some flexibility in how a new VM is configured with the software you need. You can start with a predefined image for the base OS and then use scripts to install or copy files automatically after the OS is set up. Alternately, you can create a custom virtual machine image with the operating system and your application software already installed.

## How to distribute requests

You can use either a load balancer or an application gateway to distribute requests to the VM instances in a scale set.

An Azure load balancer operates at OSI layer 4 (TCP and UDP) and routes traffic based on source IP address and port combined with the destination IP address and port. It can provide affinity, where traffic from the same source IP address is routed to the same destination server to provide consistency across a client session. The load balancer also has a health probe mechanism that determines the availability of server instances. If a virtual machine becomes unresponsive to the health probe, the load balancer will avoid routing any new connections to that machine.

An application gateway operates at OSI layer 7 (the application layer). For example, if your VMs are running a web server, then the gateway can use the requested URL to perform routing. This means you could forward requests with `*/customers*` in the URL to one pool of servers and requests with `*/partners*` in the URL to a different pool. The application gateway can also provide HTTP to HTTPS redirection, Secure Sockets Layer (SSL) termination to reduce the processing requirement on the virtual machines for encryption, and a web application firewall (WAF) that uses rules to detect known web exploits and prevent these requests from reaching the web servers.

## What is autoscaling?

_Autoscaling_ is the process of automatically scaling out or in based on a set of rules. The rules can be triggered by machine load or a schedule. The following illustration shows how the autoscale feature manages instances to handle the load.

![An illustration showing how autoscale monitors the CPU levels of a pool of virtual machines and adds instances when the CPU utilization is above the threshold.](../media/4-autoscale.png)

To enable autoscaling for a scale set, you must create an autoscale profile. The profile defines the minimum and maximum number of VM instances for the set and the scaling rules. Autoscale rules have the following elements:

* Metric source - The source of information or data that triggers the autoscale rule. There are four options:
  * *Current scale set* provides host-based metrics that do not require any additional agents.
  * *Storage account*. The Azure diagnostic extension writes performance metrics to Azure Storage. These metrics are used to trigger autoscale rules.
  * *Azure Service Bus queue* can specify application-based or other Azure Service Bus messages to trigger autoscaling.
  * *Azure Application Insights* uses an instrumentation package that needs to be installed in the application running on the scale set to stream metric data directly from the application.
* Rule criteria - This is the specific metric you want to use to trigger an autoscale rule. If you are using host-based metrics, this can include aspects such as CPU usage, volume of network traffic, disk operations, or CPU credits. For example, you could configure a rule to scale out if disk write operations per second exceed a threshold. Using the Azure diagnostic extension or Application Insights enables you to use any available measure to trigger the rule but requires configuration of the appropriate agent.
* Aggregation type - This specifies how you want to measure the metric data and will be one of the following options:
  * Average
  * Minimum
  * Maximum
  * Total
  * Last
  * Count
* Operator - The operator denotes how a metric must be different to a defined threshold to trigger the rules action. This is particularly important when identifying whether the rule will scale out or in. Operators can be:
  * Greater than
  * Greater than or equal to
  * Less than
  * Less than or equal to
  * Equal to
  * Not equal to
* Action - This determines how the number of instances will change when the rule is triggered. The following actions are available:
  * *Increase count by* a fixed number of virtual machines.
  * *Increase percent by* a percentage of existing instances.
  * *Increase count to* a specific number of virtual machines.
  * *Decrease count by* a fixed number of virtual machines.
  * *Decrease percent by* a percentage of existing instances.
  * *Decrease count to* a specific number of virtual machines.

You can also create autoscale rules that trigger on a schedule. For example, you might define a rule that scales out in the morning when you know demand is high and then scales in after lunch when demand typically decreases.

## How to create a scale set

You can create a scale set using the Azure portal, Azure PowerShell, or the Azure CLI.

### Azure portal

If you use the Azure portal to create the scale set, you will specify the operating system image to use for the virtual machines and how many VM instances to create at startup. You will also specify the size of virtual machine for each instance and whether to use the Azure load balancer or the application gateway for load balancing. If you choose a load balancer, the portal will create a default health probe on port 80 for it.

### Azure PowerShell

You can create a virtual machine scale set with the `New-AzureRmVmss` PowerShell cmdlet. This cmdlet can create a new scale set, a load balancer, and control IP address and virtual network assignments. Unless settings are specified in the cmdlet, `New-AzureRmVmss` will use the following default settings:

* Create two virtual machine instances
* Use the Windows Server 2016 Datacenter image
* Use the Standard DS1_v2 virtual machine size
* Create a load balancer
* Create load balancer rules for ports 3389 and 5985 for Windows, port 22 for Linux

`New-AzureRmVmss` does not create a health probe for the load balancer. The best practice would be to create this using `Add-AzureRmLoadBalancerProbeConfig` after you have created the scale set.

Horizontal scaling with scale sets gives you multiple servers to run your application. Using multiple servers lets you handle high loads and ensures your services remain available even if a server crashes. You can add autoscale to your scale sets, so your system automatically adjusts to unexpected changes in demand.