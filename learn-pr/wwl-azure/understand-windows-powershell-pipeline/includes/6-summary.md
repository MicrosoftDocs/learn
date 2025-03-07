In this module, you've learned about the Windows PowerShell pipeline and some basic techniques for running multiple commands in it. The following are the key takeaways:

- PowerShell can run commands in a *pipeline*, which is a chain of one or more commands in which the output from one command can pass as input to the next command.  
- PowerShell commands generate objects as output. *Object* is a generic word that describes an in-memory data structure.
- If you imagine command output as a database table or a spreadsheet, in PowerShell terminology, the table or spreadsheet consists of a collection of objects, or just a *collection* in short. Each row is a single object, and each column is a *property* of that object, that is, information about the object.
- *Members* are the various components of an object and include Properties, which describe attributes of the object, Methods, which invoke an action on an object, and Events, which trigger when something happens to an object.
- The default formatting of the output depends on the objects that exist in the output and the configuration files that define the output. You can override the default output formatting by specifying any of the formatting cmdlets as part of the pipeline.
