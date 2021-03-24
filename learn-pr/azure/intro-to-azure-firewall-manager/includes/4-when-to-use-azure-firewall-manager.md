Here, we'll discuss how you can decide whether Firewall Manager is the correct choice for your organizational requirements. We'll analyze the following criteria to help you make this decision:

- Complexity
- Need for centralized management
- Number of virtual networks

## Decision criteria

Administrators with multiple Azure virtual networks to protect will use rules to control traffic throughout their perimeter networks. As virtual network infrastructure grows, it can become more complex to manage and administrators can benefit from using Firewall Manager to centralize the configuration of Azure Firewall rules and settings. Here's some discussion that'll help you decide whether Firewall Manager will benefit your organization.

| **Criteria** | **Analysis**|
| ---------------------------- | ------------------------------------------------------------ |
| **Complexity** | A key question to ask when you're considering Firewall Manager is "How complex are my organization's firewall and security requirements?" If you have a simple virtual network structure with a limited number of firewalls, then you probably don't require Firewall Manager. |
| **Need for centralized management** | The next question to consider is "Will I benefit from a more centralized approach to managing my virtual networks and firewalls?" If the answer is yes, then you should consider implementing Firewall Manager. |
| **Number of virtual networks** | If you have many virtual networks, with many distinct Azure Firewalls, then Firewall Manager could benefit your organization. If you have only a few virtual networks, then you might not get as much benefit from Firewall Manager. |

## Apply the criteria

Firewall Manager enables you to centralize firewall security policies and route management for your cloud-based security perimeters. If you're trying to determine if your organization would benefit from using Firewall Manager, your decision will rely on the complexity of your Azure infrastructure.

Essentially, you have a binary choice. You can:

- Choose to manage each Azure Firewall and its associated rules as a separate and distinct entity.
- Implement Firewall Manager to centralize configuration.

If your Azure infrastructure consists only of one or two virtual networks, with perhaps differing traffic filtering needs, there's no obvious reason to implement Firewall Manager. 

However, you might consider Firewall Manager when you want to:

- Manage security policy configuration and logging across multiple Azure Firewall instances with hierarchical policies
- Centralize Azure Firewall management across secured virtual hubs and hub virtual networks deployments
- Automate traffic routing for security filtering in secured virtual hubs
- Integrate with third-party security partners for advanced protection