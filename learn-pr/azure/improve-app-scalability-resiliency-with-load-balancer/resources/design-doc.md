# Module Design

## Title

Improve application scalability and resiliency with Azure Load Balancer

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Load Balancer

## Prerequisites

- Basic knowledge of networking concepts
- Basic knowledge of Azure virtual machines
- Familiarity with Azure portal

## Summary

Discuss the different Load Balancers in Azure and how to choose the right Azure Lload Bbalancer solution to suit your requirements.

## Learning objectives

- Identify the features and capabilities of Azure Load Balancer
- Deploy and configure an Azure Load Balancer

## Chunk your content into subtasks

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Explain the features and benefits of using Azure Load Balancer |  The new portal needs to be available around the clock, and handle failures. It must adjust to fluctuations in load, by adding and removing resources to match load. The organization needs a load-balancing solution that can distribute work across the system to virtual machines as they're added. The load balancer should detect failures and reroute jobs to machines as appropriate. This improved resiliency and scalability ensures patients can schedule appointments from any location, whenever they need too. | Knowledge check | Identify the features and capabilities of Azure Load Balancer | Yes |
|Configure a Public Load Balancer | Use an Azure public facing Load Balancer to distribute internet traffic to different VMs.| Exercise | Deploy and configure an Azure Load Balancer | Yes |
Configure an Internal Load Balancer | Configure Azure Internal load balancer for VMs hosting business tier to have resiliency for connections to Business tier from Patients Portal web servers. | Knowledge check | Deploy and configure an Azure Load Balancer | Yes |

## Outline the units

### 1. Introduction

A health care organization is launching a new portal application where patients can schedule appointments. The application consists of a patients' portal, which comprises a web application frontend and business tier database. The database is used by the frontend to retrieve and save patient information. The new portal needs to be available around the clock, and handle failures. It must adjust to fluctuations in load, by adding and removing resources to match load. The organization needs a load-balancing solution that can distribute work across the system to virtual machines as they're added. The load balancer should detect failures and reroute jobs to machines as appropriate. This improved resiliency and scalability ensures patients can schedule appointments from any location, whenever they need too.

### 2. Features and benefits of Azure Load Balancer

Cover the following points:

- The azure load balancer is a layer 4 load balancer that distributes incoming traffic among healthy virtual machine instances. Load balancers use a hash-based distribution algorithm. By default, it uses a five-tuple (source IP, source port, destination IP, destination port, protocol type) hash to map traffic to available servers.

- With Azure Load Balancer, you can scale your applications and create high availability for your services. A Load Balancer supports inbound and outbound scenarios provides low latency and high throughput and scales up to millions of requests for TCP and UDP applications.

- Discuss the differences between Availability Sets and Availability Zones, highlighting the benefits of each.

- Basic SKU supports these features in the:

  - Load Balancing
  - Port Forwarding
  - Application Agnostic and Transparent
  - Automatic Reconfiguration
  - Health Probes
  - Outbound Connections (SNAT)
  - Diagnostics via Azure Log Analytics for public-facing Load Balancers
  - Can only be used with availability sets

- The Standard Load Balancer SKU provides all the above and offers these additional features:

  - HTTPS Health Probes
  - Availability Zones
  - Diagnostics via Azure Monitor supporting multi-dimensional metrics
  - HA Ports
  - Outbound Rules
  - Can be used with availability sets and availability zones
  - Guaranteed SLA (99.99% for 2+ VMs)

- You can use Azure Load Balancer with following configurations.

  - Use a public Load Balancer to load-balance incoming internet traffic to your VMs.
  - Use an internal Load Balancer to load-balance traffic across VMs inside a virtual network.

- Traffic distribution is optimized at two levels for the example application:

  - Front End Patients Portal – handling all the requests from clients (for example, browsers).
  - Business Tier – handling all the request for backend data from the front end web servers.

Add three knowledge check questions to verify the student's understanding of the content.

### 3. Configure Public Load Balancer

You want to distribute the internet web traffic of your web portal to different VMs hosting the web app. By the end of this unit, you will be able to:

- Configure Public Load Balancer
- Choose the Traffic Distribution Mode

Cover the following points:

- A public Load Balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of a VM in the backend pool. The responses from that VM are then returned to the client. You can distribute specific types of traffic across multiple VMs or services, by applying load-balancing rules.

- By default, Azure Load Balancer distributes network traffic equally among VM instances. The following distribution modes are also possible if different behavior is required:

  - Hash-based distribution mode
  This is the default distribution mode and is used to map traffic to the available servers and the algorithm provides stickiness only within a transport session. Packets that are in the same session are directed to the same dynamic IP (DIP) instance behind the load-balanced endpoint.

  - Source IP affinity mode
  This distribution mode is also known as session affinity or client IP affinity.  By using the source IP, connections that are initiated from the same client computer go to the same DIP endpoint.

### 4. Exercise – Configure Public Load Balancer

By the end of this unit, you will be able to configure public load balancer and verify that the traffic is evenly distributed to the VMs behind the load balancer.

Lab environment:

This lab uses zone pivots to enable the student to select from the following environments to perform the lab:

- Azure CLI in the Cloud Shell
- Azure PowerShell in the Cloud Shell
- Azure portal

You have a set of 2 virtual machines hosting the patient's portal. In this exercise, you will:

- Configure Azure Public Load Balancer to distribute traffic to the two virtual machines in the availability set.
- Setup Health Probes
- Setup Backend Pools
- Setup Load Balancing Rules

Setup:

