Another option for passing the results of one command to the parameters of another is by using parenthetical commands. A parenthetical command is a command that is enclosed in parentheses. Just as in math, parentheses tell Windows PowerShell to execute the enclosed command first. The parenthetical command runs, and the results of the command are inserted in its place.

You can use parenthetical commands to pass values to parameters that do not accept pipeline input. This means you can have a pipeline that includes data inputs from multiple sources. Consider the following command:

```powershell
Get-ADGroup "London Users" | Add-ADGroupMember -Members (Get-ADUser -Filter {City -eq 'London'})
```

In this example, output of **Get-ADGroup** passes to **Add-ADGroupMember**, telling it which group to modify. However, that is only part of the information needed. We also need to tell **Add-ADGroupMember** what users to add to the group. The **-Members** parameter does not accept piped input, and even if it did, we have already piped data to the command. Therefore, we need to use a parenthetical command to provide a list of users that we want added to the group.

Parenthetical commands do not rely on pipeline parameter binding. They work with any parameter if the parenthetical command produces the kind of object that the parameter expects.
