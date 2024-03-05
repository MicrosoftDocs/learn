# Module design

## Title

Networking Fundamentals - Security

## Role(s)

- Administrator
- Solution Architect
- Developer

## Level

Beginner

## Product(s)

## Prerequisites

- Network Fundamentals - Principals
- Network Fundamentals - Topology

## Summary

In this module, you'll learn the fundamentals of computer networking security. You'll cover the core difference between authentication and authorization. You'll also explore monitoring of network access and traffic usage. Finally, you'll explore network security and how firewalls can be used to protect your network and your organizations assets and resources.  The content of this module will prepare you for the Azure Admin and Developer learning paths.

## Learning objectives

1. Understand how authentication and authorization can protect your network
1. Understand how to monitor your network for intrusion, performance and access
1. Understand firewall and network security
1. Understand how these core components map to Azure networking

## Chunk your content into subtasks

Identify the subtasks of *Networking Fundamentals*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Using Authentication, Authorization. | Understanding the basics of how network security are put together | Knowledge Check | 1 and 4 | Yes |
| Monitoring your network | There are other aspects like network communication protocols, network monitoring, and network security | Knowledge Check | 2 and 4 | Yes |
| Understand Firewalls and Network Security | Understanding the basics of how network security are put together | Knowledge Check | 3 and 4 | Yes |

## Outline the units

1. **Introduction**

	Moving to the cloud and taking on a role as an Azure Developer, Solution Architect or Administrator requires knowing the foundations for how networking works, and how to use different devices to build networks. While networks are made up of various tangible element like network devices, switches, and routers. There are other aspects like network communication protocols, network monitoring, and network security which will protect your organizations assets and resources. Understanding the basics of how network security are put together is an important step in understanding Azure concepts.

1. **Using Authentication, Authorization in your network**
	- Network Authentication
      - What is it?
          - Types of Authentication
        - Password
        - Two-factor authentication
        - Token authentication
        - Biometric authentication
        - Transactional authentication
        - Computer recognition authentication
        - CAPTCHAs
        - Single Sign-on
        - Kerberos
        - SSL/TLS
    - Network Authorization
      - What is it?
      - Differences between authentication and authorization
    - Knowledge check
      - What role does authorization play during a sign-in event?
        - Authorization is the process of determining whether the authenticated user has access to specific resources.
        - Authorization is the process of determining whether a particular user or client is the author of specific resources.
        - Authorization is the process of determining whether a client or user is indeed who they claim to be.
       
      - Which of the following happens in SSL/TLS protocol?
        - The server sends a "ServerHello" message back, and this message includes a session ID, the server's digital certificate, and its public key.
        - The server sends a "ServerHello" message back, and this message includes a session ID, the client's digital certificate, and a public key.
        - The server sends a "ClientHello" message back, and this message includes a session ID, the server's digital certificate, and its public key.
1. **Network Monitoring**
    - What is it?
      - Agent-Based Monitoring
      - Agentless Based Monitoring
    - Monitoring Intervals
    - Protocols
      - SNMP, WMI,Syslog
    - Best Practice
      - FCAPS
        - Fault Management
        - Configuration Management
        - Accounting
        - Performance Management
        - Security
      - Alerting and Reporting
      - How this relates to what will be done in Azure.
        - Azure Monitor
        - Log Analytics
    - Knowledge Check
      - You need to query log data for applications across your network in Azure. Which tool do you use?
        - You use Syslog to query the log data that has been collected.
        - You use Log Analytics to query the data that has been collected.
        - You use an Azure agent to query the data that has been collected.

      - What is Syslog used for?
        - Syslog is used to let your device send event messages.
        - Syslog is used to schedule processes to be triggered.
        - Syslog is used to update system properties on your device.
1. **Understand Firewalls and Network Security**
	- Overview of network security
        - Types of network security
             - Access Control, antivirus, application security, behavioral analytics, email security, intrusion prevention, VPN, web security, wireless security.
   - Network security zones
        - Zone filtering policies
             - Inside-to-outside, outside-to-inside, DMZ too inside, Outside to DMZ, DMZ to Outside.
   - What are Network Firewalls
        - Software vs Hardware
        - Firewall Types
             - Application-layer, packet filtering, circuit-level, proxy server, stateful, next generation.
        - Importance of Firewalls
   - Example as to how this relates to what will be done in Azure.
        - Azure Network Security Groups and logging for Azure network security groups
        - Azure Firewall
        - Site-to-site and point-to-site VPN Connectivity
        - Azure best practices for network security
          - Azure network security appliances
          - Azure Virtual Network Service Endpoints
          - Disable SSH/RDP
          - Load-balancing
          - Azure DDOS protection
    - Knowledge check
      - Which of the following best practices should you implement for your network security on Azure?
        - Disable load-balancing of traffic
        - Disable SSH/RDP protocols
        - Disable network service endpoints
      - You need to prevent users from directly requesting webpages from the internet. Which tool would you use to do this?
        - Packet filtering firewall
        - Application-layer firewall
        - Proxy server firewall
1. **Summary**

   - Summary of this module.
   - Links to additional resources

## NOTES

This proposal has a lot of content, which could exceed the length of a single module. With that in mind, an exercise was carried out to draw together appropriate proxy content to establish a reading time for each unit.  Some of the units are short, others are much longer but the combined length for this module is over 100 minutes.  

While it is accepted that the proxy content is not the final content, it does form the basis for that content.  There could be around a 10%-15% reduction in the overall time of each of the units.

The table here represents the reading times, based on Hemmingway, using the proxy content.

| Content                                          | Read Duration | Knowledge Check | Total Time |
|:-------------------------------------------------|--------------:|----------------:|-----------:|
| 2. Standards and Protocols                       | 8             | 2.5             | 10.5       |
| 3. LANs, WANs, and PANs                          | 8             | 2               | 10         |
| 4. IP/TCP                                        | 21            | 3               | 24         |
| 5. Basic Client / Server                         | 8             | 2               | 10         |
| 6. Network hub, switches & routers               | 17            | 1.5             | 18.5       |
| 7. Authentication, Authorization, and Monitoring | 20            | 1.5             | 21.5       |
| 8. Firewalls and Security                        | 11            | 1               | 12         |

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

=-=-=-=-=-=-=-=-=-=-=-=-=-=

**NOTE:** You might want to split monitoring into a separate unit all by itself, since authentication and authorization are linked.  Monitoring isn't.
