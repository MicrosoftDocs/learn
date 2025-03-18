In these lab exercises, you will assign RBAC roles to control access to Azure Database for MySQL resources and MySQL GRANTS to control access to database operations.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

To complete these exercises, you must have:

- Created a resource group (see Module 1, Unit 5).
- Created an Azure Database for MySQL Flexible Server (see Module 1, Unit 5).
- Downloaded and installed MySQL Workbench (see Module 2, Unit 5).
- Created the **zoodb** database (see Module 2, Unit 5).

> [!TIP]
> If you stopped your Azure Database for MySQL server after completing the last lab, restart it now.

<a name='create-a-new-user-account-in-azure-active-directory'></a>

## Create a new user account in Microsoft Entra ID

1. In the [Azure portal](https://portal.azure.com), sign in using an Owner account and navigate to your Microsoft Entra ID.
1. Under **Manage**, select **Users**.
1. At the top-left, select **New user** and then select **Create new user**.
1. In the **New user** page, enter these details and then select **Create**:
    - **Username:** Holly
    - **Name:** Holly Rees
    - **Password:** Select **Let me create password** and then type **Pa$$w0rd**.

    > [!TIP]
	> When the user is created, make a note of the full **User principal name** so that you can use it later to log in.

## Assign the Reader role

1. In the Azure portal, select **All resources** and then select your Azure Database for MySQL resource.
1. Select **Access control (IAM)** and then select **Role assignments**. Holly Rees doesn't appear in the list.
1. Select **+ Add** and then select **Add role assignment**.
1. Select the **Reader** role, and then select **Next**.
1. Add **Holly Rees** to the list of members and then select **Next**.
1. Select **Review + Assign**.

## Test the Reader role

1. In the top-right of the Azure portal, select your user account and then select **Log out**.
1. Log in as the new user, with the user principal name that you noted and the password **Pa$$w0rd**. Replace the default password if you are prompted to and make a note of the new one.
1. In the portal home page, select **All resources** and then select your Azure Database for MySQL resource.
1. Select **Stop**. An error is displayed, because the Reader role enables you to see the resource but not change it.

## Assign the Contributor role

1. In the top-right of the Azure portal, select Holly's user account and then select **Log out**.
1. Log in using your original Owner account.
1. Navigate to your Azure Database for MySQL resource, and then select **Access Control (IAM)**.
1. Select **+ Add** and then select **Add role assignment**.
1. Select the **Contributor** role, and then select **Next**.
1. Add **Holly Rees** to the list of members and then select **Next**.
1. Select **Review + Assign**.
1. Select **Role Assignments**. Holly Rees now has assignments for both Reader and Contributor roles.

## Test the Contributor role

1. In the top-right of the Azure portal, select your user account and then select **Log out**.
1. Log in as the Holly Rees, with the user principal name and password that you noted.
1. In the portal home page, select **All resources** and then select your Azure Database for MySQL resource.
1. Select **Stop** and then select **Yes**. This time, the server stops without errors because Holly has the necessary role assigned.
1. Select **Start** to ensure that the MySQL resource is ready for the next steps.
1. In the top-right of the Azure portal, select Holly's user account and then select **Log out**.
1. Log in using your original Owner account.

## GRANT access to Azure Database for MySQL

1. Open MySQL Workbench and connect to your Azure Database for MySQL server.
1. In the query pane, execute this code. Six user accounts should be returned, including the **demo** account that you're using to connect:

    ```SQL
	SELECT user, host FROM mysql.user;
	```

1. To create a new user, execute this code

    ```SQL
	CREATE USER 'dbuser'@'%' IDENTIFIED BY 'Pa$$w0rd';
	```
	
1. To list the new user, execute the above SELECT query again. You should see the **dbuser@%** user listed.
1. To enable the new user to query and modify data in all tables in the **zoodb** database, execute this code:

    ```SQL
	GRANT SELECT, INSERT, UPDATE, DELETE ON zoodb.* TO 'dbuser'@'%';
	FLUSH PRIVILEGES;
	```

## Test the new user

1. In MySQL Workbench, on the **Database** menu, select **Manage Connections**.
1. Select the existing connection to Azure Database for MySQL, and then select **Duplicate**.
1. In the duplicated connection, in the **Username** textbox, type **dbuser**.
1. Next to **Password**, select **Store in Vault**.
1. In the **Password** textbox, type **Pa$$w0rd** and then select **OK**.

    :::image type="content" source="../media/new-user-connection.png" alt-text="Screenshot showing the new user account in the Manage Connections dialog in MySQL Workbench." lightbox="../media/new-user-connection.png":::

1. Select **Test Connection**. If the connection is successful, select **OK** and then select **Close**.
1. On the **Database** menu, select **Connect to Database**.
1. In the **Connect to Database** dialog, select the new connection, and then select **Connect**.
1. To test whether you have the SELECT privilege, in the query window, execute this code:

    ```SQL
	SELECT * FROM animal;
	```

1. To test whether you have the UPDATE privilege, execute this code:

    ```SQL
	UPDATE animal SET Name = "Linda Lioness" WHERE AnimalID = "6";
	SELECT * FROM animal;
	```

1. To test whether you have the DROP privilege, execute this code. If there is an error, examine the error code:

    ```SQL
	DROP TABLE animal;
	```

1. To test whether you have the GRANT privilege, execute this code:

    ```SQL
	GRANT ALL PRIVILEGES ON zoodb.* TO 'dbuser'@'%';
	```

These tests demonstrate that the new user can execute Data Manipulation Language (DML) commands to query and modify data but can't use Data Definition Language (DDL) commands to change the schema. Also, the new user can't GRANT any new privileges to circumvent the permissions.
