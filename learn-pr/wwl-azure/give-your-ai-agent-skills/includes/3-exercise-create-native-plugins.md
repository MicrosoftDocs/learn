In this exercise, you build a travel agent that helps users find and book flights. Let's get started!

## Prepare your development environment

A starter project is available for you to use for this exercise. Use the following steps to set up the starter project:

> [!IMPORTANT]
> You must have Visual Studio Code and the .NET Framework 8.0 installed to complete these steps. 
> You may also need to install the Visual Studio Code C# Dev Kit extension.

1. Open Visual Studio Code.

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**.

1. In the URL bar, enter `https://github.com/MicrosoftLearning/MSLearn-Develop-AI-Agents-with-Azure-OpenAI-and-Semantic-Kernel-SDK.git`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop.

1. Click the **Select as Repository Destination** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Open the project in Visual Studio Code.

1. Open the **appsettings.json** file and update the values with your Azure OpenAI Services modelId, endpoint, and API key.

    ```json
    {
        "modelId": "gpt-35-turbo-16k",
        "endpoint": "",
        "apiKey": ""
    }
    ```

1. In Explorer, right-click the **M03-create-semantic-kernel-plugins/M03-Project** folder and click **Open in Integrated Terminal**.

1. Expand the **M03-create-semantic-kernel-plugins/M03-Project** folder.

    You should see a "Program.cs" file.

Now you're ready to begin the exercise. Good luck!

## Create a flight booking plugin

In this task, you create a plugin class for your travel agent. The class includes functions to search for available flights and book a selected flight for the user. A `flights.json` file is included in the project which contains some sample flight information.

1. Open the **FlightBookingPlugin.cs** in the **M03-Project** folder.

1. Create a function that searches for flights by entering the following code:

    ```c#
    public List<FlightModel> SearchFlights(string destination, string departureDate)
    {
        // Filter flights based on destination
        return flights.Where(flight =>
            flight.Destination.Equals(destination, StringComparison.OrdinalIgnoreCase) &&
            flight.DepartureDate.Equals(departureDate)).ToList();
    }
    ```

1. Add attributes to your function that will help the AI understand how to call the function:

    ```c#
    [KernelFunction("search_flights")]
    [Description("Searches for available flights based on the destination and departure date in the format YYYY-MM-DD")]
    [return: Description("A list of available flights")]
    public List<FlightModel> SearchFlights(string destination, string departureDate)
    ```

1. Add a function that updates the flight as booked for the user:

    ```c#
    public string BookFlight(int flightId)
    {
        var flight = flights.FirstOrDefault(f => f.Id == flightId);
        if (flight == null)
        {
            return "Flight not found. Please provide a valid flight ID.";
        }

        if (flight.IsBooked)
        {
            return $"You've already booked this flight.";
        }

        flight.IsBooked = true;
        SaveFlightsToFile();
        
        return $"Flight booked successfully! Airline: {flight.Airline}, Destination: {flight.Destination}, Departure: {flight.DepartureDate}, Price: ${flight.Price}.";
    }
    ```

1. Add attributes to your function that will help the AI understand how to call the function:

    ```c#
    [KernelFunction("book_flight")]
    [Description("Books a flight based on the flight ID provided")]
    [return: Description("Booking confirmation message")]
    ```

1. Navigate to the **Program.cs** file.

1. Add your plugin to the kernel with the following code:

    ```c#
    kernel.Plugins.AddFromType<FlightBookingPlugin>("FlightBooking");
    ```

1. Add the following code to enable automatic function calling:

    ```c#
    OpenAIPromptExecutionSettings openAIPromptExecutionSettings = new() 
    {
        FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
    };
    ```

1. Create a chat history object and add a prompt to guide the LLM:

    ```c#
    var history = new ChatHistory();
    history.AddSystemMessage("The year is 2025 and the current month is January");
    ```

1. Enter the following code to a prompt to trigger the `SearchFlights` function:

    ```c#
    AddUserMessage("Find me a flight to Tokyo on the 19");
    await GetReply();
    GetInput();
    await GetReply();
    ```

1. To test your code, open the **M03-Project** folder in the terminal and enter `dotnet run` 

    You should see output similar to the following:

    ```output
    User: Find me a flight to Tokyo on the 19
    Assistant: I found a flight to Tokyo on January 19th. 

    - Airline: Air Japan
    - Price: $1200

    Would you like to book this flight?
    ```

1. Enter "Yes" in the terminal to invoke the `BookFlight` function

    You should see output similar to the following:

    ```output
    User: Yes
    Assistant: Congratulations! Your flight to Tokyo on January 19th with Air Japan has been successfully booked. The total price for the flight is $1200.
    ```

Now you successfully added plugin functions to your kernel that can be invoked automatically. Great work!