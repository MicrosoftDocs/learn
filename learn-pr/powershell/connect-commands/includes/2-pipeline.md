The pipe character (`|`) is used to connect cmdlets. The output of the cmdlet that precedes the pipe serves as the input for the cmdlet that follows the pipe. By connecting cmdlets in this way, you can create a statement that's more powerful and complex than a single cmdlet. This connection is called a _pipeline_, and it can consist of one or more pipes and cmdlets.

As you construct pipelines, you'll apply these concepts:

- **Pipeline evaluation**: Cmdlets in a pipeline are evaluated in a specific order. By understanding the evaluation process, you can better understand how to connect two or more cmdlets.

- **Helper constructs**: Your pipelines become more complex as you build longer statements, each separated by the pipe character. Part of this process is filtering for the data you need. Cmdlet helpers and operators can make the filtering task easier.

- **Filtering and formatting principles**: As you apply filtering functions and operators, you'll want to follow sound filtering and formatting principles. Such principles will help you write each statement efficiently so that the result is readable and usable.

## Pipeline input evaluation

You can use most cmdlets in either of two ways:
- You can call only a specific cmdlet and assign values to the mandatory parameters. 
- You can use the cmdlet in a pipeline, which is a long expression where the cmdlet operates on input that's usually the result of calling another cmdlet.

PowerShell treats these two approaches differently by letting you, as author of the cmdlet, specify the `Accept pipeline input?` field. This field takes a Boolean as a value. If the value is _true_, PowerShell accepts the pipeline data.

As part of your learning journey, it's important to understand:

- The type of input parameters a cmdlet takes.
- The order in which the parameters are processed.
- How to provide data.

This understanding helps you combine suitable cmdlet statements in a way that's useful for solving your problem.

### Evaluation order in the pipeline

A cmdlet often takes more than the parameters that are meant for the pipeline.

How can you know which of the parameter inputs the system will try to use first?

Consider a real example. The `Get-Help Get-Process -Full` command returns a detailed listing of the help section for the `Get-Process` command. The `INPUTS` section and the `PARAMETERS` section reveal three possible inputs:

- **System.String[]**: This primitive type is connected to the parameter `-Name`.
- **System.Int32**: The parameter for this input is called `-Id`.
- **System.Diagnostics.Process[]**: This complex type is associated with a parameter called `-InputObject`.

The `PARAMETERS` section includes more than these three parameters. But these parameters are the only ones whose `Accept pipeline input?` field is set to _true_. The parameters are eligible for pipeline evaluation, because here you're evaluating only parameters that accept pipeline input.

PowerShell evaluates the input in the following order:

Step 1 - **By value (by type)**: PowerShell first tries to match the input to a complex type. That is, it tries to match them _by value_. In the preceding example, PowerShell evaluates whether the input looks like `System.Diagnostics.Process[]`. 

   If there's no match, PowerShell moves to the next step.

Step 2 - **By property name**: Next, PowerShell tries to match the input to a simpler data type, which is either the `-Name` parameter or the `-Id` parameter. In the `PARAMETERS` section for both parameters, you see the following output:

   ```output
   Accept pipeline input?       true (ByPropertyName)
   ```

   This information tells you that the parameter accepts pipeline input, but it also has a `ByPropertyName` statement. The `ByPropertyName` statement means that the parameter expects to receive an object that contains a property named `Name` or `Id` to match the `Get-Process` input parameter requirements. So it expects an object like the following example output:

   ```output
   {
      Name: 'a name of a process'
   }
   ```

How can you test the evaluation process by using `Get-Process` and the pipe? You could call a cmdlet that returns an object that has the needed shape. Or you could use a construct called `pscustomobject`. By using the `pscustomobject` construct, you can create a custom PowerShell object. To use it, you construct a custom object and then pipe it to `Get-Process`, as in the following PowerShell statement:

   ```powershell
   [pscustomobject]@{ Name='name of process' } | Get-Process
   ```

   This statement first creates a custom PowerShell object that has a `Name` property and a value assigned to it. Then the statement pipes the object, statement, and value to the `Get-Process` cmdlet. The result is your process listing.

## Helper constructs

You've seen how to use a `Name` parameter to look for a specific process by its display name. You could also use the helper cmdlet `Where-Object`. This cmdlet takes an operator and an expression. Together, they process a list of objects and return a result where all records match the filtering statement. 

Take a look at the following example, which uses the `Where-Object` helper:

```powershell
Get-Process | Where-Object Name -eq name-of-my-process
```

The `Where-Object` helper cmdlet increases your flexibility. Use it to create queries that look for properties other than `Name`, and use operators to help you better match your result.

### Operators

You can use a large selection of operators with the `Where-Object` cmdlet. These operators aren't tied to the cmdlet. The following example shows how you can use an operator at a command prompt:

```powershell
'a string' -eq 'some other string'
```

This statement evaluates to _false_ when you to run it in the console.

You'll likely use these common operators:

- **-eq**: This operator checks whether something that precedes it is equal to something that follows it.  
- **-gt**: The greater-than operator checks whether a number is higher than the compared number.  
- **-lt**: The less-than operator checks whether a number is less than a compared number.  
- **-Match**: This operator matches a value to a regular expression. For example, you could use this operator to look for all processes that start with the letter `V`:  

   ```powershell
   Get-Process | Where-Object Name -Match "^V.*"
   ```  

- **-Contains**: This operator checks whether a collection contains a specific value.
