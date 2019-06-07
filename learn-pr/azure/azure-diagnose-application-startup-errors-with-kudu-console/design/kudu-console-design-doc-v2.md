## Title

Diagnose startup errors in your application using Kudu console

## Role(s)

- Administrator
- Developer

## Level

- intermediate

## Product(s)

- azure

## Prerequisites

- Experience in basic web app development and deployment
- Understanding of App Service in Microsoft Azure

## Summary

This module explains how to use kudu console to examine the application event log to identify the event that caused the error. The module will also cover how to use the kudu remote execution console and diagnostic console.

## Learning objectives

1. Describe the different types of App startup errors  
1. Use kudu console to examine the application event log

## Chunk your content into subtasks

Identify the subtasks of **Diagnose startup errors in your application using Kudu console**

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe the different App startup errors and diagnostic techniques | Introduces the different app startup errors and use the Diagnose and solve problems blade to examine the Application Event Log | knowledge check | 1 | Yes |
| Run the ASP.NET Core Module app in kudu console | Outlines the web app creation process and run the app in kudu console | Exercise | 2 | Yes |
| Diagnose the ASP.NET Core Module stdout log | Outlines the process to diagnose the stdout log using kudu console | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You are an IT admin supporting a leading hotel and resort company using Azure web apps. The hospitality group is rolling out a new service to its gold tier members to support digital room selection.  This service however returns an application process failure message. 

    In this module, you will learn how to diagnose the app startup error by examining the application event logs. In case of not finding useful information to diagnose the startup error, then you will use the Kudu remote execution console to discover the error.

1. **Describe Kudu console purpose and functionalities**
    
    Azure App Service diagnostic tools help to diagnose ASP.NET Core app startup issues. 

    App startup errors - 502.5 Process Failure, 500 Internal Server Error, Connection reset

1. **Exercise -  Create and configure a web app**

    1. Create an Azure web app
    1. Configure the web app
    1. Access the application event log in the Diagnose and Solve problems screen
    1. Examine the application event log using kudu console
    1. Run the app in the kudu console    

1. **Describe the application startup errors and starter web project development process**

1. **Exercise -  Implement a web application**

1. **Exercise -  Diagnose application event log using kudu console**

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Summary**

   In this module, you learned about the different application startup errors. As an IT admin of hotel and resort company, you learned how to use kudu console to examine the application event log and gather useful information to diagnose startup errors. You also learned how to analyze errors using kudu diagnostic console.


1. **References**

    - [Azure DevOps Work Item](https://ceapex.visualstudio.com/Microsoft%20Learn/_workitems/edit/53156/)

    - [Docs guide](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/azure-apps/troubleshoot?view=aspnetcore-2.2)


