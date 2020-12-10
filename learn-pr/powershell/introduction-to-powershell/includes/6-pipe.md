The pipe character (`|`) is used to connect cmdlets. The output of the cmdlet on the left of the pipe serves as the input for the cmdlet on the right of the pipe. This connection of cmdlets allows you to create a statement that's more powerful and complex than a single cmdlet. The connection is called a _pipeline_. It consists of one or more pipes and cmdlets.

You've already created some pipelines in this module. For example, to find the fields and columns of a process, you _piped_ the `Get-Command` cmdlet with `Get-Member`. In effect, you asked for details about a specific process. By piping `Get-Member` to the result, you inspected the resulting object's types, events, and methods.

As you construct pipelines, you'll use these concepts:

- **Pipeline evaluation**: A pipeline is evaluated in a specific order. By understanding the evaluation process, you can better understand how to connect two or more cmdlets.
- **Helper constructs**: Your pipelines become more complex as you build longer statements separated by the pipe character. Part of this process is filtering for the data you need. Cmdlet helpers and operators can make the filtering task easier.
- **Filtering and formatting principles**: As you apply filtering functions and operators, you'll want to follow filtering and formatting principles. Sound principles will help you write your statement efficiently so that the result is readable and usable.

## Pipeline input evaluation

Most cmdlets can be used in two ways. You can call only a specific cmdlet and assign values to the mandatory parameters. Or you can use the cmdlet in a pipeline, which is a long expression where the cmdlet operates on input that's usually the result of calling another cmdlet. 

PowerShell treats these two usages differently by letting the author of the cmdlet specify the field `Accept pipeline input?`. This field takes a Boolean as a value. If the value is true, then PowerShell accepts the pipeline data.

As part of your learning journey, you need to understand:
- The type of input parameters a cmdlet takes.
- The order in which the parameters are processed.
- How to provide data. 
 
This understanding helps you combine suitable cmdlet statements in a useful way to solve your problems.

### Evaluation order in the pipeline

A cmdlet often takes more than just the parameters meant for the pipeline.

How can you know which of the parameter inputs the system will try to use first? Consider a real example. The command `help Get-Process -Full` returns a detailed listing of the help section for the `Get-Process` command. The `INPUTS` section and the `PARAMETERS` section reveal three possible inputs:

- **System.String[]**: This primitive type is connected to the parameter `-Name`.
- **System.Int32**: The parameter for this input is called `-Id`.
- **System.Diagnostics.Process[]**: This complex type is associated with a parameter called `-InputObject`.

The `PARAMETERS` section includes more than just these three parameters. But these parameters are the only ones whose `Accept pipeline input?` field is set to true. The parameters are eligible for pipeline evaluation because here you're evaluating only parameters that accept pipeline input.

Now back to the evaluation process. PowerShell evaluates the input:

1. **By value (by type)**: PowerShell first tries to match the input to a complex type. That is, it tries to match _by value_. So in the preceding example, PowerShell evaluates whether the input looks like `System.Diagnostics.Process[]`. If that fails, PowerShell moves to the next step.

2. **By property name**: Next, PowerShell tries to match the input to a simpler data type, which is either the `-Name` parameter or the `-Id` parameter. In the `PARAMETERS` section for both parameters, you see the following listing:

   ```output
   Accept pipeline input?       true (ByPropertyName)
   ```

   This information tells you that the parameter accepts pipeline input, but it also has a `ByPropertyName` statement. The `ByPropertyName` statement means that the parameter expects to receive an object that contains a property named `Name` or `Id` to match the `Get-Process` input parameter requirements. So it expects an object like the following example.  

   ```output
   {
     Name: 'a name of a process'
   }
   ```

   How can you test the evaluation process by using `Get-Process` and the pipe? You could call a cmdlet that returns an object that has the needed shape. Or you could use a construct called `pscustomobject`. The `pscustomobject` construct allows you to create a custom PowerShell object. To use it, you construct a custom object and then pipe it to `Get-Process`, as in the following PowerShell statement.

   ```powershell
   [pscustomobject]@{ Name='name of process' } | Get-Process
   ```

   This statement first creates a custom PowerShell object that has a `Name` property and a value assigned to it. Then the statement pipes the object, statement, and value to the `Get-Process` cmdlet. The result is your process listing.

## Helper constructs

You've seen how to use a `Name` parameter to look for a specific process by its display name. You could also use the helper cmdlet `Where-Object`. This cmdlet takes an operator and an expression. Together, they process a list of objects and return a result where all records match the filtering statement. 

Take a look at the following example that uses `Where-Object`.

```powershell
Get-Process | Where-Object Name -eq name-of-my-process
```

The `Where-Object` helper cmdlet increases your flexibility. Use it to create queries that look for properties other than `Name`. And use operators to help you better match your result.

### Operators

You can use a large selection of operators with the `Where-Object` cmdlet. These operators aren't tied to the cmdlet. This example shows how you can use an operator at a command prompt:

```powershell
'a string' -eq 'some other string'
```

This statement evaluates to false when you to run it in the console.

You'll likely use these common operators:

- **-eq**: This operator checks whether something on its left is equal to something on its right.
- **-gt**: The greater-than operator checks whether a number is higher than the compared number.
- **-lt**: The less-than operator checks whether a number is less than a compared number.
- **-Match**: This operator matches a value to a regular expression. For example, you could use this operator to look for all processes that start with the letter `V`:

   ```powershell
   Get-Process | Where-Object Name -Match "^V.*"
   ```

- **-Contains**: This operator checks whether a collection contains a specific value.

## Filtering left

In a pipeline statement, _filtering left_ means filtering for the results you want as early as possible. You can think of the term _left_ as _early_ because a PowerShell statement runs from left to right. The idea is to make the statement fast and efficient by ensuring that the dataset you operate on is as small as possible. This principle really comes into play when your commands are backed by larger data stores or you're bringing results back across the network.

Consider the following statement:

```powershell
Get-Process | Select-Object Name | Where-Object Name -eq name-of-process
```

This statement first retrieves all of the processes on the machine. It ends up formatting the response so that only the `Name` property is listed. This statement doesn't follow the _filtering left_ principle, because it operates on all of the processes, attempts to format the response, and then filters at the end.

It's better to filter first and then format, like in the following statement.

```powershell
Get-Process | Where-Object Name -eq name-of-process | Select-Object Name
```

Often, a cmdlet that offers filtering is more efficient than using `Where-Object`. Here's a more efficient version of the preceding statement:

```powershell
Get-Process -Name name-of-process | Select-Object Name
```

In this version, the parameter `-Name` does the filtering for you.

## Formatting right

Whereas _filtering left_ means to filter something as early as possible, _formatting right_ means to _format_ something as _late_ as possible in your statements. The most common cmdlets that format your output are `Format-Table` and `Format-List`. By default, most cmdlets format output as a table. If your output displays properties in columns, the `Format-List` cmdlet reformats them as a list.
