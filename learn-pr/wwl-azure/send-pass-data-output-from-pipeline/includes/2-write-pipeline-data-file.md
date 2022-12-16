PowerShell provides several ways to write output to a file. The **Out-File** command can accept input from the pipeline and write that data to a file. It can render objects as text by using the same technique that Windows PowerShell uses to render objects as text for on-screen display. That is, whatever you pipe into **Out-File** is the same as what would otherwise display on the screen.

PowerShell also supports converting and exporting objects, which the next topics examine. The **Out-File** behavior differs from converting or exporting the objects, because you don’t change the form of the objects. Instead, PowerShell captures what would have displayed on the screen.

Various **Out-File** parameters allow you to specify a file name, append content to an existing file, specify character encoding, and more. PowerShell also supports the text redirection operators (**>** and **>>**) that **cmd.exe** uses. These operators act as an alias for **Out-File**. The greater than sign (**>**) at the end of a pipeline directs output to a file, overwriting the content. Two consecutive greater than signs (**>>**) direct output to a file, appending the output to any text already in the file.

**Out-File** is the easiest way to move data from PowerShell to external storage. However, the text files that **Out-File** creates are usually intended for reviewing by a person. Therefore, reading the data back into Windows PowerShell in a way that enables data manipulation, sorting, selection, and measurement is frequently difficult or impractical.

**Out-File** doesn't produce any output of its own, which means that the command doesn't put objects into the pipeline. After you run the command, you should expect no output on the screen.

## Keeping track of what the pipeline contains

As you begin to create more complex commands in PowerShell, you need to become accustomed to keeping track of the pipeline’s contents. As each command in the pipeline runs, it might produce output different from the input it received. Therefore, the next command will work with something different.

For example, review the following pipeline:

```powershell
Get-Service |
Sort-Object –Property Status, Name |
Select-Object –Property DisplayName,Status |
Out-File –FilePath ServiceList.csv
```

The preceding example contains five commands in a single command line, or pipeline:

- After **Get-Service** runs, the pipeline contains objects of type **System.ServiceProcess.ServiceController**. These objects have a known set of properties and methods.
- After **Sort-Object** runs, the pipeline still contains those **ServiceController** objects. **Sort-Object** produces output that has the same kind of object that was put into it.
- After **Select-Object** runs, the pipeline no longer contains **ServiceController** objects. Instead, it contains objects of type **Selected.System.ServiceProcess.ServiceController**. This behavior indicates that the objects derive from the regular **ServiceController** but have had some of their members removed. In this case, the objects contain only their **DisplayName** and **Status** properties, so you can no longer sort them by **Name**, because that property no longer exists.
- After **Out-File** runs, the pipeline contains nothing. Therefore, nothing displays on the screen after this complete command runs.

> [!NOTE]
> When you have a complex, multiple‑command pipeline such as this one, you might have to debug it if it doesn't run correctly the first time. The best way to debug is to start with one command and check what it produces. Then add the second command, and check what happens. Continue to add one command at a time, verifying that each one produces the output you expect before you add the next command. For example, the output of the previous command might not seem to be correctly sorted, because the sorting was done on the **Name** property and not the **DisplayName** property.
