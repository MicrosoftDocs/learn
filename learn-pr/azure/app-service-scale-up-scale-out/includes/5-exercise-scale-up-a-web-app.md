Scaling up provides more powerful resources for running a web app. It also increases the number of instances available for scaling out.

In the hotel reservation system, you should scale out to handle the increasing number of visitors to the web app. Scaling up enables you to scale out further. Scaling up is also likely necessary to support the new functionality that you add to the web app.

In this exercise, scale up the hotel reservation system web app that you deployed earlier. Run the same test client application that you used before, and monitor the performance of the web app.

## Examine the current pricing tier for the web app

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. On the Azure portal menu or from the **Home** page, select **All resources**, and then go to your App Service plan.

1. Under **Settings**, select **Scale up (App Service plan)**. You should see details of the pricing tier for your App Service plan. The pricing tier is S1, which provides 100 Azure Compute Units and 1.75 GB of memory running on an A-Series virtual machine.

    :::image type="content" source="../media/5-pricing-tier.png" alt-text="Screenshot of the pricing tier details for the App Service plan S1." lightbox="../media/5-pricing-tier.png":::

## Run the test client app

1. In the Cloud Shell window on the right side of the screen, go to the *~/mslearn-hotel-reservation-system/src/HotelReservationSystemTestClient* folder:

   ```bash
   cd ~/mslearn-hotel-reservation-system/src/HotelReservationSystemTestClient
   ```

1. Run the client app. Allow the system to run for a couple minutes. As at the start of the previous exercise, the responses are slow. The client requests soon fail with HTTP 408 (Timeout) errors.

    ```bash
    dotnet run
    ```

1. Keep running the app. Wait for another five minutes. Then go to the chart that shows the metrics for the web app on the dashboard in the Azure portal. As in the previous exercise, you should see that the statistics indicate a relatively slow response time and many HTTP 4xx errors.

## Scale up the web app and monitor the results

1. In the Azure portal, return to the page for the App Service plan.

1. Under **Settings**, select **Scale up (App Service plan)**.

1. Select the **P2V2** pricing tier and then select **Apply**. This pricing tier gives you 420 ACU (more than four times the power of the S1 pricing tier) and 7 GB of memory that runs on a Dv2-Series virtual machine. But this virtual machine costs four times the cost of running the S1 pricing tier.

1. Wait for another five minutes, and then view the performance chart on the dashboard in the Azure portal.

1. At the time of the system scale-up, you might notice some other HTTP server errors. Ongoing client requests that were aborted when the system switched hardware cause these errors. After the scale-up, the CPU time jumps because more processors are available. You might not notice the same drop in response time that you saw when scaling out. This behavior is because you're still using only a single instance. Requests aren't being load balanced as they were when you scaled out. But you now have the opportunity to scale out across more instances (20) than you had before.

   The chart in this image shows an example of the performance metrics for the web app. The point at which the system was scaled up is noted.

    :::image type="content" source="../media/5-scale-up.png" alt-text="Screenshot of the performance chart for the web app, with the point of scale-up noted." lightbox="../media/5-scale-up.png":::

1. Return to the Cloud Shell that's running the client app. Select **Enter** to stop the app.
