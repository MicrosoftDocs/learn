<!-- markdownlint-disable MD041 -->

Imagine working for an organization that uses Azure Virtual Machines (VMs) to test its Customer
Relationship Management (CRM) software. You create these VMs from images, including a web front-end
and a SQL database.

During multiple testing iterations on a single VM, you notice that changes to configuration files
and the database lead to inconsistent results. In one instance, a bug erroneously generated a phone
call record without an associated customer in the database. This orphaned record caused subsequent
integration tests to fail, even after you fixed the bug.

Recognizing the frequency of these testing cycles, which occur multiple times per week, you decide
to deploy a new VM for each cycle to ensure the consistency and reliability of your test
environment. By developing Azure CLI scripts for deployment, you streamline the process, optimize
workflow efficiency, and minimize errors through automation.

This module teaches you how to deploy and manage Azure resources using Azure CLI. You learn
how to use Azure CLI interactively for one-off tasks and how to write CLI scripts to
automate recurring tasks.

## Learning objectives

In this module, you'll:

- Determine if Azure CLI is the appropriate tool for your Azure management tasks.
- Install the Azure CLI on Windows, Linux, or macOS.
- Connect to Azure using the Azure CLI.
- Create Azure VMs with Azure CLI.

## Prerequisites

- Experience with a command-line interface, such as Bash or PowerShell.
- Understanding of basic Azure concepts, including resource groups and virtual machines.
- Experience administering Azure resources using the Azure portal.
