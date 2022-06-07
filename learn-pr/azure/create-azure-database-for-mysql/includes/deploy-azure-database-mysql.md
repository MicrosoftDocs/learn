Now that you’ve reviewed the deployment and connectivity options of Azure Database for MySQL, you want to test the process of provisioning a server and validate its availability by connecting to it. In this unit, you’ll step through a sample deployment and connect to the server by using the mysql.exe utility from the Azure Cloud Shell.

> [!NOTE]
> You might incur costs in your Azure Subscription when you run this exercise.

### Deploy Azure Database for MySQL Flexible Server

Use the following procedure to deploy an Azure Database for MySQL Flexible Server from the Azure portal:

1. Navigate to the Azure portal for the sandbox

   > [!div class="nextstepaction"]
   > [Azure portal for the sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)

2. Use the **Search resources, services, and docs** text box to search for and select **Azure Database for MySQL**.

3. On the **Azure Database for MySQL servers** page, select **Create**.

4. On the **Select Azure Database for MySQL deployment option** page, select **Flexible Server** as the deployment option.

5. On the *Flexible Server** page, on the **Basics** tab, enter the information in the following table.

   | **Setting**                  | **Value**                          | **Description**                                              |
   | ---------------------------- | ---------------------------------- | ------------------------------------------------------------ |
   | **Subscription**             | The name of  your subscription     | Enter the name  of the Azure subscription that you want to use for your server. |
   | **Resource group**           | <rgn>[sandbox resource group name]</rgn> | Use the LEARN created resource group available. |
   | **Server name**              | <server_name>                      | Enter any  valid and globally unique name that will identify your Flexible Server. The fully  qualified name of the server consists of this name followed by the suffix mysql.database.azure.com.  The server name can contain only lowercase letters, numbers, and the hyphen  (-) character. It must contain between 3 and 63 characters. |
   | **Region**                   | The name of  an Azure region       | Enter the name  of the Azure region that will host your server. Select any region that  supports Azure Database for MySQL Flexible Server deployment, and that is close  to the location of the computer you use to run this exercise. |
   | **MySQL version**            | 8.0                                | Enter the MySQL  major version your app will be using.       |
   | **Workload type**            | For  development or hobby projects | Enter the  intended workload type, which determines the VM SKU to host the server. |
   | **Availability zone**        | No preference                      | This is the  setting that allows you to specify an availability zone where the server will  be deployed. Your choice is typically based on the zone hosting the  application tier. |
   | **Enable high availability** | Not selected                       | This is the  setting that determines whether you want to have a replica server  automatically provisioned in another availability zone (for zonal  deployments). This option requires the choice of either **General Purpose** or **Business Critical** VM SKUs  compute tier). |
   | **Admin username**           | <server_name>                      | Enter any  valid user name, which will be configured as the admin account for the MySQL  server instance. Do not use azure_superuser, admin, administrator, root,  guest, or public. |
   | **Password**                 | <server_name>                      | Enter any  valid password that is assigned to the admin account. It must contain between  8 and 128 characters, and include characters from three of the following  categories: English uppercase letters, English lowercase letters, numbers (0  through 9), and non-alphanumeric characters (such as !, $, #, %). |

6. On the **Basics** tab, select the **Configure server** link.

7. On the **Compute + Storage** page, configure the following settings, and then select **Save**:

   a. From the **Compute** **size** drop-down list, select **Standard_B1s (1 vCore, 1 GiB memory, 400 max iops)**.

   b. Leave the **Storage size (in GB)** set to **20**.

   c. Leave the value of **IOPS** set to **360**.

   d. Ensure that the **Backup retention period (in days)** is set to **7**.

   e. Clear the **Recover from regional outage or disaster** checkbox.

8. On the **Compute + Storage** page, select **Save**.

9. On the **Basics** tab of the **Flexible Server** page, select **Next: Networking >**.

10. On the **Networking** tab of the **Flexible Server** page, configure the following settings:

    a. Ensure that **Connectivity method** is set to **Public access (allowed IP address)**.

    b. Select the **Allow public access from any Azure service within Azure to this server** checkbox.

    c. Select the **+ Add current client IP address** link.

11. On the **Networking** tab of the **Flexible Server** page, select **Review + create**.

12. On the **Review + create** page, review the settings you configured, and then select **Create**.

13. Wait for the provisioning process to complete. This might take about 10 minutes.

14. When the deployment is complete, on the **Overview** page, select **Go to resource** to navigate to the page for the newly deployed Azure Database for MySQL Flexible Server.

15. On the Azure Database for MySQL Flexible Server page, in the navigation menu, in the **Settings** section, select **Databases**, and then select **Add**.

16. In the **Create database** pane, in the **Name** text box, enter **testdb**, accept the default character set and collation values, and then select **Save**.

> [!NOTE]
> Retain the resources you deployed in Task 1 because you’ll use them Task 2 also.
