You can use Azure Communication Services to send and receive text messages programmatically. In this unit, you'll create a Communication Services resource and provision the phone number that you'll later use to send an SMS message.

1. Go to [the Azure Portal](https://portal.azure.com/).

1. Select the red **Create a resource** button in the upper-left corner.

1. Enter Communication into either the Search the Marketplace input or the search bar at the top of the portal.

1. Select Communication Services in the results, and then select **Add**.

1. Specify your subscription, resource group, geography, and the name of your Communication Services resource.

1. When your resource has been created, select your Communication Services resource within the Azure Portal and navigate to the Phone Numbers blade.

1. Select the **Get** button to launch the phone number provisioning wizard. Be sure to enable the SMS capability for your phone number while provisioning.

> [!NOTE]
> Phone number availability is currently restricted to Azure subscriptions that have a billing address in the United States. For more information, visit the [Phone number types](https://docs.microsoft.com/azure/communication-services/concepts/telephony-sms/plan-solution) documentation.


1. Copy and save the following values to use later:

   - Your Communication Services phone number
   - Your Communication Services resource connection string and endpoint (available via the **Keys** blade of your Communication Services resource)

In this unit, you created a Communication Services resource that you'll use to send and receive text messages. Next, you'll learn how to create and deploy a function app in Azure.
