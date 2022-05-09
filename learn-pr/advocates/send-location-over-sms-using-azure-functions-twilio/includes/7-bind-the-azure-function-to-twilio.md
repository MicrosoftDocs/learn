At this point, the mobile app is complete and it can send the user's location and list of phone numbers to the Azure Functions that can deserialize the data. In this unit, you'll bind your function to Twilio to send SMS messages.

Azure Functions can be connected to other services, either in Azure or third-party. These connections, called bindings, exist in two forms - input and output bindings. Input bindings provide data to your function and output bindings take data from your function and send it to another service. You can read about bindings in the [Azure Functions Binding docs](/azure/azure-functions/functions-triggers-bindings?azure-portal=true).

Bindings for Azure Functions created in Visual Studio are defined using parameters to the function, decorated with attributes.

## Bind the Azure Functions to Twilio

Sending SMS messages via Twilio requires an output binding that is configured with your account subscription ID (SID) and Auth Token.

1. Stop the local Azure Functions runtime if it's still running from the previous unit.

1. Add the "Microsoft.Azure.WebJobs.Extensions.Twilio" NuGet package to the `ImHere.Functions` project. This NuGet package contains the relevant classes for the binding.
Make sure that you also have NuGet packages for Microsoft.Azure.WebJobs and latest .NET SDK installed in your function. The NuGet section for your function should look like the screenshot below:

   :::image type="content" source="../media/Imhere-function-dependencies.png" alt-text="Screenshot showing the function New Get dependencies.":::

1. Open the SendLocation class in the ImHere.Functions project for editing.

1. Add a using directive for `Twilio.Rest.Api.V2010.Account` to the class.

    ```cs
      using Twilio.Rest.Api.V2010.Account;
    
    ```

1. Add a new parameter called `messages` of type `ICollector<CreateMessageOptions>` to the static `Run` method.

    ```cs
    [FunctionName("SendLocation")]
    public static async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous,"get", "post", Route = null)]HttpRequestMessage req, ICollector<CreateMessageOptions> messages, ILogger log)
    ```

1. Decorate the new `messages` parameter with the `TwilioSms` attribute as follows:

      ```cs
    [TwilioSms(AccountSidSetting = "TwilioAccountSid",AuthTokenSetting = "TwilioAuthToken", From = "+1xxxxxxxxx")]ICollector<CreateMessageOptions> messages,
    ```

    This attribute has three parameters you need to set:

    * **AccountSidSetting** - set this to `"TwilioAccountSid"`
  
        This is the SID for your Twilio account that you recorded earlier in the module. Rather than set the SID directly, this parameter is the name of a value in the function app settings that will be used to retrieve the SID. We will define this parameter later.

    * **AuthTokenSetting** - set this to `"TwilioAuthToken"`

       This is the Auth Token for your Twilio account that you recorded earlier in the module. Rather than set the Auth Token directly, this parameter is the name of a value in the function app settings that will be used to retrieve the Auth Token. We will define this parameter later.

    * **From** - set this to your Twilio active phone number that you recorded earlier in the module.

        The Twilio phone number that the SMS messages will come from in international format (+\<country code\>\<phone number\>, for example "+1555123456").

    > [!IMPORTANT]
    > Make sure to remove all spaces from the phone number.

## Define TwilioSMS variables in local settings

Function app settings can be configured locally inside the `local.settings.json` file. Add your Twilio account SID and Auth Token to this JSON file using the setting names that were passed to the `TwilioSMS` attribute.

1. Open the `local.settings.json` file in the ImHere.Functions project and replace the existing code with the following:

    ```json
    {
        "IsEncrypted": false,
        "Values": {
            "AzureWebJobsStorage": "UseDevelopmentStorage=true",
            "FUNCTIONS_WORKER_RUNTIME": "dotnet",
            "TwilioAccountSid": "<Your SID>",
            "TwilioAuthToken": "<Your Auth Token>"
        }
    }
    ```

