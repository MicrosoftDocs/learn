

Administrators with multiple Azure virtual networks to protect will use rules to control traffic throughout their perimeter networks. As virtual network infrastructure grows, it can become more complex to manage. Administrators can benefit from centralizing the configuration of Azure Firewall rules and settings with Azure Firewall Manager. In this unit, we'll learn when using Azure Firewall Manage makes sense for your organization. 

## Decision criteria

You can choose to manage each Azure Firewall and its associated rules as a separate and distinct entity. Alternatively, you can implement Azure Firewall Manager to centralize configuration. The choice you make is determined largely by the complexity of your Azure infrastructure. If you have many virtual networks, with many distinct Azure Firewalls, then Firewall Manager could benefit your organization. 

## Apply the criteria

Azure Firewall Manager enables you to centralize firewall security policies and route management for your cloud-based security perimeters. If your Azure infrastructure consists only of one or two virtual networks, with perhaps differing traffic filtering needs, there's no obvious reason to implement Azure Firewall Manager. However, you might consider Azure Firewall Manager in the following situations:

- Manage security policy configuration and logging across multiple Azure Firewall instances with hierarchical policies
- Centralize Azure Firewall management across secured virtual hubs and hub virtual networks deployments
- Automate traffic routing for security filtering in secured virtual hubs
- Integrate with third-party security partners for advanced protection

