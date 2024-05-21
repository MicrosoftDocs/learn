With your initial database migration complete, you're ready to migrate your application to Azure VMs.

## Remediate your application code

Before migrating your servers to Azure VMs, prepare your applications to use your new databases. During its code audit pass, your dev team will have identified the connection strings, queries, or other functionality with Oracle-specific features. The team now [modifies the application code to address those issues](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide#post-migration).

## Use Azure Migrate to replicate the application VMs

You previously used Azure Migrate to analyze your existing hosting environment. The tool can also help automate your [application server migration to Azure VMs](/azure/migrate/tutorial-migrate-physical-virtual-machines). Azure Migrate creates the appropriate Azure VMs and copies the OS and applications running on the on-premises servers you're migrating, minimizing any manual configuration your team needs to perform.

Note that Azure Migrate requires the deployment of virtual appliances to your local datacenter and the installation of migration agent software on your servers, and it may not be supported on certain application servers. Although it may not be a good fit for all migrations, you believe it will be a useful component in your scenario.

To complete this process:

1. [Install the Azure Migrate replication appliance on your on-premises network.](/azure/migrate/tutorial-migrate-physical-virtual-machines#set-up-the-replication-appliance) This appliance coordinates the required tasks between Azure and the local machines being migrated.

1. [Install Azure Migrate Mobility service agent on servers migrating to Azure.](/azure/migrate/tutorial-migrate-physical-virtual-machines#install-the-mobility-service-agent) This agent allows the replication appliance to manage the local servers and to copy necessary data to the newly deployed Azure VMs.

1. [Configure your replication settings.](/azure/migrate/tutorial-migrate-physical-virtual-machines#replicate-machines) This allows you to select which machines are being migrated, the target Azure resource group and virtual network, and the target VM and storage settings. Because you used Azure Migrate to assess the application, the tool should automatically populate many of these settings.

1. [Test your migration.](/azure/migrate/tutorial-migrate-physical-virtual-machines#run-a-test-migration) After configuring your replication settings, perform a test migration. By deploying a test version of your replicated machine, you validate that your settings are correct. After validation, delete the test VMs.

1. [Execute migration.](/azure/migrate/tutorial-migrate-physical-virtual-machines#migrate-vms) This process creates the target VMs and then copies the OS and applications from your existing servers to the new Azure VMs.

1. [Perform post-migration VM configuration and code deployment.](/azure/migrate/tutorial-migrate-physical-virtual-machines#post-migration-best-practices) When the new VMs are up and running, you need to deploy your updated code and modify settings, such as host names, networking and firewall configuration, and database connections, that allow your applications to communicate with your new Azure SQL Managed Instance databases.

After completing this process, confirm that the networking and security configuration is in order and that your applications are working as expected.

## Perform final sync, testing, and cutover

After you've confirmed that your data has been imported successfully into the new Azure SQL managed instance and your applications are running as expected on Azure VMs, you're ready to finalize the migration.

First, perform a final data sync to ensure that your cloud-hosted databases are up to date. Next, test to confirm that the application and data are behaving as expected. After you're satisfied with your testing, cut over production to the new Azure-hosted resources, completing your migration.
