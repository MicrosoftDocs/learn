<!-- markdownlint-disable MD041 -->

Imagine you must select a tool to deploy and manage the Azure resources for your Customer
Relationship Management (CRM) system. For testing, you need to create resource groups and virtual
machines (VMs) for each test iteration.

You seek a tool that's easy for administrators to learn, yet powerful enough to automate the
installation and configuration of multiple virtual machines. With several tools available, your goal
is to find the best one for your administrators to script the deployment of the entire cloud
infrastructure efficiently.

## What tools are available?

Azure offers three administration tools:

- Azure portal
- Azure PowerShell
- Azure CLI

These tools provide the same deployment and configuration capabilities, allowing you to perform any
task with any of the three. All are available on Windows, Linux, and macOS. However, they differ in
syntax, setup requirements, and support for automation.

The rest of this unit describes each of these tools and offers guidance on how to choose the best
one for your needs.

## Azure portal

The Azure portal is a web-based interface that allows you to create, configure, and manage the
resources in your Azure subscription. As a Graphical User Interface (GUI), it offers a user-friendly
way to locate and manage resources, with wizards and tooltips to assist you through complex
management tasks.

However, Azure portal lacks automation capabilities for repetitive tasks. For instance, if you need
to set up 15 VMs, you must create each one individually, completing the wizard for each VM. This
approach can be time-consuming and error-prone for more complex tasks.

## Azure PowerShell

Azure PowerShell is a collection of modules that provide PowerShell cmdlets for connecting to your
Azure subscription and managing resources. It requires PowerShell, a command-line shell and
scripting language.

For example, Azure PowerShell offers the `New-AzVM` cmdlet to create a virtual machine in your Azure
subscription. To use it, launch PowerShell and execute the following command:

```azurepowershell
$azVmParams           = @{
    ResourceGroupName = 'CrmTestingResourceGroup'
    Name              = 'CrmUnitTestVm'
    Image             = 'Ubuntu2204'
}
New-AzVm @azVmParams
```

Azure PowerShell is available in two ways: inside a browser via Azure Cloud Shell or through a local
installation on Windows, Linux, or macOS. You can use PowerShell interactively, running Azure
PowerShell commands from PowerShell, or you can create and execute scripts that consist of multiple
commands.

## The Azure CLI

The Azure CLI is a cross-platform command-line tool that enables you to connect to Azure and execute
administrative commands on Azure resources. For instance, you can create a virtual machine using the
following command (this example uses Bash line continuation characters):

```azurecli
az vm create \
    --resource-group CrmTestingResourceGroup \
    --name CrmUnitTestVm \
    --image Ubuntu2204
```

The Azure CLI is also available in two ways: inside a browser via Azure Cloud Shell or through a
local installation on Windows, Linux, or macOS. You can use it interactively by launching a shell
(such as Bash, PowerShell, or `cmd.exe`) and entering commands at the prompt. Alternatively, you can
automate repetitive tasks by assembling the commands into a shell script using the syntax of your
chosen shell.

## How to choose a management tool

With few exceptions, any task you can perform in the Azure portal can also be accomplished using
Azure PowerShell or the Azure CLI. Here are some factors to consider when choosing the most
appropriate tool for your needs:

- **Automation**: Do you need to automate complex or repetitive tasks? Azure PowerShell and the
  Azure CLI support automation, whereas the Azure portal doesn't.

- **Learning curve**: Do you need to complete a task quickly without learning new commands or
  syntax? The Azure portal is user-friendly and doesn't require learning commands or syntax. In
  contrast, Azure PowerShell and the Azure CLI require an understanding of command shell syntax and
  the specific requirements for each command.

- **Team skillset**: Does your team have existing expertise? For instance, if your team is already
  using PowerShell to manage other products like Windows, Exchange Server, or Microsoft 365, they
  might find Azure PowerShell to be a more comfortable and efficient choice.

## Example

Let's revisit the scenario of choosing an administrative tool to deploy and test your CRM
application. Your administrators have two specific Azure tasks to complete:

1. Create one resource group for each category of testing (unit, integration, and acceptance).
1. Create multiple VMs in each resource group before each round of testing.

The Azure portal is a reasonable choice for creating resource groups. Since these tasks are one-off,
you don't need scripts to create them.

The first experience with Azure for most administrators is through the Azure portal. It provides a
well-organized graphical interface for managing Azure resources, making it an excellent starting
point. However, the portal doesn't support automation, which is essential for repetitive tasks like
creating multiple VMs several times a week.

For automation in Azure, you have two options:

- Azure PowerShell
- Azure CLI

Both tools meet your needs, but Azure PowerShell might be the best choice if your team has existing
PowerShell knowledge.

In practice, businesses typically perform a mix of one-off and repetitive tasks, often using both
the Azure portal and a scripting solution. In your CRM example, creating resource groups using the
Azure portal and automating VM creation with Azure PowerShell is a reasonable approach.

The remainder of this module assumes Azure PowerShell is your choice for an automation tool.
