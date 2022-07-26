The **Show-Command** cmdlet opens a window that displays either a list of commands or a specific command's parameters. This window is the same one that displays when you select the **Show** **Command Window** option in the ISE.

To display a specific command's parameters, provide the name of the command as the value for the *‑Name* parameter. For example, to open the **Show** **Command Window** with the command used to retrieve an Active Directory user, enter the following command in the console, and then press the Enter key:

`Show-Command –Name Get-ADUser`

The *–Name* parameter is positional, so the following command produces the same result:

`Show-Command Get-ADUser`

If you select the **Show** **Command Window** option in the ISE, and your cursor is within or immediately next to a command name within the console or scripting pane, the results are the same.

> [!NOTE]
> In these examples, **Show-Command** is the command that you're actually running, but **Get-ADUser** is the name of the command that you want to review in the dialog box.

Within the **Show** **Command Window**, each parameter set for the specified command displays on a separate tab. This makes it visually clear that you can't mix and match parameters between sets.

Once you provide values for all required parameters, you can run the command immediately by selecting **Run** in the **Show** commands window. You can also copy it to the Clipboard by selecting **Copy**. From the Clipboard, you can paste the command into the console, so that you can review the correct command-line syntax without running the command.

Notice that **Show-Command** also exposes the Windows PowerShell *common parameters*, which are a set of parameters that Windows PowerShell adds to all commands to provide a predefined set of core capabilities. You'll learn more about many of the common parameters in upcoming modules. However, if you want to find out about them now, run **help about\_common\_parameters** in Windows PowerShell and review the results.

## Using Get-Help

Windows PowerShell provides extensive in-product help for commands. You can access this help by using the **Get-Help** command. **Get-Help** displays all help content on the screen and lets you scroll through it. You can also use the **Help** function or the **Man** alias, which maps to the **Get-Help** command. All three return basically the same results. These results include a short and long description of the cmdlet, the syntax, any additional remarks from the help author, and links to related cmdlets or additional information online. The **help** and **Man** commands display content in the console one page at a time. The ISE displays the entire help content.

For example, to display the help information for the **Get-ChildItem** cmdlet, enter the following command in the console, and then press the Enter key:

`Get-Help Get-ChildItem`

### Get-Help parameters

The **Get-Help** command accepts parameters that allow you find additional information beyond the information displayed by default. A common reason to seek additional help is to identify usage examples for a command. Windows PowerShell commands commonly include many such examples. For instance, running the command **Get-Help Stop-Process –Examples** will provide examples of using the **Stop-Process** cmdlet.

The *-Full* parameter provides in-depth information about a cmdlet, including:

 -  A description of each parameter.
 -  Whether each parameter has a default value (although this information isn't consistently documented across all commands).
 -  Whether a parameter is mandatory.
 -  Whether a parameter can accept a value in a specific position (in which case the position number, starting from 1, is given) or whether you must enter the parameter name (in which case **named** displays).
 -  Whether a parameter accepts pipeline input and, if so, how.

Other **Get-Help** parameters include:

 -  *‑ShowWindow*. Displays the help topic in a separate window, which makes it much easier to access help while entering commands.
 -  *‑Online*. Displays the online version of the help topic (typically the most up-to-date information) in a browser window.
 -  *‑Parameter ParameterName*. Displays the description of a named parameter.
 -  *‑Category*. Displays help only for certain categories of commands, such as cmdlets and functions.

### Using Get-Help to find commands

The **Get-Help** command can be very useful for finding commands. It accepts wildcard characters\*,\* notably the asterisk (\*) wildcard character. When you ask for help and use wildcard characters with a partial command name, Windows PowerShell will display a list of matching help topics.

By using the information you learned earlier about the verb-noun structure of cmdlets, you can use **Get-Help** as a tool to discover cmdlets even if you don't know their names. For example, if you want all cmdlets that operate on processes, you can enter the command **Get-Help \*process\*** in the console, and then press the Enter key. The results match the ones returned by the command **Get-Command \*process\***, except that **Get-Help** displays a *synopsis*. This synopsis is a short description that helps you identify the command you want.

Sometimes, you might specify a wildcard search that doesn't match any command name. For example, running **Get-Help \*beep\*** won't find any commands that have *beep* in their name. When no results are found, the help system performs a full-text search of available command descriptions and synopses. This search locates any help files that contain *beep*. If there's only a single file with a match, the help system displays its content, rather than displaying a one-item list. In the case of the search term *beep*, **Get-Help** returns a list of two topics: **Set-PSReadlineOption**, a cmdlet, and **about\_Special\_Characters**, a conceptual help topic.
