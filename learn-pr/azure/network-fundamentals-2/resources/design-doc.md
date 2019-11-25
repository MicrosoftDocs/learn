# Module design

## Title

Networking Fundamentals - Topology

## Role(s)

- Administrator
- Solution Architect
- Developer

## Level

Beginner

## Product(s)

## Prerequisites

- Network Fundamentals - Principals

## Summary

In this module, you'll learn the fundamentals of computer networking hardware.  You'll explore the the different client options available, and the nature and use of servers.  You'll then explore the various hardware options used to build a network, from simple hubs, through to switches and routers. The content of this module will prepare you for the Azure Admin and Developer learning paths.

## Learning objectives

1. Identify the difference between a client and a server.
1. Identify the differences between hubs, switches and routers.
1. Understand how these elements map to Azure networking services and systems

## Chunk your content into subtasks

Identify the subtasks of *Networking Fundamentals - Topology*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Understand Clients and Servers | Understanding the basics of networks hardware | Knowledge Check | 1 and 3 | Yes |
| Introduction to Hubs, Switches, and Routers | Understanding the basics of networks hardware | Knowledge Check | 2 and 3 | Yes |

## Outline the units

1. **Introduction**

   Moving to the cloud and taking on a role as an Azure Developer, Solution Architect or Administrator requires knowing the foundations for how networking works, and how to use different devices to build networks. While networks are made up of various tangible element like network devices, switches, and routers. There are other aspects like network communication protocols, and network security which will protect your organizations assets and resources. Understanding the basics of networks hardware is an important step in understanding Azure concepts.

1. **Understand Clients and Servers**

   - Client
     - A client is a different computer, such as your laptop or cell phone, that requests to view, download, or use the content. The client can connect over a network to exchange information.
     - Types
       - Fat, Thin, Hybrid
   - Server
     - A server is a computer that holds content and services such as a website, a media file, or a chat application.
     - Operation of a server
     - Types of server
       - Application, Catalog, Communications, Computing, Database, etc.
     - Advantages and Disadvantages of client server
   - How this relates to what will be done in Azure.
     - Azure Resource Manager
     - Azure VM
     - Azure 
   - Knowledge check
     - What is a thin client?
       - A thin client only presents processed data provided by an application server. 
     - What is the purpose of an Application server?
       - Hosts web apps allowing users in the network to run and use them.

1. **Introduction to Hubs, Switches, and Routers**
      - Hub
        - A network device that repeats the traffic it receives to all connected devices.
        - Physical Layer function
        - Connecting multiple hubs
        - Types of hub
          - Fast Ethernet
          - Dual Speed
          - Gigabit Ethernet
      - Switch:
        -  A network device that sends traffic it receives to a specific connected device, such as a single desktop computer or laptop.
        -  Role in a network
        -  Layer-specific functionality
        -  Types
           - Unmanaged, Managed, Smart, Enterprise
      - Router
        - Router: A network device that can bridge between different networks, determine what traffic can pass between them, and perform other functions on a network, such as assigning IP addresses.
        - Operation
        - Uses of a router
        - Security
        - Usage
      - Example as to how this relates to what will be done in Azure.
        - Azure hub-spoke
        - ExpressRoute
      - Knowledge check
        - What is the primary purpose of a hub?
          - It allows connection for multiple ethernet devices making them act as a single network segment.
        - What is the principle difference between hub routing and switch routing
          - Hub routing sends all packets to all connected devices, whereas switch routing sends packets to specific devices.
        - What does a router do?
          - A router is a network device that forwards data packets between computer networks.

1. **Summary**

   - Summary of this module.
   - Links to additional resources

## NOTES

This proposal has a lot of content, which could exceed the length of a single module. With that in mind, an exercise was carried out to draw together appropriate proxy content to establish a reading time for each unit.  Some of the units are short, others are much longer but the combined length for this module is over 100 minutes.  

While it is accepted that the proxy content is not the final content, it does form the basis for that content.  There could be around a 10%-15% reduction in the overall time of each of the units.

The table here represents the reading times, based on Hemmingway, using the proxy content.

| Content                                         | Read Duration | Knowledge Check | Total Time |
| ----------------------------------------------- | ------------- | --------------- | ---------- |
| 2. Standards and Protocols                      | 8             | 2.5             | 10.5       |
| 3. LANs, WANs, and PANs                          | 8             | 2               | 10         |
| 4. IP/TCP                                       | 21            | 3               | 24         |
| 5. Basic Client / Server                        | 8             | 2               | 10         |
| 6. Network hub, switches & routers              | 17            | 1.5             | 18.5       |
| 7. Authentication, Authorization, and Monitoring | 20            | 1.5             | 21.5       |
| 8. Firewalls and Security                       | 11            | 1               | 12         |

Note: Reading Duration comes from Hemingway assessment of duration based on the proxy content. Knowledge Check duration is based on 30 seconds per question.

Given the approximate duration of each of the units, and the overall length.  We think this unit can be split into a number of modules.

The proposal is for three modules of around 30 minutes each logically grouped based on their content.

- Module 1: Network Fundamentals - Principals
  - 44.5 minutes (approx.)
  - Standards and Protocols
  - LANs and WANs
  - IP/TCP
- Module 2: Network Fundamentals - Topology
  - 28.5 minutes (approx.)
  - Basic Client / Server
  - Network Hub, Switches, and Routers
- Module 3: Network Fundamentals - Security
  - 33.5 minutes (approx.)
  - Authentication, Authorization, and Monitoring
  - Firewalls and Security

The proxy control document contains links to all the relevant materials.

When a final decision is made on the design and whether it is to be broken down, the links can be transferred from the proxy control document to the design.