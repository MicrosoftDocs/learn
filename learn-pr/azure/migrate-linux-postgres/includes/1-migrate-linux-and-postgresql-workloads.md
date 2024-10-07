## Introduction

In this Learning Path, you'll be guided through a series of modules that enable you to migrate an existing workload from an on-premises or cloud environment to Azure. It covers the migration of the compute to an Azure Virtual Machine and the data to Azure Database for PostgreSQL. The application is a cloud-agnostic sample application that is a stand-in for any real-world application prepared for migration to the cloud. You explore the value of shifting from a self-hosted environment, such as from a self-managed database to a fully managed database offering and from bare-metal compute to cloud-hosted virtual machines with the benefit of a full suite of security and identity controls provided by Azure, such as Microsoft Entra ID. You'll also explore the benefits of managing resources in the cloud from a cost and performance perspective. You'll learn how to precisely calculate and manage costs before and after deployment, as well as how to optimize performance from both a compute and a data perspective. 

## Our workload 

Our workload is a cloud-agnostic application written in Go that works with data inside PostgreSQL. Future implementations will be available in Python and Java.

Our data is an open dataset that enables you to explore the power of our Postgres platform and related extensions. 

Though this application could easily be run within a container, the stakeholders have not chosen to do so at this stage. Therefore, building a container, deploying to a container platform, or using container orchestration are out of scope at this stage, but this might be a logical future step. 

The application and its associated data are provided for you in the GitHub repository associated with this Learning Path. You'll learn how to prepare your application and export your data to reach a similar state to this sample application, or even use it as a template for a green-field deployment. 

## What is the value of migrating this workload? 

As we consider this migration effort, you may wonder about the benefits of migrating this workload to the cloud. There are many, but some of the value propositions include:

