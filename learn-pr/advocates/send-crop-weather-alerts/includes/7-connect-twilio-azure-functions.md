In this unit, you'll set up your Twilio phone number to connect to the function app to receive text messages.

The function app you created is configured to respond to HTTP requests. Twilio will make HTTP requests in the application by accessing an HTTP trigger endpoint in Azure.

### Get the HTTP trigger endpoint

In the sandbox, to get the full endpoint URL, run this command:

```azurecli
func azure functionapp list-functions $FUNCTION_APP_NAME --show-keys
```

In the output, find the `SetupAlert` URL:

```output
Functions in cropweatheralert20200519:
    CheckForecast - [timerTrigger]

    ProcessAndNotify - [queueTrigger]

    SetupAlert - [httpTrigger]
        Invoke url: https://cropweatheralert20200519.azurewebsites.net/api/setupalert?code=Secr3tC0de
```

The full URL is displayed after `Invoke url:`. Copy and save the URL to use in the next section.

### Set up Twilio to respond to function app requests

Now that everything is set up, the only thing left is to make Twilio call the function app endpoint for incoming text messages.

1. In a web browser, sign in to [Twilio](https://www.twilio.com?azure-portal=true).

1. In the **Develop** menu, select **Phone Numbers**.

1. Select **Manage** > **Active numbers**, and then select your phone number.

    :::image type="content" source="../media/twilio-develop.png" alt-text="Screenshot that shows the Active numbers button highlighted in Twilio.":::

1. In the **Messaging Service** section, paste the function endpoint URL that you copied in the preceding section as the webhook destination for arriving messages.

    :::image type="content" source="../media/twilio-webhook.png" alt-text="Screenshot that shows the webhook destination.":::

1. For the webhook request method, select **HTTP Post**.

1. Select **Save**.

## Test the application

Now you can begin using the application by sending a text message to your Twilio phone number. Send a text message that contains your location and a temperature range. Every 10 minutes you'll receive a reply that contains the temperature ranges for the next five days if the forecast is below or above your specified temperature range.

:::image type="content" source="../media/text-message.png" alt-text="Screenshot of text messages sent to and received by the application.":::
