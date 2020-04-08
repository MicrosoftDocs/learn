# Configure Azure IoT Hub Event Subscription

In this unit, you will create an Event Subscription within Azure IoT Hub to set up Event Grid integration that will trigger a Logic App to send an alert email.

1. Return to the Azure portal and navigate to the Azure IoT Hub created earlier.

1. On the IoT Hub summary page, click the **Events** link on the left-side.

1. On the **Events** pane, click the **+Event Subscription** button at the top.

1. Click **+ Event Subscription** and create the event subscription with the following values:

   * **Event Subscription Details**: Provide a descriptive name (for example: *MyDeviceCreatedEvent*) and select **Event Grid Schema**.

   * **Event Types**: In the **Filter to Event Types**, uncheck all of the choices except **Device Created**.

    [![subscription event types](../media/subscription-event-types.png)](../media/subscription-event-types.png#lightbox)

   * **Endpoint Details**: Select Endpoint Type as **Web Hook** and select *Select an endpoint* and paste the URL that you copied from your logic app and confirm selection.

    When you're done, the pane should look like the following example:

    [![Sample event subscription form](../media/subscription-form.png)](../media/subscription-form.png#lightbox)

1. You could save the event subscription here, and receive notifications for every device that is created in your IoT hub. For this tutorial, though, let's use the optional fields to filter for specific devices. Select **Filters** at the top of the pane.

1. Select **Add new filter**. Fill in the fields with these values:

   * **Key**: Select `Subject`.

   * **Operator**: Select `String begins with`.

   * **Value**:  Enter `devices/CheeseCave1_` to filter for device events in Cheese Cave 1.
  
1. Add another filter with these values:

   * **Key**: Select `Subject`.

   * **Operator**: Select `String ends with`.

   * **Value**: Enter `_Thermostat` to filter for device events related to temperature.

1. Select **Create** to save the event subscription.

## Next Steps

Now that the integration has been implemented, the next unit tests the logic app by creating devices to trigger the event notification email.
