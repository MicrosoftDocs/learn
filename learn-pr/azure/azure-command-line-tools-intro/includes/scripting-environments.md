In this unit, you'll learn about the command-line shells that can be used to manage your Azure
resources. We'll review a few concepts that allow you to choose the best command-line shell for your
requirements.

## What is a command-line shell?

A command-line shell is a text-based program that instructs the operating system to perform actions.
Bash, PowerShell, Windows PowerShell, and `cmd.exe` are shell environments. Your shell environment
not only determines which tools you can use but also changes your command-line experience.

### Bash

Bash is a command-line interpreter and shell scripting language. Bash runs on Linux and macOS. Bash
is also available in Azure Cloud Shell and on Windows via the Windows Subsystem for Linux (WSL).

### PowerShell

PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting
language, and a configuration management framework. PowerShell runs on Windows, Linux, and macOS.
PowerShell is also available in Azure Cloud Shell.

### Azure Cloud Shell

Azure Cloud Shell is a hosted shell environment that runs Linux in a container. Cloud Shell provides
two different command line shells:

- Bash with the Azure CLI preinstalled
- PowerShell with Azure PowerShell and the Azure CLI preinstalled

Cloud Shell is accessible in a web browser and has integrations for Windows Terminal and Visual
Studio Code (VS Code).

## Supported shell environments

The following table identifies supported shells for each Azure command line tool.

- The ![Supported][1] icon indicates that the command line tool is `supported` in the specified
  shell.
- The ![Not supported][3] icon indicates that the command line tool is `not supported` in the
  specified shell.

| Shell Environment  |    Azure CLI    |  Azure PowerShell   |      Bicep      |    Terraform    |
| ------------------ | :-------------: | :-----------------: | :-------------: | :-------------: |
| Bash               | ![Supported][1] | ![Not supported][3] | ![Supported][1] | ![Supported][1] |
| PowerShell         | ![Supported][1] |   ![Supported][1]   | ![Supported][1] | ![Supported][1] |
| Windows PowerShell | ![Supported][1] |   ![Supported][1]   | ![Supported][1] | ![Supported][1] |
| Azure Cloud Shell  | ![Supported][1] |   ![Supported][1]   | ![Supported][1] | ![Supported][1] |
| `cmd.exe`          | ![Supported][1] | ![Not supported][3] | ![Supported][1] | ![Supported][1] |

Azure CLI has an installer that makes its commands executable in all five shell environments.

Azure PowerShell is set of cmdlets packaged as a PowerShell module named `Az`; not an executable.
PowerShell or Windows PowerShell must be used to run the commands in the `Az` PowerShell module.

PowerShell is a stand-alone installation that uses .NET Core as its runtime, allowing it to be
installed on Windows, Linux, and macOS. Windows PowerShell is a scripting environment shell that
comes preinstalled with Windows operating systems.

You can use either PowerShell or Bash to manage your Azure resources. As a best practice, you should
write your scripts for a specific shell as syntax elements are different between PowerShell and
Bash. For example, for the line continuation character, Bash uses the backslash `\` while PowerShell
uses the backtick `` ` ``. The differences in the shell environments don't change how the Azure CLI
and Azure PowerShell operate. However, they do change your command-line experience.

<!-- link references -->
[1]: ../media/shared/check-mark-button_2705.svg
[3]: ../media/shared/cross-mark_274c.svg
