*Enumeration* is the process of performing a task on each object, one at a time, in a collection. Frequently, PowerShell doesn't require you to explicitly enumerate objects. For example, if you need to stop every running Notepad process on your computer, you can run either of these two commands:

```powershell
Get-Process –Name Notepad | Stop-Process

Stop-Process –Name Notepad
```

One common scenario that requires enumeration is when you run a method of an object, and no command provides the same functionality as that method. For example, consider an object produced when you run **Get-ChildItem -File** to list files on a disk drive. The resulting object type, **System.IO.FileInfo**, has a method named **Encrypt** that can encrypt a file by using the current user account’s encryption certificate. No equivalent command is built into Windows PowerShell, so, if you want to run that method on many file objects, enumeration allows you to accomplish this with a single command.
