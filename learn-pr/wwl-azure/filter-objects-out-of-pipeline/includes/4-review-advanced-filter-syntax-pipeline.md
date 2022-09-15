The advanced syntax of **Where-Object** uses a filter script. A *filter script* is a script block that contains the comparison and that you pass by using the *-FilterScript* parameter. Within that script block, you can use the built-in `$PSItem` variable (or `$_`, which is also valid in versions of Windows PowerShell older than 3.0) to reference whatever object was piped into the command. Your filter script runs one time for each object that's piped into the command. When the filter script returns True, that object is passed down the pipeline as output. When the filter script returns False, that object is removed from the pipeline.

The following two commands are functionally identical. The first uses the basic syntax, and the second uses the advanced syntax to do the same thing:

```powershell
Get-Service | Where Status –eq Running

Get-Service | Where-Object –FilterScript { $PSItem.Status –eq 'Running' }
```

The *-FilterScript* parameter is positional, and most users omit it. Most users also use the **Where** alias or the **?** alias, which is even shorter. Experienced Windows PowerShell users also use the `$_` variable instead of `$PSItem`, because only `$_` is allowed in Windows PowerShell 1.0 and Windows PowerShell 2.0. The following commands perform the same task as the previous two commands:

```powershell
Get-Service | Where {$PSItem.Status –eq 'Running'}

Get-Service | ? {$_.Status –eq 'Running'}
```

The single quotation marks (**' '**) around **Running** in these examples are required to make it clear that it's a string. Otherwise, PowerShell will try to run a command called **Running**, which will fail because no such command exists.

## Combining multiple criteria

The advanced syntax allows you to combine multiple criteria by using the **-and** and **-or** Boolean, or logical, operators. Here's an example:

```powershell
Get-EventLog –LogName Security –Newest 100 |
Where { $PSItem.EventID –eq 4672 –and $PSItem.EntryType –eq 'SuccessAudit' } 
```

The logical operator must have a complete comparison on either side of it. In the preceding example, the first comparison checks the **EventID** property, and the second comparison checks the **EntryType** property. The following example is one that many beginning users try. It's incorrect, because the second comparison is incomplete:

```powershell
Get-Process | Where { $PSItem.CPU –gt 30 –and VM –lt 10000 } 
```

The problem is that **VM** has no meaning, but `$PSItem.VM` would be correct. Here's another common mistake:

```powershell
Get-Service | Where { $PSItem.Status –eq 'Running' –or 'Starting' }
```

The problem is that **'Starting'** isn't a complete comparison. It's just a string value, so `$PSItem.Status
 -eq 'Starting'` would be the correct syntax for the intended result.

## Accessing properties that contain True or False

Remember that the only purpose of the filter script is to produce a True or False value. Usually, you produce those values by using a comparison operator, like in the examples that you've learned up to this point. However, when a property already contains either True or False, you don't have to explicitly make a comparison. For example, the objects produced by **Get-Process** have a property named **Responding**. This property contains either True or False. This value indicates whether the process represented by the object is currently responding to the operating system. To obtain a list of the processes that are responding, you can use either of the following commands:

```powershell
Get-Process | Where { $PSItem.Responding –eq $True }

Get-Process | Where { $PSItem.Responding }
```

In the first command, the special shell variable `$True` is used to represent the Boolean value True. The second command has no comparison at all, but it works because the **Responding** property already contains True or False.

It's similar to reverse the logic to list only the processes that aren't responding:

```powershell
Get-Process | Where { -not $PSItem.Responding }
```

In the preceding example, the **-not** logical operator changes True to False, and it changes False to True. Therefore, if a process isn't responding, its **Responding** property is False. The **-not** operator changes the result to True, which causes the process to be passed into the pipeline and included in the final output of the command.

## Accessing properties without limitations

Although the basic filtering syntax can access only the direct properties of the object being evaluated, the advanced syntax doesn't have that limitation. For example, to display a list of all the services that have names longer than eight characters, use this command:

```powershell
Get-Service | Where {$PSItem.Name.Length –gt 8}
```
