PowerShell provides several ways to control the formatting of pipeline output. The default formatting of the output depends on the objects that exist in the output and the configuration files that define the output. After PowerShell decides on the appropriate format, it passes the output to a set of formatting cmdlets without your input.

The formatting cmdlets are:

- **Format-List**
- **Format-Table**
- **Format-Wide**
- **Format-Custom**

You can override the default output formatting by specifying any of the preceding cmdlets as part of the pipeline.

> [!NOTE]
> The **Format-Custom** cmdlet requires creating custom XML configuration files that define the format. It's used infrequently and is beyond the scope of this course.

Each formatting cmdlet accepts the *-Property* parameter. The *-Property* parameter accepts a comma‑separated list of property names, and then it filters the list of properties that display and the order in which they display. Keep in mind that when you specify property names for this parameter, the original command must have returned those properties.

For example, the **Get-ADUser** cmdlet returns only a subset of properties, unless you specify its *-Properties* parameter. Therefore, if you specify the **City** property in the *-Property* parameter for a formatting cmdlet, it will display as if the property isn't set, unless you make sure that the **City** property is one of the properties returned for the users queried.

Some cmdlets default to passing a different set of properties for each formatting cmdlet. For example, the **Get-Service** cmdlet displays three properties (**Status**, **Name**, and **DisplayName**) in a table format by default. If you display the output of **Get-Service** as a list by using the **Get-Service | Format-List** command, six additional properties will display.

## Format-List

The **Format-List** cmdlet, as the name suggests, formats the output of a command as a simple list of properties, where each property displays on a new line. If the command passing output to **Format-List** returns multiple objects, a separate list of properties for each object displays. List formatting is particularly useful when a command returns a large number of properties that would be hard to review in table format.

> [!NOTE]
> The alias for the **Format-List** cmdlet is **fl**.

To display a simple list in the console of the default properties for the processes running on the local computer, enter the following command, and then press the Enter key:

```powershell
Get-Process | Format-List 
```

## Format-Table

The **Format-Table** cmdlet formats output as a table, where each row represents an object, and each column represents a property. The table format is useful for displaying properties of many objects at the same time and comparing the properties of those objects.

By default, the table includes the property names as the column headers, which are separated from the data by a row of dashes. The formatting of the table depends on the returned objects. You can modify this formatting by using a variety of parameters, such as:

- *-AutoSize*. This parameter adjusts the size and number of columns based on the width of the data. In Windows PowerShell 5.0 and newer, *-AutoSize* is set to **true** by default. In older versions of Windows PowerShell, the default values might truncate data in the table.
- *-HideTableHeaders*. This parameter removes the table headers from the output.
- *-Wrap*. This parameter causes text that's wider than the column width to wrap to the next line.

> [!NOTE]
> The alias for the **Format-Table** cmdlet is **ft**.

To display the **Name**, **ObjectClass**, and **Description** properties for all Windows Server Active Directory objects as a table, with the columns set to automatically size and wrap the text, enter the following command in the console, and then press the Enter key:

```powershell
Get-ADObject -filter * -Properties * | ft -Property Name, ObjectClass, Description -AutoSize -Wrap
```

## Format-Wide

The output of the **Format-Wide** cmdlet is a single property in a single list displayed in multiple columns. This cmdlet functions like the */w* parameter of the **dir** command in **cmd.exe**. The wide format is useful for displaying large lists of simple data, such as the names of files or processes, in a compact format.

By default, **Format-Wide** displays its output in two columns. You can modify the number of columns by using the *-Column* parameter. The *-AutoSize* parameter, which works the same way it does for **Format‑Table**, is also available. You can't use *-AutoSize* and *-Column* together, however. The *-Property* parameter is also available, but in the case of **Format-Wide**, it can accept only one property name.

> [!NOTE]
> The alias for the **Format-Wide** cmdlet is **fw**.

To send the **DisplayName** property of all the Group Policy Objects (GPOs) in the current domain as output in three columns, enter the following command in the console, and then press the Enter key:

```powershell
Get-GPO -all | fw -Property DisplayName -Column 3
```

