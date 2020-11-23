Here you will run commands to construct more powerful statements where cmdlets are _piped_ together. You will run helper cmdlets and formatting cmdlets to ensure you filter out the data you need and that the end result is something that looks usable.

## Discover the most used processes on your machine

Part of managing your machine can be to discover what processes run on it and how much memory and CPU they consume. Knowing that helps you realize what the machine spends its resources on. You can use this information to make decisions like whether you want to introduce new processes on your machine, to leave it be, or if you want to free up resources by closing down costly processes. The more you know what goes on in your machine the better.

Run the command `Get-Process`, using the cmdlets `Where-Object` and `Sort-Object` piped in:

```powershell
Get-Process | Where-Object CPU -gt 1000 | Sort-Object CPU -Descending | SelectObject -First 3
```

The resulting output differs per machine, but should present the three first processes with a CPU value higher than a 1000, sorted in a descending order. The highest CPU value is presented on top and then the next highest and so on. Your output will look similar to this:

```output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00     100.00 120,000.00    4000   1 some-process-name
      0     0.00     100.00  30,000.66     400   1 some-other-process-name
      0     0.00     100.00  27,000.00     500   1 a-process
```

## Compare formatting approaches

Different formats like a table formatting or list formatting make different sense depending on what type of data you look at. Some cmdlets use a certain type of formatting by default. You can override the _default_ formatting by using a formatting cmdlet to suit your needs.

1. Run the following command `Get-Member`:

   ```powershell
   "a string" | Get-Member
   ```

   The output shows as a table and lists all the members. The first few lines of the output look like so:

   ```output
    Name                 MemberType            Definition
    ----                 ----------            ----------
    Clone                Method                System.Object Clone(), System.Object ICloneable.Clone()
    CompareTo            Method                int CompareTo(System.Object value), int CompareTo(string strB), int IComparable.CompareTo(…
   ```

   Next up, let's override the default formatter by using the `Format-List` cmdlet.

1. Run the command `Format-List` like so instead:

   ```powershell
   "a string" | Get-Member | Format-List
   ```

   The resulting output would now show a little differently. The first few lines of the output response now show like a list instead:

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
