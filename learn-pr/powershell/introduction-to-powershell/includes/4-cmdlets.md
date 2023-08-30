A *cmdlet* (pronounced "command-let") is a compiled command. A cmdlet can be developed in .NET or .NET Core and invoked as a command within PowerShell. Thousands of cmdlets are available in your PowerShell installation. The challenge lies in discovering what the cmdlets are and what they can do for you.

Cmdlets are named according to a verb-noun naming standard. This pattern can help you to understand what they do and how to search for them. It also helps cmdlet developers create consistent names. You can see the list of approved verbs by using the `Get-Verb` cmdlet. Verbs are organized according to activity type and function.

Here's a part of the output from running `Get-Verb`:

```output
Verb        AliasPrefix Group          Description
----        ----------- -----          -----------
Add         a           Common         Adds a resource to a container, or atta…
Clear       cl          Common         Removes all the resources from a contai…
```

This listing shows the verb and its description. Cmdlet developers should use an approved verb, and also ensure that the verb description fits their cmdlet's function.

Three core cmdlets allow you to delve into what cmdlets exist and what they do:

- **Get-Command**: The `Get-Command` cmdlet lists all of the available cmdlets on your system. Filter the list to quickly find the command you need.
- **Get-Help**: Run the `Get-Help` core cmdlet to invoke a built-in help system. You can also run an alias `help` command to invoke `Get-Help` but improve the reading experience by paginating the response.
- **Get-Member**: When you call a command, the response is an object that contains many properties. Run the `Get-Member` core cmdlet to drill down into that response and learn more about it.

## Locate commands by using Get-Command

When you run the `Get-Command` cmdlet in Cloud Shell, you get a list of every command that's installed in PowerShell. Because thousands of commands are installed, you need a way to filter the response so you can quickly locate the command that you need.

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
