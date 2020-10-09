As you continue developing your application and it gets more complex you'll want to apply additional debug diagnostics to your application. 

Tracing is a way for you to monitor the execution of your application while it is running. You can add tracing and debugging instrumentation to your .NET application when you develop it, and you can use that instrumentation both while you are developing the application and after you have deployed it.

This simple technique is surprisingly powerful. It can be used in situations where you need more than a debugger:

- Issues occurring over long periods of time, can be difficult to debug with a traditional debugger. Logs allow for detailed post-mortem review spanning long periods of time. In contrast, debuggers are constrained to real-time analysis.
- Multi-threaded applications and distributed applications are often difficult to debug. Attaching a debugger tends to modify behaviors. Detailed logs can be analyzed as needed to understand complex systems.
- Issues in distributed applications may arise from a complex interaction between many components and it may not be reasonable to connect a debugger to every part of the system.
- Many services shouldn't be stalled. Attaching a debugger often causes timeout failures.
- Issues aren't always foreseen. Logging and tracing are designed for low overhead so that programs can always be recording in case an issue occurs.

## Writing information to output windows

Up to this point we have been using the console to display information to the end user of the application. There are other types of applications that are built with .NET that have user interfaces such as mobile, web, and desktop apps and there is no visible console. In these applications `System.Console` is used to log messages "behind the scenes". These messages may show up in an output window in Visual Studio or Visual Studio Code. They also may be output to a system log such as Android's `logcat`. This means that great consideration should be taken when using `System.Console.WriteLine` in a non-console application.

This is where `System.Diagnostics.Debug` and `System.Diagnostics.Trace` can be used in addition to `System.Console`. Both `Debug` and `Trace` are part of `System.Diagnostics` and will only write to logs when an appropriate listener is attached.

The choice of which print style API to use is up to you. The key differences are:

- **System.Console**
-- Always enabled and always writes to the console.
-- Useful for information that your customer may need to see in the release.
-- Because it's the simplest approach, it's often used for ad-hoc temporary debugging. This debug code is often never checked in to source control.

- **System.Diagnostics.Trace**
-- Only enabled when `TRACE` is defined.
-- Writes to attached Listeners, by default the DefaultTraceListener.
-- Use this API when creating logs that will be enabled in most builds.

- **System.Diagnostics.Debug**
-- Only enabled when `DEBUG` is defined (when in debug mode).
-- Writes to an attached debugger.
-- Use this API when creating logs that will be enabled only in debug builds.

```csharp
Console.WriteLine("This message is readable by the end user.")
Trace.WriteLine("This is a trace message when tracing the app.");
Debug.WriteLine("This is a debug message just for developers.");
```

When designing your tracing and debugging strategy, you should think about how you want the output to look. Multiple Write statements filled with unrelated information will create a log that is difficult to read. On the other hand, using WriteLine to put related statements on separate lines may make it difficult to distinguish what information belongs together. In general, use multiple Write statements when you want to combine information from multiple sources to create a single informative message, and use the WriteLine statement when you want to create a single, complete message.

```csharp
Debug.Write("Debug - ");
Debug.WriteLine("This is a full line.");
Debug.WriteLine("This is another full line.");
```

This is the output from the above logging with `Debug`:

```output
Debug - This is a full line.
This is another full ine.
```

## Defining TRACE & DEBUG Constants

By default when an application is running under debug the `DEBUG` constant is defined. This can be controlled by adding a `DefineConstants` entry in the project file in a property group. Here is an example of turning on `TRACE` for both `Debug` and `Release` configurations in addition to `DEBUG` for `Debug` configurations.

```xml
<PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|AnyCPU'">
    <DefineConstants>DEBUG;TRACE</DefineConstants>
</PropertyGroup>
<PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|AnyCPU'">
    <DefineConstants>TRACE</DefineConstants>
</PropertyGroup>
```

When using `Trace` when not attached to the debugger you will need to configure a trace listener such as [dotnet-trace](https://docs.microsoft.com/dotnet/core/diagnostics/dotnet-trace).

## Conditional tracing 

In addition to simple `Write` and `WriteLine` methods there is also the capability to add conditions with `WriteIf` and `WriteLineIf`. Take this logic that checks if the count is zero and then writes a debug message.

```csharp
if(count == 0)
{
    Debug.WriteLine("The count is 0 and this may cause an exception.");
}
```

It could be rewritten in a single line of code:

```csharp
Debug.WriteLineIf(count == 0, "The count is 0 and this may cause an exception.");
```

You can also use these conditions with `Trace` and with flags that you define in your application.

```csharp
bool errorFlag = false;  
System.Diagnostics.Trace.WriteIf(errorFlag, "Error in AppendData procedure.");  
System.Diagnostics.Debug.WriteIf(errorFlag, "Transaction abandoned.");  
Trace.Write("Invalid value for data request");
```

## Verify that certain conditions exist

An assertion, or `Assert` statement, tests a condition, which you specify as an argument to the `Assert` statement. If the condition evaluates to true, no action occurs. If the condition evaluates to false, the assertion fails. If you are running with a debug build, your program enters break mode.

You can use the `Assert` method from either `Debug` or `Trace`, which are in the `System.Diagnostics` namespace. `Debug` class methods are not included in a Release version of your program, so they do not increase the size or reduce the speed of your release code.

Use the System.Diagnostics.Debug.Assert method freely to test conditions that should hold true if your code is correct. For example, suppose you have written an integer divide function. By the rules of mathematics, the divisor can never be zero. You might test this using an assertion:

```csharp
int IntegerDivide(int dividend, int divisor)
{
    Debug.Assert(divisor != 0, $"nameof(divisor) is 0 and will cause an exception.");

    return dividend / divisor;
}
```

When you run this code under the debugger, the assertion statement is evaluated, but in the Release version, the comparison is not made, so there is no additional overhead.

> [!NOTE]
> When you use System.Diagnostics.Debug.Assert`, make sure that any code inside Assert does not change the results of the program if Assert is removed. Otherwise, you might accidentally introduce a bug that only shows up in the Release version of your program. Be especially careful about asserts that contain function or procedure calls

As you can see leveraging `Debug` and `Trace` from the `System.Diagnostics` namespace are a great way to provide additional context when running  and debugging your application.