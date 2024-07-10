As you use PowerShell to manage and automate management tasks, you take into account several considerations, including:

- Installing and using PowerShell side-by-side with Windows PowerShell.
- Running PowerShell using administrative credentials.
- Identifying and modifying the execution policy in PowerShell.

## Installing and using PowerShell side-by-side with Windows PowerShell

Depending on Windows operating system versions and editions, organizations might have computers running different versions of PowerShell. Sometimes, these mixed-version environments are the result of organizational policies that don't permit the installation of newer PowerShell versions. They might also be the result of software products, especially server software, being compatible with a specific PowerShell version.

If you install the latest version of PowerShell, you end up with multiple PowerShell versions installed on your system. For example, PowerShell 7 is designed to coexist with Windows PowerShell 5.1 and will install to a new directory and enable side-by-side execution with Windows PowerShell.

Installing the latest version of PowerShell results in the following when compared to Windows PowerShell:

- *Separate installation path and executable name*. Windows PowerShell 5.1 is installed in the `$env:WINDIR\System32\WindowsPowerShell\v1.0` location. PowerShell 7 is installed in the `$env:ProgramFiles\PowerShell\7` location. The new location is added to your PATH, which allows you to run both Windows PowerShell 5.1 and PowerShell 7. In Windows PowerShell, the PowerShell executable is named `powershell.exe`. In version 6 and newer, the executable is named `pwsh.exe`. The new name makes it easy to support side-by-side execution of both versions.
- *Separate PSModulePath*. By default, Windows PowerShell and PowerShell 7 store modules in different locations. PowerShell 7 combines those locations in the `$Env:PSModulePath` environment variable. When you import a module by name, PowerShell checks the location that `$Env:PSModulePath` specifies. This feature allows PowerShell 7 to load both Core and Desktop modules.
- *Separate profiles for each version*. A PowerShell profile is a script that runs when PowerShell starts. This script customizes the PowerShell environment by adding commands, aliases, functions, variables, modules, and PowerShell drives. In Windows PowerShell 5.1, the profile's location is `$HOME\Documents\WindowsPowerShell`. In PowerShell 7, the profile's location is `$HOME\Documents\PowerShell`.
- *Separate event logs*. Windows PowerShell and PowerShell 7 log events to separate Windows event logs.

When you're reviewing a PowerShell session, it's important to determine which version you're using. To determine the current version, enter `$PSVersionTable` in the PowerShell console, and then select Enter. PowerShell displays the version numbers for various components, including the main PowerShell version number.

## Running PowerShell using Administrative credentials

On 64-bit operating systems, the PowerShell host applications are available in both 64-bit (x64) and 32-bit (x86) versions. When working with Windows PowerShell, you'll use the 64-bit version that displays as **Windows PowerShell** or **Windows PowerShell ISE** in the Start menu. The 32-bit versions provide compatibility with locally installed 32-bit shell extensions. They display as **Windows PowerShell (x86)** or **Windows PowerShell ISE (x86)** in the Start menu. As soon as you open Windows PowerShell, the application window's title bars reflect the same names as in the Start menu. Be certain that you're opening the appropriate version for the task you want to perform.

On 32-bit operating systems, PowerShell’s host applications are available only in 32-bit versions. When working with Windows PowerShell, you'll notice that the icons and window title bars don't have the (x86) designation. Instead, they display simply as **Windows PowerShell** and **Windows PowerShell ISE** in the Start menu.

If you intend to use PowerShell to perform administrative tasks on computers that have User Account Control (UAC) enabled, you might have to take an extra step to run PowerShell cmdlets with full administrative credentials. To do this, right-click or activate the context menu for the application icon, and then select **Run as Administrator**. When you're running PowerShell with administrative credentials, the host application’s window title bar will include the **Administrator** prefix. 

## Identifying and modifying the execution policy in PowerShell

The execution policy in PowerShell is meant to minimize the possibility of a user unintentionally running PowerShell scripts. You can think of it as a safety feature that controls the conditions under which PowerShell loads configuration files and runs scripts. This feature helps prevent the execution of malicious scripts.

> [!IMPORTANT]
> The execution policy in PowerShell isn't a security system that restricts user actions. For example, if users can't run a script, they can easily bypass a policy by entering the script contents at the command line.

To identify the effective execution policy for the current PowerShell session, use the following cmdlet:

`Get-ExecutionPolicy`

You can configure the following policy settings:

- **AllSigned**. Limits script execution on all signed scripts. This setting requires that all scripts are signed by a trusted publisher, including scripts that you write on the local computer. It prompts you before running scripts from publishers that you haven't yet classified as trusted or untrusted. However, verifying the signature of a script doesn't eliminate the possibility of that script being malicious. It simply provides an extra check that minimizes this possibility.
- **Default**. Sets the default execution policy, which is **Restricted** for Windows clients and **RemoteSigned** for Windows servers.
- **RemoteSigned**. This is the default execution policy for Windows server computers. Scripts can run, but the policy requires a digital signature from a trusted publisher on scripts and configuration files that have been downloaded from the internet. This setting doesn't require digital signatures on scripts that are written on the local computer.
- **Restricted**. This is the default execution policy for Windows client computers. It permits running individual commands, but it doesn't allow scripts.
- **Unrestricted**. This is the default execution policy for non-Windows computers, which you can't change. It allows unsigned scripts to run. This policy warns the user before running scripts and configuration files that aren't from the local intranet zone.
- **Undefined**. Indicates that there isn't an execution policy set in the current scope. If the execution policy in all scopes is **Undefined**, the effective execution policy is **Restricted** for Windows clients and **RemoteSigned** for Windows Server.

To change the execution policy in PowerShell, use the following command:

`Set-ExecutionPolicy -ExecutionPolicy <PolicyName>`