1. Replace \<Your SID\> and \<Your Auth Token\> with the values from your Twilio dashboard.

    > [!NOTE]
    > These local settings will be only for running locally. In a production app, these values would be your local development or test account credentials. Once the Azure Functions has been deployed to Azure, you'll be able to configure the production values.

    > [!NOTE]
    > If you check your code into source control, these local application setting values will be checked in, too, so be careful not to check in any actual values in these files if your code is open source or public in any form.

## Create the SMS messages

The `ICollector<CreateMessageOptions>` parameter is a collection of `CreateMessageOptions` instances and is used to collect the SMS messages you want to send. After the function has finished running, any instances of `CreateMessageOptions` added to this collection are passed to Twilio and used to create messages to be sent to the relevant recipients.

1. In the `SendLocation` class, add a using directive for `Twilio.Types` to the class.

    ```cs
      using Twilio.Types;
    
    ```

1. In the `SendLocation` function, add code to loop through the phone numbers in the `PostData` and create an SMS message for each one.

    ```cs
    foreach (string toNo in data.ToNumbers)
    {
        PhoneNumber number = new PhoneNumber(toNo);
        CreateMessageOptions message = new CreateMessageOptions(number)
        {
            Body = $"I'm here! {url}"
        };
    }
    ```

    The message needs the phone number to send to and a body that contains the Google Maps URL created from the user's location.

1. Log each message, and then add it to the `messages` collection.

    ```cs
    foreach (string toNo in data.ToNumbers)
    {
        ...
        log.LogInformation($"Creating SMS message to {message.To}, message is '{message.Body}'.");
        messages.Add(message);
    }
    ```

The complete `SendLocation` method is shown below. Enter your active phone number from Twilio to replace the placeholder in the `From` parameter.

```cs
[FunctionName("SendLocation")]
public static async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous,
                                                         "get", "post",
                                                         Route = null)]HttpRequest req,
                                            [TwilioSms(AccountSidSetting = "TwilioAccountSid",
                                                       AuthTokenSetting = "TwilioAuthToken",
                                                       From = "+1xxxxxxxxx")] ICollector<CreateMessageOptions> messages,
                                            ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    PostData data = JsonConvert.DeserializeObject<PostData>(requestBody);
    string url = $"https://www.google.com/maps/search/?api=1&query={data.Latitude},{data.Longitude}";
    log.LogInformation($"URL created - {url}");

    foreach (string toNo in data.ToNumbers)
    {
        PhoneNumber number = new PhoneNumber(toNo);
        CreateMessageOptions message = new CreateMessageOptions(number)
        {
            Body = $"I'm here! {url}"
        };
        log.LogInformation($"Creating SMS message to {message.To}, message is '{message.Body}'.");
        messages.Add(message);
    }

    return new OkResult();
}
```

## Test it out

1. Set the `ImHere.Functions` app as the startup project and start it without debugging.

1. Set the `ImHere.UWP` app as the startup project and run it.

1. Enter your own phone number in international format (+\<country code\>\<phone number\>) into the Xamarin.Forms app. Twilio trial accounts can send  messages only to verified phone numbers, so for now, you'll only be able to message yourself unless you upgrade to a paid account or verify other numbers.

1. Click the **Send Location** button. If the SMS message was sent successfully, you'll see a message in the Xamarin.Forms app saying, "Location sent successfully".

    :::image type="content" source="../media/7-ui-location-sent.png" alt-text="The Xamarin.Forms app showing the location as sent.":::

1. In the console logs for your function, you'll see the message being created and sent. If any errors occur (such as, the number is in the wrong format), they will be logged out here.

    :::image type="content" source="../media/7-function-message-sent.png" alt-text="The Azure Functions console showing the message has been sent.":::

1. Check your phone for a message. Follow the link in the message to see your location.

    :::image type="content" source="../media/7-message-received.png" alt-text="The SMS message received on a mobile phone.":::

    > [!TIP]
    > The location you'll see is the location where the app is running, so will be near to the data center that the VM is running from. If this app was running on your local device then it would show your location.

## Summary

In this unit, you learned how to create a Twilio binding for the Azure Functions and send an SMS message with the user's location to a function that was running locally. In the next unit, you publish the function to Azure.
