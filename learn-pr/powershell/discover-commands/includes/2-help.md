You use `Get-Command` to locate a command that you need. After you've located the command you need, you might want to know more about what the command does and various ways to call it. By using the built-in help system, you can find out more about a specific command.

## Discover cmdlets by using the help system and Get-Help

You can use the `Get-Help` core cmdlet to learn more about your chosen command. Typically, you invoke the `Get-Help` cmdlet by specifying it by name and adding the `-Name` flag that contains the name of the cmdlet you want to learn about. Here's an example:

```powershell
Get-Help -Name name-of-command
```

### Update help

New versions of PowerShell don't include the help system by default. The first time you run `Get-Help`, you're asked to install the help files. You can also run the `Update-Help` cmdlet to install the help files. Because a call to `Update-Help` downloads many help files, the command can fetch only once per day by default. You can override this fetching behavior by using the `-Force` flag.

You update the help files differently on Windows compared to Linux or macOS. The process differs because when you run the `Update-Help` cmdlet, help files are fetched over the internet by matching your computer's culture. On Windows, a culture is already installed, but it's missing on Linux and macOS. So you need to specify a culture when you update help files on Linux and macOS.

Here's an example command:

```powershell
Update-Help -UICulture en-US -Verbose
```

This command specifies the `-UICulture` flag. It gives it the value `en-US`, which fetches US-English help files. To update your help files on macOS or Linux, use a culture that corresponds to your machine's culture.

### Explore help sections

When you invoke `Get-Help` on a cmdlet, a help page is returned. The page includes many sections. You'll likely see these common sections:

- **NAME**: This section provides the name of the command.
- **SYNTAX**: This section shows ways to call the command by using a combination of flags and sometimes also allowed parameters.
- **ALIASES**: This section lists any aliases for a command. An alias is a different name for a command, and it can be used to invoke the command.
- **REMARKS**: This section provides information about what commands to run to get more help for this command.
- **PARAMETERS**: This section provides details about the parameter. It lists its type, a longer description, and acceptable values, if applicable.

### Filter the help response

If you don't want to display the full help page, narrow down the response by adding flags to your `Get-Help` command. Here are some flags you can use:

- **Full**: This flag returns a detailed help page. It specifies information like parameters, inputs, and outputs that you don't get in the standard response.
- **Detailed**: This flag's response looks like the standard response, but it includes a section for parameters.
- **Examples**: This flag returns only examples, if any exist.
- **Online**: This flag opens a web page for your command.
- **Parameter**: This flag requires a parameter name as an argument. It lists a specific parameter's properties.

For example, you could use the following command to return only the "Examples" section of the help page.

```powershell
Get-Help Get-FileHash -Examples
```  

### Improve the reading experience

The `Get-Help` command returns the entire help page. This page might not provide the best reading experience. You might have to scroll to the part that interests you. A better approach is to use the `help` alias. The `help` alias pipes `Get-Help` into a function that ensures that your output is readable line by line. It also makes the response readable page by page.
