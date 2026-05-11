In this module, you learned how to enumerate objects in the pipeline so that you can work with one object at a time during automation. The following are the key takeaways:

 -  *Enumeration* is the process of performing a task on each object, one at a time, in a collection. If you want to run a method on many file objects, where no command provides the same functionality as that method, enumeration helps you accomplish this task with a single command.
 -  The `ForEach-Object` command that performs enumeration has a simplified syntax and a script block syntax. In the simplified syntax, you can run a single method or access a single property of the objects that were piped into the command.
 -  The script block syntax for enumeration provides more flexibility and functionality than the simplified syntax. Instead of letting you access a single object member, you can run a whole script. That script can include one command, or it can include many commands in sequence.
