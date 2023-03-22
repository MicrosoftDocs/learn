Elastic, built on the Elastic Stack, provides tools to help you search, analyze, monitor, and secure your apps and IT. The Elastic Stack, known as ELK Stack, is made up of Elasticsearch, Logstash, Kibana, and Beats.  

- Elasticsearch is a distributed, JSON-based search and analytics engine.
- Logstash is a dynamic data collection pipeline with an extensible plugin ecosystem.
- Kibana helps you visualize and shape to your data and is the extensible user interface.
- Beats, is a platform for gathering operational data from machines and systems and sending it to Elasticsearch or Logstash.

When deploying on Azure, you can select from three different options, Elastic Cloud on Azure, Elastic on Azure Kubernetes Service, and Elastic on Azure Virtual Machines (VMs).

## Elastic Cloud on Azure

Elastic Cloud gives you the power of Elastic Stack, including solutions for enterprise search, observability, and security. For most use cases, Elastic Cloud on Azure offers the fastest way to get value from your data. With the Elastic Cloud service, your team can focus on onboarding and getting to work with your data. The experts at Elastic, run, operate, patch, secure, and support your deployments. When you choose the fully managed service, it helps to eliminate costly overhead and compliance investments. It also reduces the risk of building a platform from the ground up or maintaining the platform as the enterprise grows.  

## Elastic on Azure Kubernetes Services

For users who need more control over the infrastructure that supports the Elastic deployment on Azure, you can deploy Elastic on AKS.

AKS provides users an enterprise-grade and operationally efficient way of deploying applications on Kubernetes infrastructure. Elastic Cloud Kubernetes operator provides users a highly efficient way to run Elastic on Kubernetes that includes built-in best practices.

## Elastic on Azure virtual machines

Azure virtual machines provide Azure users a flexible way to deploy their Elastic workloads and manage the infrastructure underneath, providing them with more control and flexibility over other deployment options. This deployment option is best for teams that need to meet architectural or compliance constraints. For example, if their workloads must be deployed within their Azure tenant.  

> [!NOTE]
> The Azure Marketplace and Resource Manager (ARM) template for Elastic has been deprecated. Instead, you're strongly advised to use the Elastic Cloud (Elasticsearch Service) offering in the Azure Marketplace.

## Elastic on Azure deployment options at a glance

The following table provides a quick view that compares the deployment options:

:::image type="content" source="../media/comparison-table.png" alt-text="A table comparing deployment options for Elastic on Azure." border="false":::

The Elastic on Azure deployment options can be accessed through the Azure Marketplace.

:::image type="content" source="../media/azure-marketplace.png" alt-text="A screenshot of the Azure Marketplace showing the search results for Elastic.":::
