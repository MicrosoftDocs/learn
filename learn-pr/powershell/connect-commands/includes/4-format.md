When you work with PowerShell, _filtering_ and _formatting_ are important concepts to understand, for a couple of reasons. First, you want to create a pipeline that produces the result you want. Second, you want to do so efficiently, in terms of both how you pull data over the network and how you ensure that the result is something you can work with.

## Filtering left

In a pipeline statement, _filtering left_ means filtering for the results you want as early as possible. You can think of the term _left_ as _early_, because PowerShell statements run from left to right. The idea is to make the statement fast and efficient by ensuring that the dataset you operate on is as small as possible. This principle really comes into play when your commands are backed by larger data stores or you're bringing back results across the network.

Consider the following statement:

```powershell
Get-Process | Select-Object Name | Where-Object Name -eq name-of-process
```

This statement first retrieves all of the processes on the machine. It ends up formatting the response so that only the `Name` property is listed. This statement doesn't follow the _filtering left_ principle, because it operates on all the processes, attempts to format the response, and then filters at the end.

It's better to filter first and then format, as in the following statement.

```powershell
Get-Process | Where-Object Name -eq name-of-process | Select-Object Name
```

Often, a cmdlet that offers filtering is more efficient than using `Where-Object`. Here's a more efficient version of the preceding statement:

```powershell
Get-Process -Name name-of-process | Select-Object Name
```

In this version, the parameter `-Name` does the filtering for you.

## Formatting right

Whereas _filtering left_ means to filter something as _early_ as possible in a statement, _formatting right_ means to format something as _late_ as possible in the statement. The most common cmdlets to use to format your output are `Format-Table` and `Format-List`. By default, most cmdlets format output as a table. If you want your output to display properties in columns, use the `Format-List` cmdlet to reformat them as a list.
