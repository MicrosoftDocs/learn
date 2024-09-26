You connect to a JEA endpoint by connecting interactively, using implicit remoting, programmatically, or through PowerShell Direct.

## Interactive JEA connections

You can use JEA the same way you would connect with a regular PowerShell remoting session. To use JEA interactively, you need:

- The remote computer name

- The JEA endpoint name

- An account with access to the desired endpoint

For example, if you have access to the JEA endpoint named DNSOps on the local server, you can connect to the JEA endpoint using the following PowerShell command:

```powershell
Enter-PSSession -<ComputerName> localhost -ConfigurationName DNSOps

```

After you're connected, your command prompt will change to `[localhost]: PS`>. If you're not sure what commands are available, you can use the **Get-Command** cmdlet to review which ones are available.

One limitation of interactive JEA sessions is that they operate in **NoLanguage** mode. This means you cant use variables to store data. For example, the following commands to start a virtual machine won't work because of the user of variables:

```powershell
$myvm = Get-VM -Name MyVM
Start-VM -vm $myvm

```

However, you can use piping to direct output of one command to another. This means that the following command would be the equivalent of the previous commands:

```powershell
Get-VM -Name MyVM | Start-VM

```

## Implicit remoting and JEA

Implicit remoting lets you import proxy versions of cmdlets from a remote machine to your local Windows PowerShell environment. This lets you use Windows PowerShell features such as tab completion, variables, or even local scripts.

You can even prefix PowerShell commands with a unique string so you can differentiate between the remote commands and local ones. For example, you could use the following commands to import the DNSOps JEA session and prefix the commands with DNSOps:

```powershell
$DNSOpssession = New-PSSession -ComputerName 'MyServer' -ConfigurationName 'DNSOps'
Import-PSSession -Session $DNSOpssession -Prefix 'DNSOps' Get-DNSOpsCommand

```

## Programmatic access to JEA

You can connect to JEA endpoints programmatically the same way you connect to other PowerShell endpoints programmatically. Programmatic access to JEA is often used in in-house helpdesk apps and websites and uses the same approach as apps built to interact with unconstrained PowerShell endpoints.

For more information about connecting to JEA endpoints programmatically, see [Using JEA programmatically](/powershell/scripting/learn/remoting/jea/using-jea#using-jea-programmatically).

## JEA and PowerShell Direct

PowerShell Direct allows Hyper-V administrators to connect to VMs from the Hyper-V host. By doing this, they can ignore any network or remote management settings on the VM.

The Hyper-V administrator connects to the VM the same way they would connect to any other server using PSRemoting, only specifying the -VMName parameter or the -VMId parameter. Whenever using JEA to manage VMs, you should create a dedicated JEA user account for the Hyper-V administrator, and the accounts ability to sign-in locally to the VM.