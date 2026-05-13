When you find the command that you need for a task, you can use its help file to learn how to use it. One way to learn is to review the examples and try to understand their usage. However, it's uncommon for examples to cover all possible variations of that command's usage. Learning to interpret the help-file syntax can help you to identify all capabilities of a given command.

## Get-Service help

> [!NOTE]
> This unit uses **Get-Service** as the example for reading help file syntax. `Get-Service` works in both Windows PowerShell 5.1 and PowerShell 7. If you encounter **Get-EventLog** in existing scripts or documentation, be aware that it's only available in Windows PowerShell 5.1—it was removed from PowerShell 7. Microsoft recommends **Get-WinEvent** as the modern replacement for event log queries.

Use the help for **Get-Service** as an example. If you enter the command **Get-Help Get-Service** in the console and press the Enter key, the help returns the following syntax:

```ps
Get-Service [[-Name] <String[]>] [-ComputerName <String[]>] [-DependentServices] [-RequiredServices] [-Include <String[]>] [-Exclude <String[]>] [<CommonParameters>]

Get-Service [-ComputerName <String[]>] [-DependentServices] [-RequiredServices] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>] [<CommonParameters>]

```

The two blocks of text are *parameter sets*, each of which represents a way in which you can run the command. Notice that each parameter set has many parameters, and they both have several parameters in common. You can't mix and match parameters between sets. If you decide to use the `-DisplayName` parameter, you can't also use `-Name`, because these parameters don't appear together in the same parameter set.

The `-Name` parameter name is enclosed in square brackets, meaning it's a *positional parameter*. You can retrieve a service without providing the parameter name—you just need to pass the service name as the first argument, because that's the position in the help file where the `-Name` parameter appears. Therefore, the following two commands provide the same results:

```ps
Get-Service –Name Spooler
Get-Service Spooler

```

## Omitting parameter names

Be cautious when omitting parameter names, for a few reasons. You can't omit every parameter. For example, the `-ComputerName` parameter can't have the parameter name omitted. Additionally, you can quickly lose track of where things go. When you provide parameter names, the parameters can appear in any order:

```ps
Get-Service –Name Spooler –ComputerName LON-DC1

```

However, when you omit parameter names, you must ensure to enter parameters in the correct order. For example, the following command won't work because the service name value doesn't appear in the correct position:

```ps
Get-Service –ComputerName LON-DC1 Spooler

```

## Specifying multiple values

Some parameters accept more than one value. In the **SYNTAX** section, a double-square-bracket notation in the parameter value type designates these parameters. For example:

```ps
-Name <string[]>

```

The above syntax indicates that the *–Name* parameter can accept one or more string values. One way to specify multiple values is by using a comma-separated list. You don't have to enclose the values in quotation marks, unless the values themselves contain a comma or white space, such as a space or tab character. For example, use the following command to retrieve services on multiple computers:

```ps
Get-Service –Name Spooler –ComputerName LON-CL1,LON-DC1

```

> [!NOTE]
> You can find more information about each parameter by reviewing the command's full help. For example, run **Get-Help Get-Service –Full** to review the full help for **Get-Service**, and notice the additional information that displays. For example, you can confirm that the `-Name` parameter is optional (it defaults to returning all services) and appears in the first position.

**Best Practice:** If you're just getting started with PowerShell, try to provide full parameter names instead of passing parameter values by position. Full parameter names make commands easier to review and troubleshoot, and they make it easier to notice mistakes if you're entering the command incorrectly.

## Updating help

Windows PowerShell 3.0 and newer versions don't ship with help files. Instead, help files are available as an online service. Microsoft-authored commands have their help files hosted on Microsoft-owned web servers. Non-Microsoft commands are sometimes available online, as long as the author or vendor builds the module correctly and provides an online location for the help files. By using the online model, authors who write commands, including Microsoft authors, can make corrections and improvements to their help files over time, and then deliver them without having to create an entire product update.

Run **Update-Help** to scan your computer for all installed modules, retrieve online help locations for each, and try to download their respective help files. You must run this command as a member of the local **Administrators** group, because PowerShell core command help is stored in the **%systemdir%** folder. PowerShell displays error messages if help isn't downloadable. In such cases, PowerShell will still create a default help display for the commands.

PowerShell defaults to downloading help files in your system's configured language. If help isn't available in that language, PowerShell defaults to the **en-US** (US English) language. You can override this behavior by using a parameter of **Update-Help** to specify the `-UICulture` for which you want to retrieve help.

By default, **Update-Help** will check for help files once every 24 hours, even if you run the command multiple times in a row. To override this behavior, include the `-Force` parameter.

The companion to **Update-Help** is **Save-Help**. It downloads the help content and saves it to a location that you specify. This feature allows you to copy that content to computers that aren't connected to the internet. **Update-Help** offers a parameter to specify an alternative source location. This feature makes it possible to update help on computers that aren't connected to the internet.

Prior to Windows PowerShell 4.0, **Update-Help** and **Save-Help** download help only for the cmdlets installed on the local computer (where you run the command from). In Windows PowerShell 4.0 and newer, you can use **Save-Help** for modules installed on remote computers.
