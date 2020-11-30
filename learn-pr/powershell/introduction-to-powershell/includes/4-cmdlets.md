A _cmdlet_ is a compiled command. It's pronounced "command-let." A cmdlet can be developed in .NET or .NET Core and invoked as a command within PowerShell. Thousands of cmdlets are available in your PowerShell installation. The challenge lies in discovering what they are and what they can do for you.

Cmdlets are named according to a verb-noun naming standard. This pattern can help you to understand what they do and to search for them. It also helps cmdlet developers create consistent names. You can see the list of approved verbsby using the `Get-Verb` cmdlet. Verbs are organized by activity type and function. 

Here's a part of the output from running `Get-Verb`:

```output
Verb        AliasPrefix Group          Description
----        ----------- -----          -----------
Add         a           Common         Adds a resource to a container, or atta…
Clear       cl          Common         Removes all the resources from a contai…
```

This listing shows the verb and its description. Cmdlet developers should not only use an approved verb but also  ensure that the verb description fits their cmdlet's function.

Three cmdlets allow you delve into what cmdlets exist and what they do:

- **Get-Command**: The `Get-Command` cmdlet lists all of the available cmdlets on your system. Filter the list to quickly find the command you need.
- **Get-Help**: Use the `Get-Help` core cmdlet to invoke a built-in help system. Or use an alias `help` command to invoke `Get-Help` but improve the reading experience by paginating the response.
- **Get-Member**: When you call a command, the response is an object that contains numerous properties. Use the `Get-Member` core cmdlet to drill down into that response and learn more about it.

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

## Discover your cmdlets using the help system and Get-Help

You can use the `Get-Command` to locate the specific command that you need. At this point, you might want to know more about what the command does and various ways in which you can call it. You can use the `Get-Help` core cmdlet to learn more about your chosen command. You would typically invoke the Get-Help cmdlet by specifying it by name and -Name flag containing the name of the cmdlet you want to see help on, like so:

```powershell
Get-Help -Name name-of-command
```

### Update help

New versions of PowerShell doesn't ship with help system. The first you run `Get-Help` you will be asked to install the help files. You can also run `Update-Help` cmdlet to install the help files at a later stage. Because a call to `Update-Help` downloads a lot of help files, the command is limited to only this fetch once per day. You can override this fetching behavior by using the force, `-Force` flag.

Updating the help files is done differently on Windows compared to Linux or macOS. It's because when you run `Update-Help` cmdlet, help files are fetched over the Internet matching your computer's culture. On Windows there's a culture already installed, but culture is missing on Linux and macOS. Therefore you need to be specify a culture when updating, like in this example command:

```powershell
Update-Help -UICulture en-US -Verbose
```

The command specifies the `-UICulture` flag and gives it the value `en-US` which fetches US english flavoured help files. Use a culture that corresponds to your machine's culture if using macOS or Linux, to update your help files.

### Help sections

What's returned back from invoking `Get-Help` on a cmdlet is a help page. On that help page, there are many parts being listed. Below are some common help page parts you are likely to see:

- NAME, this part states the name of the command
- SYNTAX, the SYNTAX part shows various ways to call the command using a combination of flags and also allowed parameters in some cases.
- ALIASES. An alias is a command with a different name that invokes the same command. If an alias exist for this command, it would be listed in this section.
- REMARKS. here you can read more about what commands to run to get further help on this command.
- PARAMETERS, this section tells you in detail about the parameter such as its type, a longer description and acceptable values, if applicable.

### Filter the help response

If you don't want the full help page to display, you can narrow down the response by adding flags to your Get-Help command. Here's some flags you could be using:

- **Full**, this flag gives a detailed help page back and specifies things like parameters, inputs and outputs section, that you don't get from the standard response.

- **Detailed**, the response from using this flag looks like the standard response but with the inclusion of the parameters section.

- **Examples**, specifying this flag gives you only the examples back if there are any.
- **Online**, this flag opens up web browser and the specific web page for your command
- **Parameter**, this flag requires a parameter name as an argument as it looks to list a specific parameter's properties.

You could for example ask for only the examples section of the help page with the following command:

```powershell
Get-Help Get-FileHash -Examples
```  

### Improve the read experience

Typing the `Get-Help` command gives you the entire help page all at once. That might not provide the best read experience as you may have to scroll up a bit to the part that interests you. A better approach is to use an alias called `help`. What `help` does is that it pipes `Get-Help` into a function called, which ensure that your output is readable line by line and also that the response can be read page by page.
  
## Discovering objects with Get-Member

What comes out from running a cmdlet is an object. What's good to know is that invoking a cmdlet produces a response that's been formatted and might not necessarily represent all the information available on the response. You can inspect that object and learn more about through the use of the cmdlet `Get-Member`. `Get-Member` is meant to be _piped_ on top of the command you are running and thereby used as a way to filter the output. A typical command-line invocation of `Get-Member` can therefore look like the following example:

```bash
Get-Process -Name name-of-process | Get-Member
```

The above command first produces an object result by calling `Get-Process` and then that result is passed as an input to `Get-Member` via the pipe, `|`. What you get back is a table result with the columns `Name`, `MemberType` and `Definition` and also the type of the returned object.

### Search by type

The first line of the response, calling `Get-Member`, is the type of the returned object. By having the type information, you can search for other cmdlets that operates on same type. It thereby enables you to learn about other related commands which quickly build out your knowledge in the domain you are working in.

Let's say you have invoked the PowerShell command that lists all members for a specific process. At that point, the first few rows of the result look something like this output:

```output
  TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
```

The first row states that the type is `System.Diagnostics.Process`. You can now use this type information as a search argument in looking for other related cmdlets that use this type. Such a command would look like so:

```powershell
Get-Command -ParameterType Process
```

The result is a list of cmdlets that operate on this type and from there, you little by little, learn more and more about PowerShell, through effective use of `Get-Member` and learning to interpret its result.

> [!TIP]
> PowerShell is meant to be learned little at a time. A great way to discover related cmdlets is by using the returned type and search for cmdlets by type.

### Filter `Get-Member` result with `Select-Object`

When you run `Get-Member` the result is verbose, many rows are returned as the object might have properties like events, methods and more. To make the answer less verbose, you can filter on specific columns but also decide on what columns are presented to you. It's also good to know that the answer you get back is already a subset of all the existing columns that does exist on the response.

Let's look at a `Get-Member` response again, where you get a number of columns back. By introducing the cmdlet, `Select-Object` you can now choose which columns are in the response. The command expects either a comma-separated list of column names or a wild card `*`, meaning all the columns.

Using the command `Select-Object` specified like so `Select-Object Name, MemberType` you are specifying just the columns you want, `Name` and `MemberType`. This filtering lead to an output with a lot fewer columns and the result look similar to the below:

```powershell
Name                           MemberType
----                           ----------
Handles                     AliasProperty
```

You can also filter down the response by filtering on the rows. By using, for example,  the flag `-MemberType Method` you are saying you interested in rows where the member type is a method. Showing only such rows can be useful if you want to locate and execute a specific method.

> [!TIP]
> It's generally better to use dedicated cmdlets instead of executing methods on an object.
