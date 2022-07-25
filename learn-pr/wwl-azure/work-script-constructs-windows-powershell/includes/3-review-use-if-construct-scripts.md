You can use the **If** construct in Windows PowerShell to make decisions. You also can use it to evaluate data you've queried or user input. For example, you could have an **If** statement that displays a warning if available disk space is low.

The **If** construct uses the following syntax:

```powershell
If ($freeSpace -le 5GB) {
   Write-Host "Free disk space is less than 5 GB"
} ElseIf ($freeSpace -le 10GB) {
   Write-Host "Free disk space is less than 10 GB"
} Else {
   Write-Host "Free disk space is more than 10 GB"
}
```

In the previous example, the condition `$freeSpace -le 5GB` is evaluated first. If this condition is true, the script block in the braces is run, and no further processing happens in the **If** construct. In this case, a message indicating that there's less than 5 GB of free disk space is displayed.

If the first condition isn't true, the condition `$freeSpace -le 10GB` that's defined for **ElseIf** is evaluated. If this condition is true, the script block in the braces is run, and no further processing happens in the **If** construct. In this example, there's a single **ElseIf**, but you can have multiple **ElseIf** statements or none.

If all conditions aren't true, then the script block for **Else** is run. **Else** is optional.

> **Note:** When you're making multiple decisions based on a single variable, using multiple **ElseIf** script blocks rather than nesting multiple **If** statements is preferred.
