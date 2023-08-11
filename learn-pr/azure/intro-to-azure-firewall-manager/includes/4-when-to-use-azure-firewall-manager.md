Here, we consider whether Firewall Manager is the correct choice for your organization, by analyzing these criteria to help you decide:

- Complexity.
- Need for centralized management.
- Number of virtual networks.

## Decision criteria

Administrators who must help protect multiple Azure virtual networks use rules to control traffic throughout their perimeter networks. As a virtual network infrastructure grows, it can become more complex to manage. Administrators benefit from using Firewall Manager to centralize configuration of Azure Firewall rules and settings. Here are some factors that help you decide whether Firewall Manager can benefit your organization.

| **Criteria** | **Analysis**|
| ---------------------------- | ------------------------------------------------------------ |
| **Complexity** | A key question if you're considering Firewall Manager is "How complex are my organization's firewall and security requirements?" If you have a simple virtual-network structure with limited firewalls, you probably don't need Firewall Manager. |
| **Need for centralized management** | The next question to ask is "Will I benefit from a more centralized approach to managing my virtual networks and firewalls?" If the answer is yes, consider implementing Firewall Manager. |
| **Number of virtual networks** | Do you have several virtual networks with many distinct Azure Firewalls? Firewall Manager could benefit your organization. Conversely, do you have only a few virtual networks? Firewall Manager might not be beneficial for you. |

## Apply the criteria

Firewall Manager centralizes management for your firewall security policies and routes for your cloud-based security perimeters. Are you deciding whether your organization would benefit from using Firewall Manager? The complexity of your Azure infrastructure helps determine your answer.

Essentially, you have a binary choice. You can:

- Choose to manage each Azure Firewall and its associated rules as separate and distinct entities.
- Implement Firewall Manager to centralize configuration.

If your Azure infrastructure consists of only one or two virtual networks that don't require different traffic filtering, you probably don't need to implement Firewall Manager.

However, you might consider using Firewall Manager to:

- Manage security-policy configuration and logging across multiple Azure Firewall instances that have hierarchical policies.
- Centralize Azure Firewall management across secured virtual hubs and hub virtual network deployments.
- Automate traffic routing for security filtering in secured virtual hubs.
- Integrate with third-party security partners for advanced protection.
