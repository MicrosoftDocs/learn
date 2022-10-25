The **For** construct performs a series of loops similar to a **ForEach** construct. However, when using the **For** construct, you must define how many loops occur, which is useful when you want an action to be performed a specific number of times. For example, you could create a specific number of user accounts in a test environment.

The **For** construct uses the following syntax:

```powershell
For($i=1; $i -le 10; $i++) {
   Write-Host "Creating User $i"
}
```

The **For** construct uses an initial state, a condition, and an action. In the previous example, the initial state is `$i=1`. The condition is `$i -le 10`. When the condition specified is true, another loop is processed. After each loop is processed, the action is performed. In this example, the action is `$i++`, which increments `$i` by 1.

The script block inside the braces is run each time the loop is processed. In the previous example, this loop is processed 10 times.

> [!NOTE]
> When you're processing an array of objects, using the **ForEach** construct is preferred because you don't need to calculate the number of items in the array before processing.
