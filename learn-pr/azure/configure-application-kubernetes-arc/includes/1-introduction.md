Azure App Service on Kubernetes with Azure Arc facilitates implementation of services, such as web apps, on customer-managed, Azure Arc-onboarded Kubernetes clusters. Azure App Service enables DevOps teams to use a consistent approach when deploying solutions to customer-managed clusters and Azure-hosted platform as a service (PaaS) services.

## Scenario: Implement Azure App Service on Kubernetes with Azure Arc

Suppose you lead the IT infrastructure team for a US-based financial services company. Your team assists developers with modernizing internal and public-facing web applications. Until recently, the IT organization has been operating almost exclusively from its on-premises datacenters. It is focused on containerizing workloads and uses Kubernetes as the container orchestrator. However, company leadership is actively pursuing a cloud-first strategy. It believes reduced administrative overhead is possible if they migrate applications to Azure PaaS-based services.

The company's Information Security, Risk, and Compliance teams are slowing migration. They're still evaluating security and regulatory implications of a cloud transition. This has impacted several web apps. Those apps were tentatively scheduled for the first migration wave. The primary concern is how to obtain sufficient visibility into, and control over, the hosting platform.

You're evaluating Azure App Service on Kubernetes with Azure Arc to determine whether it addresses those concerns.

## Learning objectives

After completing this module, you'll be able to:

- Prepare for implementing Azure App Service on Kubernetes with Azure Arc.
- Implement an Azure Kubernetes Service (AKS) cluster that supports Azure App Service on Kubernetes with Azure Arc.
- Install the application services extension into an AKS cluster.
- Deploy Azure App Services web apps to an AKS cluster.

## Prerequisites

To get the best learning experience from this module, you should have:

- Foundational understanding of Kubernetes (from the operator's perspective).
- Foundational understanding of AKS.
- Foundational understanding of Helm.
- Foundational understanding of Web Apps feature of Azure App Service.
- Conceptual understanding of Azure App Service on Kubernetes with Azure Arc
- Understanding of container orchestration.

To complete exercises in this module, you'll need:

- An Azure subscription.
- A Microsoft account or a Microsoft Entra account that has an Owner role in the Azure subscription.
