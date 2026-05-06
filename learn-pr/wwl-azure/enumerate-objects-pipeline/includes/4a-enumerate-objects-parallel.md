PowerShell 7.0 introduced a third parameter set for **ForEach-Object**: the `-Parallel` parameter. This allows multiple pipeline objects to be processed concurrently, rather than one at a time. The `-Parallel` parameter requires PowerShell 7.0 or later — it isn't available in Windows PowerShell 5.1.

## Basic parallel syntax

The basic syntax uses the `-Parallel` parameter with a scriptblock:

```powershell
1..5 | ForEach-Object -Parallel { "Processing $_" }
```

By default, **ForEach-Object -Parallel** runs up to five iterations simultaneously. Use the `-ThrottleLimit` parameter to control the maximum number of concurrent scriptblocks:

```powershell
Get-Content servers.txt | ForEach-Object -Parallel {
    Test-Connection -ComputerName $_ -Count 1
} -ThrottleLimit 10
```

## Passing variables into parallel scriptblocks

Parallel scriptblocks run in separate runspaces and can't directly access variables from the caller's scope. Use the `$using:` scope modifier to pass outer variables in:

```powershell
$logPath = "C:\Logs"
Get-ChildItem $logPath -File | ForEach-Object -Parallel {
    $path = $using:logPath
    Move-Item $_.FullName -Destination "$path\Archive\$($_.Name)"
}
```

> [!NOTE]
> Variables referenced without `$using:` inside a `-Parallel` scriptblock will be `$null` because the scriptblock runs in an isolated runspace.

## When to use parallel enumeration

Parallel execution is best suited for tasks where the work per object is time-consuming and independent, such as:

- Network operations (Test-Connection, Invoke-RestMethod)
- File I/O operations on separate files
- Queries to multiple servers

For trivial tasks, the overhead of creating new runspaces can make parallel execution *slower* than sequential. Use `-Parallel` when each operation takes at least several seconds.

## Additional parameters

- `-TimeoutSeconds` limits how long the parallel operation runs before stopping remaining items.
- `-AsJob` returns the operation as a background job object instead of waiting for results.

```powershell
1..20 | ForEach-Object -Parallel { Start-Sleep 1; $_ } -ThrottleLimit 5 -TimeoutSeconds 10
```
