The pipe `|` character is used to connect several cmdlets, where one cmdlet's output serve as the input for the next cmdlet to the right of the pipe. This connection of cmdlets means you are creating a much more powerful and complex statement than a single cmdlet could have accomplished. The connection is referred to as a _pipeline_, consisting of one or more pipes and cmdlets.

You've been creating pipelines already, in previous units in this module. For example, when you asked for the fields and columns of a process you had to _pipe_ the `Get-Command` cmdlet with `Get-Member`. What you did was asking for details on a specific process. By _piping_ `Get-Member` to the result you were able to have a look at the resulting object and inspect it for its types, events, methods and more.

When you start constructing pipelines more and more, it's good to know about concepts that make the construction process easier, namely:

- **Pipeline evaluation**. When a pipeline is being evaluated, it does so in a specific order. Learning how this process happen makes it easier to understand how to connect two or more cmdlets.
- **Helper constructs**. As you construct more and more complex pipelines, you build longer and longer statements separated by the pipe character. Part of this connection process is being able to filter out the data you need. There are cmdlet helpers as well as operators that can make this _filtering_ task easier.
- **Filtering and formatting principles**.  As you apply filtering functions and operators, it's good to know about some sound principles to ensure your constructed statement is written in an efficient way and that the end result is formatted in a readable and usable way.

## Pipeline input evaluation

Most cmdlets lend themselves to be used in two different ways. Either you only call that specific cmdlet and assign values to the mandatory parameters. Or you use it as part of a pipeline, a longer expression where it operates on input that usually is the result of calling another cmdlet. PowerShell differs between these two types of usages by letting the author of the cmdlet specify a field **Accept pipeline input**. This field takes a boolean as a value and if set to true means it accepts pipeline data.

As part of your learning journey it's important to understand how to interpret what type of input parameters a cmdlet takes, in what order it's processed and how to provide data. It's important as it helps you understand how to combine suitable cmdlet statements in a useful way to solve your problems.

### Evaluation order in the pipeline

It's not uncommon that a cmdlet takes more than parameter meant for the pipeline.

But how do you know which of the parameter inputs it will try to use first? Let's explain the evaluation by looking at a real example. By running the command, `help Get-Process -Full` you will get a detailed listing of the help section of the `Get-Process` command. The INPUTS and the PARAMETERS section reveal there are three possible inputs:

- `System.String[]`, this primitive type is connected to the parameter `-Name`.
- `System.Int32`, the parameter for this one is called `-Id`.
- `System.Diagnostics.Process[]`, this complex type is associated with a parameter called `-InputObject`.

The PARAMETERS section had more than these three parameters above but it's only the parameters that had a field `Accept pipeline input?` set to true that is eligible for pipeline evaluation, as that is what you are evaluating here.

Now back to the evaluation process, how will it evaluate the input?

1. **By value (by type)**. The first thing PowerShell will do is try match it to a complex type, this is called _by value_, which in the above case means it will try to evaluate whether the input looks like a `System.Diagnostics.Process[]`. If that fails, it will go on to the next step.

2. **By property name**. The next step is trying to match it towards a simpler data type, which is either the `-Name` or `-Id` parameter. Looking at the PARAMETERS section for these two parameters you see the following listing:

   ```output
   Accept pipeline input?       true (ByPropertyName)
   ```

   The above states that it accepts pipeline as input but it also has a `ByPropertyName` statement. Now this `ByPropertyName` statement means that it expects what's passed to it is an object with a property in it named `Name` or `Id` to match the `Get-Process` input parameter requirements, like so:  

   ```output
   {
     Name: 'a name of a process'
   }
   ```

   How can this be tested using `Get-Process` and the pipe? You could call a cmdlet that returns an object with the needed shape or you could use a construct called `pscustomobject`. The `pscustomobject` allows you to create a custom PowerShell object. To use it, you would construct a custom object, then pipe it to `Get-Process` like the below PowerShell statement:

   ```powershell
   [pscustomobject]@{ Name='name of process' } | Get-Process
   ```

   The above statement first creates a custom PowerShell object with a `Name` property and a value assigned to it. Then it goes onto piping it to the `Get-Process` cmdlet. The end result is your process being listed.

## Helper constructs

You've seen so far how you can use a `Name` parameter to look for a specific process by its display name. You could also be using a helper cmdlet `Where-Object`. This cmdlet takes an operator and an expression that when put together processes a list of objects and returns a result where all records match the filtering statement. A typical usage of `Where-Object` can look like the below PowerShell:

```powershell
Get-Process | Where-Object Name -eq name-of-my-process
```

The reason for using the `Where-Object` is it's increased flexibility. It allows you to create queries where you might be looking at other properties than `Name` and also use different operators to help you better match your result.

### Introducing operators

Operators can be used in conjunction with the `Where-Object` cmdlet and there are quite a few of them. These operators are not tied to the cmdlet and can be used on the command line like so:

```powershell
'a string' -eq 'some other string'
```

The above statement evaluates to false, where you to run it in the console.

Let's list some operators you are likely to use:

- `-eq`, this operator checks whether something on the left of the operator is equal to something on the right of it.
- `-gt`, the greater than operator checks whether a number is higher than the compared number.
- `-lt`, the less than operator checks whether the number is less than a compared number.
- `-Match`, this operator _matches_ a value towards a regular expression. An example usage of this operator could be looking for all process that starts with the letter `V`. You would write such a statement in the following way:

   ```powershell
   Get-Process | Where-Object Name -Match "^V.*"
   ```

- `-Contains`, checks if a collection contains a specific value.

## Filtering left

_Filtering left_ is a principle that means filtering down to the results you want to as early as possible in your pipeline statement. You can see the term _left_ equal to _early_, as you are executing a PowerShell statement from left to right. The idea is to make the statement as fast and efficient as possible by ensuring that the dataset you are operating on is as small as possible. Where this really comes in to play is when your commands are backed by larger data stores or your are bringing results back across the network.

Take the following statement:

```powershell
Get-Process | Select-Object Name | Where-Object Name -eq name-of-process
```

The above statement first retrieves all the processes on the machine and then ends up formatting the response so that only the `Name` property is listed. This does not follow the _filtering left_ principle as it operates on all the processes, attempts to format the response and then does the filtering at the end.

A better approach would be to do the filtering first and then the formatting like the below statement:

```powershell
Get-Process | Where-Object Name -eq name-of-process | Select-Object Name
```

Often, if a cmdlet offers filtering, that is more efficient than using `Where-Object` so an even more efficient version of the above statement would be the following invocation:

```powershell
Get-Process | -Name name-of-process | Select-Object Name
```

In this version, the parameter `-Name` is doing the filtering for you.

## Format right

If _filtering left_ meant to filter something as early as possible, _formatting right_ means the opposite. The idea is that any type of formatting should happen as late as possible in your statements. There are different cmdlets dedicated to the formatting of your output with `Format-Table` and `Format-List` being the most common ones. Most cmdlets defaults to formatting the output as table. What happens when you use `Format-List` is that properties that used to be columns are now grouped and each row in your resulting output now groups all its properties together.
