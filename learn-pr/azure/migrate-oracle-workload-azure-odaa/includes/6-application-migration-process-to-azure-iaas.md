With your Exadata infrastructure, virtual machine clusters, and databases ready, you can now migrate your on-premises application to Azure VMs.

## Use Azure Migrate to replicate the application VMs

You previously used Azure Migrate to analyze your existing hosting environment. The tool can also help automate your [application server migration to Azure VMs](/azure/migrate/tutorial-migrate-physical-virtual-machines). Azure Migrate creates the appropriate Azure VMs and copies the OS and applications running on the on-premises servers you're migrating, minimizing any manual configuration your team needs to perform.

Note that Azure Migrate requires the deployment of virtual appliances to your local datacenter and the installation of migration agent software on your servers, and it may not be supported on certain application servers. Although it may not be a good fit for all migrations, you believe it will be a useful component in your scenario.

To complete this process:

1. [Install the Azure Migrate replication appliance on your on-premises network.](/azure/migrate/tutorial-migrate-physical-virtual-machines#set-up-the-replication-appliance) This appliance coordinates the required tasks between Azure and the local machines being migrated.

1. [Install Azure Migrate Mobility service agent on servers migrating to Azure.](/azure/migrate/tutorial-migrate-physical-virtual-machines#install-the-mobility-service-agent) This agent allows the replication appliance to manage the local servers and to copy necessary data to the newly deployed Azure VMs.

1. [Configure your replication settings.](/azure/migrate/tutorial-migrate-physical-virtual-machines#replicate-machines) These settings allow you to select which machines are being migrated, the target Azure resource group and virtual network to use, and the target VM and storage settings. Because you used Azure Migrate to assess the application, the tool should automatically populate many of these settings.

1. [Test your migration.](/azure/migrate/tutorial-migrate-physical-virtual-machines#run-a-test-migration) After configuring your replication settings, perform a test migration. By deploying a test version of your replicated machine, you validate that your settings are correct. After validation, delete the test VMs.

1. [Execute migration.](/azure/migrate/tutorial-migrate-physical-virtual-machines#migrate-vms) This process creates the target VMs and then copies the OS and applications from your existing servers to the new Azure VMs.

1. [Perform post-migration VM configuration.](/azure/migrate/tutorial-migrate-physical-virtual-machines#post-migration-best-practices) When the new VMs are up and running, you need to update some settings, such as host names, networking and firewall configuration, and database connection settings. Ensure that the applications are accessible to users and that they can communicate with the newly migrated databases running on your Azure-hosted Exadata infrastructure.

After completing this process, confirm that the networking and security configuration is in order and that your applications are working as expected.

## Final testing and cutover

After you've confirmed that your data has been imported successfully into the new Azure-hosted Exadata databases and your applications are running as expected on Azure VMs, you're ready to make the switch.

You've configured the Oracle DMS tool to keep the Azure copy of your database in sync with your on-premises copy, so there's no need for downtime to perform any final data imports. When you've finished any last application testing, you can promote the Azure version to production, completing your migration.
