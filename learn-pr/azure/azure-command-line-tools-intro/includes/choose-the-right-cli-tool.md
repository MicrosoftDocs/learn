Every action you take in the Azure portal translates to code being executed against an API behind
the scenes to create, read, update, or delete Azure resources. Azure command line tools are wrappers
for the API that allow you to automate the provisioning of Azure resources at scale.

## Automation options in Azure

There are four command line tools commonly used to automate Azure resources. These include **the
Azure CLI**, **Azure PowerShell**, **Bicep**, and **Terraform**.

## How do the tools compare?

The Azure CLI, Azure PowerShell, Bicep and Terraform have similarities, but they each offer distinct
advantages. Since you are tasked with provisioning Azure Storage, which tool capabilities give the
best advantage in your environment?

The following table identifies capabilities of each Azure command line tool.

- The ![Yes][1] icon indicates that the capability is `true` for the specified command line tool.
- The ![No][3] icon indicates that the capability is `false` for the specified command line tool.

|                     Capability                      | Azure CLI | Azure PowerShell |   Bicep   | Terraform |
| --------------------------------------------------- | --------- | ---------------- | --------- | --------- |
| Imperative IaC                                      | ![Yes][1] | ![Yes][1]        | ![No][3]  | ![No][3]  |
| Declarative IaC                                     | ![No][3]  | ![No][3]         | ![Yes][1] | ![Yes][1] |
| Azure-native                                        | ![Yes][1] | ![Yes][1]        | ![Yes][1] | ![No][3]  |
| Cloud-agnostic                                      | ![No][3]  | ![No][3]         | ![No][3]  | ![Yes][1] |
| Can run on Windows, Linux, and macOS                | ![Yes][1] | ![Yes][1]        | ![Yes][1] | ![Yes][1] |
| Can create, edit and delete Azure Storage resources | ![Yes][1] | ![Yes][1]        | ![Yes][1] | ![Yes][1] |

Take a deeper look at each tool. What features of the Azure CLI vs Azure PowerShell and Bicep vs
Terraform make one or more a good fit in your environment?

### Azure CLI vs Azure PowerShell

The Azure CLI and Azure PowerShell are command line tools that enable you to create and manage Azure
resources. Both are cross-platform, installable on Windows, Linux, and macOS.

**Azure CLI**

- Cross-platform command-line interface, installable on Windows, Linux, and macOS
- Runs in Azure Cloud Shell, PowerShell, `Cmd.exe`, or in a Docker container
- Is based on Python
- Defaults to outputting a JSON string although other format options are available, such as table, yaml and tsv
- Allows you to query for command output using JMESPath query syntax
- Commands are organized in _groups_, like `az vm`, and _subgroups_, like `az vm disk`
- Syntax follows a simple `reference name -command -parameter -parameter value` pattern
- Supports asynchronous operations

**Azure PowerShell**

- Cross-platform PowerShell module, runs on Windows, Linux, and macOS
- Runs locally in PowerShell, in Azure Cloud Shell, or in a Docker container
- Based on .NET Standard
- Provides tab completion and predictive intellisense
- Returns .NET objects
- Uses `Verb-Noun` command names for ease of discoverability

## Bicep vs Terraform

**Bicep**

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In
a Bicep file, you define the infrastructure you want to deploy to Azure, and then use that file
throughout the development lifecycle to deploy your infrastructure. Your resources are deployed in a
consistent manner.

Bicep provides concise syntax, reliable type safety, and support for code reuse. Bicep offers a
first-class authoring experience for your infrastructure-as-code solutions in Azure.

**Terraform**

Hashicorp Terraform is an open source Infrastructure-as-Code (IaC) tool for provisioning and
managing cloud infrastructure. It codifies infrastructure in configuration files that describe the
desired state for your topology. Terraform enables the management of any infrastructure, such as
public clouds, private clouds, and SaaS services, by using Terraform providers.

## Which Azure Automation tool is right for you?

When picking a tool, consider your prior experience and current work environment.

Azure CLI syntax is similar to that of Bash scripting.

Azure PowerShell is a PowerShell module. Commands follow a `Verb-Noun` naming scheme and data is
returned as objects.

Choose the tool that uses your experience and shortens your learning curve. Being open-minded will
only improve your abilities. Use a different tool when it makes sense.

<!-- link references -->
[1]: ../media/shared/check-mark-button_2705.svg
[3]: ../media/shared/cross-mark_274c.svg
[5]: ../media/azure-cloud-shell-bash-powershell.png
