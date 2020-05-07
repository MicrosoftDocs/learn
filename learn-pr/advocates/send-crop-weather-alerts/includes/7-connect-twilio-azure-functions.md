In this unit, you'll connect your Twilio phone number to the Azure Functions app to receive text messages.

## Connect Twilio to Azure Functions or incoming SMS

Now that everything is set up the only thing that reminds to be done is to make Twilio call our Functions Endpoint for incoming SMS.

1. Login into Twilio at https://www.twilio.com

1. Navigate to _SUPER NETWORK_ > _Phone Numbers_ > _Manage Numbers_ > _Active Numbers_ and click on your phone number.

1. In the programmable SMS section, paste the Function Endpoint URL from the previous unit as a webhook destination.

1. For the webhook request method, choose POST.

1. Save changes.

## Test the application

You can now send a text message to your Twilio Phone Number to get started using the application.

![Screenshot of text messages sent to and received by our application](../media/text-message.png)