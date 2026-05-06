When you perform piping, the commands in the pipeline are applied to each object. In some cases, you might need to use the **ForEach-Object** cmdlet to process the data in the pipeline. When you store data in an array, the **ForEach** construct allows you to process each item in the array.

The **ForEach** construct uses the following syntax:

```powershell
ForEach ($user in $users) {
     Set-ADUser $user -Department "Marketing"
}
```

In the previous example, there's an array named `$users` that contains Active Directory Domain Services (AD DS) user objects. The **ForEach** construct processes the Windows PowerShell commands between the braces once for each object. When the commands are being processed, `$user` is the variable that contains each item from the array. On the first iteration, `$user` contains `$users[0]`, and on the second iteration, `$user` contains `$users[1]`. This continues until all items in the array have been processed once.

In a script, the **ForEach** construct is the most common way to process items that you've placed into an array. It's easy to use because you don't need to know the number of items to process them.

The previous example has only one command between the braces, but you can add many commands, which will be processed for each loop. The indent of commands between the braces is by convention to make the script easier to review. The indent is not a technical requirement, but it's a good practice.

The naming of variables in the **ForEach** loop should be meaningful. Most of the time, you clearly identify the variable used in the loop as a single instance of the array. For example, for an array named `$users`, the variable used in the loop could be `$user`. You might notice examples of variables with a single letter that's the same as the initial letter of the array. However, this should only be used in simple code where it's easy to tell that they're related.

## Parallel performance

PowerShell 7 adds the `-Parallel` parameter to the **ForEach-Object** cmdlet. This allows the pipeline to process multiple objects simultaneously, which can provide better performance than a standard **ForEach** loop. Consider using this if you're using PowerShell 7. The following example shows how to use **ForEach-Object** with the `-Parallel` parameter.

```powershell
$users | ForEach-Object -Parallel { Set-ADUser $_ -Department "Marketing" }
```

> [!NOTE]
> Inside a `-Parallel` script block, use `$_` to refer to the current pipeline object — the same as in a regular `ForEach-Object` block. This is different from a `foreach` statement, where you name the iteration variable yourself. If you need to access a variable defined outside the parallel block, prefix it with the `Using:` scope modifier — for example, `$Using:department`.

By default, the `-Parallel` parameter processes five items at a time. You can increase or decrease this limit with the `-ThrottleLimit` parameter.
