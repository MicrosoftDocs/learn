Role capability files help you specify what can be done in a Windows PowerShell session. Anything that's not explicitly allowed in a role capability file or a session configuration file isn't allowed.

You can create a new, blank, role capability file by using the **New-PSRoleCapabilityFile** cmdlet. (Role capability files use the.psrc extension.) You then edit the role capability file, adding cmdlets, functions, and external commands as necessary. You can allow entire Windows PowerShell cmdlets or functions, or you can list which parameters and parameter values can be used.

When you create a role capability file, you can define the following limitations for the Windows PowerShell session:

- VisibleAliases. This setting lists which aliases to make available in the JEA (Just Enough Administration) session.

- VisibleCmdlets. This setting lists which Windows PowerShell cmdlets are available in the session. You can choose either to list cmdlets, allowing all parameters and parameter values to be used, or limit cmdlets to particular parameters and parameter values.

- VisibleFunctions. This setting lists which Windows PowerShell functions are available in the session. Again, you can choose to list functions, allowing all parameters and parameter values to be used, or you can limit functions to particular parameters and parameter values.

- VisibleExternalCommands. This setting allows users who are connected to the session to run external commands. For example, you can use this field to allow access to c:\windows\system32\ whoami.exe so that users connected to the JEA session can identify their security context.

- VisibleProviders. This setting lists Windows PowerShell providers that are visible to the session.

You can also configure other settings such as which modules to import, which assemblies are loaded, and data types that are available. For a list of all the options when creating a role capabilities file, see [New-PSRoleCapabilityFile](/powershell/module/microsoft.powershell.core/new-psrolecapabilityfile).

## Which commands should you allow?

It's important to properly configure your role capability files. If you give users too few tools, they can't get their work done. If you give them too many tools, then you increase the attack surface of the Windows PowerShell session.

Using the following process can help you decide how to configure your role capabilities files:

1. Working with your IT team, survey your current tools and processes to identify which commands are needed.

1. Whenever possible, move away from command-line tools to PowerShell cmdlets.

1. Restrict which cmdlet parameters and values can be used to only those that are necessary to complete specific tasks.

1. Prevent the use of commands that let users elevate their permissions or that allows them to run arbitrary code.

1. Create custom functions with validation logic to replace complex commands.

1. Test and monitor the list of allowed commands over time and modify as needed.
