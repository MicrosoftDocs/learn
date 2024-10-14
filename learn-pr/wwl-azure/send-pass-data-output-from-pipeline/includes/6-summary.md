In this module, you've learned how to send pipeline data to files and in various output formats. The following are the key takeaways:

 -  PowerShell provides several ways to write output to a file. The **Out-File** command can accept input from the pipeline and write that data to a file. Its behavior differs from converting or exporting the objects, because you don’t change the form of the objects.
 -  PowerShell includes the ability to convert pipeline objects to other forms of data representation. It uses two distinct verbs for conversion: **ConvertTo** and **Export**. A command that uses **ConvertTo**, such as **ConvertTo-Csv** accepts objects as input from the pipeline and produces converted data as output to the pipeline. That is, the data remains in PowerShell.
 -  A command that uses **Export**, such as **Export-Csv**, performs two operations: it converts the data and then writes the data to external storage, such as a file on disk. Export commands combine the functionality of ConvertTo with a command such as Out-File. They don't usually put any output into the pipeline.
 -  PowerShell converts data to XML by using the **ConvertTo-Clixml** and **Export-Clixml** commands.
 -  In PowerShell, you create JSON‑formatted data by using the **ConvertTo-Json** command. Unlike XML and CSV, however, JSON doesn't have an **Export** command for converting the data and creating an output file. Therefore, you must use **Out-File** or one of the text redirection operators to send the JSON data to a file.
 -  Windows PowerShell has the **ConvertTo-Html** command that you can use when you need to display your Windows PowerShell output in a web browser or send it to a process, like the **Send-MailMessage** command, which accepts HTML input.
 -  PowerShell provides various other options for controlling output.

