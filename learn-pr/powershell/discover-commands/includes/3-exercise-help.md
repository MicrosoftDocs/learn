After you find a cmdlet you want to use, you can learn more about it. For example, you can learn about the different ways to call it, what parameters you can use, and example use cases. 

## Use Get-Help to discover commands

Use the `Get-Help` cmdlet to learn about cmdlets.

1. Run the command `Get-Help`:

   ```powershell
   Get-Help -Name Get-FileHash
   ```

   This command produces an output similar to the following text:

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

   Because this output is difficult to read, you decide to use an alternative that is less verbose. That is, you use the `help` alias.

1. Enter the `help` command:

   ```powershell
   help Get-FileHash
   ```

   Now, a reduced version of the help output is shown. It looks like the following text:

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

   You can move through the results vertically, row by row, by using the arrow keys. To view the results page by page, use the Spacebar.

1. Run `help Get-FileHash -Examples`:

   ```powershell
   help Get-FileHash -Examples
   ```

   The output looks like the following text:

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

   This output contains a list of examples that use the cmdlet. Locate the part of the response that contains the text `Example 1`. This portion of the text shows how you can use `Get-FileHash` with a file path by piping it to the cmdlet `Format-List`.

   > [!TIP]
   > To quickly see an example, add the flag `-Examples` when you search for help.
