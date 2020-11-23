Here you will run commands to aid your learning journey in PowerShell. PowerShell isn't something you just learn overnight but something that's learned command by command. However your learning journey can be greatly improved through an effective use of the core cmdlets.

## Locate a command

Locating commands is done with the `Get-Command` cmdlet. The cmdlet helps you search among all the available cmdlets installed on your system. With the help of flags, you can narrow it down to just the cmdlets that fits your scenario. In this scenario, you are looking for cmdlet that helps you work with files.

1. Run the command `Get-Command` with the flag `-Noun` and with `File*` specified (anything related to files):

   ```powershell
    Get-Command -Noun File*
    ```

    the response shows something similar to the below text:

    ```output
    CommandType     Name                                               Version    Source
    -----------     ----                                               -------    ------
    Cmdlet          Get-FileHash                                       7.0.0.0    Microsoft.PowerShell.Utility
    Cmdlet          Out-File                                           7.0.0.0    Microsoft.PowerShell.Utility
    Cmdlet          Unblock-File                                       7.0.0.0    Microsoft.PowerShell.Utility
   ```

   The cmdlets `Get-FileHash`, `Out-File` and `Unblock-File`, all matches your query. At this point, you have a manageable response, only three records matching your query. You could filter it down even more by adding a `-Verb` as parameter to your query next.

1. Run the command `Get-Command` with flags `-Verb` and `-Noun` specified:

   ```powershell
   Get-Command -Verb Get -Noun File*
   ```

   It produces an output similar to the below:

   ```output
   CommandType     Name                                               Version    Source
   -----------     ----                                               -------    ------
   Cmdlet          Get-FileHash                                       7.0.0.0    Microsoft.PowerShell.Utility
   ```

   This time you only get one record to match given that you've specified both the parameters `-Noun` and `-Verb`. As you can see, by knowing the domain you work in, file management, you can specify that as the noun. If you have even more information on what, you want to do within that domain you can specify the `-Verb` parameters. The end result of using one or possibly two parameters is that you can quickly find the cmdlet that you need out of thousands.  

## Use Get-Help to discover commands

When you've tracked down a cmdlet you want to use, you want to know more about it like the different ways you can call it, with what parameters or maybe read up on some example usage cases. The `Get-Help` cmdlet is what you use for those scenarios.

1. Run the command `Get-Help`:

   ```powershell
   Get-Help -Name Get-FileHash
   ```

   the above command produces an output similar to the below text:

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

   You feel the above output is not a great reading experience so you decide on using a little verbose alternative namely the `help` alias.

1. Type the `help` command:

   ```powershell
   help Get-FileHash
   ```

   You now get a reduced version of the help output that looks similar to this text:

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

   Additionally you can use the arrow keys to navigate the results vertically, row by row, using the arrow keys. On top of that, you can also browse the results page by page using the space key.

1 Run `help Get-FileHash -Examples`

   ```powershell
   help Get-FileHash -Examples
   ```

   You will see an out looking like the below text:

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

   The command produces an output containing a list of examples of using the cmdlet. Locate the part of the response containing the text `Example 1`. This portion of the text shows how you can use `Get-FileHash` with a file path and _piping_ it to the cmdlet `Format-List`.

   > [!TIP]
   > Adding the flag `-Examples`, when searching for help will quickly show you a working example, which can greatly speed up your learning.

## Discover object with Get-Member

Managing processes on a machine is a thing you are likely to do. You might want to keep track on what processes are running, how much resources they take up and what ID they have, should you need to close them down. You've found out that there's a cmdlet `Get-Process` that lists information on a process. At this point, you want to find what more cmdlets there are working with processes and what a process consists of. You will use the `Get-Member` cmdlet to tackle this scenario.

1. Run `Get-Process`:

   ```powershell
   Get-Process
   ```

   You will see a table-like response consisting of all running processes on your machine. The exact response may wary depending on what's running on your machine. Pick a process name from the right-most column and use that as an argument for your next command:

1. Run `Get-Process`, this time with process name and with `Get-Member` piped:

   ```powershell
   Get-Process -Name {selected process name} | Get-Member
   ```

   The above command produces a lengthy response consisting of all the members, events, and methods and more. What you care about at this point, is the first line that lists the following information:

   ```output
   TypeName: System.Diagnostics.Process
   ```

   At this point, you know the type that's being dealt with. You can now learn more about what other cmdlets use this type and build out your knowledge, by using `Get-Command` with type as a parameter next.

1. Run the command `Get-Command`:

   ```powershell
   Get-Command -ParameterType Process
   ```

   The command produces a response similar to the below text:

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

   Congrats, by knowing the name of one cmdlet `Get-Process`, you've managed to discover other commands related to it. You can now continue to learn more about these new commands you've discovered by using `Get-Help`.
