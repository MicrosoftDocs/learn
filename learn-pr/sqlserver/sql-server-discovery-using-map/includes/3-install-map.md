Suppose you are a newly-hired database administrator, and you have learnt that there is no current inventory of the company’s SQL Server instances. You have chosen the **Microsoft Assessment and Planning (MAP)** toolkit to help you automate the process of completing a full inventory of these SQL Server instances. You have decided to install the toolkit on your local machine, and you need to know how to perform the installation, and whether there are any install considerations that you need to be aware of.

## What must be installed?

When you are ready to download the Microsoft Assessment and Planning toolkit, you can select from the following four options:

- MapSetup.exe
- MAP_Sample_Documents.zip
- MAP_Training_Kit.zip
- read_me.htm

At a minimum, you only require **MapSetup.exe**. When installing the MAP toolkit, the default option will be to use a local database for storing the inventory and assessment data: a copy of SQL Server 2012 Express is installed for this purpose.

If you want to install the toolkit using your own SQL Server instance, create a non-default instance named **MAPS** prior to running the installer on SQL Server 2008, SQL Server 2008 R2, or SQL Server 2012. The database engine collation should be configured to **SQL_Latin1_General_CP1_CI_AS**.

The **MAP Sample Documents** are useful for showing the potential data you can gather. For example, if members of your operations team want to adopt the toolkit, providing them with sample files to show what data is gathered in the inventory, may help them to see the benefits across your whole organizational infrastructure; MAP can provide audit information on Exchange Server usage, Office 365, remote desktop licensing, SharePoint server usage, and much more. For SQL Server, the sample files included in the download offer an overview of how you can assess your landscape after the toolkit has performed a network-wide inventory.

The **MAP Training Kit** enables you to familiarize yourself with the tool prior to running it against any of your production servers. It includes a sample database backup, and an instruction document for using the tool in a number of scenarios.

The **Read Me** file includes the latest features to the software since the last iteration, along with a list of target operating systems that are supported.  

## How to install the Microsoft Assessment and Planning Toolkit

When installing the toolkit on a client machine, the operating system must be Windows 7 Service Pack 1 or higher, and desktop must be the Professional edition or higher. Optionally you can install the toolkit on a server running Windows Server 2008 R2 with Service Pack 1, or higher. Check that the target desktop or server machine has the .NET Framework 4.5 installed.

Before you install the Microsoft Assessment and Planning Toolkit, check for any existing MAP databases on the machine you intend install it on, and make a backup it if the application has already been installed and you are now installing an upgraded version.

After you have installed the toolkit, you will need credentials for the SQL Server instances to which you want to connect.

## Summary

The Microsoft Assessment and Planning Toolkit can be installed on a Windows client or server machine, but it is best practice to not to install it on a production SQL Server. Along with the toolkit, the sample database and training documents are useful to see the tool in action prior to running this across your network.