Now that you’ve reviewed the deployment and connectivity options of Azure Database for MySQL, you want to test the process of provisioning a server and validate its availability by connecting to it. In this unit, step through a sample deployment and connect to the server by using the mysql.exe utility from the Azure Cloud Shell.

### Deploy an Azure Database for MySQL flexible server

Use the following procedure to deploy an Azure Database for MySQL flexible server from the Azure portal:

1. Navigate to the Azure portal for the sandbox

   > [!div class="nextstepaction"]
   > [Azure portal for the sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)

2. Use the **Search resources, services, and docs** text box at the top of the page to search for *MySQL* and select **Azure Database for MySQL flexible servers**.

3. On the **Flexible server** page, on the **Basics** tab, enter the information in the following table.

   | **Setting**                  | **Value**                                | **Description**                                              |
   | ---------------------------- | ---------------------------------------- | ------------------------------------------------------------ |
   | **Subscription**             | Concierge Subscription                   | The name of your subscription. In this case, we're using the *Concierge Subscription*. |
   | **Resource group**           | <rgn>[sandbox resource group name]</rgn> | Use the LEARN created resource group available.              |
   | **Server name**              | <server_name>                            | A valid and globally unique name that identifies your flexible server. The server's fully qualified name consists of the <server_name> you choose, followed by the suffix mysql.database.azure.com. The server name can contain only lowercase letters, numbers, and the hyphen (-) character. It must contain between 3 and 63 characters.                                                                                                |
   | **Region**                   | The name of an Azure region              | The name of the Azure region that hosts your server. Select any region that supports Azure Database for MySQL Flexible Server deployment, close to the location of the computer you use to run this exercise.          |
   | **MySQL version**            | 8.0                                      | The MySQL major version your app uses.        |
   | **Workload type**            | For development or hobby projects        | The intended workload type, which determines the VM SKU to host the server. |
   | **Availability zone**        | No preference                            | This setting allows you to specify an availability zone where the server's deployed. Your choice is typically based on the zone hosting the application tier. |
   | **Enable high availability** | Not selected                             | This setting determines whether you want to have a replica server automatically provisioned in another availability zone (for zonal deployments). This option requires the choice of either **General Purpose** or **Business Critical** VM SKUs compute tier). |
   | **Admin username**           | mysqladmin                               | A valid user name, which you configure as the admin account for the MySQL server instance. In this case, we're using *mysqladmin*. Don't use azure_superuser, admin, administrator, root,  guest, or public.                                                                   |
   | **Password**                 | Passw0rd123                              | A valid password assigned to the admin account. In this case, we're suing *Passw0rd123*. It must contain between 8 and 128 characters and include characters from three categories: English uppercase letters, English lowercase letters, numbers (0 through 9), and non-alphanumeric characters (such as ! $, #, %). |

4. On the **Basics** tab, under **Compute + Storage**, select **Configure server**.

5. On the **Compute + Storage** page, configure the following settings, and then select **Save**:
    1. **Compute**
        1. From the **Compute** **size** drop-down list, select **Standard_B1s (1 vCore, 1 GiB memory, 400 max iops)**.
    1. **Storage**
       1. Leave the **Storage size (in GB)** set to **20**.
       2. Select **Pre-provisioned IOPS** and leave the value set to **360**.
       3. Leave **Storage Auto-growth** checked.
    1. **High Availability**
       1. Leave **Enable High Availability** as not selected.
    1. **Backups**
       1. Ensure that the **Backup retention period (in days)** is set to **7**.
       2. Leave the **Recover from regional outage or disaster** as not selected.

6. On the **Basics** tab of the **Flexible server** page, select **Next: Networking >**.

7. On the **Networking** tab of the **Flexible server** page, configure the following settings:

    a. Ensure that **Connectivity method** is set to **Public access (allowed IP address)**.

    b. Select the **Allow public access from any Azure service within Azure to this server** checkbox.

    c. Select the **+ Add current client IP address** link.

8. Select **Review + create**.

9. On the **Review + create** page, review the settings you configured, and then select **Create**.

    > [!NOTE]
    > Wait for the provisioning process to complete. This might take about 10 minutes.

10. After the deployment is complete, select **Go to resource** to navigate to the page for the newly deployed Azure Database for MySQL flexible server.

11. On the page for Azure Database for MySQL flexible server page, in the navigation menu, in the **Settings** section, select **Databases**, and then select **Add**.

12. In the **Create database** pane, in the **Name** text box, enter **testdb**, accept the default character set and collation values, and then select **Save**.

> [!NOTE]
> You will use the resources you deployed in this exercise for the next exercise.
