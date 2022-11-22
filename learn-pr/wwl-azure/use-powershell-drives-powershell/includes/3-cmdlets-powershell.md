Because Windows PowerShell creates PowerShell drives for local drives (such as drive **C**), you might already be using some of the cmdlets associated with PowerShell drives without realizing it. PowerShell drives contain items that contain child items or item properties. The Windows PowerShell cmdlet names that work with PowerShell drive objects use the nouns **Item**, **ChildItem**, and **ItemProperty**.

You can use the **Get-Command** cmdlet with the *-Noun* parameter to review a list of commands that work on each PowerShell drive object. You can also use **Get-Help** to review the help for each command. The following table describes the verbs that are associated with common **PSDrive** cmdlets.

*Table 1: PSDrive cmdlet verbs*

| **Verb** | **Description**                                              |
| -------- | ------------------------------------------------------------ |
| New      | Creates a new item or item property.                        |
| Set      | Sets the value of an item or item property.                   |
| Get      | Displays properties of an item or child item, or value of an item property. |
| Clear    | Clears the value of an item or item property.                 |
| Copy     | Copies an item or item property from one location to another. |
| Move     | Moves an item or item property from one location to another. |
| Remove   | Deletes an item or item property.                             |
| Rename   | Renames an item or item property.                             |
| Invoke   | Performs the default action that's associated with an item.  |

The items in the various PowerShell drives behave differently. Although these commands work in all PowerShell drives, how the verbs act on the items in each PowerShell drive might vary. Additionally, other commands might work with those items. The other topics in this module describe how to work with specific PowerShell drives.

When you use commands that have the **Item**, **ChildItem**, and **ItemProperty** nouns, you typically specify a path to tell the command what item or items you want to manipulate. Most of these commands have two parameters for paths:

- *–Path*. This typically interprets the asterisk (*) and the question mark (?) as wildcard characters. In other words, the path ***.txt** refers to all files ending in “.txt.” This approach works correctly in the file system because the file system doesn't allow item names to contain the asterisk  or question mark characters.
- *–LiteralPath*. This parameter treats all characters as literals and doesn't interpret any character as a wildcard. The literal path ***.txt** means the item named “*.txt.” This approach is useful in drives where the asterisk and question mark characters are allowed in item names, such as in the registry.

## Working with PowerShell drive locations

In addition to the commands for working with PowerShell drive items and item properties, there are also commands for working with PowerShell drive working locations. *Working locations* are paths within PowerShell drives to items that can have child items, such as a file system folder or registry path. The commands that manage PowerShell drive locations use the **Location** noun and include those described in the following table.

*Table 2: Location commands*

| **Command**      | **Description**                                              |
| ------------- | ------------------------------------------------------------ |
| **Get-Location**  | Displays the current working location.                        |
| **Set-Location**  | Sets the current working location.                           |
| **Push-Location** | Adds a location to the top of a location stack.              |
| **Pop-Location**  | Changes the current location to the location at the top of a location stack. |

> [!NOTE]
> The **Push-Location** and **Pop-Location** cmdlets are the equivalent of the **pushd** and **popd** commands in the Windows Commamd Prompt (**cmd.exe**) console. In PowerShell, **pushd** and **popd** are aliases for those cmdlets.

> **Additional reading:** For more information about location stacks, refer to [Push-Location](https://aka.ms/idat4p).
