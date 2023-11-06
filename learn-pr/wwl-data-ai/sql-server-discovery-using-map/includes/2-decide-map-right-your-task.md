**SQL Server Management Studio (SSMS)** and **Microsoft Assessment and Planning (MAP)** are tools you use to manage your SQL Server estate. 

Suppose you're a newly hired database administrator for a large company with SQL Server instances across multiple sites. To learn more about these instances, you've started manually connecting to each SQL Server. It's taking too long to gather all the information you require. Your manager says there's no budget for purchasing third-party software to help with this task until the next financial year begins, which is months away.

You want a free tool that's easy to learn, but automates the process of auditing your environment. Ideally, it should be something you'll share with members of the operations team. The team can then quickly discover the hardware on the database servers, and apply appropriate upgrades.

In this unit, you'll look at the two options you can use to investigate SQL Server instances and information about the databases running on them. Then you'll be equipped to make the right decision on which tool to use.

## What tools are available?

With no option to purchase auditing software, you can continue to manually connect to each server and gather the information, or you could use the free Microsoft Assessment and Planning (MAP) toolkit.

To manually connect to each server and gather data on the underlying hardware, you need to use a remote desktop connection (RDP). You then use SQL Server Management Studio (SSMS) to connect to the SQL Server instances and discover the version and edition, databases, and logins. You can find out some information by executing the Transact-SQL statement:

```sql
SELECT @@VERSION
```

Different SQL Server versions return this information in varying formats, preventing you from gathering consistent metadata about all your SQL Servers. Also, you'll need to run a script against each server to return a list of user databases and logins. You might discover other components on the server, such as SQL Server Integration Services (SSIS), SQL Server Reporting Services (SSRS), or SQL Server R Services.

You'd need to save this data to a spreadsheet or another document. If you want to create visualizations in Power BI for management reports, you might decide to store this data in a database. The database would prevent multiple versions appearing when it's shared with others. Maintaining this list would mean adding tasks to an already tedious process, with added opportunities for human error.

You could automate the process by building a system of SQL Agent jobs and SSIS packages. These packages would run scheduled jobs to query each server and store the results in a database, allowing you to generate reports with SSRS. This solution would obviously come at the cost of designing, building, testing, and maintaining it.

## What is the Microsoft Assessment and Planning toolkit?

The MAP toolkit automates the gathering and reporting of all database instances across your network. You need only supply credentials to each server once, as they're stored for later use. Connect MAP to an instance, and it takes an inventory of the database instance and server hardware. You use this information for managing upgrades, consolidating databases, and ensuring you have the required components installed on an instance.

The reporting tool graphically displays aggregations of instances by edition, allowing you to quickly see how many versions are unsupported or are about to expire. You'll also see how many components such as **Data Quality Services (DQS)** or **Master Data Services (MDS)** are installed. The summary of editions makes it easy to see how your servers are licensed. You can potentially improve performance by finding editions with advanced features not being used.

The export feature lets you copy the inventory to Excel. You can then analyze the full instance and hardware configuration on each server in detail. The assessment report allows you to compare these properties across all the audited servers:

- SQL Server version
- Service pack
- Operating system version
- System memory
- Processors
- Cores

You then dive into the database count on each server, the data and log file sizes, and counts of tables, views, and stored procedures. The reports also detail users and logins for each database, and the roles to which each user belongs.

In practice, many DBAs hold informal lists of SQL Server instance configuration settings in Excel files that become neglected and overlooked. This neglect is often because of the time and effort required to manually complete a full audit.

The MAP toolkit quickly discovers all the information you need to know about an instance. This toolkit helps you plan upgrades, database-consolidation operations, licensing checks, and security audits. Reporting prevents the need to maintain files where inventory information is held, as reports can be rapidly regenerated as required.

### Prepare for the exercises

You'll be using a virtual machine in later exercises. Run these commands to set up the machine so you can connect to it:

1. In the Cloud Shell, create a VM: 

    ```azurecli
    PASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name ReportingServer \
        --image "MicrosoftWindowsDesktop:windows-ent-cpc:win11-22h2-ent-cpc-m365:22621.1105.230110" \
        --size Standard_D2s_v3 \
        --admin-username azureadmin \
        --admin-password $PASSWORD \
        --nsg-rule RDP \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    echo $PASSWORD
    ```

1. Make a note of this password; you'll need it to connect to the VM in the exercises.
1. Open the RDP port to allow you to connect with an RDP.

    ```azurecli
    az vm open-port \
        --port 3389 \
        --name ReportingServer \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    ```
