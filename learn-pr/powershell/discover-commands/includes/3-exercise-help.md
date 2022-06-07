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
    
   SYNOPSIS
       Computes the hash value for a file by using a specified hash algorithm.
    
   SYNTAX
       Get-FileHash [-InputStream] <System.IO.Stream> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] 
       [<CommonParameters>]
    
       Get-FileHash [-LiteralPath] <System.String[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] 
       [<CommonParameters>]
    
       Get-FileHash [-Path] <System.String[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] 
       [<CommonParameters>]
    
   DESCRIPTION
       The `Get-FileHash` cmdlet computes the hash value for a file by using a specified hash algorithm. A hash value 
       is a unique value that corresponds to the content of the file. Rather than identifying the contents of a file 
       by its file name, extension, or other designation, a hash assigns a unique value to the contents of a file. 
       File names and extensions can be changed without altering the content of the file, and without changing the 
       hash value. Similarly, the file's content can be changed without changing the name or extension. However, 
       changing even a single character in the contents of a file changes the hash value of the file.
    
       The purpose of hash values is to provide a cryptographically-secure way to verify that the contents of a file 
       have not been changed. While some hash algorithms, including MD5 and SHA1, are no longer considered secure 
       against attack, the goal of a secure hash algorithm is to render it impossible to change the contents of a file 
       -- either by accident, or by malicious or unauthorized attempt -- and maintain the same hash value. You can 
       also use hash values to determine if two different files have exactly the same content. If the hash values of 
       two files are identical, the contents of the files are also identical.
    
       By default, the `Get-FileHash` cmdlet uses the SHA256 algorithm, although any hash algorithm that is supported 
       by the target operating system can be used.

   RELATED LINKS
       Online Version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-filehash?view=powe
       rshell-7.2&WT.mc_id=ps-gethelp
       Format-List 

   REMARKS
       To see the examples, type: "Get-Help Get-FileHash -Examples"
       For more information, type: "Get-Help Get-FileHash -Detailed"
       For technical information, type: "Get-Help Get-FileHash -Full"
       For online help, type: "Get-Help Get-FileHash -Online"
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
    
   SYNOPSIS
       Computes the hash value for a file by using a specified hash algorithm.
   
   SYNTAX
       Get-FileHash [-InputStream] <System.IO.Stream> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] 
       [<CommonParameters>]
    
       Get-FileHash [-LiteralPath] <System.String[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] 
       [<CommonParameters>]
    
       Get-FileHash [-Path] <System.String[]> [[-Algorithm] {SHA1 | SHA256 | SHA384 | SHA512 | MD5}] 
       [<CommonParameters>]
    
   DESCRIPTION
       The `Get-FileHash` cmdlet computes the hash value for a file by using a specified hash algorithm. A hash value 
       is a unique value that corresponds to the content of the file. Rather than identifying the contents of a file 
       by its file name, extension, or other designation, a hash assigns a unique value to the contents of a file. 
       File names and extensions can be changed without altering the content of the file, and without changing the 
       hash value. Similarly, the file's content can be changed without changing the name or extension. However, 
       changing even a single character in the contents of a file changes the hash value of the file.
    
       The purpose of hash values is to provide a cryptographically-secure way to verify that the contents of a file 
       have not been changed. While some hash algorithms, including MD5 and SHA1, are no longer considered secure 
       against attack, the goal of a secure hash algorithm is to render it impossible to change the contents of a file 
       -- either by accident, or by malicious or unauthorized attempt -- and maintain the same hash value. You can 
       also use hash values to determine if two different files have exactly the same content. If the hash values of 
       two files are identical, the contents of the files are also identical.
    
       By default, the `Get-FileHash` cmdlet uses the SHA256 algorithm, although any hash algorithm that is supported 
       by the target operating system can be used.
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
    
    
       ------ Example 2: Compute the hash value for an ISO file ------
    
       Get-FileHash C:\Users\user1\Downloads\Contoso8_1_ENT.iso -Algorithm SHA384 | Format-List
    
       Algorithm : SHA384
       Hash      : 20AB1C2EE19FC96A7C66E33917D191A24E3CE9DAC99DB7C786ACCE31E559144FEAFC695C58E508E2EBBC9D3C96F21FA3
       Path      : C:\Users\user1\Downloads\Contoso8_1_ENT.iso   
   ```

   This output contains a list of examples that use the cmdlet. Locate the part of the response that contains the text `Example 1`. This portion of the text shows how you can use `Get-FileHash` with a file path by piping it to the cmdlet `Format-List`.

   > [!TIP]
   > To quickly see an example, add the flag `-Examples` when you search for help.
