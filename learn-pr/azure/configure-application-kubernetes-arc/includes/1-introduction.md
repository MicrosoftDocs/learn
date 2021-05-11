App Service on Azure Arc enables you to implement services such as web apps on customer-managed, Azure Arc-onboarded Kubernetes clusters. Azure App Service allows DevOps teams to use a consistent approach when deploying their solutions to the customer-managed clusters and Azure-hosted Platform-as-a-service (PaaS) services. <!-- Dallas: Mind checking I didn't change the meaning while making less wordy? The intro paragraph used to be: App Service on Azure Arc enables you to implement Azure App Service services, such as App Services web apps on customer-managed, Azure Arc-onboarded Kubernetes clusters. This allows DevOps teams to use a consistent approach when deploying their solutions to the customer-managed clusters and Azure-hosted Platform-as-a-service (PaaS) services. From ID Brooks, please delete note if ok. --> 

## Scenario: Implement Azure App Service on Kubernetes with Azure Arc

Suppose you work for a US-based financial services company. You lead the IT infrastructure team, which assists developers with modernizing internal and public facing web applications. Until recently, the IT organization has been operating almost exclusively from its on-premises datacenters focusing on containerizing their workloads, with Kubernetes serving the role of the container orchestrator. Over the last few months, the company's leadership has started actively pursuing the cloud first strategy, seeking to lower its administrative overhead by migrating its applications to PaaS-based services in Azure. <!-- Dallas: Assuming we're doing first mention spelled out and subsquent mentions abbreviated, so I abbreviated PaaS here. From ID Brooks, please delete if ok--> 

The pace of migration has been hindered by the company's Information Security, Risk, and Compliance teams, which are still in the process of evaluating the security and regulatory implications of transitioning to the cloud. This affected, in particular, a number of web apps, which were tentatively scheduled for the first wave of the migration. The primary concern was the ability to obtain sufficient visibility into and control over the hosting platform. 

In search for a solution that would address this concern, you decided to evaluate Azure App Service on Kubernetes with Azure Arc. 

## Learning objectives

After completing this module, you'll be able to:

- Prepare for implementing Azure App Service on Azure Arc enabled Kubernetes.
- Implement an AKS cluster that supports App Service on Azure Arc.
- Install the Azure Web Apps extension into an AKS cluster.
- Deploy Azure App Services web apps to an AKS cluster.

## Prerequisites

To get the best learning experience from this module, you should have:

- Foundational understanding of Kubernetes (from the operator's perspective).
- Foundational understanding of AKS.
- Foundational understanding of Helm.
- Foundational understanding of Web Apps feature of Azure App Service.
- Conceptual understanding of App Service on Azure Arc.
- Understanding of container orchestration.

To complete exercises in this module, you'll need:

- An Azure subscription.
- A Microsoft account or an Azure Active Directory (Azure AD) account that has an Owner role in the Azure subscription.
