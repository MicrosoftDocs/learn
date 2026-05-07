In this module, you learned to import data from a text file, CSV file, XML file, and JavaScript Object Notation (JSON) file. Key takeaways:

- Use **Get-Content** to retrieve data from a text file for use in your scripts. The information retrieved from the text file is stored in an array and each line in the text file becomes an item in the array.

- Many applications export data to CSV files, making **Import-Csv** a useful cmdlet for importing that data.

- Use the **Import-Clixml** cmdlet to retrieve data from an XML file to create an array of objects. 

- JSON is a lightweight data format. Like XML, it supports multiple layers of data, but uses a simpler syntax.

- Windows PowerShell doesn't include cmdlets to import or export JSON files directly. Instead, use **Get-Content** to read the file, then pipe the output to **ConvertFrom-Json**.


## Additional reading

To learn more, go through the following documents:

- [Get-Content](https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-content)

- [Import-Csv](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/import-csv)

- [Import-Clixml](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/import-clixml)

- [ConvertFrom-Json](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-json)

- [Invoke-RestMethod](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/invoke-restmethod)

