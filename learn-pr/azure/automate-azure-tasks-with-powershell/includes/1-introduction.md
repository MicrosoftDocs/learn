## Motivation
It's common to automate Azure administration tasks because it lets you get your work done more quickly and helps avoid errors. 

As an example, suppose you work at a company that uses Azure Virtual Machines (VMs) to test your Customer Relationship Management (CRM) software. The VMs are built from images that include a web front end, a web service that implements business logic, and a SQL database.

You have been executing multiple rounds of tests on a single VM but noticed that changes in the database and configuration files can cause inconsistent results. In one case, a bug created a phone-call record with no corresponding customer in the database. The orphaned record caused subsequent integration tests to fail even after the bug had been fixed. You plan to solve this problem by using a fresh VM deployment for each testing cycle. You want to automate the VM setup because it will be executed many times per week. 

Here, you will see how to manage Azure resources using Azure PowerShell. You will use Azure PowerShell interactively for one-off tasks and write scripts to automate repeated tasks. 

## Learning Objectives
> [!div class="checklist"]
> * Decide if Azure PowerShell is the right tool for your Azure administration tasks
> * Install Azure PowerShell on Linux, macOS, and Windows
> * Connect to an Azure subscription using Azure PowerShell
> * Create Azure resources using Azure PowerShell

## Prerequisites
- Experience with a command-line interface such as PowerShell or Bash
- Knowledge of basic Azure concepts such as resource groups and Virtual Machines
- Experience administering Azure resources using the Azure Portal

## Expected Duration

40 minutes