Windows PowerShell provides access protection to variables, aliases, functions, and Windows PowerShell drives by limiting where they can be changed and read. By enforcing a few simple rules using Windows PowerShell scopes, you ensure that you don't inadvertently change an item that shouldn't be changed. The basic rules of scopes are:

- Unless you explicitly make it private, items you include in a scope are visible in the scope in which it was created and in any child scope. You can use variables, aliases, functions, or Windows PowerShell drives in one or more scopes.
- Items you create within a scope can be changed only in the scope in which the item was created unless you explicitly stipulate a different scope.

If you create an item in a scope and the item has the same name as an item in a different scope, the original item might get hidden under the new item. However, it doesn't get overridden or changed.

You can use local variables in remote commands, but you must indicate that the variable is defined in the local session. Windows PowerShell assumes that the variables used in remote commands are defined in the session in which the command runs.

## The $Using: scope modifier

As mentioned earlier, starting with Windows PowerShell 3.0, you can implement the `$Using:` scope modifier to identify a local variable in a remote command. This is a special scope modifier and is the most straightforward way to reference a local variable in a remote command. This technique passes on the variable value(s) to the remote computer, and therefore involves less processing across the hosts being used. By default, variables in remote commands are assumed to be defined in the remote session.

### The syntax of Using is `$Using:`.

In the following example, the `$ps` variable is created in the local session but is used in the session in which the command runs. The `$Using:` scope modifier identifies `$ps` as a local variable:

```powershell
$ps = "Windows PowerShell" 

Invoke-Command -ComputerName LON-DC1 -ScriptBlock {Get-WinEvent -LogName $Using:ps}
```

You can also apply the `$Using:` scope modifier in PSSessions such as in the following example:

```powershell
$s = New-PSSession -ComputerName LON-DC1

$ps = "Windows PowerShell"

Invoke-Command -Sessions $s -ScriptBlock {Get-WinEvent -LogName $Using:ps}
```
