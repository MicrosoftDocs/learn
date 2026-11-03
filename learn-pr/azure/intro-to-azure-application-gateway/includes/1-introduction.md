Azure Application Gateway is an Azure service that processes traffic to web apps that are hosted on a pool of web servers. It load balances HTTP traffic and can provide web application firewall (WAF) protection when configured with WAF_v2 and an enabled WAF policy. Configuring HTTPS on the listener encrypts traffic between users and the gateway. Configuring HTTPS in the backend HTTP settings encrypts traffic between the gateway and application servers.

Adatum is a new and expanding online commerce store that sells industrial drones. You're responsible for networking at the company. Adatum has several web applications that are hosted on computers in its on-premises datacenter. At the moment, a special but aging hardware device is deployed on the Adatum perimeter network that manages traffic to the web applications hosted on these computers. You want to retire this device and have traffic mediated by an Azure service. The solution also needs a private network connection between Azure and Adatum's datacenter.

To meet your goals, you need to ensure that the Azure service replicates the functionality that the special hardware currently provides. Important functionality that must be present in the replacement service includes:

- Detect if one of the on-premises servers becomes unavailable so that traffic isn't directed to it.
- TLS (Transport Layer Security) termination functionality to offload backend TLS encryption and decryption when forwarding requests over unencrypted HTTP. With end-to-end TLS, backend servers still perform TLS processing.
- Cookie-based session affinity to keep a client's session on the same healthy backend server while it's available and the client retains and returns the affinity cookie.
- Security filtering of malicious requests, such as SQL injection and cross-site scripting attacks, using WAF_v2 with an enabled [WAF policy](/azure/web-application-firewall/ag/create-waf-policy-ag) in Prevention mode.

This module explains what Azure Application Gateway does, how it works, and when you should choose to use Azure Application Gateway as a solution to meet your organization’s needs.

## Learning objectives

In this module, you'll:

- Learn what Azure Application Gateway is and the functionality it provides.
- Determine whether Azure Application Gateway meets the needs of your organization.

## Prerequisites

- Understanding of basic networking concepts
- Familiarity with Azure virtual machines and Azure App Service
- Familiarity with Azure virtual networking
