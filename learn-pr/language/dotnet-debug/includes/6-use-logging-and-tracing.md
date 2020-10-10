Now that the application is started development it is good to add additional diagnostics to the logic to help developers as they add new features. This can be accomplished by leveraging our new learnings on debug diagnostics.

## Write to the debug console

Before debugging the application let's add additional debug diagnostics. This will help  diagnose the application while it is being run under debug. 

Add a `WriteLine` statement at the start of the `` method to get clarity when debugging through the code.

```csharp
Debug.WriteLine("Entering x method");
```

A conditional print statement by using `WriteIf` or `WriteLineIf`. Add a print a line only when X is X.

```csharp
Debug.WriteLineIf(x == x, $"{x} is 0");
Debug.WriteLineIf(x != x, $"{x} does not equal 0");
```

Debug the application and you should see the following output:

```output
```

## Check for conditions with Assert

In some situations, you may want to stop the entire running application when a certain condition is not met. Using `Debug.Assert` allows you to check for a condition and output additional information about the state of the application.

```csharp
Debug.Assert(condition, "X is not 0 and it should be.");
```

Debug the application and note that when `Debug.Assert` is run in the code the debugger stops the application so you can inspect variables, watch window, call stack, and more. It also outputs the message to the debug console.

```output
---- DEBUG ASSERTION FAILED ----
---- Assert Short Message ----
Count is 0 and it should not be.
---- Assert Long Message ----
   at LearnDependencies.Program.Main(String[] args) in C:\Users\jamont\Desktop\LearnDependencies\Program.cs:line 21
```

Run the application without debug by entering the following command in the terminal:

```bash
dotnet run
```

Note that the application is terminated after the assertion has failed and information has been logged to the application output:

```output
Process terminated. Assertion failed.
Count is 0 and it should not be.
   at LearnDependencies.Program.Main(String[] args) in C:\Users\jamont\Desktop\LearnDependencies\Program.cs:line 21
```

Now, let's run the application in `Release` configuration with the following command in the terminal:

```bash
dotnet run --configuration Release
```

Note that the application successfully runs to completion because we are no longer in the `Debug` configuration.

Congratulations, you have successfully and efficiently debugged code using features of .NET including `Debug.WriteLine` and `Debug.Assert`. Well done!

