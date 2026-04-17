**Microsoft Azure** is a cloud computing platform that provides a wide range of services to help individuals and organizations build, deploy, and manage applications through Microsoft-managed data centers. It offers flexibility, scalability, and global reach, making it a popular choice for businesses of all sizes. Azure supports various programming languages, frameworks, and operating systems, allowing developers to work with the tools they prefer.

## Cloud capabilities
Azure delivers core cloud capabilities across four main areas: compute, storage, networking, and application services. Compute services include virtual machines, containers, and serverless functions that run workloads efficiently. Storage services offer scalable and secure options for saving data, such as Blob Storage and Azure Files. Networking services connect resources securely and reliably, using tools like Azure Virtual Network and Load Balancer. Application services help developers build and host web apps, APIs, and mobile backends with ease.

## Understand how Azure organizes your resources
Azure organizes access and management through a hierarchy of entities. A tenant represents a dedicated instance of Azure Active Directory, which handles identity and access management. Within a tenant, subscriptions define billing boundaries and provide access to Azure services. Each subscription can contain multiple resource groups, which are logical containers for managing related resources together. Resources are the individual services or components—like virtual machines, databases, or storage accounts—that you deploy and manage within Azure.

This organizational structure helps ensure clarity, security, and scalability in cloud environments. Tenants and subscriptions allow for clear separation of concerns across departments or projects. Resource groups simplify management by grouping related assets, making it easier to apply policies, monitor usage, and automate deployments. Understanding this hierarchy is essential for efficient cloud governance and cost control in Azure.

#### Foundry runs on Azure
Foundry runs on Azure and uses Azure resource types. Foundry is an AI development layer within Azure, designed to accelerate building and managing generative AI apps and agents with enterprise-grade governance. Foundry projects and hubs are resources that integrate with Azure networking, storage, and security. 

Foundry Tools and models are cloud-based and accessed through a Foundry resource. This means that they are managed in the same way as other Azure services, such as platform as a service (PaaS), infrastructure as a service (IaaS), or a managed database service. From creating or deleting resources, to availability and billing, the Azure platform and resource manager provides a consistent framework for all your Azure services. 

Thus, starting with an Azure subscription, you can create a Foundry project, and develop an AI application. Next, let's try starting a project in Foundry.