Sometimes, you might not need to display all the objects that a command produces. For example, you've already learned that the **Get-EventLog** command has a parameter *-Newest* that produces a list of only the newest event log entries. Not all commands have the built-in ability to limit their output like that. However, the **Select-Object** command can limit the output from any command.

> [!NOTE]
> The **Select-Object** command has the alias **Select**.

You can use **Select-Object** to select a subset of the objects that are passed to it in the pipeline. One of the ways you can select a subset of objects is by position. If you think of a collection of objects as a table or spreadsheet, selecting a subset means selecting only certain rows. **Select-Object** can select a specific number of rows. You can't use **Select-Object** to choose those rows by column or property value, only by position. You can instruct it to start from the beginning or the end of the collection. You can also instruct it to skip a certain number of rows before the selection begins. You can use the **Sort-Object** command to control the row order before passing the objects to **Select-Object** in the pipeline.

For example, to select the first 10 processes based on the least amount of virtual memory use, enter the following command in the console, and then press the Enter key:

```powershell
Get-Process | Sort-Object –Property VM | Select-Object –First 10
```

To select last 10 running services and sort them by name, enter the following command in the console, and then press the Enter key:

```powershell
Get-Service | Sort-Object –Property Name | Select-Object –Last 10
```

To select the five processes using the least amount of CPU and skip the one process using the least CPU, enter the following command in the console and press the Enter key:

```powershell
Get-Process | Sort-Object –Property CPU –Descending | Select-Object –First 5 –Skip 1
```

## Selecting unique objects

Consider a scenario in which **Select-Object** evaluates the properties and values when selecting the rows to return. If some members of the object collection passed to **Select-Object** have duplicate names and values, and you include the *-Unique* parameter, **Select-Object** returns only one of the duplicated objects.

For example, if you want to display user information for one user in each department, enter the following command in the console, and then press the Enter key:

```powershell
Get-ADUser -Filter * -Property Department | Sort-Object -Property Department | Select-Object Department -Unique
```
