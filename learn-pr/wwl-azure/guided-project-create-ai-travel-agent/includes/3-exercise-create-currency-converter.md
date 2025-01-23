For this exercise, you create a plugin that allows the user to convert currency amounts from one currency to another. Since the model can't access the internet to determine the current exchange rate, you need to provide the exchange rates into your plugin. For this exercise, you use an existing currencies.txt file to provide the exchange rates.

> [!IMPORTANT]
> You need to complete the Setup instructions in the previous unit, Prepare, before you begin this exercise.

### Create a native function

In this task, you create a native function that can convert an amount from a base currency to a target currency.

1. Navigate to the `CurrencyConverter.cs` file in the **Plugins** folder

3. Create a `ConvertAmount` function with the following code:

    ```c#
    public static string ConvertAmount(string amount, string baseCurrencyCode, string targetCurrencyCode)
    {
        Currency targetCurrency = currencyDictionary[targetCurrencyCode];
        Currency baseCurrency = currencyDictionary[baseCurrencyCode];

        if (targetCurrency == null)
        {
            return targetCurrencyCode + " was not found";
        }
        else if (baseCurrency == null)
        {
            return baseCurrencyCode + " was not found";
        }
    }
    ```

    In this code, you use the `Currency.Currencies` dictionary to get the `Currency` object for the target and base currencies. You check if the currency code was found before continuing.
    
1. Add the logic to convert currencies to the method:

    ```c#

        else
        {
            double amountInUSD = Double.Parse(amount) * baseCurrency.USDPerUnit;
            double result = amountInUSD * targetCurrency.UnitsPerUSD;
            return result + targetCurrencyCode;
        }
    ```
    
    In this code, you convert the amount from the base currency to the target currency and return a string with the converted amount. Next, let's add the kernel function attributes.

1. Add the following attributes to your `ConvertAmount` function:

    ```c#
    [KernelFunction("ConvertAmount")]
    [Description("Converts an amount from one currency to another")]
    public static string ConvertAmount(string amount, string baseCurrencyCode, string targetCurrencyCode)
    {
    ```

    Next you can register the plugin to the kernel so it can use the new `ConvertAmount` function.

1. In the `Program.cs` file, register your plugin and enable auto function calling with the following code:

    ```c#
    kernel.ImportPluginFromType<CurrencyConverter>();

    OpenAIPromptExecutionSettings openAIPromptExecutionSettings = new() 
    {
        FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
    };
    ```

1. Create a chat history object and add a prompt to guide the large language model (LLM):

    ```c#
    var history = new ChatHistory();
    AddUserMessage("Can you convert 52000 VND to USD?");
    await GetReply();
    ```

1. Complete the `AddUserMessage` function by adding the following code to the method:

    ```c#
    void AddUserMessage(string msg) 
    {
        Console.WriteLine("User: " + msg);
        history.AddUserMessage(msg);
    }
    ```

1. Add the following code to the `GetReply` method to retrieve a response from the LLM:

    ```c#
    async Task GetReply() 
    {
        ChatMessageContent reply = await chatCompletionService.GetChatMessageContentAsync(
            history,
            executionSettings: openAIPromptExecutionSettings,
            kernel: kernel
        );

        Console.WriteLine("Assistant: " + reply.ToString());
        history.AddAssistantMessage(reply.ToString());
    }
    ```

    Now you're ready to test your plugin function.

1. In the terminal, enter `dotnet run`. You should see the following output:

    ```output
    $52000 VND is approximately $2.13 in US Dollars (USD)
    ```

Now you have a plugin that allows your travel agent to convernt currencies. Great work!
