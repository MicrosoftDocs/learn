When troubleshooting connections between a virtual machine (VM) and a Platform as a Service (PaaS), it is important to assess whether a problem is due to the VM, the PaaS service, a network issue, or an issue with a specific service, such as email or Microsoft Graph.

## Connecting to an application running on an Azure virtual machine

To troubleshoot connectivity to an application running in an Azure VM, perform the following steps:

- Access the application on the target VM.
  - If you cannot access the application check that it is running and listening on the correct TCP and UDP ports.

- Access the application from another VM in the same virtual network.
  - If this fails, check anything that could be filtering traffic such as a firewall, a load balancer, network monitoring, or intrusion detection.

- Access the application from another VM on another virtual network.
  - If you have implemented load-balancing, verify that the probe protocol and port number are correct and are not being blocked by firewalls.
  - If you cannot access the application verify that incoming traffic is allowed by endpoint configuration, Access Control Lists (ACLs), inbound NAT rules, and Network Security Groups (NSGs).
  - If you can access the application, verify that your Internet edge device allows traffic from the Azure VM and to the client computer.

## Sending outbound email messages

Outbound email messages on TCP port 25 are blocked by Azure platform for the following subscriptions:

- Pay-as-you go

- MSDN

- Azure Pass

- Azure in Open

- Education

- Azure for Students

- Free Trial

- Any Visual Studio subscription

- Cloud Solution Provider

- Microsoft Partner Network (MPN)

- BizSpark Plus

- Azure Sponsorship

VMs using Enterprise Agreement subscriptions do not have outgoing port 25 email messages blocked by the Azure Service but might be blocked by the external domain.

It is recommended that you use authenticated SMTP relay services in your VM which will minimize the likelihood of your messages being blocked or moved to a SPAM folder regardless of the type of subscription.

## Azure cloud service

Cloud service applications can have a wide range of connectivity problems. To resolve Azure cloud services, you should use the relevant scenario in the [Azure Cloud Service Troubleshooting Series](/troubleshoot/azure/cloud-services/dev-troubleshoot-series).

## Determine root cause for throttling at service level

Microsoft Graph has a limit of 2000 requests per second. Furthermore, Microsoft Entra ID has a limit of requests against resource units after which traffic is throttle. For more information, see Throttling and service limits to consider for testing.