*Security and compliance.* When you bring compute and data workloads to the cloud, they benefit from increased security capabilities. Virtual Machines in Azure benefit from a vast array of security and compliance features, including firewalls, vnets, JIT, encryption, RBAC, and confidential computing. Azure Database for PostgreSQL supports many similar features as well, such as [encryption with customer-managed keys](/azure/postgresql/flexible-server/concepts-data-encryption), [compliance certifications](/azure/postgresql/flexible-server/concepts-compliance), and support for [Microsoft Defender for Cloud](/azure/postgresql/flexible-server/concepts-security#microsoft-defender-for-cloud-support).  

*Secure connections between your Virtual Machines and Databases.* As we integrate these two services, it is critical that they can connect to each other in a secure manner that reduces the risk of data loss. [Microsoft Entra ID authentication](/azure/postgresql/flexible-server/concepts-azure-ad-authentication) enables you to connect to your Azure Database for PostgreSQL without traditional passwords, but instead using Entra ID identities for both your application workload (Managed Identity) as well as users and administrators via their Entra ID user accounts. This mitigates the risk of long-lived credentials being compromised and allowing bad actors to access your data. Entra ID, Managed Identities, and fine-grained Role-Based Access Control (RBAC) can enable your application workload to access data and manage resources in Azure securely, following the principle of least privilege. 

*Access to high-performance and cost-effective compute across multiple regions.* Whether you need cost-effective compute for test-dev or the most recent, highest performance, or largest compute types available in the cloud today, Azure has a broad selection of compute options for both [Virtual Machines](/azure/virtual-machines/sizes/overview) and [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-compute), which can be scaled up and down as needed, and are available across [over 60 regions](https://azure.microsoft.com/explore/global-infrastructure/products-by-region) in Azure. Compute can be scaled vertically as well as horizontally, including via [database replicas](/azure/postgresql/flexible-server/concepts-read-replicas) and [distributed options](/azure/cosmos-db/postgresql/introduction) such as Azure Cosmos DB for PostgreSQL, a managed service for PostgreSQL extended with the Citus open source superpower of distributed tables. This compute is paired with some of the [fastest cloud storage options](/azure/virtual-machines/disks-types) to tailor your compute and storage I/O requirements to your workload. 

*Cost management and cost-effectiveness.* You can optimize for cost management and cost-effectiveness on both the Linux and PostgreSQL sides. When compared with on-prem solutions, the cost can often be significantly more tailored and appropriate for your situation. You can right-size your compute in comparison to an on-prem solution. You can also easily manage your entire fleet to optimize for only the compute and storage you need, and pay only for what you use in a utility billing model. Utility billing enables customers to handle periods of high demand without having to pay the cost of over-provisioning and allows migration to faster and more efficient generations of compute as they become available. Customers can also take advantage of the Azure Hybrid Benefit to save on licensing costs for specific Linux distributions (learn more about the [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux)). Customers can also reduce costs—up to 72 percent compared to pay-as-you-go pricing—with one-year or three-year terms for virtual machines (VMs) and Azure Reserved Virtual Machine Instances (learn [How the Azure reservation discount is applied to virtual machines](/azure/cost-management-billing/manage/understand-vm-reservation-charges)). Azure pricing is transparent and predictable, and you can use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to estimate your costs before you deploy.

*Day 2 operations.* Operations across the board become more efficient through automation, the ability to upgrade easily with potentially zero downtime, monitoring, security patching, backups, and disaster recovery. Additionally, you can manage your infrastructure end-to-end with industry-standard toolchains.

## Before you begin

This learning path is designed to help you migrate an existing Linux and PostgreSQL workload to Azure.

However, we will not be focusing on how to export the data from your source database or how to prepare the application for migration. This is in part due to the fact that there are many different types of source databases and applications that could be migrated, and the process for each one is unique.

What you will be provided with is a sample application, Postgres data, binary files, and infrastructure as code that you can use to simulate the migration process. Once you have completed the simulated migration, you can use the knowledge gained to apply the same principles to your own workload.

You be using our sample application, [Azure-Samples/tailwind-traders-go](https://github.com/Azure-Samples/tailwind-traders-go), as the stand-in for the application code to be migrated. The Bicep infrastructure as code, sample Postgres and binary data, and other resources to support the hands-on portion of this module are available in the [Azure-Samples/linux-postgres-migration](https://github.com/Azure-Samples/linux-postgres-migration).

In order to apply this to your own workload, you will need to map your source application and data to the following structure:

### Application Code

Your application code should be stored in source control, preferably a repository in GitHub.

This migration shows the simplest scenario where you will clone the repository directly to your Azure Virtual Machine. In a real-world scenario, you would likely have a more complex deployment pipeline, such as GitHub Actions, that builds and deploys your application code to your compute resources.

### Postgres data

Your Postgres data should be stored in a `.sql` file that can be used to create the database schema and insert the data. In this simulated migration you will be provided with a sample data file, `tailwind.sql`, within the `Azure-Samples/linux-postgres-migration` that you copy to Azure Blob Storage and then import into your Azure Database for PostgreSQL. 

When it comes time to migrate your own data, you will export your data from your source database and save it to a `.sql` file and copy it to Azure Blob Storage as outlined in the module.

### Binary files

Most applications have other binary files, such as media files, that need to be migrated. In this application you learn how to migrate images to Azure Blob Storage.

The images are provided for you in `Azure-Samples/linux-postgres-migration` and you will copy them to Azure Blob Storage as outlined in the module.

Similarly, you will need to copy your binary files to Azure Blob Storage when you migrate your own workload. In this instance our compute will be *stateless*, and our application has permission to access the binary data directly in Blob Storage. 

### Infrastructure as Code (Bicep)

The infrastructure as code for this module is also stored in `Azure-Samples/linux-postgres-migration` and is designed to be a reference architecture you can use as-is, with minimal changes, provided you can make your source data and application conform to the structure outlined above.

Security is a major theme of this migration, and certain security settings have been chosen to make the hands-on portion of this module easier to complete. For example, Azure Blob Storage uses a more secure, keyless, authentication method, but we allow network connections from any IP address. In a production environment, you would want to lock down the network access to only the IP addresses that need access to the storage account. Similarly, we leave the option to add a firewall rule to the PostgreSQL server to allow a specific IP address, but in a production environment you may completely disable all public access to the server.

## Differences between source environments and Azure

One of the major differences you will notice migrating from another environment to Azure is that we are fully utilizing the security and identity controls provided by Azure. This includes using Managed Identities for Virtual Machines and Azure Database for PostgreSQL, as well as using Microsoft Entra ID for authentication to the database, as well as accessing the Virtual Machine with Entra ID rather than SSH keys.

Rather than a lift-and-shift migration, we are taking the opportunity to modernize the application to take full advantage of the security and compliance features provided by Azure.

On premisis you may be using a username and password to authenticate to your database. In Azure, we showcase how to use the Managed Identity of the Virtual Machine to authenticate to the database. This is a more secure method of authentication that reduces the risk of long-lived credentials being compromised. 

However, this will require code changes in your application. We show how to use the `azidentity` library in Go to get a token for the Managed Identity. The same library is available across our SDKs.

## Create an Azure account and install the Azure CLI

If you don't have an Azure account, you can create a [free account](https://azure.microsoft.com/free/) today. You get credits that can be used to try out paid Azure services. Even after the credits are used up, you can keep the account and use free Azure services.

To complete this learning path, you need the Azure CLI. You can install the Azure CLI on your local machine by following the instructions in the [Install the Azure CLI](/cli/azure/install-azure-cli) article.

In order to run the commands in the following modules you will need access to a bash shell. This can be on your local machine such as macOS, Linux, Windows Subsystem for Linux (WSL), Docker, a virtual machine such as Multipass, or in the cloud such as [Azure Cloud Shell](/azure/cloud-shell/overview), [GitHub Codespaces](https://github.com/features/codespaces), or an Azure Virtual Machine.

## Resources
- [Create a Free Azure account](https://azure.microsoft.com/free/)
- [How to Install the Azure CLI](/cli/azure/install-azure-cli)
- [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
- [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux)
- [How the Azure reservation discount is applied to virtual machines](/azure/cost-management-billing/manage/understand-vm-reservation-charges)
- [Azure-Samples/tailwind-traders-go](https://github.com/Azure-Samples/tailwind-traders-go)
- [Azure-Samples/linux-postgres-migration](https://github.com/Azure-Samples/linux-postgres-migration)
- [What is Azure Cloud Shell](/azure/cloud-shell/overview)
- [GitHub Codespaces](https://github.com/features/codespaces)