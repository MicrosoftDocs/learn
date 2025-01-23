In this exercise, you extend your AI travel assistant to help users convert currency and get the weather forecast in ther destination city. You focus on function choice behaviors to ensure the assistant invokes the correct functions for specific tasks. Let's get started!

## Task 1: Advertise selected functions

In this task, you configure your kernel to advertise only selected functions to assist in providing travel information. The assistant should be able to answer questions about flight availability, currency conversions, and the destination weather. You have the following plugins:

FlightBookingPlugin: Provides flight information and books flights.
CurrencyExchangePlugin: Provides currency exchange information.
WeatherPlugin: Provides weather forecasts for travel destinations.


1. Open the **Program.cs** in the **M03-Project** folder.

    You should have the following code from the previous exercise:

    ```c#
    // Add the plugin
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    
    // Enable planning
    OpenAIPromptExecutionSettings openAIPromptExecutionSettings = new() 
    {
        FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
    };

    var history = new ChatHistory();
    history.AddSystemMessage("The year is 2025 and the current month is January");

    AddUserMessage("Find me a flight to Tokyo on the 19");
    await GetReply();
    GetInput();
    await GetReply();
    ```

1. Register the currency exchange plugin to the kernel by adding the following code:

    ```c#
    // Add the plugin
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    kernel.Plugins.AddFromType<CurrencyExchangePlugin>("CurrencyExchange");
    ```

1. Retrieve the functions from the plugins with the following code:

    ```c#
    // Add the plugins
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    kernel.Plugins.AddFromType<CurrencyExchangePlugin>("CurrencyExchange");

    // Select the plugin functions
    KernelFunction searchFlight = kernel.Plugins.GetFunction("FlightBooking", "search_flights");
    KernelFunction convertCurrency = kernel.Plugins.GetFunction("CurrencyExchange", "convert_currency");
    ```

1. Select the functions to be available to the kernel by updating the execution settings:

    ```c#
    // Select the plugin functions
    KernelFunction searchFlight = kernel.Plugins.GetFunction("FlightBooking", "search_flights");
    KernelFunction convertCurrency = kernel.Plugins.GetFunction("CurrencyExchange", "convert_currency");

    // Enable planning
    PromptExecutionSettings openAIPromptExecutionSettings = new() 
    { 
        FunctionChoiceBehavior = FunctionChoiceBehavior.Auto(functions: [searchFlight, convertCurrency]) 
    };
    ```

1. Run the code as is to observe the difference in behavior.

    Enter `dotnet run` in the terminal to run the code. If you request to book the flight, you should see output similar to the following:

    ```output
    User: Find me a flight to Tokyo on the 19
    Assistant: I found a flight to Tokyo on the 19th of January 2025. The flight is with Air Japan and the price is $1200. Please let me know if you would like to book this flight.
    User: Can you book this flight?
    Assistant: I'm sorry, but I am just a virtual assistant and I don't have the capability to book flights. However, I can assist you with providing information and guiding you through the booking process
    ```

1. Update the user interaction with the following code:

    ```c#
    var history = new ChatHistory();
    history.AddSystemMessage("The year is 2025 and the current month is January");
    AddUserMessage("Please convert $30 USD to Japanese Yen");
    await GetReply();
    ```

1. Enter `dotnet run` in the terminal to run the code.

    You should see the following output:

    ```output
    User: Please convert $30 USD to Japanese Yen
    Assistant: $30 USD is equivalent to 3,315 Japanese Yen.
    ```

    Now your assistant can use the selected function to process the currency conversion request.

## Task 2: Enforcing Required Function Choice Behavior

In this task, you will require the model to choose at least one function, ensuring the assistant provides the necessary information about weather for a particular destination.

1. Add the weather plugin to the kernel with the following code:

    ```c#
    // Add the plugins
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    kernel.Plugins.AddFromType<CurrencyExchangePlugin>("CurrencyExchange");
    kernel.Plugins.AddFromType<WeatherPlugin>("Weather");
    ```

1. Retrieve and require the weather forecast function by updating your code to the following:

    ```c#
    KernelFunction getWeather = kernel.Plugins.GetFunction("Weather", "get_weather");

    PromptExecutionSettings openAIPromptExecutionSettings = new() 
    {
        FunctionChoiceBehavior = FunctionChoiceBehavior.Required(functions: [getWeather]) 
    };
    ```

1. Update the user interaction with the following code:

    ```c#
    var history = new ChatHistory();
    history.AddSystemMessage("The year is 2025 and the current month is January");
    AddUserMessage("What is the weather in Tokyo");
    await GetReply();
    ```

1. Enter `dotnet run` in the terminal to test the code.

    You should see a response similar to the following oujtput:

    ```output
    User: What is the weather in Tokyo
    Assistant: The current weather in Tokyo is rainy with a temperature of 18.3°C and a humidity level of 85%.
    ```

    Note that for this example, the plugins are using mock static data.

You successfully used selected function advertising to limit the AI model’s available functions to those relevant to the user's query. You also used required function choice behavior to ensure the assistant always invokes the weather function when asked for a weather forecast These techniques give you greater control over how external functions are invoked, making your travel assistant more accurate and efficient in responding to user queries. Great work!