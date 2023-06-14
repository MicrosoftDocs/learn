You should install and run the **Microsoft Assessment and Planning (MAP)** application on your local machine instead of on SQL or production servers. 

As the newly hired database administrator, you've learned there's no current inventory of the company's SQL Server instances. You've chosen the MAP toolkit to help automate the process of completing a full inventory. You'll need to know how to install the toolkit on your local machine. While you complete your investigation, you'll check for any install considerations of which you need to be aware.

In this unit, you'll look at the steps you need to take to successfully install the MAP toolkit.

## What must be installed?

When you're ready to download the MAP toolkit, you can choose to download:

- MapSetup.exe
- MAP_Sample_Documents.zip
- MAP_Training_Kit.zip
- read_me.htm

At a minimum, you require **MapSetup.exe**. When installing the MAP toolkit, the default option is to use a local database for storing the inventory and assessment data. A copy of SQL Server 2012 Express is installed for this purpose.

If you want to install the toolkit using your own SQL Server instance, create a non-default instance named **MAPS** before you run the installer on SQL Server 2008, SQL Server 2008 R2, or SQL Server 2012. The database engine collation should be configured to **SQL_Latin1_General_CP1_CI_AS**.

The **MAP Sample Documents** are useful for showing the potential data you can gather. For example, if members of your operations team want to adopt the toolkit, give them sample files to show what data is gathered in the inventory. This action might help them to see the benefits across your whole organizational infrastructure. MAP can provide audit information on, for example:

- Exchange Server usage
- Microsoft 365
- Remote desktop licensing
- SharePoint server usage

For SQL Server, the sample files included in the download offer an overview of how you can assess your landscape after the toolkit has done a network-wide inventory.

The **MAP Training Kit** allows you to familiarize yourself with the tool before running it against any production servers. It includes a sample database backup, and an instruction document for using the tool in a number of scenarios.

The **Read Me** file includes the latest features to the software since the last iteration, and a list of target operating systems that are supported.  

## How to install the MAP toolkit

When you install the toolkit on a client machine, the operating system must be Windows 7 Service Pack 1 or higher. The desktop must be the Professional edition or higher. Optionally, you can install the toolkit on a server running Windows Server 2008 R2 with Service Pack 1 or higher. Check the target desktop or server machine has the .NET Framework 4.5 installed.

Before you install the MAP toolkit on a particular machine, check for any existing MAP databases. If the application is already installed and you're now installing an upgraded version, you should make a backup.

After you've installed the toolkit, you'll need credentials for the SQL Server instances to which you want to connect.

You can install the MAP toolkit on a Windows client or server machine, but it's best practice not to install it on a production SQL Server. Along with the toolkit, the sample database and training documents are useful to help you see the tool in action before running it across your network.
