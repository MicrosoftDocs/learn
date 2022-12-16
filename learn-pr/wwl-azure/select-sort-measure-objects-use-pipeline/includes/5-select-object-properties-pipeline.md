In addition to selecting the first or last number of rows from a collection, you can use **Select-Object** to specify the properties to display. You use the *-Property* parameter followed by a comma-separated list of the properties you want to display. If you think of a collection of objects as a table or spreadsheet, you're choosing the columns to display. After you choose the properties you want, **Select-Object** removes all the other properties (or columns). If you want to sort by a property but not display it, you first use **Sort-Object** and then use **Select-Object** to specify the properties you want to display.

The following command displays a table containing the name, process ID, virtual memory size, paged memory size, and CPU usage for all the processes running on the local computer:

```powershell
Get-Process | Select-Object –Property Name,ID,VM,PM,CPU | Format-Table
```

The *-Property* parameter works with the *-First* or *-Last* parameter. The following command returns the name and CPU usage for the 10 processes with the largest amount of CPU usage:

```powershell
Get-Process | Sort-Object –Property CPU –Descending | Select-Object –Property Name,CPU –First 10
```

Take care when specifying property names. Sometimes, the default screen display that PowerShell creates doesn't use the real property names in the table column headers. For example, the output of **Get-Process** includes a column labeled **CPU(s)**. However, the **System.Diagnostics.Process** object type doesn't have a property that has that name. The actual property name is **CPU**. You can check this by piping the output of **Get-Process** to **Get-Member**.

> **Best Practice**: Always review the property names in the output of **Get-Member** before you use those property names in another command. By doing this, you can help to ensure that you use the actual property names and not ones created for display purposes.
