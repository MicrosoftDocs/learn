Now that your Azure SQL database is up and running, you can connect it to your favorite SQL Server management tool to populate it with real data.

You initially considered whether to run your database on-premises or in the cloud. With Azure SQL Database, you configure a few basic options, and you have a fully functional SQL database that you can connect to your apps.

There's no infrastructure or software patches to maintain. You're now free to focus more on getting your transportation logistics app prototype up and running and less on database administration. Your prototype won't be a throw-away demo, either. Azure SQL Database provides production-level security and performance features.

Remember that each Azure SQL logical server contains one or more databases. Azure SQL Database provides two pricing models, DTU and vCore, to help you balance cost versus performance across all your databases.

Choose DTU if you're just getting started or want a simple, preconfigured buying option. Choose vCore when you want greater control over what compute and storage resources you create and pay for.

Azure Cloud Shell makes it easy to start working with your databases. From Cloud Shell, you have access to the Azure CLI, which enables you to get information about your Azure resources. Cloud Shell also provides many other common utilities, such as `sqlcmd`, to help you start working right away with your new database.

## Clean up

To ensure you're not charged for the resources you created, you can delete resources individually or delete the resource group you used to delete the entire set of resources. Make sure to delete any resources you don't plan to use again.

## Additional resources

The documentation provides lots more information, including tutorials and samples. Here are a few links to what we covered here:

- [Azure SQL Database documentation](/azure/sql-database/)
- [Azure SQL Database purchasing models and resources](/azure/sql-database/sql-database-service-tiers)
- [Azure SQL Database logical servers and their management](/azure/sql-database/sql-database-logical-servers)
- [Azure SQL Database and SQL Data Warehouse firewall rules](/azure/sql-database/sql-database-firewall-configure)

To learn more about Cloud Shell, see [Overview of Azure Cloud Shell](/azure/cloud-shell/overview).

If you're interested in learning more about the `sqlcmd` utility, see [sqlcmd Utility](/sql/tools/sqlcmd-utility).
