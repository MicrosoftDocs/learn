In this module, you learned about Azure Database for PostgreSQL. You also learned about Hyperscale, and other server deployment options.

In this module, you've seen what the Azure Database for PostgreSQL offering looks like. You created an Azure Database for PostgreSQL server using the Azure portal and adjusted the firewall. Finally, you connected to the Azure Database for PostgreSQL server using psql in Azure Cloud Shell and queried the database.

## Clean up

It's important that you clean up any unused resources. You're charged for the configured capacity not how much of the database is used. For this module, we make these resources available to you free of charge. But you should get into the habit of deleting resources when you're done with them.

1. Go to the [Azure portal](https://portal.azure.com/).
1. In the navigation menu on the left, click **Resource Groups**, and then click the resource group that you created as part of the optional exercise in unit 3.
1. In the **Overview** pane, click **Delete resource group**.
1. Enter the name of the resource group that you created to confirm, and then click **Delete**.

Now that you have reviewed this module, you should be able to:

* Create an Azure Database for PostgreSQL instance using the CLI
* Query the Azure Database for PostgreSQL instance using pgsql
* Use a Django app to connect to the PostgreSQL database

## Use these resources to discover more

[!include[](../../../includes/open-link-in-new-tab-note.md)]

- [Azure Database for PostgreSQL documentation](https://docs.microsoft.com/azure/postgresql/)
- [Azure Database for PostgreSQL - Hyperscale (Citus) documentation](https://docs.microsoft.com/azure/postgresql/hyperscale/)
