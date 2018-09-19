Let's assume that you're using an on-premises PostgreSQL database. You're managing all security aspects and you've locked down all access to your servers using the standard PostgreSQL server-level firewall rules. You now have a good understanding of how to configure the same server-level firewall rules in Azure.

Let's connect to one of the Azure Database for PostgreSQL servers that you created.

## Allow Azure service access

Before we begin, you'll have to allow access to Azure services if you want to use PowerShell and `psql` to connect to your server. Recall that you can allow access in two ways.

Your first option is to enable **Allow access to Azure services**. Allowing access will create a firewall rule even though the rule isn't entered in the list of custom rules you create.

Your second option is to create a firewall rule that allows access to all IP addresses. The rule will include the IP address for the client running PowerShell that you'll use to execute `psql` from.

You also need to disable the **Enforce SSL connection** option.

### Create a firewall rule

1. Sign into the [Azure portal](https://portal.azure.com/triplecrownlabs.onmicrosoft.com?azure-portal=true) using the same account you activated the sandbox with. 

1. Navigate to the server resource for which you would like to create a firewall rule.

1. Select the **Connection Security** option to open the connection security blade to the right.

    ![Screenshot of the Azure portal showing the Connection security section of the PostgreSQL database resource blade](../media/7-db-security-settings.png)

Recall that you want to allow access to PowerShell clients running `psql`.

You can choose to either:

- Set **Allow access to Azure services** to **ON**
- Set **Enforce SSL connection** to **DISABLED**
- Click the **Save** button to save your changes

Or, you can add a firewall rule to allow access to all IP addresses by adding a firewall rule. Use the following values:

- Rule Name: `AllowAll`
- Start IP: `0.0.0.0`
- End IP: `255.255.255.255`
- Set **Enforce SSL connection** to **DISABLED**
- Click the **Save** button to save your changes

> [!Warning]
> Creating this firewall rule will allow any IP address on the Internet to attempt to connect to your server. In production environments, you'll want to restrict access to specific IP addresses.

### Connect to the database with psql

1. In the Azure Cloud Shell on the right, connect PSQL to your server using the following command. Make sure to replace the server name and admin name.

    ```bash
    psql --host=<server-name>.postgres.database.azure.com --username=<admin-user>@<server-name> --dbname=postgres
    ```
    
    Use the values you chose for the `server-name`, and `admin-user`. 

1. **postgres** is the default management database every PostgreSQL server is created with. You'll be prompted for the password you provided when you created the server.

1. Once successfully connected, execute the <kbd>\l</kbd> command to list all databases. This command will result in two or more default databases returned.

1. Hit <kbd>q</kbd> to exit the list.

1. You can try other PSQL commands.
    - <kbd>\?</kbd> to get help.
    - <kbd>\dt</kbd> to list the tables.

1. When you're finished executing PSQL operations on your server, execute the command <kbd>\q</kbd> to quit PSQL.
