# Design Document

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

This module explains how to use kudu console to examine the application event log to identify the event that caused the error. The module will also cover how to use the kudu diagnostic console.

## Learning objectives

- Learn about the concepts of Kudu console
- Learn various types of App startup errors  
- Use Kudu console to examine the application event log

## Chunk your content into subtasks

Identify the subtasks of **Diagnose startup errors in your application using Kudu console**

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe the different App startup errors and diagnostic techniques | Introduces the different app startup errors and use Kudu console to examine the Application Event Log | knowledge check | 1 | Yes |
| Run the ASP.NET Core Module app in kudu console | Outlines the web app creation process and run the app in kudu console | Exercise | 2 | Yes |
| Diagnose the ASP.NET Core application event log | Outlines the process to diagnose the application event log using kudu console | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**
    You are an IT admin supporting a leading hotel and resort company using Azure web apps. The hospitality group is rolling out a new service to its gold tier members to support digital room selection.  This service however returns an application process failure message. 

    In this module, you'll learn how to diagnose the app startup error by examining the application event logs. To diagnose the startup error, you'll use the Kudu diagnostic console to discover the error.
1. **Describe Kudu console purpose and functionalities**
    What is Kudu console?
    Kudu console functionalities - Run commands, navigate folder, upload files and folders, download files and folders, view and edit files
1. **Describe the application startup errors and logging process**
    App startup errors:
        500.30 In-Process Start Failure
        502.5 Process Failure
        500 Internal Server Error
        Connection reset
    App Service Diagnostics
    Knowledge check
1. **Exercise -  Implement a web application**
    Create a web project
    Update the web project code
    Deploy the web app
1. **Exercise -  Diagnose application event log using kudu console**
    Access the application event log through Azure Portal
    Access the application event log through Kudu console
    Run the app in Kudu Console
    Test the app in Kudu Console
1. **Summary**
   In this module, you learned about the different application startup errors. As an IT admin of hotel and resort company, you learned how to use kudu console to examine the application event log and gather useful information to diagnose startup errors. You also learned how to analyze errors using kudu diagnostic console.

1. **References**

    - [Azure DevOps Work Item](https://ceapex.visualstudio.com/Microsoft%20Learn/_workitems/edit/53156/)

    - [Docs guide](https://docs.microsoft.com/aspnet/core/host-and-deploy/azure-apps/troubleshoot?view=aspnetcore-2.2)


