Running a command can be really powerful, you get data from either your local machine or across the network. To be even more effective, you need to learn how to get the data that you want. Most commands operates on objects, as input or as output, or both. Objects have properties and you likely want a subset of those properties and present them in reports for example. You might also want to sort the data based on one ore more columns. But how do you get there?

## Use Get-Member to inspect output

When you run `Get-Member` on a command, it returns back with the type of object, and properties and methods the returned object consist of. Let's demonstrate this fact by running `Get-Member` on the command `Get-Process`.

```powershell
Get-Process zsh | Get-Member
```

Note how you are using the pipe `|` and that by calling `Get-Member`, you are in fact creating a pipeline already. The outcome of the statement above looks like so (at least the first few lines):

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

Above you are shown both the type of object the `Get-Process` returns, i.e `System.Diagnostics.Process` and also properties. The rest of the response shows all the properties this object consist of. If you wanted to fit `Get-Process` with another command in a pipeline, running `Get-Member` would be the first steps in finding this out.

## Select-Object

When you run a command and get an output, you are not shown the full truth. What you are shown is just a subset of everything that's possible to show as indicated by the below response from running `Get-Process` on the process `zsh`:

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

The way to show something different than the above response is by specifying what properties you want to see.

### Getting the full response

What you've seen so far is a very limited response. To present the full response, you use `Select-Object` and asks for all the properties `*`, like so:

```powershell
Get-Process zsh | Select-Object -Property *
```

This shows you every single attribute and their value and you can start investigating what values you are interested in. You likely don't want this massive response but you may not be content with the default response either.

However, the response you get is using presentational names for properties, not the actual property names and is something that looks good in a report.

### Selecting specific columns

To limit the response and find a middle ground between the default response and the full response, you want to select some properties you are interested in and have that as parameter input to `Select-Object`. But, and here's a problem, you need to use the real names for the columns. How do you find those out? Use `Get-Member`. A call to `Get-Member` gives you all the properties and their actual names.

### Finding the real property name

Let's quickly recap on the default response, with this subset:

```output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00       0.01       0.38     644 620 zsh
```

From the default response, the properties `Id` and `ProcessName` are most likely called the same, but CPU(s) is a presentational name, real property names tend to consist of only text characters and no spaces. To find out the real name for said property, you can use `Get-Member` to find out:

```powershell
Get-Process zsh | Get-Member -Name C*
```

You now get a list of all members that starts with a `C` and among them is `CPU` which is likely what you want:

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

With all these learnings, you can now use `Select-Object` and ask exactly for what you need and with correct property names like so:

```powershell
Get-Process zsh | Select-Object -Property Id, Name, CPU
```

and here it is:

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

an output that differs from the default output but contains properties that you care about.

## Sorting

TODO