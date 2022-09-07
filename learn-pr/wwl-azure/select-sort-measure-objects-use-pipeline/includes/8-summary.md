In this module, you've learned to manipulate objects in the pipeline by using commands that sort, select, and measure objects. This is needed for successfully creating automation in Windows PowerShell. The following are the key takeaways:

- The **Sort-Object** command can help you sort command output differently from the default. It accepts one or more property names to sort by. 
- The **Measure-Object** command, by default, counts the number of objects in the collection and produces a measurement object that includes the count.
- The **Select-Object** command can limit the output from any command when you don't need to display all the objects that a command produces.
- **Select-Object** can also display specific properties if you use the *-Property* parameter followed by a comma-separated list of the properties you want to display.  
- **Select-Object** can create custom, or *calculated*, properties. Each of these properties has a label, or name, that Windows PowerShell displays in the same way it displays any built-in property name. 