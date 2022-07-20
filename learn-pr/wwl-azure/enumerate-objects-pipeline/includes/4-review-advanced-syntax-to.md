The advanced syntax for enumeration provides more flexibility and functionality than the basic syntax. Instead of letting you access a single object member, you can run a whole script. That script can include one command, or it can include many commands in sequence.

For example, to encrypt a set of files by using the advanced syntax, enter the following command in the console, and then select Enter:

```powershell
Get-ChildItem –Path C:\ToEncrypt\ -File | ForEach-Object –Process { $PSItem.Encrypt() }
```

The **ForEach-Object** command can accept any number of objects from the pipeline. It has the *-Process* parameter that accepts a script block. This script block runs one time for each object that was piped in. Every time that the script block runs, the built-in variable `$PSItem` (or `$_`) can be used to refer to the current object. In the preceding example command, the **Encrypt()** method of each file object runs.

> **Note:** When used with the advanced syntax, method names are always followed by opening and closing parentheses, even when the method doesn't have any input arguments. For methods that do need input arguments, provide them as a comma-separated list inside the parentheses. Don't include a space or other characters between the method name and the opening parenthesis.

## Advanced techniques

In some situations, you might need to repeat a particular task a specified number of times. You can use **ForEach-Object** for that purpose when you pass it an input that uses the range operator. The *range operator* is two periods (**..**) with no space between them. For example, run the following command:

```powershell
1..100 | ForEach-Object { Get-Random }
```

In the preceding command, the range operator produces integer objects from 1 through 100. Those 100 objects are piped to **ForEach-Object**, forcing the script block to run 100 times. However, because neither `$_` nor `$_PSItem` display in the script block, the actual integers aren't used. Instead, the **Get-Random** command runs 100 times. The integer objects are used only to set the number of times the script block runs.