1. Create a VNET and network infrastructure for the VMs (`az network vnet create ...`)
2. Create 2 VMs in this VNET. If the student's region supports availability zones, then create both VMs in the same availability zone. If not, then create an availability set for the VMs. Create the VMs using az `vm create ... cloud-init cloud-init.txt` (the cloud-init.txt file configures a basic web service and app).

   > [!NOTE]
   > The cloud-init.txt file, and scripts containing sample commands for creating the VNET and VMs are available in the `src` folder.

Exercise steps

To use PowerShell, CLI and portal with zone pivots for this.

1. Go to Azure portal Find Load Balancer and click Create
2. Enter a unique Name (for example, Pub-LB-PatientsPortal)
3. Choose the Type as Public
4. Select Standard SKU
5. Choose Create new public IP option
6. Enter a unique name for the public IP (for example, Pub-LB-PatientsPortal-IP)
7. Choose public IP assignment type Static
8. Click "Review + create button"
9. After Validation is passed, click Create
10. Once Azure Load Balancer is created, go to Backend Pools and click Add
11. On Add Backend pool screen, give a unique name to the backend pool (for example, bepool-http)
12. Choose Ipv4 as IP Version
13. If you are using an availability set for the VMS:
    1. Choose "Availability Set"
    2. Choose the existing Availability set
    3. Click "+Add a target network IP configuration" button
    4. Choose first VM from the availability set
    5. Choose Network IP configuration
    6. Click "+Add a target network IP configuration" button again
    7. Choose the second VM from the availability set
    8. Choose Network IP configuration
    9. Click OK
14. If you are using VMs in an availability zone:
    1. Select the VNET for the first VM
    2. Select the first VM and IP address
    3. Click Add new backend resource
    4. Select the VNET for the second VM
    5. Select the second VM and IP address
    6. Click Add
15. Now go to Health probes
16. Click Add
17. Give name to health probe
18. Choose TCP a protocol
19. Enter port 80 (default)
20. Enter Interval (e.g. 5 seconds, this is default value and you can leave it as it is). This is the amount of time between the probes.
21. Enter Unhealthy Threshold (e.g. 2, this is default value and you can leave it as it is). This is the number of consecutive probes failures that must occur before a virtual machine is considered unhealthy.
22. Click OK
23. Now go to Load Balancing Rules and click Add, Form to add load balancing rule will be displayed
24. Give a name for Load Balancing Rule (e.g. lbrule-http)
25. Choose Ipv4 as IP Version
26. Choose public IP of load balancer as Frontend IP address
27. Choose TCP protocol
28. Enter port number (e.g. 80, this is default. So, you can leave it as it is)
29. Choose the backend pool created in previous steps
30. Choose the Health probe created in previous steps
31. Choose None as Session persistence
32. Enter Idle timeout (e.g. 5 minutes). This is the time to keep a TCP or HTTP connection open without relying on clients to send keep-alive messages.
33. Leave Floating IP as Disabled
34. Click OK to complete the load balancer configuration.
35. Open Microsoft Edge on your machine.
36. Browse to [http://LoadBalancerIP](http://LoadBalancerIP)
37. You will see that response will be returned from one of the virtual machines
38. Try Force Refresh using Ctrl+F5 few times to see that response will be returned from both virtual machines randomly
39. Stop the webVM1 server and force a refresh of the webpage, all traffic will be returned from webVM2

### Unit 5: Configure Internal Load Balancer

You want to distribute the traffic from front end servers to business tier consisting of multiple VMs hosting the business application. Internal load balancer can be used to distribute traffic to VMs connected to the same vnet. By the end of this unit you will learn how to:

- Configure Internal Load Balancer
- Choose the Traffic Distribution Mode

In the current scenario, there is a business tier which is used by the web frontend. The business tier is also deployed on two virtual machines and is a web application hosting web services or web APIs, or WCF services etc. The type of application does not matter here. The web servers hosting the patient's portal is connecting to the business tier servers. To allow the front-end web portal to survive losing a connection to an entire data center you will setup availability zones.

You want the business tier servers behind a load balancer but that load balancer should not be exposed as a public load balancer and the VMs in the pool of that load balancer will also not be public. If all the VMs hosting the business tier are in one vnet then internal load balancer can be used to distribute traffic to those VMs.

Cover the following points:

- What is an internal load balancer
- When should internal load balancer be used
- Understand the differences between availability sets and availability zones
- Overview of the az cli statements

Add two knowledge check questions to verify the student's understanding of the differences between Internal Load Balancer and Public Load Balancer.

### Unit 6: Summary + Cleanup

How did you solve the problem in the initial scenario with the knowledge learned in the module?

- Explained the purpose of Azure Load Balancer.
- Described how different configurations of Azure Load Balancer can be used to setup Public Load Balancer or an Internal Load Balancer.
- Configured a Public Load Balancer
- Configured an Internal Load Balancer across availability zones.

References:

[What is Azure Load Balancer?](https://docs.microsoft.com/azure/load-balancer/load-balancer-overview)

[Configure the distribution mode for Azure Load Balancer](https://docs.microsoft.com/azure/load-balancer/load-balancer-distribution-mode)

[Load balance VMs across all availability zones using Azure CLI](https://docs.microsoft.com/azure/load-balancer/load-balancer-standard-public-zone-redundant-cli)

[Standard Load Balancer and Availability Zones](https://docs.microsoft.com/azure/load-balancer/load-balancer-standard-availability-zones)

[Azure VMs : Availability Sets and Availability Zones](https://social.technet.microsoft.com/wiki/contents/articles/51828.azure-vms-availability-sets-and-availability-zones.aspx)
