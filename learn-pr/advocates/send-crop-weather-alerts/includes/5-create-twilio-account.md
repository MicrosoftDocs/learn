To send and receive text messages programmatically, you'll need a Twilio account. In this unit, you'll create a free Twilio account, which is more than enough to get started.

## Create a Twilio account

1. Go to the [Twilio](https://www.twilio.com?azure-portal=true) website.

1. Select the red **Sign Up** button at the upper right.

1. Enter your name, contact information, and a password, and then select **Start your free trial**.

1. Twilio will send you an email to verify your email address. In the email message, select **Confirm your email**, and then log in to Twilio with the email address and password that you provided in the preceding step.

1. Enter your phone number for verification.

   To prevent phone numbers from being used for spam, Twilio free accounts let you send messages to verified phone numbers only.  

1. Twilio will send you a verification code via text message. On the **Verify Your Identity** page, verify your phone number by entering that code, and then select **Verify**.

    :::image type="content" source="../media/twilio-verify-phone.png" alt-text="Screenshot of the phone verification step in Twilio sign-up process.":::

1. Work through the introductory questions until you get to the dashboard. These questions are used to create a first Twilio project for you to use.

   Any settings that you choose won’t impact how we’re going to use Twilio in this module.

1. On your account dashboard, select the **Get a Trial Number** button. Twilio assigns you a phone number to use to send messages.

    > [!NOTE]
    > Assigned numbers might not be able to send messages in some countries. To learn which countries have restrictions, see [Twilio international phone number availability and their capabilities](https://support.twilio.com/hc/articles/223183068-Twilio-international-phone-number-availability-and-their-capabilities?azure-portal=true). For more information about restrictions, see [Using Twilio when SMS numbers are unavailable in your country](https://support.twilio.com/hc/articles/226690868-Using-Twilio-when-SMS-numbers-are-unavailable-in-your-country?azure-portal=true).

1. On your dashboard, copy and store the following values:

   - Trial Number
   - Account SID
   - Auth Token

    :::image type="content" source="../media/twilio-dashboard.png" alt-text="Screenshot of the Twilio dashboard, showing the values to be copied and stored.":::
   
   You'll need these values later in this module.

In this unit, you created a Twilio account that you'll use to send and receive text messages. Next, you'll learn how to create and deploy an Azure function app.
