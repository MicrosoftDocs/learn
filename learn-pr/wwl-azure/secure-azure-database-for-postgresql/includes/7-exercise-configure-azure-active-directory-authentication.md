In this exercise you'll create an Azure Database for PostgreSQL single server, and then create an Azure AD admin user and configure the server for Azure AD authentication.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

## Create a resource group

1. In the Azure portal, under Azure services, select **Resource groups**.
1. In Resource groups, select **+ Create**.
1. Select your subscription.
1. In resource groups, enter **PostgresAzureAD**.
1. In region, select a **region** close to you.
1. Select **Review + create**.
1. Select **Create**.

## Create an Azure Database for PostgreSQL single server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for PostgreSQL**, select **Create**.
1. Under **Choose a deployment option to create a PostgreSQL server**, select the **Resource type** dropdown box to view the options. Select **Single server**. When the message box appears, select **No - Create Single server**.
1. On the **Basics** tab, enter each field as follows:
    1. **Subscription** - your subscription.
    1. **Resource group** - PostgresAzureAD.
    1. **Server name** - postsinglennn (replace nnn with random numbers).
    1. **Data source** - None.
    1. **Location** - select the same region as the resource group, or a location close to you.
    1. **PostgreSQL version** - select **11**.
    1. **Compute + storage** - General Purpose.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Review + create**, and then select **Create**. The Azure Database for PostgreSQL single server is created.

When the deployment is complete, select **Go to resource**.

1. Under **Settings**, select **Connection security**. The Connection security section is displayed.
    1. Under Firewall rules, select **+ Add current client IP address**. This adds your current IP address as a firewall rule. Optionally name the firewall rule.
1. Select **Save**.

You've now created an Azure Database for PostgreSQL single server.

## Create the Azure AD admin user

Before configuring Azure Active Directory authentication, you must first create an Azure AD admin user. Each Azure Database for PostgreSQL single server can have only one Azure AD admin user.

To create an Azure AD admin user:

1. In the Azure portal, navigate to your Azure Database for PostgreSQL single server.
1. From the left menu, under **Settings**, select **Active Directory admin**.
1. From the top menu select **Set admin**, and a list of Active Directory users and groups is displayed.
1. Select **yourself** as the **Azure Active Directory user** to be the Azure Active Directory administrator, and then select **Select**.
1. The Active Directory admin is displayed. This user has full administrator permissions.
1. Select **Save**.

> [!IMPORTANT]
> Remember to select **Save**, otherwise the Azure Active Directory administrator will not be set.

Setting the administrator adds a new user to the Azure Database for PostgreSQL server with full administrator permissions. The Azure AD Admin user has the role **azure_ad_admin**.

Only one Azure AD admin can be created, and another selection will overwrite the existing Azure AD admin. Specify an Azure AD group if you want to have multiple administrators. If you specify a group, you'll then sign in with the group name for administration purposes.
:::image type="content" source="../media/active-directory-admin.png" alt-text="Screenshot showing the PostgreSQL single server Active directory admin page." lightbox="../media/active-directory-admin.png":::

## Obtain an access token

To obtain an Azure AD access token:

1. Sign in to the Azure portal using the Azure AD admin user credentials.
1. Select **Cloud Shell** from the top menu. In the Cloud Shell pane, select **PowerShell**. (You can also use Bash, but this example uses PowerShell.)
1. If you've no storage, a message is displayed to create storage. If necessary, provide the necessary details, and select **Create Storage**.
1. To get an access token, enter:

    ```sql
    az account get-access-token -resource-type oss-rdbms
    ```

    Azure AD will return an access token.

1. Inspect the contents of the token, particularly the expiry time. The token is a Base 64 string that encodes all the information about the authenticated user, targeted to the Azure Database for PostgreSQL service.
1. To display the token property, enter:

    ```sql
    $accessToken.Token
    ```

1. You can now use the token (before it expires) in a client tool, such as pgAdmin or psql.
    :::image type="content" source="../media/access-token.png" alt-text="Screenshot showing the $accessToken.Token value page." lightbox="../media/access-token.png":::

> [!IMPORTANT]
> Delete the Azure Database for PostgreSQL single server when you have finished this exercise. You cannot STOP a single server, and you'll be charged for the server until you delete it.

Congratulations! You've created an Azure Access token for use with a PostgreSQL admin tool that doesn't recognize Azure AD, such as pgAdmin or psql.

In the next section you'll sign in to Azure Data Studio, using the Azure AD account WITHOUT a token. Azure Data Studio does recognize Azure AD and will accept account credentials. This is more convenient than using a token.

## Sign in to Azure Data Studio

1. Open Azure Data Studio and select **New Connection**, or **Add Connection**, which appears when there are no existing connections.
1. In Connection details, in Connection type select **PostgreSQL**.
1. In server name, copy the name of your single server from the Azure portal.
1. In Authentication type, select **Azure Active Directory**.
1. In user name, enter \<youradmin\>@\<yourdomain\>@\<**postsinglennn\>**
    1. Replace \<youradmin\> with the user name assigned as Azure AD admin
    1. Replace with your server name with the PostgreSQL single server you created.
1. In Azure AD tenant, select your Azure AD tenant.
1. In account, from the dropdown list select **Add an account**. Select the Azure AD admin user you assigned earlier (yourself). If a sign in box appears - sign in with the relevant account details.
1. Select **Connect**.

    :::image type="content" source="../media/connection-details.png" alt-text="Screenshot of the Connection Details page." lightbox="../media/connection-details.png":::

Congratulations! You're now connected to the PostgreSQL single server you created, using Azure AD credentials.
