Network security is fundamental to protecting cloud resources from unauthorized access and threats. Azure Network Security Groups (NSGs) provide a critical layer of defense by filtering network traffic to and from Azure resources within a virtual network. NSGs act as distributed firewalls, allowing you to control traffic flow using security rules based on source, destination, port, and protocol.

In modern cloud environments, implementing defense-in-depth strategies requires multiple layers of security controls. NSGs are one essential component of this approach, working alongside other Azure security services to create comprehensive network protection.

## Scenario

You work as a cloud architect for a growing e-commerce company that migrated its infrastructure to Microsoft Azure. The company operates a multi-tier application with web servers, application logic servers, and database servers. Your task is to implement network security controls to ensure that:

- Web servers only accept HTTPS traffic from the internet
- Application servers only accept traffic from web servers
- Database servers only accept traffic from application servers
- All unauthorized traffic is blocked and logged for security analysis

You use Azure Network Security Groups to implement these access controls and establish secure network segmentation.

## Learning Objectives

By the end of this module, you'll be able to:

- Create and configure network security groups to filter network traffic in Azure virtual networks
- Define security rules based on source, destination, port, and protocol to allow or deny specific traffic
- Understand how NSGs evaluate inbound and outbound traffic using priority-based rules
- Implement application security groups to simplify security management for multi-tier applications
- Apply network security best practices using NSGs to protect Azure resources
- Monitor and troubleshoot network traffic using NSG diagnostic capabilities
