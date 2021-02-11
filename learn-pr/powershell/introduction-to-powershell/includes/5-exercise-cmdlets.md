In this exercise, you'll run commands that will help you learn more about PowerShell. PowerShell isn't something you learn overnight. It's learned command by command. You can speed up your learning by effectively using the core cmdlets.

## Locate a command

Locate commands by using the `Get-Command` cmdlet. The cmdlet helps you search all of the cmdlets installed on your system. Use flags to narrow down your search results to just the cmdlets that fit your scenario. 

In this scenario, you're looking for a cmdlet that can help you work with files.

1. Run the command `Get-Command` with the flag `-Noun`. Specify `File*` to find anything related to files.

   ```powershell
    Get-Command -Noun File*
    ```

    The response shows something similar to the following text.

    ```output
    CommandType     Name                                               Version    Source
    -----------     ----                                               -------    ------
    Cmdlet          Get-FileHash                                       7.0.0.0    Microsoft.PowerShell.Utility
    Cmdlet          Out-File                                           7.0.0.0    Microsoft.PowerShell.Utility
    Cmdlet          Unblock-File                                       7.0.0.0    Microsoft.PowerShell.Utility
   ```

   The cmdlets `Get-FileHash`, `Out-File`, and `Unblock-File` all match your query. Now you have a manageable response. To further filter the response, add the `-Verb` parameter to your query.

1. Run `Get-Command`. Specify the flags `-Verb` and `-Noun`.

   ```powershell
   Get-Command -Verb Get -Noun File*
   ```

   The result is similar to the following output.

   ```output
   CommandType     Name                                               Version    Source
   -----------     ----                                               -------    ------
   Cmdlet          Get-FileHash                                       7.0.0.0    Microsoft.PowerShell.Utility
   ```

   This time, only one record matches your search because you specified both the `-Noun` parameter and the `-Verb` parameter. 

Because the domain you work in is file management, you specified `File` as the noun. If you know what you want to do within that domain, you can specify `-Verb` parameters. By using one or possibly two parameters, you can quickly find the cmdlet that you need.  

## Use Get-Help to discover commands

After you find a cmdlet you want to use, you can learn more about it. For example, you can learn about the different ways to call it, what parameters you can use, or some example use cases. Use the `Get-Help` cmdlet to learn about cmdlets:

1. Run the command `Get-Help`.

   ```powershell
   Get-Help -Name Get-FileHash
   ```

   This command produces an output similar to the following text.

   ```output
   NAME
    Get-FileHash
    
    SYNTAX
        Get-FileHash [-Path] <string[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] [<CommonParameters>]
        
        Get-FileHash [-LiteralPath] <string[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] [<CommonParameters>]
        
        Get-FileHash [-InputStream] <Stream> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] [<CommonParameters>]
        
    
    ALIASES
        None
        
    
    REMARKS
        Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
            -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
            -- To view the Help topic for this cmdlet online, type: "Get-Help Get-FileHash -Online" or
               go to https://go.microsoft.com/fwlink/?LinkId=517145.
   ```

   Because this output is a difficult to read, you decide to use a less verbose alternative. That is, you use the `help` alias.

1. Type the `help` command.

   ```powershell
   help Get-FileHash
   ```

   You now get a reduced version of the help output. It looks like the following text.

   ```output
   NAME
    Get-FileHash
    
    SYNTAX
        Get-FileHash [-Path] <string[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] [<CommonParameters>]
        
        Get-FileHash [-LiteralPath] <string[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] [<CommonParameters>]
        
        Get-FileHash [-InputStream] <Stream> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] [<CommonParameters>]
        
        
    PARAMETERS
        -Algorithm <string>
   ```

   You can move through the results vertically, row by row, by using the arrow keys. To view the results page by page, use the spacebar.

1. Run `help Get-FileHash -Examples`.

   ```powershell
   help Get-FileHash -Examples
   ```

   The output looks like the following text.

   ```output
   NAME
    Get-FileHash
    
    SYNOPSIS
        Computes the hash value for a file by using a specified hash algorithm.
        
        
        --------- Example 1: Compute the hash value for a file ---------
        
        Get-FileHash /etc/apt/sources.list | Format-List
        
        Algorithm : SHA256
        Hash      : 3CBCFDDEC145E3382D592266BE193E5BE53443138EE6AB6CA09FF20DF609E268
        Path      : /etc/apt/sources.list
   ```

   This output contains a list of examples that use the cmdlet. Locate the part of the response that contains the text `Example 1`. This portion of the text shows how you can use `Get-FileHash` with a file path, piping it to the cmdlet `Format-List`.

   > [!TIP]
   > To quickly see an example, add the flag `-Examples` when you search for help.

## Discover an object by using Get-Member

In some scenarios, you'll need to manage processes on a machine. If you need to stop some of the processes, then you might want to track what processes are running, how much resources they're using, and what their process IDs are. You know that the cmdlet `Get-Process` lists information about processes. Now you want to find what other cmdlets work with processes and what a process consists of. 

In this scenario, you'll use the `Get-Member` cmdlet.

1. Run `Get-Process`.

   ```powershell
   Get-Process
   ```

   The table-like response consists of all running processes on your machine. The exact response depends on what's running on your machine. Pick a process name from the column on the right, and use it as an argument for your next command.

1. Run `Get-Process` again. This time, use the process name and pipe `Get-Member`.

   ```powershell
   Get-Process -Name {selected process name} | Get-Member
   ```

   This command produces a long response that consists of all of the members, events, and methods. At this point, focus on the first line, which lists the following information.

   ```output
   TypeName: System.Diagnostics.Process
   ```

   Now you know the type is `Process`, so you can learn more about what other cmdlets use this type. Next, use `Get-Command` and add the type as a parameter.

1. Run `Get-Command`.

   ```powershell
   Get-Command -ParameterType Process
   ```

   This command produces a response similar to the following text.

   ```output
    CommandType     Name                                               Version    Source
    -----------     ----                                               -------    ------
    Cmdlet          Debug-Process                                      7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Enter-PSHostProcess                                7.0.3.0    Microsoft.PowerShell.Core
    Cmdlet          Get-Process                                        7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Get-PSHostProcessInfo                              7.0.3.0    Microsoft.PowerShell.Core
    Cmdlet          Stop-Process                                       7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Wait-Process                                       7.0.0.0    Microsoft.PowerShell.Management
   ```

Congratulations! By knowing the name of the cmdlet `Get-Process`, you've discovered related commands. You can continue to learn about these commands by using `Get-Help`.
