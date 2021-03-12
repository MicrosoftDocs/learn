Flow control means how your code is executed in your console or script, what _flow_ is it following and how can you control that. There are various constructs available for you that helps you control _the how_. The code can either run all the statements or parts of them. It can also repeat certain statements, over and over, until it meets a certain condition. 

Let's examine these flow-control constructs closer and see what they can help with:

- **Sanitize input**. If you use parameters in your script. it's important to ensure that your parameters hold reasonable values so that your script works as intended. Writing code to manage this process is called to _sanitize_ input.

- **Control execution flow**. If the first case was to ensure you got reasonable and correct input data, this case is more about deciding how to execute the code. Depending on the values set, you might either run one group of statements or another group statements.

- **Iterate over data**. Sometimes your data takes on the form of an array, a data structure containing many items. For such data, you might need to examine each and every item and perform an operation for each item. There are many constructs in PowerShell that can help you with just that.

   > [!NOTE]
   > iterating over arrays is outside the scope of this module.
There are many constructs to handle flow control in PowerShell. We can't name them all, but lets talk about some important ones that you're likely to encounter in scripts that you read or author.

## Manage input and execution flow using IF, ELESEIF, and ELSE

An `If` construct is used to determine if something is `True` or `False`, based on that, you run the statement defined by the `If` construct. The syntax for the `If` looks like so:

```powershell
If(<expression evaluating to True or False>) 
{
  # Run statement, only run if expression above is $True
}
```

### Operators

To determine if something is `True` or `False` there are two built-in parameters in PowerShell:

- `$True`, this value represents that something is `True`.
- `$False`, the other value represents that something is `False`.

When you compare if something is `True` or `False`, you use operators to do so. There are a few operators, and the basic idea is usually to compare if something on the left side of the operator matches with the right side, given the operator's condition. An operator can express things like if something is equal, larger than, matches a Regular Expression and more.

Here's an example of using an operator `-le` operators that look to compare if the value to the left is larger or equal to the value on the right:

```powershell
$Value = 3
If($Value -le 0) 
{
  Write-Host "Is negative"
}
```

The code would not output anything as the expression would evaluate to false, as the value `3` is clearly positive.

### Else

The `If` construct runs statements only if they evaluate to `True`. How can you deal with cases where it evaluates to `False`? That's where the `Else` construct comes in. `If` expresses, if this specific case is true, run my statement. `Else` doesn't take an expression but rather states it will capture all cases where the `If` clause evaluates to `False`. When `If` and `Else` are combined, the code will execute the statements in one of the two constructs. Lets modify the previous code to include an `Else` construct:

```powershell
$Value = 3
If($Value -le 0) 
{
  Write-Host "Is negative"
} Else {
  Write-Host "Is Positive"
}
```

By placing the `Else` right next to the ending curly brace for the `If` construct, you're able to construct a joined construct that's works in unison. Where you to run such a code in the console, you would see the text **Is Positive** printed. The reason is that `If` evaluates to `False` but `Else` evaluates to `True` and `Else` thereby runs its statement.

> [!NOTE]
> `Else` cannot exist without their being an `If` construct defined right above.
### ElseIf

`If` and `Else` works great to cover all the paths the code can take. There's another construct that can be helpful, `ElseIf`. `ElseIf` is meant to be used with the `If` and says, the expression in this construct will be evaluated if the above `If` statement evaluates to `False`. Like `If`, `ElseIf` is able to take an expression, so it's good to think of `ElseIf` as a _secondary if_.

Here's an example of using an `ElseIf`:

```powershell
# _FullyTax.ps1_
# possible values  'Minor', 'Adult', 'Senior Citizen'
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

It's definitely possible to write this code in a more compact way, but it does show the use of `ElseIf`. It shows how the `If` is first evaluated, then the `ElseIf`, followed lastly by the `Else`.

> [!Note]
> Just like with `Else` an `ElseIf` can't exist without their being an `If` defined above.