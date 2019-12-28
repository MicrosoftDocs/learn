In this unit, we complete the app testing.

### 4. Confirm the command to send the truck to a specified customer works as expected

Now for the best fun of all.

1. Click the **Commands** title for the device. This control should be under the truck name, and right of the **Truck view** control.

1. Enter a customer ID, say "1" ("0" through "9" are valid customer IDs), and click **Run**.

1. In the console for the device app, you should both see  **New customer** event, and a **Route found** message.

    [![Screenshot showing the map view of the truck at its base in Seattle](../media/refrigerated-trucks-route-points.png)](../media/refrigerated-trucks-route-points.png#lightbox)

   > [!NOTE]
   > If you see a message including the text **Access denied due to invalid subscription key**, then check your subscription key to Azure Maps.

1. In the dashboard **Location** tile, is your truck on its way? You might have to wait a short time for the apps to sync up.

    [![Screenshot showing the map view of our first truck delivery route](../media/refrigerated-trucks-first-delivery.png)](../media/refrigerated-trucks-first-delivery.png#lightbox)

1. Verify the event text in the dashboard tile.

    [![Screenshot showing the new customer event in the dashboard](../media/refrigerated-trucks-new-customer-tile.png)](../media/refrigerated-trucks-new-customer-tile.png#lightbox)

Great progress! Take a moment to just watch the map update, and your truck deliver its contents.

### 5. Confirm the command to recall the truck works as expected

1. When the truck returns to base, and is reloaded with contents, it's state will be **ready**. Try issuing another delivery command. Choose another customer ID.

1. Issue a recall command before the truck reaches its customer, to check the truck responds to this command.

### 6. Check customer and conflict events are transmitted correctly

To test a conflict event, send a command that you know doesn't make sense.

1. With your truck at the base, issue a Recall command. The truck should respond with the "already at base" event.

    [![Screenshot showing the console view with a conflict event](../media/refrigerated-trucks-already-at-base.png)](../media/refrigerated-trucks-already-at-base.png#lightbox)

### 7. Check the truck properties, and change the optimal temperature

1. The simplest test is to check the **Truck ID** tile. This tile should have picked up the **Truck number 1** message when the apps were started.

1. A more complex test is to check the writable property, **OptimalTemperature**. To change this value, click on **Jobs** in the left-hand menu.

1. Click **+ New**, top-right.

1. Give the job a friendly name, "Set optimal temperature to -10".

1. For **Device group**, select **RefrigeratedTruck - All devices**. For **Job type**, select **Writable properties**. For **Writable properties**, select **Optimal Temperature**.

1. Finally, set the value as **-10**.

    [![Screenshot showing the completed Job](../media/refrigerated-trucks-job.png)](../media/refrigerated-trucks-job.png#lightbox)

1. Running this job should set the optimal temperature for all trucks in the device group, just one in our case. Click **Run**. Wait for the **Status** of the job to change from **Pending** to **Completed**. This change should only take a few seconds.

1. Navigate back, via **Devices** to your dashboard. Verify the **Optimal temperature** has been set to -10, in the tile on the dashboard.

    [![Screenshot showing the dashboard tile showing the new optimal temperature](../media/refrigerated-trucks-optimal-temp.png)](../media/refrigerated-trucks-optimal-temp.png#lightbox)

## Next steps

With the testing for one truck complete, it is time to consider expanding our IoT Cental system.
