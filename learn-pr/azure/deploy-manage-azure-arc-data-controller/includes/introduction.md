Suppose you work for a New York-based financial services company with a global customer base and several US government contracts. You lead the IT infrastructure engineering team, which assists solution architects, data engineers, and software developers with modernizing internal and public-facing services and applications.

Until recently, you relied almost exclusively on infrastructure hosted in on-premises datacenters. Your primary focus was on increasing the agility of on-premises workloads by containerizing them, with Kubernetes serving the role of the container orchestrator. Over the last few months, the company's technology leadership has started vigorously pursuing the cloud-first strategy, seeking to lower its capital expenditures and administrative overhead by transitioning the existing on-premises solutions to Platform-as-a-Service (PaaS)-based services in Microsoft Azure. This strategy included a successful migration of approximately hundred on-premises Microsoft SQL Server databases to Azure SQL Managed Instance. The need to minimize potential compatibility issues determined the choice of the target offerings, which also enabled the organization to take advantage of managed cloud services benefits.

However, the company's Risk and Compliance team's evaluation of the regulatory implications of transitioning to the cloud has constrained the pace and scope of the migration. In particular, the risk evaluation impacted the company’s ability to migrate several SQL Server databases hosted in overseas datacenters that are subject to data residency requirements. The US government contract-related data stores pose more significant challenges due to the additional need to fully isolate them from the internet.

In search of a solution that would address these concerns, help minimize the operational burden, and leverage the existing investment into Kubernetes, you decide to evaluate the functionality of Azure Arc-enabled data services.

## Learning objectives

By the end of this module, you’ll be able to:

- Prepare for deploying Azure Arc-enabled data services.
- Deploy an Azure Arc data controller.
- Manage an Azure Arc data controller.
