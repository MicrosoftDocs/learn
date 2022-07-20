You can use parenthetical commands to provide parameter input without using the pipeline. In some cases, however, you might have to manipulate the objects produced by a parenthetical command so that the command’s output is of the type that the parameter requires.

For example, you might want to list all the processes that are running on every computer in the domain. In this example, imagine that you have a very small lab domain that contains just a few computers. You can get a list of every computer in the domain by running the following command:

```powershell
Get-ADComputer –Filter *
```

However, this command produces objects of the type **ADComputer**. You could not use those objects directly in a parenthetical command such as the following:

```powershell
Get-Process –ComputerName (Get-ADComputer –Filter *)
```

The **–ComputerName** parameter expects objects of the type **String**. However, the parenthetical command does not produce **String** type objects. The **–ComputerName** parameter only wants a computer name. However, the command provides it an object that contains a name, an operating system version, and several other properties.

You could try the following command:

```powershell
Get-Process –ComputerName (Get-ADComputer –Filter * | Select-Object –Property Name)
```

This command selects only the **Name** property. This property is still a member of a whole **ADComputer** object. It is the **Name** property of an object. Although the **Name** property contains a string, it is not itself a string. The **–ComputerName** parameter expects a string, not an object with a property. Therefore, that command does not work either.

The following command achieves the goal of passing the computer name as a string to the **-ComputerName** parameter:

```powershell
Get-Process –ComputerName (Get-ADComputer –Filter * | Select-Object –ExpandProperty Name)
```

The –ExpandProperty parameter accepts one, and only one, property name. When you use that parameter, only the contents of the specified property are produced by Select-Object. Some people refer to this as extracting the property contents. The official description of the feature is expanding the property contents.

In the preceding command, the result of the parenthetical command is a collection of strings that are passed as individual strings, not an array, and that is what the **–ComputerName** parameter expects. The command will work correctly; of course, it might produce an error if one or more of the computers cannot be reached on the network.

Expanding property values also works when piping output. Consider the following example:

```powershell
Get-ADUser Ty -Properties MemberOf | Get-ADGroup
```

This command returns an error because Windows PowerShell cannot match the **MemberOf** property to any property of **Get-ADGroup**.

However, if you expand the value of the **MemberOf** property, as in the following example, Windows PowerShell can match the resulting output to a value that 
**Get-ADGroup** understands as valid input:

```powershell
Get-ADUser Ty -Properties MemberOf | Select-Object -ExpandProperty MemberOf | Get-ADGroup 
```
