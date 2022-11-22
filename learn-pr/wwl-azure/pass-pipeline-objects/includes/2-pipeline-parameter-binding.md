A Windows PowerShell command can only use one of its parameters each time it runs to specify the object on which it operates. When piping data from one command to another, you do not need to specify that parameter. This makes the complete command statement easier to read. However, it might not be obvious how the command works when you run the command. Consider the following command:

```powershell
Get-ADUser -Filter {Name -eq 'Perry Brill'} | Set-ADUser -City Seattle
```

In this example, **Set-ADUser** accepts input in an indirect manner; that is, it needs a user object as input. If running **Set-ADUser** directly, you might pass the user name to identify the user, but this command does not do this. Instead, the object that Get-ADUser produces is picked up out of the pipeline by **Set-ADUser**. **Set-ADUser** is passed two parameters, not the one parameter that you can see. Windows PowerShell invisibly uses the other parameter in a process that is known as *pipeline parameter binding*.

When you connect two commands in the pipeline, pipeline parameter binding takes the output of the first command and decides what to do with it. The process selects one of the parameters of the second command to receive that output. Windows PowerShell has two techniques that it uses to make that decision. The first technique, which is the one that Windows PowerShell always tries to use first, is named **ByValue**. The second technique is named **ByPropertyName**, and it is used only when **ByValue** fails.
