The **Where-Object** command and its alias, **Where**, have two syntax forms: basic and advanced. These two forms are defined by an extensive list of parameter sets—one for each comparison operator. This allows for an easy-to-review syntax, especially in the basic form.

For example, to display a list of only the running services, enter the following command in the console, and then press the Enter key:

```powershell
Get-Service | Where Status –eq Running
```

You start this basic syntax with the **Where** alias (you can also specify the full command name, **Where-Object**), followed by the property that you want PowerShell to compare. Then you specify a comparison operator, followed by the value that you want PowerShell to compare. Every object that has the specified value in the specified property will be kept.

If you misspell the property name, or if you provide the name of a nonexistent property, PowerShell won't generate an error. Instead, your command won't generate any output. For example, consider the following command:

```powershell
Get-Service | Where Stat –eq Running
```

This command produces no output, because no service object has a **Stat** property that contains the value **Running**. In fact, none of the service objects have a **Stat** property. The comparison returns False for every object, which filters out all objects from the results.

> [!NOTE]
> Because of the large number of parameter sets needed to make the basic syntax functional, the help file for **Where-Object** is very long and might be difficult to review. Consider skipping the initial syntax section and going directly to the description or examples if you need help with this command.

## Limitations of the basic syntax

You can use the basic syntax for only a single comparison. You can't, for example, display a list of the services that are stopped and have a start mode of **Automatic**, because that requires two comparisons.

You can't use the basic syntax with complex expressions. For example, the **Name** property of a service object consists of a string of characters. PowerShell uses a **System.String** object to contain that string of characters, and a **System.String** object has a **Length** property. The following command won't work with the basic filtering syntax:

```powershell
Get-Service | Where Name.Length –gt 5
```

The intent is to display all the services that have a name longer than five characters. However, this command will never produce output. As soon as you exceed the capabilities of the basic syntax, you must move to the advanced filtering syntax.
