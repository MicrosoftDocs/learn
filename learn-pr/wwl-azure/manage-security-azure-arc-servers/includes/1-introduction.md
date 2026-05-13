Contoso Manufacturing recently connected its on-premises production scheduling and supply chain servers to Azure using Azure Arc. The servers are enrolled and appear in Azure as managed resources. However, a critical security gap remains. Any user with sufficient Azure permissions can deploy extensions to these servers—effectively installing software with elevated privileges. The factory servers have no policy enforcement, no security baseline compliance checks, and no unified visibility in Microsoft Defender for Cloud.

In this module, you learn how to secure Arc-enabled servers using a defense-in-depth approach. You explore:

- How to configure role-based access control (RBAC) and extension allow/block lists to prevent unauthorized software installation on Arc-enabled servers
- How to assign and manage Azure Policy to enforce security baselines across hybrid infrastructure
- How to monitor security posture and compliance for Arc-enrolled servers in Microsoft Defender for Cloud
- How machine configuration policies extend security governance to Arc-enrolled servers

## Prerequisites

- Working knowledge of Azure Arc server connectivity and the Azure Connected Machine agent
- Foundational understanding of Microsoft Defender for Cloud security recommendations and regulatory compliance features
- Access to an Azure subscription with Arc-enabled servers already enrolled

With Arc connectivity established, you can now apply security governance at cloud scale to Contoso's factory servers. In the next unit, you examine how to control who can manage Arc servers and what software can run on them.
