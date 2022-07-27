XML is a more complex data storage format than CSV files. The main advantage of using XML for Windows PowerShell is that it can hold multiple levels of data. A CSV file works with a table of information in which the columns are the object properties. In a CSV file, it's difficult to work with multivalued attributes, whereas XML can easily represent multivalued attributes or even objects that have other objects as a property.

The use of **Import-Clixml** to retrieve data from an XML file creates an array of objects. Because XML can be complex, you might not easily be able to understand the object properties by reviewing the contents of the XML file directly. You can use **Get-Member** to identify the properties of the data that you import.

The **Import-Clixml** cmdlet uses the following syntax:

```powershell
$users = Import-Clixml C:\Scripts\Users.xml
```

 You can limit the data retrieved by **Import-Clixml** by using the *-First* and *-Skip* parameters. The *-First* parameter specifies to retrieve only the specified number of objects from the beginning of the XML file. The *-Skip* parameter specifies to ignore the specified number of objects from the beginning of the XML file and to retrieve all the remaining objects.
