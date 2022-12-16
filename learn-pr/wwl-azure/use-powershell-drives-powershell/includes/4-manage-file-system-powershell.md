Administrators who are familiar with using the Windows Command Prompt (**cmd.exe**) most likely know commands to manage a file system. Common **cmd.exe** commands include **Dir**, **Move**, **Ren**, **RmDir**, **Del**, **Copy**, **MkDir**, and **Cd**. In Windows PowerShell, these common commands are provided as aliases or functions that map to equivalent PowerShell drive cmdlets.

You can use the **Get-Alias** or **Get-Command** cmdlets to identify the cmdlets that map to these aliases and functions. Keep in mind that the aliases and functions aren't exact duplicates of the original **cmd.exe** commands, but instead the syntax of an alias matches the corresponding cmdlet. For example, the **Dir** command is an alias for the **Get-ChildItem** cmdlet. To obtain a directory listing that includes subdirectories, you run the **Get-ChildItem –Recurse** command. The parameters are the same whether you decide to use the cmdlet name or the alias. That means that you can run the  ****Dir –Recurse**** command, but not **Dir /s** as you would when using Windows Command Prompt.

> [!NOTE]
> Because Windows PowerShell accepts a slash (/) or backslash (\\) as a path separator, Windows PowerShell interprets **Dir /s** to display a directory listing for the folder named **s**. If a folder named **s** exists, the command appears to work and doesn't display an error. If no such folder exists, it displays an error.

## Moving within the file system

You can move within the file system by using the **Set-Location** cmdlet. This cmdlet functions similar to the Windows Command Prompt command **Cd**. When using it, you can specify either an absolute or a relative path. For example, **Set-Location C:\\Users** changes to the C:\\Users folder. **Set-Location Temp** changes to the Temp folder that's one level down from the current directory.

## Create new files or folders

You can create new files and folders by using the **New-Item** cmdlet. You include the *-Path* parameter to define the name and location, and the *-ItemType* parameter to specify whether you want to create a file or directory.

## Delete files or folders

You can remove files or folders with the **Remove-Item** cmdlet and the positional *-Path* parameter. To delete folders that contain files, you need to include the *-Recurse* switch so that the child file items are also deleted. Otherwise, or you'll be asked to confirm the action.

## Find and enumerate files or folders

Use the **Get-Item** cmdlet and the *-Path* parameter to retrieve a single file or folder. You can also retrieve the children of an item by including the \* wildcard in the path. For example, the **Get-Item \*** command returns all files and folders in the current directory. The **Get-Item \*** command is equivalent to the **Get-ChildItem** cmdlet, which returns all the children of a specified path.

You can use the **Get-ChildItem** cmdlet with the *-Recurse* switch to enumerate through child files and folders. The FileSystem provider also supports the *-Exclude*, *-Include*, and *-Filter* parameters. These modify the value of the *-Path* parameter and specify file and folder names to include or exclude in the retrieval process.
