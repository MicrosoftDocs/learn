Here you'll run commands to construct powerful statements that pipe cmdlets together. You'll run helper cmdlets and formatting cmdlets to filter for the data you need and to ensure the result is usable.

## Discover the most-used processes on your machine

To manage your machine, you sometimes need to discover what processes run on it and how much memory and CPU they consume. This information tells you what the machine spends its resources on. You can use this information to decide whether to introduce new processes on your machine, to leave the machine as it is, or to free up resources by closing resource-intensive processes. The more you know about the processes that run on your machine, the better.

To begin, run the command `Get-Process`, and pipe in the cmdlets `Where-Object` and `Sort-Object`.

```powershell
Get-Process | Where-Object CPU -gt 100 | Sort-Object CPU -Descending | Select-Object -First 3
```

The exact output you see depends on your machine, but you should see the first three processes whose CPU value is higher than a 1,000. These processes are sorted in a descending order, with the highest CPU value on top. Your output will look similar to the following example.

```output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00     100.00 120,000.00    4000   1 some-process-name
      0     0.00     100.00  30,000.66     400   1 some-other-process-name
      0     0.00     100.00  27,000.00     500   1 a-process
```

## Compare formatting approaches

Different output formats make sense for different scenarios. Depending on the type of data you're looking for, a table might make more sense than a list, for example. 

Some cmdlets use a certain type of formatting by default. You can override the default formatting by using a formatting cmdlet.

1. Run the `Get-Member` command.

   ```powershell
   "a string" | Get-Member
   ```

   The output is a table that lists all of the members. Here are the first few lines of the output:

   ```output
    Name                 MemberType            Definition
    ----                 ----------            ----------
    Clone                Method                System.Object Clone(), System.Object ICloneable.Clone()
    CompareTo            Method                int CompareTo(System.Object value), int CompareTo(string strB), int IComparable.CompareTo(…
   ```

   Next, you override the default formatting by using the `Format-List` cmdlet.

1. Run the `Format-List` command as you see in the following example.

   ```powershell
   "a string" | Get-Member | Format-List
   ```

   The resulting output is a little different from the earlier output. The first few lines of the output response now appear like a list.

   ```output
    TypeName   : System.String
    Name       : Clone
    MemberType : Method
    Definition : System.Object Clone(), System.Object ICloneable.Clone()

    TypeName   : System.String
    Name       : CompareTo
    MemberType : Method
    Definition : int CompareTo(System.Object value), int CompareTo(string strB), int IComparable.CompareTo(System.Object obj), int 
                 IComparable[string].CompareTo(string other)
    ```
