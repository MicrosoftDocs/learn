In this exercise you will create an Azure Database for MySQL single server, and then create an Azure AD admin user and configure the server for Azure AD authentication.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

## Create an Azure Database for MySQL single server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for MySQL**, select **Create**.
1. Under **Choose a deployment option to create a MySQL server**, select the **Resource type** dropdown box to view the options. Select **Single server**. Select **Create**.
1. On the **Basics** tab, enter each field as follows:
    1. **Subscription** - your subscription.
    1. **Resource group** - MyFlex_nnn.
    1. **Server name** - mysql-singnnn (replace nnn with random numbers).
    1. **Data source** - None.
    1. **Location** - select the same region as the resource group.
    1. **MySQL version** - select 8.0.
    1. **Workload type** - for development or hobby projects.
    1. **Compute + storage** - select **Configure Server** and select **Basic**. Reduce the storage to **5GB** and select **OK**.
    1. **Availability zone** - No preference.
    1. **High availability** - leave unchecked.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Review + create**, and then select **Create**. The Azure Database for MySQL single server is created.

When the deployment is complete, select **Go to resource**.

1. Under **Settings**, select **Connection security**. The Firewall rules blade is displayed.
    - Under Firewall rules, select **+ Add current client IP address**. This adds your current IP address as a firewall rule. Optionally name the firewall rule.
1. Select **Save**.

## Create an Azure AD admin user

1. In the Azure portal, navigate to your Azure Database for MySQL single server.
1. From the left menu, under **Settings**, select **Active Directory Admin**.
1. From the top menu select **Set admin**, and a list of Active Directory users and groups is displayed.
1. Select an **Azure Active Directory user** to be the Azure Active Directory administrator, and then select **Select**.
1. The Active Directory admin is displayed in a list. This creates a new user to the Azure Database for MySQL server, with full administrator permissions.

> [!NOTE]
> Only one Azure AD admin user can be created for each Azure Database for MySQL server. If you select another user, this will replace the existing Azure AD admin.

## Obtain an access token

To obtain an Azure AD access token:

1. Sign in to the Azure portal using the Azure AD admin user credentials.
1. Select **Cloud Shell** from the top menu. In the Cloud Shell pane, select PowerShell. (You can also use Bash, but this example uses PowerShell.)
1. If you have no storage, a message is displayed to create storage. If necessary, provide the necessary details, and select **Create Storage**.
1. To obtain an access token and store it in a variable, enter:

    ```sql
    $accessToken = Get-AzAccessToken -ResourceUrl https://ossrdbms-aad.database.windows.net
    ```

1. Type the name of the variable to display the access token:

    ```sql
    $accessToken
    ```

1. Inspect the contents of the token, particularly the expiry time.
1. To display the token property, enter:

    ```sql
    $accessToken.Token
    ```

1. You can now use the token (before it expires) in a client tool, such as MySQL Workbench.

## Connect using the token

To connect to MySQL Workbench, using the token you have just created:

1. In MySQL Workbench, select **Database**, and then **Connect to Database**.
1. Select **Store in Vault**. In the Password field, paste the access token copied from **$accessToken.Token**.
1. Select the **Advanced** tab and then select **Enable Cleartext Authentication Plugin**.
1. Select **OK** to connect to the database.

Congratulations! You have created an Azure Access token and used it to connect to Azure Database for MySQL single server.
