The pipe character (`|`) is used to connect cmdlets. The output of the cmdlet on the left of the pipe serves as the input for the cmdlet on the right of the pipe. This connection of cmdlets allows you to create a statement that's more powerful and complex than a single cmdlet. The connection is called a _pipeline_. It consists of one or more pipes and cmdlets.

You've already created some pipelines in this module. For example, to find the fields and columns of a process, you _piped_ the `Get-Command` cmdlet with `Get-Member`. In effect, you asked for details about a specific process. By piping `Get-Member` to the result, you inspected the resulting object's types, events, and methods.

As you construct pipelines, apply these helpful concepts:

- **Pipeline evaluation**: A pipeline is evaluated in a specific order. By understanding this process, you can better understand how to connect two or more cmdlets.
- **Helper constructs**: As your pipelines become more complex, you build longer statements separated by the pipe character. Part of this connection process is filtering out the data you need. Cmdlet helpers and operators can make this filtering task easier.
- **Filtering and formatting principles**:  As you apply filtering functions and operators, follow filtering and formatting principles. Sound principles will help you write your statement efficiently so that the result is readable and usable.

## Pipeline input evaluation

Most cmdlets can be used in two ways. You can call only a specific cmdlet and assign values to the mandatory parameters. Or you can use the cmdlet in a pipeline, which is a long expression where the cmdlet operates on input that's usually the result of calling another cmdlet. 

PowerShell treats these two usages differently by letting the author of the cmdlet specify the field **Accept pipeline input**. This field takes a Boolean as a value. If the value is true, then PowerShell accepts pipeline data.

As part of your learning journey, you need to understand what type of input parameters a cmdlet takes, in what order the parameters are processed, and how to provide data. This understanding helps you combine suitable cmdlet statements in a useful way to solve your problems.

### Evaluation order in the pipeline

A cmdlet often takes more than parameter meant for the pipeline.

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
