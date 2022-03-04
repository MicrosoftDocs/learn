In this unit, you'll create an event subscription within Azure IoT Hub to set up Azure Event Grid integration. This integration will trigger a logic app to send an alert email.

## Create the event subscription for IoT Hub

1. Return to the Azure portal and go to the IoT hub that you created earlier.

1. On the summary page for the hub, select the **Events** link on the left side.

1. On the **Events** pane, select the **+Event Subscription** button at the top.

1. Select **+ Event Subscription** and create the event subscription with the following values:

   * **Event Subscription Details**: Provide a descriptive name (for example: *MyDeviceCreatedEvent*) and select **Event Grid Schema**.

   * **Event Types**: In **Filter to Event Types**, clear all of the choices except **Device Created**.

     [![Subscription event types.](../media/subscription-event-types.png)](../media/subscription-event-types.png#lightbox)

   * **Endpoint Details**: Select **Endpoint Type** as **Web Hook**, choose **Select an endpoint**, and paste the URL that you copied from your logic app. Confirm the selection.

   When you're done, the pane should look like the following example:

   [![Sample event subscription form.](../media/subscription-form.png)](../media/subscription-form.png#lightbox)

## Configure the event filter

You could save the event subscription here, and then receive notifications for every device that's created in your IoT hub. For this tutorial, though, let's use the optional fields to filter for specific devices. 

1. Select **Filters** at the top of the pane.

1. Select **Add new filter**. Fill in the fields with these values:

   * **Key**: Select `Subject`.

   * **Operator**: Select `String begins with`.

   * **Value**:  Enter `devices/CheeseCave1_` to filter for device events in Cheese Cave 1.
  
1. Add another filter with these values:

   * **Key**: Select `Subject`.

   * **Operator**: Select `String ends with`.

   * **Value**: Enter `_Thermostat` to filter for device events related to temperature.

1. Select **Create** to save the event subscription.

## Next steps

Now that the integration has been implemented, the next unit tests the logic app by creating devices to trigger the event notification email.
