Having a general understanding of Azure Database for MySQL - Flexible Server capabilities can help you identify the optimal deployment settings for your web-based application's development, testing, and production environments. Key decisions, such as selecting the target Azure region, zone-redundant high availability, and backup redundancy, should be made during the design stage. Other decisions, like the allocation of compute and storage resources, are driven by usage patterns that typically change over time. The previous units of this module should aid in your design and planning phase. Now, we'll focus on how to deploy and connect to your Azure Database for MySQL – Flexible Server when you are ready to implement it in your own solutions.

Understanding the dependencies between various configuration settings is key to making the right choices during the deployment process. Specifically, it's important to note:

- Disabling storage auto-grow isn't supported for servers with high availability enabled.
- High availability isn't supported in the Burstable tier, although you can also deploy the server into a specific availability zone.

> [!NOTE]
> After deploying a server with public or private access (via VNet integration), you cannot modify the connectivity mode. But in public access mode, you can enable or disable private endpoints as required and also disable public access if needed.

### How to deploy an Azure Database for MySQL Flexible Server

You can use several different methods to provision an Azure Database for MySQL flexible server. While you can use fully automated deployments, the most straightforward deployment is by creating an instance via the Azure portal, a graphical user interface (GUI). When you create an instance via the portal, you can configure a range of server settings, which can be divided into four groups: Basics, Compute and storage, Networking, Security, and Tags. Each group and its corresponding settings options are presented on its own page:

- The **Basics** page includes settings that you can use to configure:

  - Project details. The name of the target subscription and resource group.

  - Server details. The name of the server, target Azure region, the MySQL version, the compute tier, and the number of the availability zone.

    ![Screenshot of the Project and Server details sections of the Basics Azure portal Flexible Server deployment page.](../media/3-deploy-mysql-project-server-details.png)

  - Authentication method. Select either MySQL authentication, Microsoft Entra ID authentication, or a mix of the two methods.

> [!NOTE]
> The availability zone selection might not be available during this step, depending on your selected compute size and region.

- The **Compute + storage** page, which you access from the **Basics** page via the **Configure server** link, includes settings that you can use to configure:

  - Compute. The compute tier and compute size options.

  - Storage. The storage size (in GiB), the number of IOPS (or auto scale), and the Storage Auto-growth option.

    ![Screenshot of the Compute and Storage sections of the Compute + Storage Azure portal Flexible Server deployment page.](../media/3-deploy-mysql-compute-and-storage.png)

  - High availability. The high availability mode (same zone or zone redundant).

    ![Screenshot of the High availability section of the Basics Azure portal Flexible Server deployment page.](../media/3-deploy-mysql-high-availability.png)

  - Backups. The backup retention period and the backup geo-redundancy option.

    ![Screenshot of the High availability and Backups sections of the Compute + Storage Azure portal Flexible Server deployment page." border.](../media/3-deploy-mysql-high-availability-backups.png)

- The **Networking** page allows you to specify the connectivity method. Depending on your choice, you can also allow public access from any Azure service, configure firewall rules, set up VNet integration, or create private endpoints.

   ![Screenshot of the Network connectivity tab displaying the options for the connectivity method, firewall rules, and more.](../media/3-mysql-network-connectivity-firewall-rules.png)

- The **Security** page includes options to configure data encryption to encrypt your databases, backups, and logs at rest without any changes to your application, in addition to the storage encryption that is configured by default.

- The **Tags** page, which you can use to add key-value pairs that define metadata for the deployed resource.

### How to connect to an Azure Database for MySQL flexible server

Before you attempt to connect to your flexible server, consider the network configuration you implemented during deployment. For example, if your flexible server is configured with public access and you decide to connect from the Azure Cloud Shell or other client applications that don't have direct network access to the database, then enable the **Allow public access from any Azure service within Azure to this server** option of the server firewall. When connecting from an on-premises application server or an internet-connected device, add the public IP address of the connecting device or service to the list of firewall exceptions.

For secure connections from Azure VMs or containerized workloads running in Azure, consider enabling private endpoints. Private endpoints allow you to connect securely to your flexible server over a private network, eliminating exposure to the public internet. Additionally, ensure that the network you're connecting from allows outbound traffic to Azure over TCP port 3306, which is required by an Azure Database for MySQL flexible server.

> [!NOTE]
> After deploying a server with public or private access (via VNet integration), you cannot modify the connectivity mode. But in public access mode, you can enable or disable private endpoints as required and public access if needed.

Because encryption is enabled by default for new deployments, you'll need to [download the public certificate](https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem) installed on the server and use it when establishing a connection over TLS 1.2.

After you address the networking and certificate requirements, you should be able to connect to the Azure Database for MySQL flexible server and query it in several different ways, including using:

- Azure CLI (az mysql) or Azure Cloud Shell
  - Use the following command format in Azure CLI to connect:
    `az mysql flexible-server connect --name <server-name> --user <username>@<server-name>`

- mysql.exe command line utility
  - Use the following command format in the MySQL command-line tool to connect:
    `mysql -h <server-name>.mysql.database.azure.com -u <username>@<server-name> -p`

- MySQL Workbench graphical tool
  - Use the following connection details in the MySQL Workbench graphical tool:
    - **Hostname**: `<server-name>.mysql.database.azure.com`
    - **Port**: 3306
    - **Username**: `<username>@<server-name>`
    - **Password**: `<your-password>`

- Azure Data Studio with the MySQL extension
  - Launch Azure Data Studio and make sure the MySQL extension is installed
  - Select the New Connection icon or navigate to File > New Query
  - In the connection dialog, select MySQL as the Connection Type
  - Fill in Connection Details:
    - **Server Name**: <server-name>.mysql.database.azure.com
    - **Username**: <username>@<server-name>
    - **Password**: <your-password> - Alternatively, you can login through Microsoft Entra ID authentication.
    - **Port**: 3306
    - **Database Name** (Optional): Specify a specific database name to connect to, or leave blank to list all databases
  - SSL Mode:
    - Select Require or Verify CA
    - [Download the SSL certificate](https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem) if using Verify CA mode
  - Select **Test Connection** to ensure that all details are correct
  - Optionally, you can save the connection details for future use by selecting **Save Password**
  - Select **Connect** to establish the connection to your Azure Database for MySQL server

- Many programming languages, such as Python, PHP, C#, C++, Java, JavaScript, Rust, Go, and Ruby.

Here's a basic example of connecting Azure Database for MySQL – Flexible Server using Python's `mysql-connector` library:

```python
import mysql.connector

conn = mysql.connector.connect(
    host="<server-name>.mysql.database.azure.com",
    user="<username>@<server-name>",
    password="<your-password>",
    database="<database-name>",
    ssl_ca="path/to/BaltimoreCyberTrustRoot.crt.pem"
)

cursor = conn.cursor()
cursor.execute("SELECT DATABASE()")
result = cursor.fetchone()
print(f"Connected to database: {result}")

cursor.close()
conn.close()
```

> [!NOTE]
> For more information about connecting to Azure Database for MySQL Flexible Server programmatically, see [Microsoft Learn](/?azure-portal=true).
