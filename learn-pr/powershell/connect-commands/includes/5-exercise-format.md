In this unit, you use Azure Cloud Shell on the right as your Linux terminal. Azure Cloud Shell is a shell that you can access through the Azure portal or at https://shell.azure.com. You don't have to install anything on your PC or laptop to use it.

## Compare formatting approaches

Different output formats make sense for different scenarios. Depending on the type of data you're looking for, a table might make more sense than a list, for example. 

Some cmdlets use a certain type of formatting by default. You can override the default formatting by using a formatting cmdlet.

1. Type `pwsh` in a terminal window to start a PowerShell session:

   ```bash
   pwsh
   ```

1. In your PowerShell shell, run the `Get-Member` command.

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