Azure Data Factory enables you to execute packages for SSIS. 
With Azure Data Factory, you are able to provision an Azure-SQL Server Integration Services (SSIS) integration runtime (IR). 

An Azure-SSIS IR supports:

* Running packages that are or to be deployed into SSIS catalog (SSISDB) hosted by your Azure SQL Database server or Managed Instance in Project Deployment Model
* Running packages that are or to be deployed into file system, Azure Files, or SQL Server database (MSDB) hosted by your Azure SQL Managed Instance in Package Deployment Model

Once the Azure-SSIS IR is provisioned, the same familiar tools for deployment and running the packages in Azure can be used. 
Most of the familiar tools such as SQL Server Data Tools (SDDT), SQL Server Management Studio (SSMS), Azure Data Studio, and command-line utilities are Azure- enabled, and therefore ready to be used. 

Using SSDT allows you to check and assess the Azure Cloud compatibility with Azure-SSIS Integration Runtime in Azure Data Factory of the SSIS packages you might already be running locally. This feature comes in handy when you want to test existing packages before an actual lift and shift or migration can take place to Azure. If you want to develop new packages to run in Azure, it's also good to test them with this feature. 

