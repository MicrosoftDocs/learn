The **Switch** construct is similar to an **If** construct that has multiple **ElseIf** sections. The **Switch** construct evaluates a single variable or item against multiple values and has a script block for each value. The script block for each value is run if that value matches the variable. There's also a **Default** section that runs only if there are no matches.

The **Switch** construct uses the following syntax:

```powershell
Switch ($choice) {
   1 { Write-Host "You selected menu item 1" }
   2 { Write-Host "You selected menu item 2" }
   3 { Write-Host "You selected menu item 3" }
   Default { Write-Host "You did not select a valid option" }
}
```

In addition to matching values, the **Switch** construct can also be used to match patterns. You can use the *-wildcard* parameter to perform pattern matching by using the same syntax as the *-like* operator. Alternatively, you can use the *-regex* parameter to perform matching by using regular expressions.

It's important to be aware that when you use pattern matching, multiple matches are possible. When there are multiple matches, the script blocks for all matching patterns are run. This is different from an **If** construct in which only one script block is run.

The following example uses pattern matching:

```powershell
Switch -WildCard ($ip) {
   "10.*" { Write-Host "This computer is on the internal network" }
   "10.1.*" { Write-Host "This computer is in London" }
   "10.2.*" { Write-Host "This computer is in Vancouver" }
   Default { Write-Host "This computer is not on the internal network" }
 }
```

For values of `$ip` on the London or Vancouver networks, two messages will be displayed. If `$ip` includes an IP address on the 10.x.x.x network, the messages will indicate that the computer is on the internal network and that the computer is in either London or Vancouver. If `$ip` is not an IP address on the 10.x.x.x network, the message indicates that it's not on the internal network.

If you provide multiple values in an array to a **Switch** construct, each item in the array is evaluated. In the previous example, if the variable `$ip` was an array with two IP addresses, then both IP addresses would be processed. The actions appropriate for each item in the array would be performed.
