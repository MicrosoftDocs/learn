You can use **Get-Content** to retrieve data from a text file for use in your scripts. The information retrieved from the text file is stored in an array and each line in the text file becomes an item in the array.

The typical syntax for **Get-Content** is:

```powershell
$computers = Get-Content C:\Scripts\computers.txt
```

The previous example retrieves a list of computer names from the **computers.txt** file. The `$computers` variable stores each of the computer names and can be processed. For example, you could use a **ForEach** construct to do some processing on each computer in the list. Over time, as the list of computers changes, the script automatically picks them up from the **computers.txt** file.

You can use wildcards in the path for **Get-Content** to obtain data from multiple files at a time. When you use wildcards for the path, you can modify the files selected by using the *-Include* and *-Exclude* parameters. When you use *-Include*, only the specified patterns are included. When you use *-Exclude*, all files are included except the patterns specified. Using wildcards can be useful when you want to scan all text files for specific content such as an error in log files.

The syntax for using *-Include* is:

```powershell
Get-Content -Path "C:\Scripts\*" -Include "*.txt","*.log"
```

You can limit the amount of data that you retrieve with **Get-Content** by using the *-TotalCount* and *-Tail* parameters. The *-TotalCount* parameter specifies how many lines should be retrieved from the beginning of a file. The *-Tail* parameter specifies how many lines to retrieve from the end of a file. For example:

```powershell
Get-Content C:\Scripts\computers.txt -TotalCount 10
```
