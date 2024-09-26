PowerShell is an automation solution that consists of a command-line shell, a scripting language, and a configuration-management framework.

## Command-line shell

Windows PowerShell superseded the Windows command-line interface (**cmd.exe**) and the limited functionality of its batch file scripting language. PowerShell accepts and returns .NET objects and includes:

- A command-line history.
- Tab completion and prediction.
- Support for command and parameter aliases.
- Chaining commands that use the Pipeline feature.
- A robust in-console help system

Initially, Windows PowerShell was a platform built on the .NET Framework and only worked on Windows operating systems. However, with its recent releases, PowerShell uses the .NET Core and can run on Windows, macOS, and Linux platforms. Due to their multi-platform support, these recent releases are referred to as PowerShell (rather than Windows PowerShell).

## A scripting language

*Commands* provide PowerShell’s main functionality. There are many varieties of commands, including cmdlets (pronounced *command-lets*), functions, filters, scripts, applications, configurations, and workflows. Commands are building blocks that you piece together by using the Windows PowerShell scripting language. Using commands enables you to create custom solutions to complex administrative problems. Alternatively, you can run commands directly within the PowerShell console to complete a single task. The console is the CLI for PowerShell and is the primary way in which you'll interact with PowerShell.

Cmdlets use a Verb-Noun naming convention. For example, you can use the **Get-Command** cmdlet to list all cmdlets and functions that are registered in the command shell. The verb identifies the action for the cmdlet to perform, and the noun identifies the resource on which the cmdlet will perform its action.

Microsoft server applications and cloud services provide specialized cmdlets that you can use to manage those services. In fact, you can manage some features *only* by using PowerShell. In many cases, even when the application provides a graphical user interface (GUI) to manage a specific functionality, it relies on PowerShell to implement at least some of its features behind the scenes.

## Configuration management framework

PowerShell incorporates the PowerShell Desired State Configuration (DSC) management framework. This framework enables you to manage enterprise infrastructure with code to help with:

- Using declarative configurations and repeatable scripts for repeatable deployments.
- Enforcing configurations settings and identifying when configuration drift takes place from standard requirements.
- Deploying configuration settings using push or pull models.

Applications and services with PowerShell–based administrative functions are consistent in how they work. This attribute means that you can quickly apply the lessons you learned. Also, when you use automation scripts to administer a software application, you can reuse them among other applications.

## Windows PowerShell versions

As you learn about PowerShell, it's important to understand the various versions that you might encounter, depending upon your operating system (OS) type and edition. There are two main PowerShell platforms:

- Windows PowerShell
- PowerShell (originally referred to as PowerShell Core)

### Windows PowerShell

Windows PowerShell is available exclusively for the Windows OS. Windows PowerShell 1.0 was introduced in 2006 as a component installable on Windows XP Service Pack 2 (SP2), Windows Server 2003 SP1, and Windows Vista. It was also an optional component of Windows Server 2008. In 2009, PowerShell 2.0 was integrated into Windows 7 and Windows Server 2008 R2. All versions of Windows PowerShell up to and including 5.1, which is the version available with Windows 10, are integrated with a Windows OS.

Windows PowerShell is an OS component, so it receives the same lifecycle support and licensing agreements as its parent OS.

### PowerShell

PowerShell is shipped, installed, and configured separately from Windows PowerShell. First released as PowerShell Core 6.0 in 2018, it was the first version that offered multi-platform support, extending its availability to macOS and Linux operating systems.

> [!NOTE]
> The latest version of PowerShell is PowerShell 7.2, available via Microsoft Update.

PowerShell and Windows PowerShell are separately installed and you can run supported commands using either environment.

Standard Windows licensing agreements don't include PowerShell. Rather, it's supported under Microsoft paid support, Microsoft Enterprise Agreements, and Microsoft Software Assurance. Community support is also available. 

## Version release history

The following table provides a general timeline of the major PowerShell releases:

*Table 1: PowerShell release timelines*

| Version        | Release Date | Notes                                                        |
| -------------- | ------------ | ------------------------------------------------------------ |
| PowerShell 7.2 | November 2021     | Built on .NET 6.0.                                           |
| PowerShell 7.1 | November 2020     | Built on .NET 5.0.                                           |
| PowerShell 7.0 | March 2020     | Built on .NET Core 3.1.                                      |
| PowerShell 6.0 | September 2018    | Built on .NET Core 2.0. First release that's installable on Windows, Linux, and macOS. |
| PowerShell 5.1 | August 2016     | Released in Windows 10 Anniversary Update and Windows Server 2016 and as part of Windows Management Framework (WMF) 5.1. |
| PowerShell 5.0 | February 2016     | Integrated in Windows 10 version 1511. Released in Windows Management Framework (WMF) 5.0. Can be installed on Windows Server 2008 R2, Windows Server 2012, Windows 10, Windows 8.1 Enterprise, Windows 8.1 Pro, and Windows 7 SP1. |
| PowerShell 4.0 | October 2013     | Integrated in Windows 8.1 and Windows Server 2012 R2. Can be installed on Windows 7 SP1, Windows Server 2008 SP1, and Windows Server 2012. |
| PowerShell 3.0 | October 2012     | Integrated in Windows 8 and Windows Server 2012. Can be installed on Windows 7 SP1, Windows Server 2008 SP1, and Windows Server 2008 R2 SP1. |
| PowerShell 2.0 | July 2009     | Integrated in Windows 7 and Windows Server 2008 R2. Can be installed on Windows XP SP3, Windows Server 2003 SP2, and Windows Vista SP1. |
| PowerShell 1.0 | November 2006     | Installable on Windows XP SP2, Windows Server 2003 SP1, and Windows Vista. Optional component of Windows Server 2008. |

> [!NOTE]
> Throughout this module, topics will relate to both the latest Windows PowerShell and PowerShell versions (5.1 and 7.2). Most cmdlets will work using either platform. However, there'll be a note if a specific feature is only supported or relates to one specific platform.

> **Additional reading:** To support more recent versions of PowerShell on down-level operating systems, you might need to install the latest version of the Windows Management Framework. For more information, refer to [Install and Configure WMF 5.1](https://aka.ms/install-and-configure-WMF-5.1).

