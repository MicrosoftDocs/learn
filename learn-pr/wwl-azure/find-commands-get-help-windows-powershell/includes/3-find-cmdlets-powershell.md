Windows PowerShell has extensive built-in help that typically includes examples. This built-in help makes it easier for you to learn how to use a cmdlet. As you begin working with PowerShell, finding the cmdlet that you need might be a challenge. For example, what cmdlet would you use to set an IP address on a network adapter or to disable a user account in Active Directory?

You can start by using what you know about the structure of cmdlet names, along with the **Get-Command** command or the **Get-Help** command. **Get-Command** retrieves information about a command, or several commands, such as the name, category, version, and even the module that contains it. **Get-Help** retrieves help content about the command.

Like the **Get-Help** command, **Get-Command** accepts wildcard characters, which means that you can run the **Get-Command \*event\*** command and retrieve a list of commands that contain the text **event** in the name. **Get-Command** also has several parameters that you can use to further filter the returned results. For example, you can use the *-Noun* and *-Verb* parameters to filter out the noun and verb portions of the name, respectively.

Both parameters accept wildcards, though in most cases you won't need to use wildcards with verbs. You can even combine the parameters to further refine the results returned. Run the **Get-Command –Noun event\*** **–Verb Get** command to get a list of commands that have nouns starting with **event** and that use the **Get** verb.

When you attempt to identify command names, try to use just the noun portion, and consider just a single-word, singular noun. For example, *event* and *log* might be good guesses when you're trying to find a command that works with Windows event logs.

## Using modules to discover cmdlets

When you use the **Get-Module** command, it displays a partial list of cmdlets that the module you reference contains. However, you can use the module in another way to find its cmdlets.

For example, if you've discovered the module **NetAdapter**, you would expect that it should contain cmdlets you can use to manage network adapters. You can find all applicable commands in that module by running the **Get-Command –Module NetAdapter** command. The *–Module* parameter restricts the results to just those commands in the designated module.

## Using Get-Help to discover cmdlets

You can perform similar searches by using **Get-Help**, including using wildcards. One advantage of using **Get-Help** instead of **Get-Command** is that **Get-Help** performs a full-text search by using your query string if it can't find a command name that matches. If you run the **Get-Command \*beep\*** command, no results are available. If you run the **Get-Help \*beep\*** command, multiple results are returned.

You can also refer to the **Related Links** section of a cmdlet that you know is related to the one you're searching for. This section of the help topic includes related cmdlets.

## Finding cmdlets on the internet

You're not limited to searching for cmdlets that your computer already has installed. You can search the internet to find a wide variety of Microsoft and non-Microsoft modules and cmdlets. If you simply search by using the terms **PowerShell** and the technology you're working with, you'll find many links to articles on Microsoft and non-Microsoft websites. Virtually all Microsoft teams create cmdlets for use in managing their products, and you can install them as part of their management tools.

### PowerShell Gallery

The PowerShell Gallery is a central repository for Windows PowerShell–related content, including scripts and modules. The PowerShell Gallery uses the Windows PowerShell module, **PowerShellGet**. This module is part of Windows PowerShell 5.0 and newer.

**PowerShellGet** contains cmdlets for finding and installing modules, scripts, and commands from the online gallery. For example, the **Find-Command** cmdlet searches for commands, functions, and aliases. It works similar to the **Get-Command** cmdlet, including support for wildcards.

You can pass the results of the **Find-Command** cmdlet to the **Install-Module** cmdlet, which the **PowerShellGet** module also contains. **Install-Module** will install the module that contains the cmdlet that you discovered.

**Additional Reading:** For more information about PowerShell Gallery, refer to [PowerShell Gallery](https://aka.ms/iast9g).
