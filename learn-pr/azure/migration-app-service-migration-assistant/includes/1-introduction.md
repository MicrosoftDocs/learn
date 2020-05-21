Traditionally, organizations hosted web applications on their own internal infrastructure using computers running Windows Server, Internet Information Services and SQL Server. Beyond the initial effort and costs, these applications incur ongoing maintainance costs in terms of hardware, operating system updates and licensing costs. These maintenance costs make Azure App Service an attractive alternative.  

Suppose your company has legacy ASP.NET web applications that you want to move to Azure App Service. You would first need to assess whether or not the apps have dependencies on features that are not supported on Azure App Service. You could initiate a costly and time consuming series of assessment projects. Once you've performed the assessment, you would then need to set up Azure App Service accounts, move files, apply settings, and so on.

A better option would be to use the Azure App Service Migration Assistant.  You install and run the Azure App Service Migration Assistant on your server to assess each web application it hosts.  If the web application can be migrated, you merely provide a few additional details about your Azure account, target resource group, and so on to complete the migration.  If it cannot be migrated, it provides useful information that could help you re-architect the application to remove the dependencies that hinder the app's move to the cloud.

In this module, you will create an application that accepts user input from the keyboard, combine that input with hard-coded text, and present the final result back to the user. You’ll learn some initial concepts like basic C# syntax including several common operators, the string data type and how to create literal strings, how to initialize variables then set and retrieve values from a variable, why you would want to comment out a line of code, how your code is structured into classes and methods and how to call methods.

By the end of this module, you will understand the potential hurdles to migrating a legacy ASP.NET application currently running on Internet Information Services to Azure App Service.  You'll install and run the Azure App Service Migration Assistant in a VM that simulates a typical migration scenario.  You'll use the Azure App Service Migration Assistant to migrate the web application to Azure App Services and see it working.

## Learning objectives

In this module, you will:

- Discover the kinds of issues that you might face when migrating an application hosted on Internet Information Services to Azure App Services.
- Install and run the Azure App Service Migration Assistant.
- Use the Azure App Service Migration Assistant to migrate an ASP.NET MVC Core web app to Azure App Services.

## Prerequisites

- You should have some familiarity in working with Virtual Machines, Windows Server and Internet Information Services
- You should have some basic understanding of how Internet Information Services works, and its extensibility points, and how it hosts ASP.NET applications
- You should understand the benefits of Azure App Service, and understand why this is desireable to organizations
