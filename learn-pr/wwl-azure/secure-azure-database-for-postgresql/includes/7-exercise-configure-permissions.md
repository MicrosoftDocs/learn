In this lab exercises, you'll assign RBAC roles to control access to Azure Database for PostgreSQL resources and PostgreSQL GRANTS to control access to database operations.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

To complete these exercises, you must have:

- Created a resource group (see Module 1, Unit 5).
- Created an Azure Database for PostgreSQL Flexible Server (see Module 1, Unit 5).
- Download and install Azure Data Studio with the PostgreSQL extension (see Module 2, Unit 4).
- Created the **zoodb** database (see Module 2, Unit 4).

> [!TIP]
> If you stopped your Azure Database for PostgreSQL server after completing the last lab, restart it now.

## Create a new user account in Azure Active Directory

1. In the [Azure portal](https://portal.azure.com), sign in using an Owner account and navigate to your Azure Active Directory.
1. Under **Manage**, select **Users**.
1. At the top-left, select **New user** and then select **Create new user**.
1. In the **New user** page, enter these details and then select **Create**:
    - **Username:** Holly
    - **Name:** Holly Rees
    - **Password:** Select **Let me create password** and then type **Pa$$w0rd**.

    > [!TIP]
	> When the user is created, make a note of the full **User principal name** so that you can use it later to log in.

## Assign the Reader role

1. In the Azure portal, select **All resources** and then select your Azure Database for PostgreSQL resource.
1. Select **Access control (IAM)** and then select **Role assignments**. Holly Rees doesn't appear in the list.
1. Select **+ Add** and then select **Add role assignment**.
1. Select the **Reader** role, and then select **Next**.
1. Add **Holly Rees** to the list of members and then select **Next**.
1. Select **Review + Assign**.

## Test the Reader role

1. In the top-right of the Azure portal, select your user account and then select **Sign out**.
1. Sign in as the new user, with the user principal name that you noted and the password **Pa$$w0rd**. Replace the default password if you're prompted to and make a note of the new one.
1. In the portal home page, select **All resources** and then select your Azure Database for PostgreSQL resource.
1. Select **Stop**. An error is displayed, because the Reader role enables you to see the resource but not change it.

## Assign the Contributor role

1. In the top-right of the Azure portal, select Holly's user account and then select **Sign out**.
1. Sign in using your original Owner account.
1. Navigate to your Azure Database for PostgreSQL resource, and then select **Access Control (IAM)**.
1. Select **+ Add** and then select **Add role assignment**.
1. Select the **Contributor** role, and then select **Next**.
1. Add **Holly Rees** to the list of members and then select **Next**.
1. Select **Review + Assign**.
1. Select **Role Assignments**. Holly Rees now has assignments for both Reader and Contributor roles.

## Test the Contributor role

1. In the top-right of the Azure portal, select your user account and then select **Sign out**.
1. Sign in as the Holly Rees, with the user principal name and password that you noted.
1. In the portal home page, select **All resources** and then select your Azure Database for MySQL resource.
1. Select **Stop** and then select **Yes**. This time, the server stops without errors because Holly has the necessary role assigned.
1. Select **Start** to ensure that the MySQL resource is ready for the next steps.
1. In the top-right of the Azure portal, select Holly's user account and then select **Sign out**.
1. Sign in using your original Owner account.

## GRANT access to Azure Database for PostgreSQL

1. Open Azure Data Studio and connect to your Azure Database for PostgreSQL server.
1. In the query pane, execute this code. Twelve user roles should be returned, including the **demo** role that you're using to connect:

    ```SQL
	SELECT rolame FROM pg_catalog.pg_role;
	```

1. To create a new role, execute this code

    ```SQL
	CREATE ROLE dbuser WITH LOGIN NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION PASSWORD 'Pa$$w0rd';
    GRANT CONNECT ON DATABASE zoodb TO dbuser;
	```
	
1. To list the new role, execute the above SELECT query again. You should see the **dbuser** role listed.
1. To enable the new role to query and modify data in the **animal** table in the **zoodb** database, execute this code:

    ```SQL
	GRANT SELECT, INSERT, UPDATE, DELETE ON animal TO dbuser;
	```

## Test the new role

1. In Azure Data Studio, in the list of **CONNECTIONS** select the new connection button.
1. In the **Connection type** list, select **PostgreSQL**.
1. In the **Server name** textbox, type the fully qualified server name for your Azure Database for PostgreSQL resource. You can copy it from the Azure portal.
1. In the **Authentication type** list, select **Password**.
1. In the **Username** textbox, type **dbuser** and in the **Password** textbox type **Pa$$w0rd**.
1. Select the **Remember password** checkbox and then select **Connect**.
1. Select **New query** and then execute this code:

    ```SQL
	SELECT * FROM animal;
	```

1. To test whether you have the UPDATE privilege, execute this code:

    ```SQL
    UPDATE animal SET name = 'Linda Lioness' WHERE ani_id = 7;
	SELECT * FROM animal;
	```

1. To test whether you have the DROP privilege, execute this code. If there's an error, examine the error code:

    ```SQL
	DROP TABLE animal;
	```

1. To test whether you have the GRANT privilege, execute this code:

    ```SQL
    GRANT ALL PRIVILEGES ON animal TO dbuser;
	```

These tests demonstrate that the new user can execute Data Manipulation Language (DML) commands to query and modify data but can't use Data Definition Language (DDL) commands to change the schema. Also, the new user can't GRANT any new privileges to circumvent the permissions.
