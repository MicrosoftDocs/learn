While GUI management tools can often be easier to use than command-line tools, Contoso's IT department manager believes you can achieve many administrative tasks more quickly by using a simple script or a single command. For example, the process of updating the same information for several user accounts by using Active Directory Users and Computers can be time consuming. However, using the Active Directory module in Windows PowerShell enables an administrator to perform this repetitive task quickly. You decide to investigate the impact of using Windows PowerShell to administer the server infrastructure at Contoso. 

## Overview

Windows PowerShell is a command-line and scripting environment that you can use to manage all aspects of the Windows operating system. Windows PowerShell uses special commands called cmdlets that are composed of verb-noun pairs, such as `Restart-Computer`.

You can also use Windows PowerShell to remotely connect to other computers, and even run Windows PowerShell cmdlets against a list of computers, enabling  you to perform actions against multiple computers by using a single command-line instruction.

### Windows PowerShell commands and cmdlets

Commands are building blocks that you piece together by using the Windows PowerShell scripting language. They provide Windows PowerShell’s main functionality. By using commands, you can create custom solutions for complex administrative problems.

Cmdlets are the fundamental components of commands. There are thousands of  Windows PowerShell cmdlets available in the Windows operating systems and other Microsoft products. As mentioned earlier, cmdlets are comprised a verb-noun pair.

#### Cmdlet verbs

The verb portion of the cmdlet name indicates what the cmdlet does. There is a set of approved verbs that cmdlet creators use, which provides consistency in cmdlet names. Common verbs are described in the following table.

|Verb|Explanation|
|--|--|
|Get|Retrieves a resource, such as a file or a user.|
|Set|Changes the data associated with a resource, such as a file or user property.|
|New|Creates a resource, such as a file or user.|
|Add|Adds a resource to a container of multiple resources.|
|Remove|Deletes a resource from a container of multiple resources.|

#### Cmdlet nouns

The noun portion of the cmdlet name indicates what kinds of resources or objects the cmdlet affects. All cmdlets that operate on the same resource should use the same noun. For example, the **Service** noun is used for cmdlets that work with Windows services, and the **Process** noun is used for managing processes on a computer.

#### Parameter format

Parameters modify the actions that a cmdlet performs. Each cmdlet can have no parameters, one parameter, or many parameters. Parameter names begin with a dash (-). A space separates the value that you want to pass from the parameter name. If the value that you are passing contains spaces, you will need to enclose the text in quotation marks. Some parameters accept multiple values, which are separated by commas and no spaces.

#### Examples
You can study the following examples to help determine how you could use Windows PowerShell to perform common administrative tasks. The following command displays a list of running services.  

```PowerShell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

The following command displays a list of services that have a name that begins with “win” and that excludes the service called WinRM.

```PowerShell
Get-Service -Name "win*" -Exclude "WinRM"
```

This next command outputs a list of all services to a text file formatted for HTML output.

```PowerShell
Get-Service | ConvertTo-Html > File.html
```

A variation of the preceding command outputs only selected data about services, and then exports the output to a CSV file.

```PowerShell
Get-Service | Select-Object Name, Status | Export-CSV c:\service.csv
```

The following command retrieves the specified information (office phone number and user principal name) about Active Directory users.

```PowerShell
Get-ADUser -Filter * -Properties OfficePhone | FT OfficePhone,UserPrincipalName
```

This final example retrieves a subset of AD DS users (those in the Marketing OU) and modifies their properties by adding a description to each account.

```PowerShell
Get-ADUser -Filter 'Name -like "*"' -SearchBase "OU=Marketing,DC=Contoso,DC=Com" | Set-ADUser -Description "Member of the Marketing Department"
```

### Windows PowerShell ISE

The ISE is a fully graphical environment that provides a script editor, debugging capabilities, an interactive console, and several tools that help you discover and learn new Windows PowerShell commands. This module provides a basic familiarity with how the ISE works.

:::image type="content" source="../media/m2-powershell-ise.png" alt-text="A screenshot of Administrator: Windows PowerShell ISE. The administrator has enabled the Command preview window. The administrator has just run Get-localuser in the untitled script pane.":::

#### Panes

The ISE offers two main panes: a Script pane (or script editor) and the Console pane. You can position these one above the other or side-by-side in a two-pane layout. You can also maximize one pane and switch back and forth between the panes. By default, a Command Add-on pane also displays, which enables you to search for or browse available commands, and review and fill in parameters for a command you select. There is also a floating Command window that provides the same functionality.

#### Customizing the view

The ISE provides several ways to customize the view. A slider in the lower-right area of the window changes the active font size. The Options dialog box lets you customize font and color selection for many different Windows PowerShell text elements, such as keywords and string values. The ISE supports the creation of visual themes. A theme is a collection of font and color settings that you can apply as a group to customize the appearance of the ISE. There are several built-in themes that package customizations for purposes such as giving presentations. The ISE also gives you the option to create custom themes.
Other ISE features include:

- A built-in, extensible snippets library that you can use to store commonly used commands.
- The ability to load add-ins created by Microsoft or by third parties that provide additional functionality.
- Integration with Windows PowerShell’s debugging capabilities.

## Windows PowerShell remoting

The purpose of Windows PowerShell remoting is to connect to remote computers so that you can run commands on them, and then direct the results back to your local computer. This enables you to run Windows PowerShell commands on multiple computers on your network from your client computer, rather than using creating a connection to each computer.

A key goal of Windows PowerShell remoting is to enable batch administration, which enables you to run commands on a set of remote computers simultaneously. You can use remoting in one of three ways, described in the following table.

| Method               | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| One-to-One remoting  | In the One-to-One remoting scenario, (also known as *interactive remoting*), you connect to a single remote computer and run Windows PowerShell commands on it, exactly as if you had signed in to the computer and opened a Windows PowerShell window. |
| One-to-Many remoting | In the One-to-Many remoting scenario, (also known as *fan*-*out* *remoting*), you issue a command that will be executed on one or more remote computers in parallel. You are not working with each remote computer interactively. Instead, your commands are issued and executed in a batch, and the results are returned to your computer for your use. |
| Many-to-One remoting | In the Many-to-One remoting scenario, (also known as *fan-in* *remoting*), multiple administrators make remote connections to a single computer. Typically, those administrators will have differing permissions on the same remote computer and might be working in a restricted Windows PowerShell session. |

> [!CAUTION]
> When you run commands on multiple computers, be aware of the differences between the remote computers, such as differences in operating systems, file system structures, and system registries.

## PowerShell Direct

Many administrators choose to run some of their servers in virtualized environments. To enable a simpler administration of Hyper-V VMs running Windows 10 or Windows Server 2019, you can use a feature called PowerShell Direct.

PowerShell Direct enables you to run a Windows PowerShell cmdlet or script inside a VM from the host operating system regardless of network, firewall, and remote management configurations.
