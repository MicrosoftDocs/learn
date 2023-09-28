In this unit, you use the Azure Cloud Shell on the right-hand side as your Linux terminal. You can access Cloud Shell through the Azure portal or the [Cloud Shell sign-in](https://shell.azure.com). You don't have to install anything on your PC or laptop to use it.

Here, you run commands that help you learn more about PowerShell. PowerShell isn't something you learn overnight; it's learned command by command. You can speed up your learning by effectively using the core cmdlets.

## Locate a command

Locate commands by running the `Get-Command` cmdlet. This cmdlet helps you search all of the cmdlets installed on your system. Use flags to narrow down your search results to just the cmdlets that fit your scenario.

In this scenario, you're looking for a cmdlet that can help you work with files.

1. Run the command `Get-Command` with the flag `-Noun`. Specify `File*` to find anything related to files.

   ```powershell
    Get-Command -Noun File*
    ```

    The response shows something similar to the following text:

    ```output
    CommandType     Name                                               Version    Source
    -----------     ----                                               -------    ------
    Cmdlet          Get-FileHash                                       7.0.0.0    Microsoft.PowerShell.Utility
    Cmdlet          Out-File                                           7.0.0.0    Microsoft.PowerShell.Utility
    Cmdlet          Unblock-File                                       7.0.0.0    Microsoft.PowerShell.Utility
   ```

   The cmdlets `Get-FileHash`, `Out-File`, and `Unblock-File` all match your query. Now, you have a manageable response. To further filter the response, add the `-Verb` parameter to your query.

1. Run `Get-Command`. Specify the flags `-Verb` and `-Noun`.

   ```powershell
   Get-Command -Verb Get -Noun File*
   ```

   The result is similar to the following output:

   ```output
   CommandType     Name                                               Version    Source
   -----------     ----                                               -------    ------
   Cmdlet          Get-FileHash                                       7.0.0.0    Microsoft.PowerShell.Utility
   ```

   This time, only one record matches your search, because you specified both the `-Noun` parameter and the `-Verb` parameter.

Because the domain you work in is file management, you specified `File` as the noun. If you know what you want to do within that domain, you can specify `-Verb` parameters. By using one or possibly two parameters, you can quickly find the cmdlet you need.