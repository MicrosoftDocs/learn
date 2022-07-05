When using the Windows PowerShell pipeline, you can pass data through the pipeline and perform operations on it. This capability lets you perform many bulk operations such as:

- Querying a list of objects.
- Filtering the objects.
- Modifying the objects.
- Displaying the data.

The pipeline's primary limitation is that the process flows only in one direction and it's difficult to perform complex operations. You can use variables to solve this problem. Variables store values and objects in memory so you can perform complex and repetitive operations on them.

Some of the tasks you can do with a variable are:

- Storing the name of a log file that you write data to multiple times.
- Deriving and storing an email address based on the name of a user account.
- Calculating and storing the date representing the beginning of the most recent 30-day period, to identify whether computer accounts have authenticated during that time.

In addition to simple data types such as numbers or strings, variables can contain objects too. When a variable contains an object, you can access all of the object’s characteristics. For example, if you store an Active Directory user object in a variable, all of that user account's properties are stored in the variable as well, and you can review them. To review the variables contained in memory by reviewing the contents of the PSDrive named **Variable**, use the following command:

```powershell
Get-ChildItem Variable:
```

You can also review the variables in memory by using the **Get-Variable** cmdlet:

```powershell
Get-Variable
```

> **Note:** Windows PowerShell includes multiple cmdlets for creating, manipulating, and reviewing variables. However, these are seldom used because you can create and manipulate variables directly, without resorting to using cmdlets. Therefore, this course only briefly mentions cmdlets for manipulating variables.
