In this unit, you use Azure Cloud Shell as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or the [Azure Cloud Shell](https://shell.azure.com) site. You don't have to install anything on your PC or laptop to use it.

Here you'll run commands to construct powerful statements that pipe cmdlets together. You'll run helper cmdlets and formatting cmdlets to filter for the data you need and to ensure that the result is usable.

## Discover the most-used processes on your machine

To manage your machine, you sometimes need to discover what processes run on it and how much memory and CPU they consume. This information tells you what the machine spends its resources on. You can use this information to decide whether to introduce new processes on your machine, to leave the machine as it is, or to free resources by closing resource-intensive processes. The more you know about the processes that run on your machine, the better.

1. Type `pwsh` in a terminal window to start a PowerShell session:

   ```bash
   pwsh
   ```

1. To begin, run the command `Get-Process`, and pipe in the cmdlets `Where-Object`, `Sort-Object`, and `Select-Object`.

   ```powershell
   Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3
   ```

The exact output you see depends on your machine. But, you should see a result where the first 3 (`-First 3`) processes whose CPU value is greater than 2 (`-gt 2`) are sorted in `-Descending` order. Your output should look similar to the following example:

```output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00     100.00 120,000.00    4000   1 some-process-name
      0     0.00     100.00  30,000.66     400   1 some-other-process-name
      0     0.00     100.00  27,000.00     500   1 a-process
```
