Running a command can be powerful, you get data from your local machine or from across the network. To be even more effective, you need to learn how to get the data that you want. Most commands operate on objects, as input or as output, or both. Objects have properties and you may want to access a subset of those properties and present them in a report. You might also want to sort the data based on one or more properties. But how do you get there?

## Use Get-Member to inspect output

When you pass the results of a command to `Get-Member`, `Get-Member` returns information about the object, like:

- The type of object being passed to Get-Member.
- The Properties of the object that may be evaluated.
- The Methods of the object that may be executed.

Let's demonstrate this fact by running `Get-Member` on the command `Get-Process`.

```powershell
Get-Process | Get-Member
```

Note how you are using the pipe `|` and that by calling `Get-Member`, you are in fact creating a pipeline already. The first few lines of output from the preceding statement look like so:

```output
TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
Name                       AliasProperty  Name = ProcessName
NPM                        AliasProperty  NPM = NonpagedSystemMemorySize64
PM                         AliasProperty  PM = PagedMemorySize64
SI                         AliasProperty  SI = SessionId
VM                         AliasProperty  VM = VirtualMemorySize64
WS                         AliasProperty  WS = WorkingSet64
...
```

The output shows the type of object that the `Get-Process` command returns (`System.Diagnostics.Process`). The rest of the response shows the name, type, and definition of the object's members. You can see that If you want to fit `Get-Process` with another command in a pipeline, pairing it with `Get-Member` is a good first step.

## Select-Object

By default, when you run a command that is going to output to the screen, PowerShell automatically adds the command `Out-Default`. If the data isn't just a collection of strings, but objects - PowerShell looks at the object type to determine if there's a registered view for that object type, and if so, it uses that view.

The view generally doesn't contain all the properties of an object because it wouldn't display properly on screen, so only some of the most common properties are included in the view.

You can override the default view by using `Select-Object` and choosing your own list of properties. You can then send those properties to `Format-Table` or `Format-List`, to display the table however you like.

Consider the result of running `Get-Process` on the process `zsh`:

```output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00       0.01       0.38     644 620 zsh
      0     0.00       0.01       0.38     727 727 zsh
      0     0.00       0.01       0.38     731 731 zsh
      0     0.00       0.01       0.38     743 743 zsh
      0     0.00       0.01       0.38     750 750 zsh
      0     0.00       0.88       0.91   15747 …47 zsh
      0     0.00       0.01       0.29   41983 …83 zsh
      0     0.00       1.16       0.31   68298 …98 zsh
```

What you see is a view that represents what you most likely want to see from this command. However, this view doesn't show you a complete set of information. In order to see something different, you can explicitly specify which properties you want to see in the result.

### Getting the full response

What you've seen so far is a limited response. To present the full response, you use a wildcard `*`, like so:

```powershell
Get-Process zsh | Format-List -Property *
```

The `*` character shows you every attribute and its value, which allows you to investigate the values you're interested in. The full response also uses presentation names for properties instead of the actual property names, and presentation names look good in a report.

Despite these benefits, you may not want a full output of data, but you may not be content with the default response either.

### Selecting specific columns

To limit the response and find a middle ground between the default response and the full response, you want to select some properties you're interested in and have that as parameter input to `Select-Object`. But, and here's a problem, you need to use the real names for the columns. How do you find out the real names? Use `Get-Member`. A call to `Get-Member` gives you all the properties and their actual names.

### Finding the real property name

Let's quickly recap on the default response, with this subset:

```output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00       0.01       0.38     644 620 zsh
```

From the default response, the properties `Id` and `ProcessName` are most likely called the same, but CPU(s) is a presentation name, real property names tend to consist of only text characters and no spaces. To find out the real name for a specific property, you can use `Get-Member`:

```powershell
Get-Process zsh | Get-Member -Name C*
```

You now get a list of all members with names that start with a `C`. Among them is `CPU`, which is likely what you want:

```output
TypeName: System.Diagnostics.Process

Name             MemberType     Definition
----             ----------     ----------
CancelErrorRead  Method         void CancelErrorRead()
CancelOutputRead Method         void CancelOutputRead()
Close            Method         void Close()
CloseMainWindow  Method         bool CloseMainWindow()
Container        Property       System.ComponentModel.IContainer Container {get;}
CommandLine      ScriptProperty System.Object CommandLine {get=…
Company          ScriptProperty System.Object Company {get=$this.Mainmodule.FileVersionInfo.CompanyName;}
CPU              ScriptProperty System.Object CPU {get=$this.TotalProcessorTime.TotalSeconds;}
```

You now know how to use `Select-Object` to ask for exactly what you need with the correct property names, like so:

```powershell
Get-Process zsh | Select-Object -Property Id, Name, CPU
```

And here it is:

```output
Id Name       CPU
-- ----       ---
644 zsh  0.3812141
727 zsh  0.3826498
731 zsh  0.3784953
743 zsh  0.3776352
750 zsh  0.3824036
15747 zsh  0.9097993
41983 zsh  0.2934763
68298 zsh  0.3121695
```

This sequence of commands gives you an output that differs from the default output but contains properties that you care about.

## Sorting

When using `Sort-Object` in a pipeline, PowerShell sorts the output data by using the default properties first. If no such properties exist, it then tries to compare the objects themselves. The sorting is either by ascending or descending order.

By providing properties, you can choose to sort by specific columns, like so:

```powershell
Get-Process | Sort-Object -Descending -Property Name
```

In the preceding command, we're sorting by the column `Name` in descending order. To sort by more than one column, separate the column names with a comma, like so:

```powershell
Get-Process | Sort-Object -Descending -Property Name, CPU
```

In addition to sorting by column name, you can also provide your own custom expression. In this example, we use a custom expression to sort by the columns `Name` and `CPU` and control the sort order for each column.

```powershell
Get-Process 'some process' | Sort-Object -Property @{Expression = "Name"; Descending = $True}, @{Expression = "CPU"; Descending = $False}
```

The preceding example demonstrates how powerful and flexible `Sort-Object` can be. This topic is a bit advanced and out of scope for this module, but will be revisited in more advanced modules.
