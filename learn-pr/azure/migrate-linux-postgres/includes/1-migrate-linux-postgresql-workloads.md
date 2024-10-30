This module guides you through the migration of an existing workload from an on-premises or cloud environment to Azure. It covers the migration of the compute to an Azure virtual machine and the data to Azure Database for PostgreSQL. The application is a cloud-agnostic sample application that's a stand-in for any real-world application prepared for migration to the cloud.

In this unit, you explore the value of making the following shifts with the benefit of a full suite of security and identity controls that Azure provides, such as Microsoft Entra ID:

- Shifting from a self-hosted environment (such as from a self-managed database) to a fully managed database offering
- Shifting from bare-metal compute to cloud-hosted virtual machines

You also explore the benefits of managing resources in the cloud from a cost and performance perspective. And you learn how to precisely calculate and manage costs before and after deployment, along with how to optimize performance from both a compute and a data perspective.

## Our workload

Our workload is a cloud-agnostic application written in Go that works with data inside PostgreSQL. Future implementations will be available in Python and Java.

Our data is an open dataset that enables you to explore the power of the Postgres platform and related extensions.

Though this application could easily be run within a container, the stakeholders chose not to do so at this stage. Therefore, building a container, deploying to a container platform, or using container orchestration is out of scope at present. But migration to containers might be a logical future step.

The GitHub repository associated with this module provides an application and its associated data for you. You learn how to prepare your application and export your data to reach a similar state to this sample application, or use the sample application as a template for a greenfield deployment.

## What is the value of migrating this workload?

You might wonder about the benefits of migrating this workload to the cloud. Here are some of the value propositions.

### Security and compliance

When you bring compute and data workloads to the cloud, they benefit from increased security capabilities.

Virtual machines in Azure benefit from a vast array of security and compliance features, including firewalls, virtual networks, just-in-time virtual machine access, encryption, role-based access control (RBAC), and confidential computing. Azure Database for PostgreSQL supports many similar features, such as [encryption with customer-managed keys](/azure/postgresql/flexible-server/concepts-data-encryption), [compliance certifications](/azure/postgresql/flexible-server/concepts-compliance), and support for [Microsoft Defender for Cloud](/azure/postgresql/flexible-server/concepts-security#microsoft-defender-for-cloud-support).

### Secure connections between your virtual machines and databases

As you integrate the two services, it's critical that they can connect to each other in a secure manner that reduces the risk of data loss.

[Microsoft Entra ID authentication](/azure/postgresql/flexible-server/concepts-azure-ad-authentication) enables you to connect to Azure Database for PostgreSQL without traditional passwords. Instead, you use Microsoft Entra ID identities for your application workload (*managed identity*), users, and administrators, via their Microsoft Entra ID user accounts. This approach mitigates the risk of long-lived credentials being compromised and allowing bad actors to access your data.

Microsoft Entra ID, managed identities, and fine-grained RBAC can enable your application workload to access data and manage resources in Azure securely, by following the principle of least privilege.

### Access to high-performance and cost-effective compute across multiple regions

Whether you need cost-effective compute for dev/test or the most recent, highest performance, or largest compute types available in the cloud today, Azure has a broad selection of compute options for both [virtual machines](/azure/virtual-machines/sizes/overview) and [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-compute). You can scale up and scale down these options as needed, and they're available across [more than 60 regions](https://azure.microsoft.com/explore/global-infrastructure/products-by-region) in Azure.

You can scale compute both vertically and horizontally, including via [database replicas](/azure/postgresql/flexible-server/concepts-read-replicas) and [distributed options](/azure/cosmos-db/postgresql/introduction) such as Azure Cosmos DB for PostgreSQL. Azure Cosmos DB for PostgreSQL is a managed service for PostgreSQL extended with the Citus open-source superpower of distributed tables. This compute is paired with some of the [fastest cloud storage options](/azure/virtual-machines/disks-types) to tailor your compute and storage I/O requirements to your workload.

### Cost management and cost-effectiveness

You can optimize for cost management and cost-effectiveness on both the Linux and PostgreSQL sides. Compared with on-premises solutions, the cost can often be significantly more tailored and appropriate for your situation. You can right-size your compute in comparison to an on-premises solution. You can also easily manage your entire fleet to optimize for only the compute and storage that you need, and pay only for what you use in a utility billing model.

Utility billing enables customers to handle periods of high demand without having to pay the cost of overprovisioning. It allows migration to faster and more efficient generations of compute as they become available.

Customers can also take advantage of the Azure Hybrid Benefit to save on licensing costs for specific Linux distributions. To learn more, see [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).

Customers can also reduce costs (up to 72 percent compared to pay-as-you-go pricing) with one-year or three-year terms for virtual machines and Azure Reserved Virtual Machine Instances. For more information, see [How the Azure reservation discount is applied to virtual machines](/azure/cost-management-billing/manage/understand-vm-reservation-charges). Azure pricing is transparent and predictable, and you can use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) to estimate your costs before you deploy.

