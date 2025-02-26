PowerShell includes the ability to convert pipeline objects to other forms of data representation. For example, you can convert a collection of objects to the comma-separated value (CSV) format. Converting to CSV is useful for reviewing and manipulating large amounts of data, because you can easily open the resulting file in a program such as Microsoft Excel.

PowerShell uses two distinct verbs for conversion: **ConvertTo** and **Export**. A command that uses **ConvertTo**, such as **ConvertTo-Csv** accepts objects as input from the pipeline and produces converted data as output to the pipeline. That is, the data remains in PowerShell. You can pipe the data to another command that writes the data to a file or manipulates it in another way.

Here's an example:

```powershell
Get-Service | ConvertTo-Csv | Out-File Services.csv

```

A command that uses **Export**, such as **Export-Csv**, performs two operations: it converts the data and then writes the data to external storage, such as a file on disk.

Here's an example:

```powershell
Get-Service | Export-Csv Services.csv

```

Export commands, such as **Export-Csv**, combine the functionality of **ConvertTo** with a command such as **Out-File**. Export commands don't usually put any output into the pipeline. Therefore, nothing displays on the screen after an export command runs.

A key part of both operations is that the form of the data changes. The structure referred to as *objects* no longer contains the data, which is instead represented in another form entirely. When you convert data to another form, it's generally more difficult to manipulate within Windows PowerShell. For example, you can't easily sort, select, or measure data that's been converted.

As noted previously, the output of **Export-Csv** is a text file. The command writes the property names to the first row, as headers. One advantage of the CSV output format is that Windows PowerShell also supports importing the format with the **Import-Csv** command. **Import-Csv** creates objects that have properties matching the columns in the CSV file.

## Converting output to XML

PowerShell also supports writing output in the XML format. XML separates the data from the display format. The data then becomes highly portable and can be consumed by other processes and applications that don't need to know what format the data was originally presented in.

Another advantage of XML is that properties containing multiple values are easily identifiable because a new XML *element*, which is a data container in the XML file, is created for each value. Finally, standard ways exist to query, parse, and transform XML data.

PowerShell converts data to XML by using the **ConvertTo-Clixml** and **Export-Clixml** commands. As with **ConvertTo-Csv** and **Export-Csv**, the **ConvertTo** version of the command doesn't send output to a file but leaves the output in memory for further processing. The **Export** version of the command creates an XML file in the full path specified by the *-Path* positional parameter.

## Converting output to JSON

Another lightweight and increasingly popular data format is the JavaScript Object Notation (JSON) format. JSON is very popular in web application development because of its compact size and flexibility. As the name might suggest, it's very easy for JavaScript to process.

The JSON format represents data in name-value pairs that resemble and work like hash tables. So, like a hash table, JSON doesn't consider what kind of data exists in the name or value. It's up to the script or application consuming the JSON data to understand what kind of data is represented.

In PowerShell, you create JSON‑formatted data by using the **ConvertTo-Json** command. As with the other **ConvertTo** commands, no output file is created. Unlike XML and CSV, however, JSON doesn't have an **Export** command for converting the data and creating an output file. Therefore, you must use **Out-File** or one of the text redirection operators to send the JSON data to a file.

## Converting output to HTML

Sometimes, you need to display your Windows PowerShell output in a web browser or send it to a process, like the **Send-MailMessage** command, which accepts HTML input. Windows PowerShell supports this through the **ConvertTo-Html** command. As with the other **ConvertTo** commands, no output file is created. You must direct the output by using **Out-File** or one of its aliases.

**ConvertTo-Html** creates a simple list or table that's coded as HTML. You can control the HTML format in a limited way through a variety of parameters, such as:

 -  *‑Head*. Specifies the content of an HTML **head** section.
 -  *‑Title*. Sets the value of the HTML **title** tag.
 -  *‑PreContent*. Defines any content that should display before the table or list output.
 -  *‑PostContent*. Defines any content that should display after the table or list output.

