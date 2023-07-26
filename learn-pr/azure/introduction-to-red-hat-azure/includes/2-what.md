Red Hat offers many Linux solutions for Azure. In this module, we discuss three of those offerings: Red Hat Enterprise Linux (RHEL), Azure Red Hat OpenShift (ARO), and JBoss Enterprise Application platform (JBoss EAP) to help determine if one or all of these solutions may be applicable to your use case.

## What is RHEL on Azure?

**Red Hat Enterprise Linux (RHEL)** is an open-source Linux operating system that serves as the consistent foundation for the enterprise hybrid cloud, providing the tools needed to deliver services and workloads faster with less effort. By using RHEL as the operating system for your Virtual Machines on Azure, you gain tightly integrated, enterprise-grade support from Red Hat and Microsoft. this support ensures a seamless transition to running workloads in a cloud environment.

## What is ARO?

**Azure Red Hat OpenShift (ARO)** provides fully managed Red Hat OpenShift clusters on Azure, jointly engineered, managed, and supported by Microsoft and Red Hat. ARO applies the power of Azure to provide a flexible, self-service deployment of the fully managed OpenShift clusters for developing and deploying applications. With ARO, you can maintain regulatory compliance and focus on your application development, while both Microsoft and Red Hat patch, update, and monitor your cluster nodes. You can get up and running immediately using the preintegrated application builds, container packaging and registry, deployments, scaling, health management, and more. ARO also supports integration with most major CI/CD and application performance management solutions you already have in-house.

## What is JBoss?

**Red Hat JBoss Enterprise Application Platform (EAP)** is the middleware solution that makes it easier to modernize, containerize, and migrate your Java applications to Azure. It can be used either with RHEL or ARO, or through the JBoss plan offered in Azure App Services.

JBoss EAP offers a comprehensive solution for Java applications that is both cloud-friendly and feature rich. It allows for deployment across all the different types of infrastructures an organization would run including, VM-based, container-based, and even within cloud native offerings like Azure App Services.

In each of these scenarios, JBoss EAP provides the certified Java base with security and data handling extensions that organizations need to meet and exceed the latest regulations and privacy standards. JBoss EAP is also flexible enough to integrate with existing SSO and other existing solutions that are required to operate within their suite of enterprise applications.

## Why run Red Hat on Azure?

Red Hat and Microsoft have collaborated to create a seamless, enhanced experience for customers on Azure. Key benefits include:

- No-hassle, unified global support across 18 regions with a coordinated escalation and resolution process and integrated ticketing.
- Your choice of creating your own VM or selecting from hundreds of pre-provisioned VM images through Azure Marketplace.
- Simplified administration and security controls for managing across a complex hybrid infrastructure.
- Always up-to-date Red Hat infrastructure on Azure by default, and support for previous versions through Extended Lifecycle Support.

## What are the licensing options for Red Hat on Azure?

You can choose to either **Pay-As-You-Go (PAYG)** or use the Red Hat Cloud Access Program to **Bring-Your-Own-Software (BYOS)**.

With PAYG, you purchase images from Microsoft Azure at flat, hourly rates that include infrastructure and software usage rights. You pay for compute capacity by the second, with no long-term commitment or upfront payments, and can increase or decrease compute capacity on demand. These instances don't consume Red Hat Subscriptions, and they shouldn't be registered with Red Hat Subscription Management or Red Hat Satellite.

The Red Hat Cloud Access program makes your eligible Red Hat product subscriptions portable, allowing you to choose the best architecture and infrastructure for your needs. The terms of your subscription with Red Hat, including pricing, remain the same. You work directly with your Red Hat sales representative to determine sizing and pricing when moving to a certified cloud provider. Under this scenario, you pay Red Hat for subscriptions, and pay Azure for its services.

### JBoss EAP deployment and pricing

JBoss EAP can be deployed in multiple supported ways on Azure including: an application in Azure App Services; on Virtual Machines that can be ordered from the Azure Marketplace or custom-built images; or as a containerized application on ARO.

The subscriptions are available as PAYG or BYOS.

### ARO deployment and pricing

An Azure Red Hat OpenShift cluster consists of three master nodes and two or more worker nodes. Master and worker nodes run on Azure Virtual Machines, and are billed at Linux VM pricing. Worker nodes have an extra cost for the OpenShift subscription component.

Compute, networking and storage resources consumed by your cluster are billed according to usage (ARO is only available as PAYG). Use on-demand pricing, or reserved instances, whichever best meets the need of your workload and business.

### Can I use my Azure Hybrid Benefits (AHB)?

Yes. The Red Hat Cloud Access program applies AHB for the same net effect. For more information, see BYOS in the previous section: **What are the licensing options for Red Hat on Azure?**

:::image type="content" source="../media/cost-diagram.png" alt-text="A diagram representing Red Hat Enterprise Linux subscription options.":::
