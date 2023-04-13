**Select-Object** can create custom, or *calculated*, properties. Each of these properties has a label, or name, that Windows PowerShell displays in the same way it displays any built-in property name. Each calculated property also has an expression that defines the contents of the property. You create each calculated property by entering the values in a hash table.

## What are hash tables?

A *hash table* is known in some other programming and scripting languages as an *associative array* or *dictionary*. One hash table can contain multiple items, and each item consists of a key and a value, or a *name-value pair*. Windows PowerShell uses hash tables many times and for many purposes. When you create your own hash table, you can specify your own keys.

## Select-Object hash tables

When you use a hash table to create calculated properties by using **Select-Object**, you must use the following keys that Windows PowerShell expects:

- **label**, **l**, **name**, or **n**. This specifies the label, or name, of the calculated property. Because the lowercase **l** resembles the number 1 in some fonts, try to use either **name**, **n**, or **label**.
- **expression** or **e**. This specifies the expression that sets the value of the calculated property.

This means that each hash table contains only one name-value pair. However, you can use more than one hash table to create multiple calculated properties.

For example, suppose that you want to display a list of processes that includes the name, ID, virtual memory use, and paged memory use of each process. You want to use the column labels **VirtualMemory** and **PagedMemory** for the last two properties, and you want those values displayed in bytes. To do so, enter the following command in the console, and then press the Enter key:

```powershell
Get-Process |
Select-Object Name,ID,@{n='VirtualMemory';e={$PSItem.VM}},@{n='PagedMemory';e={$PSItem.PM}}
```

> [!NOTE]
> You can enter the command exactly as displayed and press the Enter key after the vertical pipe character. When you do so, you enter the extended prompt mode. After you enter the rest of the command, press the Enter key on a blank line to run the command.

The previous command includes two hash tables, and each one creates a calculated property. The hash table might be easier to interpret if you create it a bit differently, as the following code depicts:

```powershell
@{
 n='VirtualMemory';
 e={ $PSItem.VM }
 }
```

The previous example uses a semicolon to separate the two key-value pairs, and it uses the keys **n** and **e**. Windows PowerShell expects these keys. The label (or name) is a string, and therefore enclosed in single quotation marks. Windows PowerShell accepts either quotation marks (**" "**) or single quotation marks (**' '**) for this purpose. The expression is a small piece of executable code called a *script block* and is contained within braces (**{ }**).

> [!NOTE]
> `$PSItem` is a special variable created by Windows PowerShell. It represents whatever object was piped into the **Select-Object** command. In the previous example, that's a **Process** object. The period after `$PSItem` lets you access a single member of the object. In this example, one calculated property uses the **VM** property, and the other uses the **PM** property.

> [!NOTE]
> Windows PowerShell 1.0 and Windows PowerShell 2.0 used `$_` instead of `$PSItem`. That older syntax is compatible in Windows PowerShell 3.0 and newer, and many experienced users continue to use it out of habit.

A comma separates each property, such as **Name**, **ID**, and each calculated propert from the others in the list.

## Formatting calculated properties

You might want to modify the previous command to display the memory values in megabytes (MB). PowerShell understands the abbreviations **KB**, **MB**, **GB**, **TB**, and **PB** as representing kilobytes, megabytes, gigabytes, terabytes, and petabytes, respectively. Therefore, you might modify your command as follows:

```powershell
Get-Process |
Select-Object Name,
              ID,
              @{n='VirtualMemory(MB)';e={$PSItem.VM / 1MB}},
              @{n='PagedMemory(MB)';e={$PSItem.PM / 1MB}}
```

In addition to the revised formatting that makes the command easier to review, this example changes the column labels to include the **MB** designation. It also changes the expressions to include a division operation, dividing each memory value by 1 MB. However, the resulting values have several decimal places, which is visually suboptimal.

To improve the output, make the following change:

```powershell
Get-Process |
Select-Object Name,
              ID,
              @{n='VirtualMemory(MB)';e={'{0:N2}' –f ($PSItem.VM / 1MB) -as [Double] }},
              @{n='PagedMemory(MB)';e={'{0:N2}' –f ($PSItem.PM / 1MB) -as [Double] }}
```

This example uses the Windows PowerShell **-f** formatting operator. When used with a string, the **-f** formatting operator instructs Windows PowerShell to replace one or more placeholders in the string with the specified values that follow the operator.

In this example, the string that precedes the **-f** operator instructs Windows PowerShell what data to display. The string '{0:N2}' signifies displaying the first data item as a number with two decimal places. The original mathematical expression comes after the operator. It's in parentheses to make sure that it runs as a single unit. You can enter this command exactly as displayed, press the Enter key on a blank line, and then review the results.

The syntax in the previous example might seem confusing because it contains a lot of punctuation symbols. Start with the basic expression:

```powershell
'{0:N2}' –f ($PSItem.VM / 1MB)
```

The previous expression divides the **VM** property by 1 MB and then formats the result as a number with up to two decimal places. That expression is then placed into the hash table:

```powershell
@{n='VirtualMemory(MB)';e={'{0:N2}' –f ($PSItem.VM / 1MB) }}
```

That hash table creates the custom property named **VirtualMemory(MB)**.

> [!NOTE]
> You can learn more about the **-f** operator by running **Help About_Operators** in Windows PowerShell.
