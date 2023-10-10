Every action that you take in the Azure portal translates to the running of code against an API behind
the scenes to create, read, update, or delete Azure resources. Azure command-line tools are wrappers
for the API that allow you to automate the provisioning of Azure resources at scale.

## Automation options in Azure

Four command-line tools are commonly used to automate Azure resources: the
Azure CLI, Azure PowerShell, Bicep, and Terraform.

## How do the tools compare?

The Azure CLI, Azure PowerShell, Bicep, and Terraform have similarities, but each offers distinct
advantages. Because you're tasked with provisioning Azure Storage, which tool capabilities give the
best advantage in your environment?

The following table identifies capabilities of each Azure command-line tool. In the table:

- The ![Yes][1] icon indicates that the capability is `true` for the specified command-line tool.
- The ![No][3] icon indicates that the capability is `false` for the specified command-line tool.

|                     Capability                      | Azure CLI | Azure PowerShell |   Bicep   | Terraform |
| --------------------------------------------------- | --------- | ---------------- | --------- | --------- |
| Imperative IaC                                      | ![Yes][1] | ![Yes][1]        | ![No][3]  | ![No][3]  |
| Declarative IaC                                     | ![No][3]  | ![No][3]         | ![Yes][1] | ![Yes][1] |
| Azure native                                        | ![Yes][1] | ![Yes][1]        | ![Yes][1] | ![No][3]  |
| Cloud agnostic                                      | ![No][3]  | ![No][3]         | ![No][3]  | ![Yes][1] |
| Can run on Windows, Linux, and macOS                | ![Yes][1] | ![Yes][1]        | ![Yes][1] | ![Yes][1] |
| Can create, edit, and delete Azure Storage resources | ![Yes][1] | ![Yes][1]        | ![Yes][1] | ![Yes][1] |

Take a deeper look at each tool. What features of the Azure CLI versus Azure PowerShell, and Bicep versus
Terraform, make one or more a good fit in your environment?

## Azure CLI vs. Azure PowerShell

The Azure CLI and Azure PowerShell are command-line tools that enable you to create and manage Azure
resources.

### Azure CLI

- Is a cross-platform command-line interface that's installable on Windows, Linux, and macOS
- Runs in Azure Cloud Shell, PowerShell, Bash, `Cmd.exe`, or a Docker container
- Is based on Python
- Defaults to outputting a JSON string, although other format options are available, such as table,
  YAML, and TSV
- Allows you to query for command output by using JMESPath query syntax.
- Uses commands that are organized in _groups_, like `az vm`, and _subgroups_, like `az vm disk`
- Has syntax that follows a simple `reference name -command -parameter -parameter value` pattern
- Supports asynchronous operations

### Azure PowerShell

- Is a cross-platform PowerShell module that runs on Windows, Linux, and macOS
- Runs locally in PowerShell, in Azure Cloud Shell, or in a Docker container
- Is based on .NET Standard
- Provides tab completion and Predictive IntelliSense
- Returns .NET objects
- Uses `Verb-Noun` command names for ease of discoverability

## Bicep vs. Terraform

### Bicep

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In
a Bicep file, you define the infrastructure that you want to deploy to Azure. You then use that file
throughout the development lifecycle to deploy your infrastructure. Your resources are deployed in a
consistent way.

Bicep provides concise syntax, reliable type safety, and support for code reuse. Bicep offers a
good authoring experience for your IaC solutions in Azure.

### Terraform

HashiCorp Terraform is an open-source IaC tool for provisioning and
managing cloud infrastructure. It codifies infrastructure in configuration files that describe the
desired state for your topology. Terraform enables the management of any infrastructure, such as
public clouds, private clouds, and software as a service (SaaS) services, by using Terraform providers.

## Which Azure command-line tool is right for you?

When you're picking a tool, consider your prior experience and current work environment. Here's a summary of your options:

- Azure CLI syntax is similar to that of Bash scripting.
- Azure PowerShell is a PowerShell module. Commands follow a `Verb-Noun` naming scheme, and data is
returned as objects.
- Bicep is a DSL that uses declarative syntax to deploy Azure resources.
- Terraform is an open-source IaC tool for provisioning and
managing cloud infrastructure.

Choose the tool that uses your experience and shortens your learning curve. Being open-minded will
only improve your abilities. Use a different tool when it makes sense.

<!-- link references -->
[1]: ../media/shared/check-mark-button-2705.svg
[3]: ../media/shared/cross-mark-274c.svg