### Day 2 operations

Operations across the board become more efficient through automation, the ability to upgrade easily with potentially zero downtime, monitoring, security patching, backups, and disaster recovery. Additionally, you can manage your infrastructure end to end with industry-standard toolchains.

## Before you begin

This module is designed to help you migrate an existing Linux and PostgreSQL workload to Azure. However, it doesn't focus on how to export the data from your source database or how to prepare the application for migration. This approach is in part because there are many different types of source databases and applications that could be migrated, and the process for each one is unique.

This module provides you with a sample application, Postgres data, binary files, and infrastructure as code that you can use to simulate the migration process. After you complete the simulated migration, you can use the knowledge that you gained to apply the same principles to your own workload.

You use our sample application, [Azure-Samples/tailwind-traders-go](https://github.com/Azure-Samples/tailwind-traders-go) as the stand-in for the application code to be migrated. The Bicep infrastructure as code, sample Postgres and binary data, and other resources to support the hands-on portion of this module are available in the [Azure-Samples/linux-postgres-migration](https://github.com/Azure-Samples/linux-postgres-migration) GitHub repository.

To apply this approach to your own workload, you need to map your source application and data to the following structure.

### Application code

Your application code should be stored in source control, preferably a repository in GitHub.

This migration shows the simplest scenario where you'll clone the repository directly to your Azure virtual machine. In a real-world scenario, you would likely have a more complex deployment pipeline, such as GitHub Actions, that builds and deploys your application code to your compute resources.

### Postgres data

Your Postgres data should be stored in a `.sql` file that you can use to create the database schema and insert the data. In this simulated migration, you use a sample data file, `tailwind.sql`, within the `Azure-Samples/linux-postgres-migration`. You copy the file to Azure Blob Storage and then import it into Azure Database for PostgreSQL.

When it comes time to migrate your own data, you export your data from your source database and save it to a `.sql` file. You then copy the file to Azure Blob Storage as outlined in the module.

### Binary files

Most applications have other binary files, such as media files, that need to be migrated. In this application, you learn how to migrate images to Azure Blob Storage.

The images are provided for you in `Azure-Samples/linux-postgres-migration`. You copy them to Azure Blob Storage as outlined in the module.

Similarly, you need to copy your binary files to Azure Blob Storage when you migrate your own workload. In this instance, our compute is *stateless*, and our application has permission to access the binary data directly in Blob Storage.

### Infrastructure as code (Bicep)

The infrastructure as code for this module is also stored in `Azure-Samples/linux-postgres-migration`. It's designed to be a reference architecture that you can use as is, with minimal changes, if you can make your source data and application conform to the previously outlined structure.

Security is a major theme of this migration, and we chose certain security settings to make the hands-on portion of this module easier to complete. For example, Azure Blob Storage uses a more secure, keyless authentication method, but we allow network connections from any IP address. In a production environment, you would want to lock down the network access to only the IP addresses that need access to the storage account. Similarly, we leave the option to add a firewall rule to the PostgreSQL server to allow a specific IP address. In a production environment, you might completely disable all public access to the server.

## Differences between source environments and Azure

One of the major differences you'll notice in migrating from another environment to Azure is that you're fully utilizing the security and identity controls that Azure provices. You use managed identities for virtual machines and Azure Database for PostgreSQL, you use Microsoft Entra ID for authentication to the database, and you access virtual machines with Microsoft Entra ID rather than SSH keys.

Rather than a lift-and-shift migration, you're taking the opportunity to modernize the application to take full advantage of the security and compliance features that Azure provides.

On premises, you might use a username and password to authenticate to your database. In Azure, we showcase how to use the managed identity of the virtual machine to authenticate to the database. This method of authentication is more secure and reduces the risk of long-lived credentials being compromised.

The use of a managed identity for authentication often requires code changes in your application. This module shows how to use the `azidentity` library in Go to get a token for the managed identity. The same library is available across our SDKs.

## Create an Azure account and install the Azure CLI

If you don't have an Azure account, you can create a [free account](https://azure.microsoft.com/free/) today. You get credits that can be used to try out paid Azure services. Even after you use the credits, you can keep the account and use free Azure services.

In order to run the commands in the following modules you need access to a bash shell. This can be on your local machine such as macOS, Linux, Windows Subsystem for Linux (WSL), Docker, a virtual machine such as Multipass, or in the cloud such as [Azure Cloud Shell](/azure/cloud-shell/overview), [GitHub Codespaces](https://github.com/features/codespaces), or an Azure virtual machine.

To complete this module, you need the Azure CLI. You can install the Azure CLI on your local machine by following the instructions in the [Install the Azure CLI](/cli/azure/install-azure-cli) article. You also need to install [Git](https://git-scm.com/).

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
