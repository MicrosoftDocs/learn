In this unit, you'll connect your Twilio phone number to the function app to receive text messages.

## Connect Twilio to the function app for incoming text messages

Now that everything is set up, the only thing left to do is to make Twilio call the function app endpoint for incoming text messages.

1. Log in to [Twilio](https://www.twilio.com?azure-portal=true).

1. In the left menu, select the ellipsis (**...**).

    :::image type="content" source="../media/twilio-elipses.png" alt-text="Screenshot that shows the ellipsis button highlighted in the left menu in Twilio."::: 

1. Select **Super Network** > **Phone Numbers** > **Manage Numbers** > **Active Numbers**, and then select your phone number.

1. In the **Messaging** section, paste the function endpoint URL that you copied from the preceding unit as the webhook destination for arriving messages.

    :::image type="content" source="../media/twilio-webhook.png" alt-text="Screenshot that shows the webhook destination.":::

1. For the webhook request method, select **HTTP Post**.

1. Select **Save**.

## Test the application

You can now get started using the application by sending a text message to your Twilio phone number. Send a text message that contains your location and a temperature range. Every 10 minutes you'll receive a reply that contains the temperature ranges for the next five days if the forecast is below or above your specified temperature range.

:::image type="content" source="../media/text-message.png" alt-text="Screenshot of text messages sent to and received by the application.":::
