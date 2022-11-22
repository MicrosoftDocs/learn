*Flow control* refers to how your code runs in your console or script. It describes the *flow* the code follows and how you control that flow. There are various constructs available to help you control the flow. The code can run all the statements, or only some of them. It can also repeat certain statements until it meets a certain condition. 

Let's examine these flow-control constructs to see what they can do:

- **Sanitize input**. If you use parameters in a script, you need to ensure your parameters hold reasonable values so your script works as intended. Writing code to manage this process is called *sanitizing* input.

- **Control execution flow**. The previous technique ensures you get reasonable and correct input data. This technique is more about deciding how to run code. The values set can determine which group of statements runs.

- **Iterate over data**. Sometimes your data takes the form of an array, which is a data structure that contains many items. For such data, you might need to examine each item and perform an operation for each one. Many constructs in PowerShell can help you with that process.

   > [!NOTE]
   > Iterating over arrays is outside the scope of this module.
There are many constructs to handle flow control in PowerShell. We can't name them all, but we'll talk about some important ones that you're likely to encounter in scripts that you read or write.

## Manage input and execution flow by using `If`, `ElseIf`, and `Else`

You can use an `If` construct to determine if an expression is `True` or `False`. Depending on that determination, you might run the statement defined by the `If` construct. The syntax for `If` looks like this:

```powershell
If (<expression that evaluates to True or False>) 
{
  # Statement that runs only if the preceding expression is $True.
}
```

### Operators

 PowerShell has two built-in parameters to determine if an expression is `True` or `False`:

- `$True` indicates that an expression is `True`.
- `$False` indicates that an expression is `False`.

You can use operators to determine if an expression is `True` or `False`. There are a few operators. The basic idea is usually to determine if something on the left side of the operator matches something on the right side, given the operator's condition. An operator can express conditions like whether something is equal to something else, larger than something else, or matches a regular expression.

Here's an example of using an operator. The `-le` operator determines if the value on the left side of the operator is less than or equal to the value on the right side:

```powershell
$Value = 3
If ($Value -le 0) 
{
  Write-Host "Is negative"
}
```

This code won't display anything because the expression evaluates to `False`. The value 3 is clearly positive.

### `Else`

The `If` construct runs statements only if they evaluate to `True`. What if you want to handle cases where they evaluate to `False`? That's when you use the `Else` construct. `If` expresses "if this specific case is true, run this statement." `Else` doesn't take an expression. It captures all cases where the `If` clause evaluates to `False`. When `If` and `Else` are combined, the code runs the statements in one of the two constructs. Let's modify the previous code to include an `Else` construct:

```powershell
$Value = 3
If ($Value -le 0) 
{
  Write-Host "Is negative"
} Else {
  Write-Host "Is Positive"
}
```

Because we put the `Else` next to the ending brace for the `If`, we created a joined construct that works as one. If you run this code in the console, you'll see that `Is Positive` prints. That's because `If` evaluates to `False`, but `Else` evaluates to `True`. So `Else` prints its statement.

> [!NOTE]
> You can use `Else` only if there's an `If` construct defined immediately above it.

### `ElseIf`

`If` and `Else` work great to cover all the paths code can take. `ElseIf` is another construct that can be helpful. `ElseIf` is meant to be used with `If`. It says "the expression in this construct will be evaluated if the preceding `If` statement evaluates to `False`." Like `If`, `ElseIf` can take an expression, so it helps to think of `ElseIf` as a *secondary If*.

Here's an example that uses `ElseIf`:

```powershell
# _FullyTax.ps1_
# Possible values: 'Minor', 'Adult', 'Senior Citizen'
$Status = 'Minor'
If ($Status -eq 'Minor') 
{
  Write-Host $False
} ElseIf ($Status -eq 'Adult') {
  Write-Host $True
} Else {
  Write-Host $False
}
```

It's possible to write this code in a more compact way, but this way does show the use of `ElseIf`. It shows how `If` is evaluated first, then `ElseIf`, and then `Else`.

> [!Note]
> As with `Else`, you can't use `ElseIf` if you don't define an `If` above it.
