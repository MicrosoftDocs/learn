In the previous unit, you learned that the Azure Explorer in the Azure Toolkit for Eclipse enables you to manage and configure Azure web apps. In this exercise, you see how to use Azure Explorer to stop and restart the **SampleWebApp** Azure web app. Next, modify the web app by using Azure Explorer to add a pair of properties to the configuration.

You modify the web app to read the value of these properties and use them in the web app logic. You then redeploy the web app and verify that it functions as expected. Finally, use Azure Explorer to delete the web app and remove it from Azure.

## Stop and restart the web app

1. Start Eclipse if it isn't already running, and open the **SampleWebApp** project.

1. In the Azure Toolkit for Eclipse toolbar, select **Show Azure Explorer**.

1. If you aren't currently signed in to Azure, follow the procedure described in the previous exercise to sign in to your Azure account and select your subscription.

1. In the **Azure Explorer** window, expand **Web Apps**, right-click your web app, and then select **Stop**.

   :::image type="content" source="../media/7-web-app-stop.png" alt-text="Screenshot of the context menu for the web app in the Azure Explorer window.":::

1. Right-click your web app again, and then select **Open in Browser**. The web browser should display an HTTP 403 message that indicates that the web app isn't currently running.

   :::image type="content" source="../media/7-web-browser-403.png" alt-text="Screenshot of the web browser displaying the HTTP 403 message.":::

1. Leave the web browser open and return to Eclipse. In the **Azure Explorer** window, right-click the web app, and then select **Start**.

1. Return to the web browser, and refresh the display. The web app should be running again.

1. Close the web browser and return to Eclipse.

## Add configuration properties to the web app

1. In the **Azure Explorer** window, right-click the web app, and then select **Show Properties**. The properties window for the web app appears.

   :::image type="content" source="../media/7-web-app-properties.png" alt-text="Screenshot of the properties window for the web app.":::

1. In the properties window, select **New** to add a new property key and value.

1. In the **Key** column of the new property, enter the name **Delay**, and then select **Enter**.

1. Select **Edit**, and in the **Value** column for the property, type the value **2**, and then select **Enter**.

1. In the properties window, select **New** again.

1. Add another property named **Iterations**, with the value **10**.

   :::image type="content" source="../media/7-new-web-app-properties.png" alt-text="Screenshot of the properties window for the web app showing the new properties and values.":::

1. Select **Save**.

1. When the **Properties updated** dialog box appears, select **OK**.

## Modify the web app to use the properties

1. In **Project Explorer**, expand **SampleWebApp**, expand **WebContent**, and then double-click **index.jsp**.

1. In the body section of the code for the web page, change the code as shown here:

   ```html
   <body>
       <%! int delayms = Integer.valueOf(System.getenv("Delay")) * 1000;
           int iterations = Integer.valueOf(System.getenv("Iterations"));
           DateFormat fmt = new SimpleDateFormat("dd/MM/yy HH:mm:ss"); %>
       <%  for (int i = 0; i < iterations; i++) {
           Thread.sleep(delayms); %>
           <p>Today's date is <%= fmt.format(new Date()) %></p>
       <% } %>
       <p>Your IP address is <%= request.getRemoteAddr() %></p>
   </body>
   ```

   This code reads the values of both properties. The properties are exposed as environment variables for the web app runtime. The code displays the date and time at `Delay` seconds intervals, looping `Iterations` times.

   > [!NOTE]
   > In this example, the code runs synchronously when it generates the output. This means it will take up to 20 seconds for the page to appear.

1. On the **File** menu, select **Save**.

1. In the **Project Explorer** window, right-click **SampleWebApp**, select **Azure**, and then select **Publish as Azure Web App**.

1. In the **Deploy Web App** window, accept the default settings, then select **Deploy**. Accepting the default settings overwrites the existing web app with the new version.

   > [!NOTE]
   > If you want to preserve the original version of the web app until the new version has been fully tested, deploy the new web app to a new deployment slot, using the options at the bottom of the **Deploy Web App** window.

1. In the **Azure Activity Log** window, wait until the progress column indicates that the web app is successfully deployed.

1. Select the **Published** link in the **Azure Activity Log** window. A new browser window opens. After 20 seconds, the messages displaying the time at two-second intervals appears, followed by the IP address of the client computer.

   :::image type="content" source="../media/7-updated-web-app.png" alt-text="Screenshot of the web browser running the new version of the web app." loc-scope="third-party":::

1. Leave the browser window open, and return to Eclipse. In the **Azure Explorer** window, right-click the web app, and then select **Show Properties**.

1. In the properties window, select the **Delay** property, and select **Edit**. Change the value to *1*.

1. Select the **Iterations** property, select **Edit**, and change the value to *5*.

1. Select **Save**.

1. In the **Properties updated** dialog box, select **OK**.

1. Switch back to the web browser and refresh the display. This time, the page displays the time at one-second intervals, repeated only five times. You didn't need to redeploy the web app.

1. Close the web browser and return to Eclipse.

## Delete the web app

1. In the **Azure Explorer** window, right-click the web app, and then select **Delete**.

1. In the **Azure Explorer** dialog box that prompts you to make sure this deletion is really what you want to do, select **OK**.

   :::image type="content" source="../media/7-delete-web-app.png" alt-text="Screenshot of the message box confirming that the user wants to delete the web app." loc-scope="third-party":::

1. When the web app is deleted, it disappears from the **Web Apps** folder in **Azure Explorer**.

> [!IMPORTANT]
> Deleting the web app using the Azure Toolkit for Eclipse doesn't delete the app service plan. You can remove the plan using the Azure portal. To do so, navigate to the appropriate resource group, select the app service plan, and then select **Delete**, as shown in the following image:
>
> :::image type="content" source="../media/7-delete-app-service-plan.png" alt-text="Screenshot of the Azure portal with the delete option highlighted." lightbox="../media/7-delete-app-service-plan.png":::
