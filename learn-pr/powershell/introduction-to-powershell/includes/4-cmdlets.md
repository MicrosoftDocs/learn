A _cmdlet_ (pronounced "command-let") is a compiled command. A cmdlet can be developed in .NET or .NET Core and invoked as a command within PowerShell. Thousands of cmdlets are available in your PowerShell installation. The challenge lies in discovering what they are and what they can do for you.

Cmdlets are named according to a verb-noun naming standard. This pattern can help you to understand what they do and to search for them. It also helps cmdlet developers create consistent names. You can see the list of approved verbs by using the `Get-Verb` cmdlet. Verbs are organized by activity type and function. 

Here's a part of the output from running `Get-Verb`:

```output
Verb        AliasPrefix Group          Description
----        ----------- -----          -----------
Add         a           Common         Adds a resource to a container, or atta…
Clear       cl          Common         Removes all the resources from a contai…
```

This listing shows the verb and its description. Cmdlet developers should use an approved verb and also ensure that the verb description fits their cmdlet's function.

Three core cmdlets allow you delve into what cmdlets exist and what they do:

- **Get-Command**: The `Get-Command` cmdlet lists all of the available cmdlets on your system. Filter the list to quickly find the command you need.
- **Get-Help**: Use the `Get-Help` core cmdlet to invoke a built-in help system. Or use an alias `help` command to invoke `Get-Help` but improve the reading experience by paginating the response.
- **Get-Member**: When you call a command, the response is an object that contains many properties. Use the `Get-Member` core cmdlet to drill down into that response and learn more about it.

## Locate commands by using Get-Command

When you run the `Get-Command` cmdlet in the shell, you get a list of every command that's installed in PowerShell. Because thousands of commands are installed, you need a way to filter the response so you can quickly locate the command that you need. 

To filter the list, keep in mind the verb-noun naming standard for cmdlets. For example, in the `Get-Random` command, `Get` is the verb and `Random` is the noun. Use flags to target either the verb or the noun in the command you want. The flag you specify expects a value that's a string. You can add pattern-matching characters to that string to ensure you express that, for example, a flag's value should start or end with a certain string.  

These examples show how to use flags to filter a command list:

- **-Noun**: The `-Noun` flag targets the part of the command name that's related to the noun. That is, it targets everything after the hyphen (`-`). Here's a typical search for a command name:

   ```powershell
   Get-Command -Noun a-noun*
   ```

   This command searches for all cmdlets whose noun part starts with `a-noun`.

- **-Verb**: The `-Verb` flag targets the part of the command name that's related to the verb. You can combine the `-Noun` flag and the `-Verb` flag to create an even more detailed search query and type. Here's an example:

   ```powershell
   Get-Command -Verb Get -Noun a-noun*
   ```

   Now you've narrowed the search to specify that the verb part needs to match `Get`, and the noun part needs to match `a-noun`.

## Discover cmdlets by using the help system and Get-Help

You've now learned how to use `Get-Command` to locate a command that you need. At this point, you might want to know more about what the command does and various ways to call it. You can use the `Get-Help` core cmdlet to learn more about your chosen command. Typically, you invoke the `Get-Help` cmdlet by specifying it by name and adding the `-Name` flag that contains the name of the cmdlet you want to learn about. Here's an example:

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
  
## Discover objects by using Get-Member

When a cmdlet runs, it returns an object. When you invoke a cmdlet, the response you see has been formatted and might not necessarily represent all of the available information for the response. You can inspect the object to learn more by using the cmdlet `Get-Member`. 

The `Get-Member` cmdlet is meant to be _piped_ on top of the command you run so you can filter the output. A typical command-line invocation of `Get-Member` can look like the following example:

```bash
Get-Process -Name name-of-process | Get-Member
```

This command first produces an object result by calling `Get-Process`. That result is passed as an input to `Get-Member` by using the pipe (`|`). In return, you get a table result that includes the columns `Name`, `MemberType`, and `Definition`. You also get the type of the returned object.

### Search by type

The first line of the response, running the `Get-Member` command, is the type of the returned object. When you know the type, you can search for other cmdlets that operate on the same type. Explore these related commands to quickly build your knowledge in the domain you're working in.

Let's say you invoked the PowerShell command that lists all members for a specific process. The first few rows of the result look something like this output:

```output
  TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
```

The first row indicates that the type is `System.Diagnostics.Process`. Use this type as a search argument to look for other cmdlets that use this type. Here's an example command:

```powershell
Get-Command -ParameterType Process
```

The result is a list of cmdlets that operate on this type. Little by little you can learn more about PowerShell by using `Get-Member` and learning to interpret its result.

> [!TIP]
> PowerShell is meant to be learned a little at a time. A great way to discover related cmdlets is by using the returned type to search for cmdlets by type.

### Filter a Get-Member result by using Select-Object

When you run `Get-Member`, the result is _verbose_. That is, many rows are returned. The object might have properties like events and methods. To make the answer less verbose, you can filter on specific columns and also decide which columns to display. Keep in mind that the returned answer is already a subset of all of the columns in the response.

Take a look at a `Get-Member` response that includes many columns. By introducing the cmdlet `Select-Object`, you can choose which columns appear in the response. The command expects either a comma-separated list of column names or a wildcard character such as an asterisk (`*`), which indicates all of the columns.

When you use the command `Select-Object` in the context of `Select-Object Name, MemberType`, you specify just the columns you want. In this case, those columns are `Name` and `MemberType`. This filtering pattern returns an output that includes a lot fewer columns. Here's an example of the result:

```powershell
Name                           MemberType
----                           ----------
Handles                     AliasProperty
```

You can also filter the response by rows. For example, you can use the flag `-MemberType Method` to specify that you're interested in the rows where the member type is a method. You might want to show only specific rows, for example, if you want to locate and run a specific method.

> [!TIP]
> It's generally better to use dedicated cmdlets than to run methods on an object.
