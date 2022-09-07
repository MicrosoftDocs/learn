The **Measure-Object** command can accept any kind of object in a collection. By default, the command counts the number of objects in the collection and produces a measurement object that includes the count.

> [!NOTE]
> The **Measure-Object** command has the alias **Measure**.

The *-Property* parameter of **Measure-Object** allows you to specify a single property, which must contain numeric values. You can then include the *-Sum*, *-Average*, *-Minimum*, and *-Maximum* parameters to calculate those aggregate values for the specified property.

> [!NOTE]
> PowerShell allows you to *truncate* a parameter name, or use only a portion of the parameter name, if the truncated name clearly identifies the parameter. You'll frequently notice the *–Sum*, *-Minimum*, and *–Maximum* parameters truncated to *-Sum*, *-Min*, and *-Max*, corresponding to the common English abbreviations for those words. However, you can't shorten *‑Average* to *-Avg*, although beginners frequently try to. You can shorten the *‑Average* parameter to *-Ave*, which is a valid truncation of the name.

The following command counts the number of files in a folder and displays the smallest, largest, and average file sizes:

```powershell
Get-ChildItem -File | Measure -Property Length -Sum -Average -Minimum -Max
```
