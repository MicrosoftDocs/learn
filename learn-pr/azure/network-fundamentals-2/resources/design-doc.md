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

1. **An introduction to IP/TCP Basics**

    - What is TCP
         - One of the main protocols in the Internet protocol suite
    - What is IP
         -  [IP](https://searchunifiedcommunications.techtarget.com/definition/Internet-Protocol) defines how to [address](https://searchnetworking.techtarget.com/definition/address) and [route](https://searchnetworking.techtarget.com/definition/routing-table) each packet to make sure it reaches the right destination.
    - What is TCP/IP
         - TCP/IP, or the Transmission Control Protocol/Internet Protocol, is a suite of communication [protocols](https://searchnetworking.techtarget.com/definition/protocol) used to interconnect [network](https://searchnetworking.techtarget.com/definition/network) devices on the internet.
         - TCP/IP model layers
    - Internet Protocol Address standards
            - IPv4
                 - **Internet Protocol version 4** (**IPv4**) is the fourth version of the [Internet Protocol](https://en.wikipedia.org/wiki/Internet_Protocol) (IP). It is one of the core protocols of standards-based internetworking methods in the [Internet](https://en.wikipedia.org/wiki/Internet) and other [packet-switched](https://en.wikipedia.org/wiki/Packet-switched) networks.
                 - Special Use addresses
            - IPv6
                 - **Internet Protocol version 6** (**IPv6**) is the most recent version of the [Internet Protocol](https://en.wikipedia.org/wiki/Internet_Protocol) (IP), the [communications protocol](https://en.wikipedia.org/wiki/Communication_protocol) that provides an identification and location system for computers on networks and routes traffic across the [Internet](https://en.wikipedia.org/wiki/Internet).
                 - Address Space Exhaustion
                 - IPv6 Addressing
                      - [IPv6 addresses](https://en.wikipedia.org/wiki/IPv6_address) have 128 bits. The design of the IPv6 address space implements a different design philosophy than in IPv4, in which subnetting was used to improve the efficiency of utilization of the small address space. 
       - Subnetting
             - A **subnetwork** or **subnet** is a logical subdivision of an [IP network](https://en.wikipedia.org/wiki/IP_network).[[1\]](https://en.wikipedia.org/wiki/Subnetwork#cite_note-rfc950-1):1.16 The practice of dividing a network into two or more networks is called **subnetting**.
       - Private IP Addressing
             - Of the approximately four billion addresses defined in IPv4, about 18 million addresses in three ranges are reserved for use in [private networks](https://en.wikipedia.org/wiki/Private_network). 
       - DNS
             - The **Domain Name System** (**DNS**) is a [hierarchical](https://en.wikipedia.org/wiki/Hierarchy) and [decentralized](https://en.wikipedia.org/wiki/Decentralised_system) naming system for computers, services, or other resources connected to the [Internet](https://en.wikipedia.org/wiki/Internet) or a private network.
             - Function of the DNS
       - Ports
             - In [computer networking](https://en.wikipedia.org/wiki/Computer_networking), a **port** is a communication endpoint. Physical as well as wireless connections are terminated at ports of hardware devices.
             - Port Numbers
                   - A port number is a 16-bit unsigned integer, thus ranging from 0 to 65535.
                   - Common Port Numbers
                         - The port numbers are divided into three ranges: the *well-known ports*, the *registered ports*, and the *dynamic* or *private ports*.
    - How this relates to what will be done in Azure.
         - Azure Subnets
         - Azure DNS
         - Azure VNET
         - Azure Management Console
    - Knowledge check
         - What is the structure of an IPv4 address?
              - It is comprised of four numbers, in the range 0-255, each separated by a decimal.
         - What is TCP/IP
              - It is a protocol used to interconnect network devices on the internet. 
         - What is a subnet?
              - It is the logical subdivision of an IP based network.
         - How would you access a private network from the internet?
              - It is not possible to access a private network from the internet.  A private network can access another private network using a Network address translation.
         - What is the DNS?
              - It is a hierarchical and decentralized naming system for computers, services, or other resources connected to the Internet or a private network.
         - What port number is associated with the FTP data transfer protocol?
              - 20

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