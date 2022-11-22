Many applications can export data to a CSV file. This ability makes the **Import-Csv** cmdlet useful because it can import data that was exported from those applications. When the CSV file is imported, each line in the file becomes an item in an array, except the first row. The first row in the CSV file is a header row that's used to name the properties of each item in the array.

The **Import-Csv** cmdlet uses the following syntax:

```powershell
$users = Import-Csv C:\Scripts\Users.csv
```

Example data for **Users.csv**:

```powershell
First,Last,UserID,Department
Amelie,Garner,AGarner,Sales
Evan,Norman,ENorman,Sales
Siu,Robben,SRobben,Sales
```

When you run the previous example, the data from **Users.csv** is placed in the `$users` array. There are three items in the array. Each item in the array has four properties named in the header row. You can reference each of the properties by name. For example:

```powershell
$users[2].UserID
```

Some programs export data by using a delimiter other than a comma. If your data uses an alternate delimiter, you can specify which character by using the *-Delimiter* parameter.

If your data file doesn't include a header row, you can provide names for the columns by using the *-Header* parameter. You can provide a list of property names in the command or provide an array that contains the property names. When you use the *-Header* parameter, all rows in the file become items in the imported array.
