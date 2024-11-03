Now that you’ve deployed the Spring Pet Clinic application with the default H2 in-memory database, you might want to connect it to a more powerful, persistent database like PostgreSQL. This will ensure that your application data is stored even when the application is restarted, providing greater durability and scalability for production use.

## Create the PostgreSQL Database
First, create a PostgreSQL database in Azure to host your application’s data. In the search bar, search `Azure Database for PostgreSQL - Flexible Servers`, then click on the `Create` button.

Complete the necessary details:
Basic:
- Server name: Provide a unique name for your PostgreSQL server. postgressqlpetclinic.
- Location: Choose the same region as your Azure Container App for optimal performance.
- Admin username and password: Set the admin credentials for accessing your database.
- Select the database tier and configuration options (you can start with the Basic tier if this is for testing purposes).

Click Review + create to deploy the database.

Note: Once the database is created, take note of the following information:

- Server name (e.g., your-server-name.postgres.database.azure.com)
- Admin username and password


## Connect to the Database
With the database set up, the next step is to configure the Spring Pet Clinic application to connect to PostgreSQL.

### Configure Database Firewall Rules

1. Go to your PostgreSQL server in the Azure portal.

2. Under Settings, select **Networking**.

3. To allow Azure Container Apps to connect, either:
 - Add the IP address of your Azure Container Apps environment.
 - Or enable Allow access to Azure services to permit connections from all Azure services.

### Create a new Database
1. Go to your PostgreSQL server in the Azure portal.
2. Expand **Settings** > **Databases** > Click on **Add**.
3. Name it as `petclinic` and save.

### Connect via Service Connector

1. In the Azure portal, navigate to your **Azure Container Apps** instance.

2. Go to **Settings** > **Service Connector**.

3. Click on **Create**, then fill out the connection form:
 - Basic:
    - **Service type**: DB for PostgreSQL flexible server
    - **PostgreSQL flexible server**: your-server-name
    - **PostgreSQL database**: postgres
    - **Client type**: SpringBoot
 - Authentication:
    - Choose `Connection string`.
    - Fill in your Username and Password
Leave others as default.

4. Confirm and deploy your changes.

5. Once the deploy is ready, cLick on **Validate** to validate your connection status.

### Update `spring.profiles.active` for PostgreSQL

1. In the Azure portal, navigate to your **Azure Container Apps** instance. In the left pane, under **Application**, select **Containers**.

2. Click on **Edit and Deploy**, then in the **Container Image** section, click on **petclinic**.

3. In the pop up window, switch to the ***Environment variables** tab and add one more line: **Name**: `spring.profiles.active`, **Source**: `Manual entry`, **Value**: `postgres`.

4. Click **Save**, then Click **Create**.

This will restart the app and apply changes, such as initializing the SQL tables.


## Validate the Database setup
Now that the configuration is complete. If you connect to your PostgreSQL, you will see that the table has already been created.
![Diagram of the PostgreSQL.](../media/postgresql.png)
