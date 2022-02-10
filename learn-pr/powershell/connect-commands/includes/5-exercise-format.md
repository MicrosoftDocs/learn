In this unit, you use Azure Cloud Shell to format your PowerShell output. Azure Cloud Shell is a shell that you can access through the Azure portal. You don't have to install anything on your PC or laptop to use it.

## Compare formatting approaches

Different output formats make sense for different scenarios. For example, depending on the type of data that you want to display, a table might make more sense than a list.

Some cmdlets use a certain type of formatting by default. You can override the default formatting by using a formatting cmdlet.

1. Type `pwsh` in a terminal window to start a PowerShell session:

   ```bash
   pwsh
   ```

1. In your PowerShell shell, run the `Get-Member` command:

   ```powershell
   "a string" | Get-Member
   ```

   The output is a table that lists all the members. Here are the first few lines of the output:

   ```output
    Name                 MemberType            Definition
    ----                 ----------            ----------
    Clone                Method                System.Object Clone(), System.Object ICloneable.Clone()
    CompareTo            Method                int CompareTo(System.Object value), int CompareTo(string strB), int IComparable.CompareTo(…
   ```

   Next, you override the default formatting by using the `Format-List` cmdlet.

1. Run the `Format-List` command, as shown here:

   ```powershell
   "a string" | Get-Member | Format-List
   ```

   The resulting output is different from the preceding output. The first few lines now appear as a list, as shown here:

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
