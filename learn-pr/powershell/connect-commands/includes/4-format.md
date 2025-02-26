When you work with PowerShell, *filtering* and *formatting* are important concepts to understand, for a couple of reasons. First, you want to create a pipeline that produces the result you want. Second, you want to do so efficiently. Both in terms of how you pull data over the network, and how you ensure that the result is something you can work with.

## Filtering left

In a pipeline statement, *filtering left* means filtering for the results you want as early as possible. You can think of the term *left* as *early*, because PowerShell statements run from left to right. The idea is to make the statement fast and efficient by ensuring that the dataset you operate on is as small as possible. This principle really comes into play when your commands are operating on larger data stores or you're bringing back results across the network.

Consider the following statement:

```powershell
Get-Process | Select-Object Name | Where-Object Name -eq 'name-of-process'
```

This statement first retrieves all of the processes on the machine. It ends up formatting the response so that only the `Name` property is listed. This statement doesn't follow the *filtering left* principle, because it operates on all the processes, attempts to format the response, and then filters at the end.

It's better to filter first and then format, as in the following statement.

```powershell
Get-Process | Where-Object Name -eq 'name-of-process' | Select-Object Name
```

Often, a cmdlet that offers filtering is more efficient than using `Where-Object`. Here's a more efficient version of the preceding statement:

```powershell
Get-Process -Name 'name-of-process' | Select-Object Name
```

In this version, the parameter `-Name` does the filtering for you.

## Formatting right, formatting as the last thing you do

Whereas *filtering left* means to filter something as *early* as possible in a statement, *formatting right* means to format something as *late* as possible in the statement. Ok, but why do I need to format late? The answer is because format commands alter the structure of the object that your results are contained in so that your data is no longer found in the same properties. This alteration impacts your ability to retrieve the information you want by using pipe commands, `Select-Object`, or by looping through the results with `foreach`.

The formatting destroys the object with which you're dealing. Take the following call for example:

```powershell
Get-Process 'some process' | Select-Object Name, CPU | Get-Member
```

The type you get back is `System.Diagnostics.Process`. Now, add the `Format-Table` formatter like so:

```powershell
Get-Process 'some process' | Format-Table Name,CPU | Get-Member
```

Focusing just on the types you get back, notice you're getting back something different:

```output
TypeName: Microsoft.PowerShell.Commands.Internal.Format.FormatStartData
TypeName: Microsoft.PowerShell.Commands.Internal.Format.GroupStartData
TypeName: Microsoft.PowerShell.Commands.Internal.Format.FormatEntryData
TypeName: Microsoft.PowerShell.Commands.Internal.Format.GroupEndData
```

What these types are, isn't important for this lesson. What's important to realize is that when you use any type of formatting command, your data is different. And when it's different, it may no longer contain the columns you care about. Let's illustrate with an example:

```powershell
Get-Process 'some process' | Select-Object Name, Cpu
```

The preceding command gives you a result with the columns `Name` and `CPU`.

```output
Name       CPU
----       ---
zsh  1.2984395
zsh  0.2522047
zsh  0.2486375
zsh  0.2683466
zsh  0.2681874
zsh  1.6799438
zsh  0.2909816
zsh  0.7855272
```

Let's use formatting first and then `Select-Object`, to illustrate what might happen if you don't format last:

```powershell
Get-Process 'some process' | Format-Table Name,CPU | Select-Object Name, CPU
```

The result now looks like so:

```output
Name CPU
---- ---
```

It's empty, because `Format-Table` transformed the object containing your results by placing data into other properties. Your data isn't gone, only your properties. The preceding PowerShell command makes an attempt to find the properties but is unable to.

Formatting commands should be the last thing you use in your statement because they're meant for formatting things nicely for screen presentation. They aren't meant to be used as a way to filter or sort your data.

### Formatting commands

The most common cmdlets to use to format your output are `Format-Table` and `Format-List`. By default, most cmdlets format output as a table. If you don't want your output to display properties in columns, use the `Format-List` cmdlet to reformat them as a list.
