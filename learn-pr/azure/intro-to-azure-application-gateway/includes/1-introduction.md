Azure Application Gateway is an Azure service that processes traffic to web apps that are serviced by a pool of web servers. This processing includes load balancing HTTP traffic, inspecting traffic using web application firewall, encrypting traffic between users and an application gateway, and encrypting traffic between application servers and an application gateway. 

Adatum is a new and expanding online commerce store that sells industrial drones. You're responsible for networking at the company. Adatum has several web applications that are hosted on computers in its on-premises datacenter. At the moment, a special but aging hardware device is deployed on the Adatum perimeter network that manages traffic to the web applications hosted on these computers. You want to retire this device and have traffic mediated by an Azure service.

To meet your goals, you need to ensure that the functionality the special hardware provides is replicated by the Azure service with which you're replacing it. Important functionality that must be present in the replacement service includes:

- Detect if one of the on-premises servers has become unavailable so that traffic is no longer directed to it
- TLS termination functionality to reduce the amount of CPU capacity consumed by encryption and decryption operations
- Session affinity to ensure that a client using a web application’s session is handled by the same web server in the pool
- Security filtering of malicious traffic such as SQL injection and cross site scripting attacks

This module explains what Azure Application Gateway does, how it works, and when you should choose to use Azure Application Gateway as a solution to meet your organization’s needs.

## Learning objectives

In this module, you'll:

- Learn what Azure Application Gateway is and the functionality it provides.
- Determine whether Azure Application Gateway meets the needs of your organization.

## Prerequisites

- Understanding of basic networking concepts
- Familiarity with Azure virtual machines and Azure App Service
- Familiarity with Azure virtual networking
