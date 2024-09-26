The Azure portal is great for performing single tasks and for seeing a quick overview of the state of your resources. However, for tasks that need to be repeated daily or even hourly, using the command line and a set of tested commands or scripts can help get your work done more quickly and avoid errors.

Suppose you work at a company that develops Azure Web Apps. These are applications hosted in Azure, with all the benefits of automatically configured security, load balancing, management, and so on. You're currently testing a web app that generates sales forecasts based on a range of inputs from different databases and other data sources. Your developers use Windows, Linux, and Mac computers, and use a GitHub repository for daily builds of the applications.

As part of the testing, you want to compare app performance for different data sources and for different types of data connections. You've noticed that when your development team uses the Azure portal to create a new test instance of the app, they don't always use exactly the same parameters. You plan to solve this problem by using a set of standard deployment commands for each app test, which you can automate if required, and which will work in the same way across all the computers used by your software team.

In this module, you'll learn how to manage Azure resources using the Azure CLI.

## Learning objectives

In this module, you'll:

- Install the Azure CLI on Linux, macOS, and/or Windows.
- Connect to an Azure subscription using the Azure CLI.
- Create Azure resources using the Azure CLI.

## Prerequisites

- Experience with a command-line interface, such as PowerShell or Bash
- Knowledge of basic Azure concepts, such as resource groups
- Experience administering Azure resources using the Azure portal
