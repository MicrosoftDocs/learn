You've planned out which application and database resources you need to create on Azure. In this section, discover how to create the underlying infrastructure to support the Exadata Virtual Machine Clusters that will host your database loads. (We'll discuss creating your cluster and migrating data in later sections.)

## Prepare the landing zone

Before you deploy the database VMs, you need to address the initial setup for the target deployment environment. Prior to the migration:

- [Select your Azure region](/azure/oracle/oracle-db/database-overview?branch=main#available-regions). (Oracle Database@Azure isn't available in all Azure regions at this time.) To make the most of the service's colocation with Azure, pick a supported region to deploy not only your Exadata infrastructure but also your application VMs.

- [Review the landing zone architecture for Oracle Database@Azure.](/azure/cloud-adoption-framework/scenarios/oracle-iaas/#oracle-on-azure-architectures) The conceptual diagram offers insight into critical design areas to help you prepare your environment.

- [Create resource groups.](/azure/azure-resource-manager/management/manage-resource-groups-portal) Azure resource groups are region-specific containers for storing and organizing resources. Before setting up your Exadata infrastructure, VMs, virtual networks, or any other assets, create a resource group for them to live in.

- [Deploy a virtual network and configure access, as appropriate.](/azure/virtual-machines/workloads/oracle/deploy-application-oracle-database-azure#network-and-security) Your virtual network allows your VMs to communicate with each other, your databases, your on-premises systems, and the outside world. Before deployment, you need to deploy and configure the network and add whatever security, routing, and RBAC controls your application requires. Make sure you've set up appropriate subnets for the various components you're hosting. [Enable Oracle Database network attachments](/azure/oracle/oracle-db/oracle-database-network-plan) to the subnet that will connect to your Exadata Virtual Machine Cluster.

## Create your Exadata infrastructure

After you've prepared your landing zone, you're ready to start deploying resources. Your first step is to ensure that you've [enabled Oracle Database@Azure on your Azure account](/azure/oracle/oracle-db/database-overview#purchase-oracle-databaseazure). Oracle automatically associates the subscription to either your [existing Oracle Cloud Infrastructure account or a new account you create](/azure/oracle/oracle-db/onboard-oracle-database#step-2-select-your-oracle-cloud-account).

After the service is enabled, you can use the Azure portal to access the Oracle Database@Azure service blade to begin [creating your Exadata infrastructure](/azure/oracle/oracle-db/provision-oracle-database#provision-exadata-infrastructure).

During this process, you're asked to provide the following information:

- The subscription and resource group you're deploying the infrastructure instance to.

- The [Azure region](/azure/oracle/oracle-db/database-overview#available-regions) and [availability zone](/azure/reliability/availability-zones-overview) where you want the instance to reside. For best performance, make sure these settings match where you're going to deploy your VMs and virtual network.

- The unique name of your infrastructure.

- The Exadata infrastructure model you want to use.

- Total number of database and storage servers that will exist in your infrastructure.

- The total number of OCPUs and amount of storage capacity that you'll have available.

You then configure maintenance schedules and set up [Azure tags for management purposes](/azure/azure-resource-manager/management/tag-resources). After you have completed those tasks, finalize your configuration and then create the Exadata infrastructure.

Note that you can support multiple workloads on the same infrastructure, so make sure that when you're configuring these settings, you're allocating enough resources to handle everything you want the infrastructure to host.
