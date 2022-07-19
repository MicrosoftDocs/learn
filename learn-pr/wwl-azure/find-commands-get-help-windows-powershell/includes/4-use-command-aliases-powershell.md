If you have experience using the traditional Windows Command Prompt shell (**cmd.exe**), you're likely also familiar with batch commands such as:

 -  **dir** for listing files and folders.
 -  **cd** for changing directories.
 -  **mkdir** for creating new directories.

In many cases, you can continue to use these commands within Windows PowerShell. That's because behind the scenes, these commands are running native PowerShell cmdlets. The **dir** command runs **Get-ChildItem**, the **cd** command runs **Set-Location**, and the **mkdir** command runs **New-Item**. These commands work with PowerShell because they're *aliases* of the cmdlets that perform the equivalent action.

## Aliases and parameters

It's important to note that aliases typically don't support the parameters that the original commands use. For example, if you run the command **dir /o:d** in the console, you'll receive an error because **Get‑ChildItem** doesn't recognize the */o:d* parameter. Instead, you can use the *dir \| sort LastAccessTime* to list the contents of the current folder sorted by last accessed date and time in the ascending order.

## Get-Alias

PowerShell includes more than just aliases for legacy batch and Linux commands. It also provides other aliases, such as **gci** for **Get-ChildItem**, which you can use to replace a full command with its abbreviated notation and minimize the amount of typing required. You can discover aliases, their definitions, and the commands that they run, by using the **Get-Alias** cmdlet. **Get‑Alias** with no parameters returns all aliases defined. You can use the *-Name* parameter, a positional parameter, which also accepts wildcards, to find the definition for specific aliases. For example, running the command **Get-Alias di\*** returns aliases for both **diff** and **dir**.

You can also use the **Get-Alias** cmdlet to discover new cmdlets. For example, you use the batch command **del** to delete a file or folder. You can enter the command **Get-Alias del** to discover that **del** is an alias for **Remove-Item**. You can even reverse the discovery process by running the command **Get‑Alias -definition Remove-Item** to discover that **Remove-Item** has several other aliases, including **rd**, **erase**, and **ri**.

Parameters can also have aliases. For example, the *-s* parameter is an alias for **-Recurse** in the **Get‑ChildItem** cmdlet. In fact, for parameters, you can use partial parameter names just like aliases, if the portion of the name you do include in the command is enough to uniquely identify that parameter.

## New-Alias

You can also create your own alias by using the **New-Alias** cmdlet. This allows you to define your own custom alias that you can map to any existing cmdlet. Keep in mind, however, that custom aliases aren't saved between Windows PowerShell sessions. You can use a Windows PowerShell profile to recreate the alias every time you open Windows PowerShell.

**Additional Reading:** For more information about creating and using a PowerShell profile, refer to [about\_Profiles](https://aka.ms/about-profiles).

## Disadvantages of aliases

Aliases can help you enter commands more quickly, but they tend to make scripts harder to review and understand. One reason is that the verb-noun syntax clearly defines the action taking place. It creates commands that read and sound more like natural language. Aliases for parameters and partial parameter names make scripts even harder to review. In most cases, using tab completion will make command entry almost as fast as entering an alias name and, at the same time, ensure its accuracy.
