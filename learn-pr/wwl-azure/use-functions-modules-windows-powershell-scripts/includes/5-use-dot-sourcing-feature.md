Dot sourcing is a method for importing another script into the current scope. If you have a script file that contains functions, you can use dot sourcing to load the functions into memory at a Windows PowerShell prompt. Normally, when you run the script file with functions, the functions are removed from memory when the script completes. When you use dot sourcing, the functions remain in memory, and you can use them at the Windows PowerShell prompt. You can also use dot sourcing within a script to import content from another script.

Dot sourcing can load from a local file or over the network by using a Universal Naming Convention (UNC) path. The syntax for using dot sourcing is:

```powershell
. C:\scripts\functions.ps1
```

At one time, dot sourcing was the only method available to maintain a centralized repository of functions that could be reused across multiple scripts. However, modules are a more standardized and preferred method for maintaining functions used across scripts.
