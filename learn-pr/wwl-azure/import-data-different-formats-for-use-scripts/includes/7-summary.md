In this module, you learned to import data from a text file, CSV file, XML file, and JavaScript Object Notation (JSON) file. The following are the key takeaways:

- Use **Get-Content** to retrieve data from a text file for use in your scripts. The information retrieved from the text file is stored in an array and each line in the text file becomes an item in the array.

- Many applications can export data to a CSV file. This ability makes the **Import-Csv** cmdlet useful because it can import data that was exported from those applications. 

- Use the **Import-Clixml** cmdlet to retrieve data from an XML file to create an array of objects. 

- JavaScript Object Notation (JSON) is a lightweight data format that's similar to XML, because it can represent multiple layers of data. JSON is a lightweight data-interchange format compared to XML because of its simpler syntax.

- Windows PowerShell doesn't include cmdlets that import or export JSON data directly from a file. Instead, if you have JSON data stored in a file, you can retrieve the data by using **Get-Content** and then convert the data by using the **ConvertFrom-Json** cmdlet.


## Additional reading

To learn more, go through the following documents:

- [About Assignment Operators](https://aka.ms/lewact)

- [Hosting your own NuGet Feeds](https://aka.ms/vm0ys1)




