For this exercise, you create a plugin that allows the user to convert currency amounts from one currency to another. Since the model can't access the internet to determine the current exchange rate, you need to provide the exchange rates into your plugin. For this exercise, you use an existing currencies.txt file to provide the exchange rates.

> [!IMPORTANT]
> You need to complete the Setup instructions in the previous unit, Prepare, before you begin this exercise.

### Create a native function

In this task, you create a native function that can convert an amount from a base currency to a target currency.

1. Create a new file named `CurrencyConverter.cs` in the **Plugins/ConvertCurrency** folder

2. In the `CurrencyConverter.cs` file, add the following code to create a plugin function:

    ```c#
    using AITravelAgent;

    class CurrencyConverter
    {
        [KernelFunction, 
        Description("Convert an amount from one currency to another")]
        public static string ConvertAmount()
        {
            var currencyDictionary = Currency.Currencies;
        }
    }
    ```

    In this code, you use the `KernelFunction` decorator to declare your native function. You also use the `Description` decorator to add a description of what the function does. You can use `Currency.Currencies` to get a dictionary of currencies and their exchange rates. Next, add some logic to convert a given amount from one currency to another.

3. Modify your `ConvertAmount` function with the following code:

    ```c#
    [KernelFunction, Description("Convert an amount from one currency to another")]
    public static string ConvertAmount(
        [Description("The target currency code")] string targetCurrencyCode, 
        [Description("The amount to convert")] string amount, 
        [Description("The starting currency code")] string baseCurrencyCode)
    {
        var currencyDictionary = Currency.Currencies;
        
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
        else
        {
            double amountInUSD = Double.Parse(amount) * baseCurrency.USDPerUnit;
            double result = amountInUSD * targetCurrency.UnitsPerUSD;
            return @$"${amount} {baseCurrencyCode} is approximately 
                {result.ToString("C")} in {targetCurrency.Name}s ({targetCurrencyCode})";
        }
    }
    ```

    In this code, you use the `Currency.Currencies` dictionary to get the `Currency` object for the target and base currencies. You then use the `Currency` object to convert the amount from the base currency to the target currency. Finally, you return a string with the converted amount. Next, let's test your plugin.

    > [!NOTE]
    > When using the Semantic Kernel SDK in your own projects, you don't need to hardcode data into files if you have access to RESTful APIs. Instead, you can use the `Plugins.Core.HttpClient` plugin to retrieve data from APIs.

4. In the `Program.cs` file, import and invoke your new plugin function with the following code:

    ```c#
    kernel.ImportPluginFromType<CurrencyConverter>();
    kernel.ImportPluginFromType<ConversationSummaryPlugin>();
    var prompts = kernel.ImportPluginFromPromptDirectory("Prompts");

    var result = await kernel.InvokeAsync("CurrencyConverter", 
        "ConvertAmount", 
        new() {
            {"targetCurrencyCode", "USD"}, 
            {"amount", "52000"}, 
            {"baseCurrencyCode", "VND"}
        }
    );

    Console.WriteLine(result);
    ```

    In this code, you use the `ImportPluginFromType` method to import your plugin. Then you use the `InvokeAsync` method to invoke your plugin function. The `InvokeAsync` method takes the plugin name, function name, and a dictionary of parameters. Finally, you print the result to the console. Next, run the code to make sure it's working.

5. In the terminal, enter `dotnet run`. You should see the following output:

    ```output
    $52000 VND is approximately $2.13 in US Dollars (USD)
    ```

    Now that your plugin is working correctly, let's create a natural language prompt that can detect what currencies and amount the user wants to convert.

### Create a prompt

In this task, you create a prompt that parses the user's input to identify the target currency, base currency, and amount to convert.

1. Create a new folder named `GetTargetCurrencies` in the **Prompts** folder

2. In the `GetTargetCurrencies` folder, create a new file named `config.json`

3. Enter the following text into the `config.json` file:

    ```output
    {
        "schema": 1,
        "type": "completion",
        "description": "Identify the target currency, base currency, and amount to convert",
        "execution_settings": {
            "default": {
                "max_tokens": 800,
                "temperature": 0
            }
        },
        "input_variables": [
            {
                "name": "input",
                "description": "Text describing some currency amount to convert",
                "required": true
            }
        ]
    }
    ```

4. In the `GetTargetCurrencies` folder, create a new file named `skprompt.txt`

5. Enter the following text into the `skprompt.txt` file:

    ```html
    <message role="system">Identify the target currency, base currency, and 
    amount from the user's input in the format target|base|amount</message>

    For example: 

    <message role="user">How much in GBP is 750.000 VND?</message>
    <message role="assistant">GBP|VND|750000</message>

    <message role="user">How much is 60 USD in New Zealand Dollars?</message>
    <message role="assistant">NZD|USD|60</message>

    <message role="user">How many Korean Won is 33,000 yen?</message>
    <message role="assistant">KRW|JPY|33000</message>

    <message role="user">{{$input}}</message>
    <message role="assistant">target|base|amount</message>
    ```

## Check your work

In this task, you run your application and verify your code is working correctly. 

1. Test your new prompt by updating your `Program.cs` file with the following code:

    ```c#
    kernel.ImportPluginFromType<CurrencyConverter>();
    var prompts = kernel.ImportPluginFromPromptDirectory("Prompts");

    var result = await kernel.InvokeAsync(prompts["GetTargetCurrencies"],
        new() {
            {"input", "How many Australian Dollars is 140,000 Korean Won worth?"}
        }
    );

    Console.WriteLine(result);
    ```

2. Enter `dotnet run` in the terminal. You should see the following output:

    ```output
    AUD|KRW|140000
    ```

    > [!NOTE]
    > If your code doesn't produce the output you expected, you can review the code in the **Solution** folder. You may need to adjust the prompt in the skprompt.txt file to produce more exact results.

Now you have a plugin that can convert an amount from one currency to another, and a prompt that can be used to parse the user's input into a format the `ConvertAmount` function can use. In the next exercise, you can use the user's intent to run your functions.
