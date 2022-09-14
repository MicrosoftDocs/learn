Some PowerShell commands produce their output in a specific order. For example, the **Get-Process** and **Get-Service** commands produce output that's sorted alphabetically by name. **Get-EventLog** produces output that's sorted by time. In other cases, the output might not seem to be sorted at all. Sometimes, you might want command output sorted differently from the default. The **Sort-Object** command, which has the alias **sort**, can do that for you.

## Sort-Object

The **Sort-Object** command accepts one or more property names to sort by. By default, the command sorts in ascending order. If you want to reverse the sort order, add the *-Descending* parameter. If you specify more than one property, the command sorts by the first property, then by the second property, and so on. It isn't possible in a single command to sort by one property in ascending order and another in descending order.

The following commands are examples of sorting:

```powershell
Get-Service | Sort-Object –Property Name –Descending
Get-Service | Sort Name –Desc
Get-Service | Sort Status,Name
```

By default, string properties are sorted without regard to case. That is, lowercase and uppercase letters are treated the same. The parameters of **Sort-Object** allow you to specify a case-sensitive sort, a specific culture’s sorting rules, and other options. As with other commands, you can review the help for **Sort-Object** for details and examples.

## Grouping objects by property

Sorting objects also allows you to display objects in groups. The **Format-List, Format-Table**, and **Format-Wide** formatting cmdlets have a *-GroupBy* parameter that accepts a property name. By using the *-GroupBy* parameter, you can group the output by the specified property.

For example, the following command displays the names of services running on the local computer in two two-column lists that are grouped by the **Status** property:

```powershell
Get-Service | Sort-Object Status,Name | fw -GroupBy Status
```

The *-GroupBy* parameter works similarly to the **Group-Object** command. The **Group-Object** command accepts piped input and gives you more control over the grouping of the objects. **Group-Object** has the alias **group**.
