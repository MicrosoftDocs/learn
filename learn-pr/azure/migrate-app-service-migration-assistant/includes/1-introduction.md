Traditionally, organizations hosted web applications on their own internal infrastructure using computers running Windows Server, Internet Information Services, and SQL Server. Beyond the initial effort and costs, these applications incur ongoing maintenance costs in terms of hardware, operating system updates and licensing costs. These maintenance costs make Azure App Service an attractive alternative.  

Suppose your company has legacy ASP.NET web applications that you want to move to Azure App Service. The first step would be to assess whether the apps have dependencies on features that are unsupported on Azure App Service. You could initiate a costly and time consuming series of assessment projects. Once you've completed the assessment, you would then need to set up Azure App Service accounts, move files, apply settings, and so on.

A better option would be to use the Azure App Service Migration Assistant.  You install and run the Azure App Service Migration Assistant on your server to assess each web application it hosts.  If the web application can be migrated, you merely provide a few additional details about your Azure account, target resource group, and so on, to complete the migration.  If it cannot be migrated, it provides useful information that could help you rearchitect the application to remove the dependencies that hinder the app's move to the cloud.

In this module, you will use the Azure App Service Migration Assistant in a simulated on-premises environment to see it at work.  You'll perform an assessment, then a migration of a legacy ASP.NET application to Azure App Service.

By the end of this module, you will understand the potential hurdles to migrating a web application currently running on Internet Information Services to Azure App Service.

## Learning objectives

By the end of this module, you will be able to:

- Identify the kinds of issues that you might face when migrating an application hosted on Internet Information Services (IIS) to Azure App Service.
- Assess the migration readiness of an on-premises web application with the Azure App Service Migration Assistant.
- Use the Migration Assistant to migrate an on-premises web application to Azure App Service.

## Prerequisites

- You should have some familiarity in working with Virtual Machines, Windows Server, and IIS
- You should have some basic understanding of how IIS works, and its extensibility points, and how it hosts ASP.NET applications
