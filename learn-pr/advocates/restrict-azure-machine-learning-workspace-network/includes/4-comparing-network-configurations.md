A key difference between managed and custom network isolation is the location of the virtual network used for compute resources. For custom network isolation, the virtual network for compute is in your tenant. In a deployment that uses managed network isolation, the virtual network that hosts compute is located in the Microsoft tenant.

| | **Managed network (recommended)** | **Custom network** |
|---|---|---|
| **Benefits** | - Minimize set-up and maintenance overhead.<br>- Supports managed online endpoints.<br>- Supports serverless spark.<br>- Access to HTTPS endpoint resources located on-premises or in your custom virtual network.<br>- Focus for new feature development. | - Customize network to your requirements.<br>- Bring your own non-Azure resources.<br>- Connect to on-premises resources. |
| **Limitations** | - Extra costs for Azure Firewall and FQDN rules.<br>- Logging of the virtual network firewall and NSG rules isn't supported.<br>- Access to non-HTTPS endpoint resources isn't supported. | - New feature support might be delayed.<br>-Managed online endpoints aren't supported.<br>- Serverless spark isn't supported.<br>- Foundational models aren't supported.<br>- Implementation complexity.<br>- Maintenance overhead. |

Use managed virtual network when…

- You're new user to Azure Machine Learning with standard network isolation requirements
- You're a company with standard network isolation requirements
- You require on-premises access to resources with HTTP/S endpoints
- You don't have many non-Azure dependencies set up yet
- You require using Azure Machine Learning managed online endpoints and serverless spark computes
- You have fewer management requirements for networking in your organization

Use custom virtual network when…

- You're a company with heavy network isolation requirements
- You have many non-Azure dependencies previously set-up and need to access Azure Machine Learning
- You have on-premises databases with no HTTP/S endpoints
- You require using your own Firewall and virtual network logging and monitoring of outbound network traffic
- You want to use Azure Kubernetes Services (AKS) for inference workloads
