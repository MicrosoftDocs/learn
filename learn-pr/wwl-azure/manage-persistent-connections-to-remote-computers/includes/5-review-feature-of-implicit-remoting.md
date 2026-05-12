One of the ongoing problems in the Windows management space is version mismatch. For example, Windows Server 2019, 2022, and 2025 each include new PowerShell modules and management tools. You can make these commands available on Windows 10 or Windows 11 as part of the Remote Server Administration Tools (RSAT). However, you might not be able to use the same approach with older versions of Windows.

You must be familiar with another ongoing problem if you recently had to rebuild a workstation. The problem is the sheer amount of time it can take to track down and install administrative tools and Microsoft Management Consoles (MMCs) on a computer. Assuming all of them are compatible with your Windows versions, installation alone can take days.

These problems lead administrators to forgo installing tools on workstations, and instead access tools directly on the server through Microsoft Remote Desktop. However, this isn't a good solution because it puts the server in the position of having to be a client, while simultaneously providing services to hundreds or thousands of users. The advent of Server Core, which lacks a graphical user interface (GUI), was in part to make servers perform better and need fewer updates. However, this also means that they can't run GUI tools and MMCs.

## Implicit remoting brings tools to you

Implicit remoting brings a copy of a server’s Windows PowerShell tools to your local computer. In reality, you're not copying the commands at all; you're creating a kind of shortcut, called a *proxy function*, to the server’s commands. When you run the commands on your local computer, they implicitly run on the server through remoting. Results are then sent back to you. It's exactly as if you ran everything through **Invoke-Command**, but it's much more convenient. Commands also run quicker, because commands on the server are co-located with the server’s functionality and data.

## Using implicit remoting

Implicit remoting has been available since PowerShell 2.0 through the **Import-PSSession** cmdlet. You create a session to the remote server, then use `Import-PSSession` to import commands from a specific module into your local session.

```powershell
$s = New-PSSession -ComputerName Server01
Import-PSSession -Session $s -Module ActiveDirectory
```

Starting with PowerShell 3.0, **Import-Module** gained a `-PSSession` parameter that provides a module-level convenience alternative using the same underlying mechanism. Both cmdlets create proxy functions that run commands remotely while appearing local.

With implicit remoting, you have the option of adding a prefix to the noun of commands that you import using the `-Prefix` parameter of **Import-PSSession**. Doing this can make it easier, for example, to have multiple versions of the same commands loaded simultaneously without causing a naming collision. For example, if you import both Microsoft Exchange Server 2016 and Exchange Server 2019 commands, you might add the 2016 and 2019 prefix to each of them, respectively. This enables you to run both sets of commands. In reality, each would be running on their respective servers, enabling you to run both sets (perhaps in a migration scenario) side-by-side.

The **Help** option also works for commands that are running through implicit remoting. However, the Help files are drawn through the same remoting session as the commands themselves. Therefore, the remote computer must have an updated copy of its Help files. This can be a concern on servers because they might not be used frequently and might not have had **Update-Help** run on them recently to pull down the latest Help files.
