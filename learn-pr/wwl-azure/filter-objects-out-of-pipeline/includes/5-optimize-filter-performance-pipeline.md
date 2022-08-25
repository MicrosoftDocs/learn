The way you create your commands can have a significant effect on performance. Imagine that you have a container of plastic blocks. Each block is red, green, or blue. Each block has a letter of the alphabet printed on it. You have to put all the red blocks in alphabetical order. What would you do first?

Consider creating this task as a Windows PowerShell command by using the fictional **Get‑Block** command. Which of the following two examples do you think will be faster?

```powershell
Get-Block | Sort-Object –Property Letter | Where-Object –FilterScript { $PSItem.Color –eq 'Red' }

Get-Block | Where-Object –FilterScript { $PSItem.Color –eq 'Red' } | Sort-Object –Property Letter
```

The second command will be faster, because it removes unwanted blocks from the pipeline so that only the remaining blocks are sorted. The first command sorts all the blocks and then removes many of them. This means that much of the sorting effort was wasted.

Many PowerShell scripters use a *mnemonic*, which is a phrase that serves as a simple reminder, to help them remember to do the correct thing when they're optimizing performance. The phrase is *filter left,* and it means that any filtering should occur as far to the left, or as close to the beginning of the command line, as possible.

Sometimes, moving filtering as far to the left as possible means that you'll not use **Where-Object**. For example, the **Get-ChildItem** command can produce a list that includes files and folders. Each object produced by the command has a property named **PSIsContainer**. It contains True if the object represents a folder and False if the object represents a file. The following command will produce a list that includes only files:

```powershell
Get-ChildItem | Where { -not $PSItem.PSIsContainer }
```

However, this isn't the most efficient way to produce the result. The **Get-ChildItem** command has a parameter that limits the command’s output:

```powershell
Get-ChildItem -File
```

When it's possible, check the help files for the commands that you use, to check whether they contain a parameter that can do the filtering you want.
