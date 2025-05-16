In this exercise, you add a filter function that will request the user's approval before allowing the agent to book a flight or hotel on their behalf. Let's get started!


1. Create a new file named **PermissionFilter.cs**.

1. Enter the following code in the new file:

    ```c#
    #pragma warning disable SKEXP0001 
    using Microsoft.SemanticKernel;
    
    public class PermissionFilter : IFunctionInvocationFilter
    {
        public async Task OnFunctionInvocationAsync(FunctionInvocationContext context, Func<FunctionInvocationContext, Task> next)
        {
            
        }
    }
    ```

    >[!NOTE] 
    > In version 1.30.0 of the Semantic Kernel SDK, function filters are subject to change and require a warning suppression. 

    In this code, you implement the `IFunctionInvocationFilter` interface. The `OnFunctionInvocationAsync` method is always called whenever a function is invoked from an AI agent.

1. Add the following code to detect when the `book_flight` or `book_hotel` functions are invoked:

    ```c#
    if ((context.Function.PluginName == "FlightBooking" && context.Function.Name == "book_flight") ||
        (context.Function.PluginName == "HotelBooking" && context.Function.Name == "book_hotel"))
    {
    
    }

    await next(context);
    ```

    This code uses the `FunctionInvocationContext` to determine which plugin and function were invoked.

1. Add the following logic to request the user's permission to book the flight:

    ```c#
    if ((context.Function.PluginName == "FlightBooking" && context.Function.Name == "book_flight") ||
        (context.Function.PluginName == "HotelBooking" && context.Function.Name == "book_hotel"))
    {
        Console.WriteLine("System Message: The agent requires an approval to complete this operation. Do you approve (Y/N)");
        Console.Write("User: ");
        string shouldProceed = Console.ReadLine()!;

        if (shouldProceed != "Y")
        {
            context.Result = new FunctionResult(context.Result, "The operation was not approved by the user");
            return;
        }
    }

    await next(context);
    ```

1. Navigate to the **Program.cs** file.

1. Add the `FlightBooking` and `HotelBooking` plugins to the kernel:

    ```c#
    // Build the kernel
    Kernel kernel = builder.Build();
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    kernel.Plugins.AddFromType<FHotelBookingPlugin>("HotelBooking");
    ```

1. Add the permission filter to your kernel using the following code:

    ```c#
    // Build the kernel
    Kernel kernel = builder.Build();
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    kernel.Plugins.AddFromType<FHotelBookingPlugin>("HotelBooking");
    kernel.FunctionInvocationFilters.Add(new PermissionFilter());
    ```

1. Enter `dotnet run` in the terminal.

    Enter a prompt to book a flight or a hotel. You should see a response similar to the following:

    ```output
    User: Find me a flight to Tokyo on the 19
    Assistant: I found a flight to Tokyo on the 19th of January. The flight is with Air Japan and the price is $1200.
    User: Y
    System Message: The agent requires an approval to complete this operation. Do you approve (Y/N)
    User: N
    Assistant: I'm sorry, but I am unable to book the flight for you.
    ```

    The agent should require user approval before proceeding with any bookings.

Now you successfully applied a permission filter to your agent. Great work!