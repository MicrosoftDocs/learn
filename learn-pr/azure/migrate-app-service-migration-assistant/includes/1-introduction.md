Traditionally, organizations have hosted web applications on their own internal infrastructure using computers running Windows Server, Internet Information Services (IIS), and SQL Server. Beyond the initial effort and costs, these applications incur ongoing maintenance costs in terms of hardware, operating system updates, and licensing costs. These maintenance costs make Azure App Service an attractive alternative.  

Suppose your company has ASP.NET web applications that you want to move to Azure App Service. The first step is to assess whether the apps have dependencies on features that are unsupported on Azure App Service. You can then start a costly and time-consuming series of assessment projects. After you complete the assessment, you need to set up Azure App Service accounts, move files, and apply settings.

A better option is to use the Azure App Service Migration Assistant. You install and run the Migration Assistant on your server to assess each web application it hosts.  If the web application can be migrated, you provide information about your Azure account, target resource group, and other details, to complete the migration. If the migration can't happen, the information can help you rearchitect the application to remove the dependencies that hinder its move to the cloud.

In this module, you use the Azure App Service Migration Assistant in a simulated on-premises environment to see it at work. You perform an assessment, and then migrate an ASP.NET application to Azure App Service.

By the end of this module, you'll understand the potential hurdles to migrating a web application currently running on IIS to Azure App Service.

## Learning objectives

By the end of this module, you'll be able to:

- Identify the types of problems that you might face when migrating an application hosted on IIS to Azure App Service.
- Assess the migration readiness of an on-premises web application with the Azure App Service Migration Assistant.
- Use the Migration Assistant to migrate an on-premises web application to Azure App Service.

## Prerequisites

- Some familiarity in working with virtual machines, Windows Server, and IIS.
- Basic understanding of how IIS works, its extensibility points, and how it hosts ASP.NET applications.
