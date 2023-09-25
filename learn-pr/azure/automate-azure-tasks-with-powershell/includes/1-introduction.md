Creating administration scripts is a powerful way to optimize your workflow. You can automate common, repetitive tasks. Once a script has been verified, it will run consistently, likely reducing errors.

Suppose you work at a company that uses Azure Virtual Machines (VMs) to test your Customer Relationship Management (CRM) software. The VMs are built from images that include a web front end, a web service that implements business logic, and an SQL database.

You've been executing multiple rounds of tests on a single VM, but you've noticed that changes in the database and configuration files can cause inconsistent results. In one case, a bug created a phone-call record with no corresponding customer in the database. The orphaned record caused subsequent integration tests to fail, even after you fixed the bug. You plan to solve this problem by using a fresh VM deployment for each testing cycle. You want to automate the VM-creation setup because it will be executed many times per week.

Here, you'll learn how to manage Azure resources using Azure PowerShell. You'll use Azure PowerShell interactively for one-off tasks, and write scripts to automate repeated tasks.

## Learning objectives

In this module, you will:

- Decide if Azure PowerShell is the right tool for your Azure administration tasks.
- Install Azure PowerShell on Linux, macOS, and/or Windows.
- Connect to an Azure subscription using Azure PowerShell.
- Create Azure resources using Azure PowerShell.

## Prerequisites

- Experience with a command-line interface such as PowerShell or Bash
- Knowledge of basic Azure concepts such as resource groups and Virtual Machines
- Experience administering Azure resources using the Azure portal
