In this unit, you'll set up your Twilio phone number to connect to the function app to receive text messages.

## Connect Twilio with the function app

The function app you created is configured to respond to HTTP requests. Twilio will make HTTP requests in the application by accessing an HTTP trigger endpoint in Azure.

### Get the HTTP trigger endpoint

In the sandbox, to get the full endpoint URL, run this command:

```azurecli
func azure functionapp list-functions $FUNCTION_APP_NAME --show-keys
```

In the output, find the `SetupAlert` URL:

```output
Functions in cropweatheralertjabenn:
    CheckForecast - [timerTrigger]

    ProcessAndNotify - [queueTrigger]

    SetupAlert - [httpTrigger]
        Invoke url: https://cropweatheralertjabenn.azurewebsites.net/api/setupalert?code=Secr3tC0de
```

The full URL is displayed after `Invoke url:`. Copy and save the URL to use in the next section.

### Set up Twilio to respond to function app requests

Now that everything is set up, the only thing left to do is to make Twilio call the function app endpoint for incoming text messages.

1. Log in to [Twilio](https://www.twilio.com?azure-portal=true).

1. In the left menu, select the ellipsis (**...**).

    :::image type="content" source="../media/twilio-elipses.png" alt-text="Screenshot that shows the ellipsis button highlighted in Twilio."::: 

1. Select **Super Network** > **Phone Numbers** > **Manage Numbers** > **Active Numbers**. Select your phone number.

1. In the **Messaging** section, paste the function endpoint URL that you copied in the preceding unit as the webhook destination for arriving messages.

    :::image type="content" source="../media/twilio-webhook.png" alt-text="Screenshot that shows the webhook destination.":::

1. For the webhook request method, select **HTTP Post**.

1. Select **Save**.

## Test the application

Now you can begin using the application by sending a text message to your Twilio phone number. Send a text message that contains your location and a temperature range. Every 10 minutes you'll receive a reply that contains the temperature ranges for the next five days if the forecast is below or above your specified temperature range.

:::image type="content" source="../media/text-message.png" alt-text="Screenshot of text messages sent to and received by the application.":::
