In this unit, you'll connect your Twilio phone number to the Azure Functions app to receive text messages.

## Connect Twilio to Azure Functions or incoming SMS

Now that everything is set up the only thing that reminds to be done is to make Twilio call our Functions Endpoint for incoming SMS.

1. Log in into Twilio at [twilio.com](https://www.twilio.com?azure-portal=true)

1. Select the ellipses on the side bar

    ![Ellipses](../media/twilio-elipses.png)

1. Navigate to _SUPER NETWORK_ > _Phone Numbers_ > _Manage Numbers_ > _Active Numbers_ and select your phone number

1. In the *Messaging* section, paste the Function Endpoint URL from the previous unit as the webhook destination for when a message comes in

    ![Setting the twilio webhook](../media/twilio-webhook.png)

1. For the webhook request method, choose **HTTP POST**

1. Select the Save button at the bottom to save your changes

## Test the application

You can now send a text message to your Twilio Phone Number to get started using the application.

![Screenshot of text messages sent to and received by our application](../media/text-message.png)
