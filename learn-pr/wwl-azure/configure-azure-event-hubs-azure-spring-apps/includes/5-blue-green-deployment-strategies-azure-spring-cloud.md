To conclude this module, you'll run the producer app to send 100 events to your event hub and use output logs of the customers microservice to verify that messages are being received.

1.  In the Git Bash window, set the current working directory to the **extra** folder and run the TestProducer application.
    
    ```
    mvn exec:java -Dexec.mainClass="TestProducer"
    ```

2.  Verify that the output indicates that 100 events were sent to the **telemetry** event hub.
3.  Press the **Ctrl+C** key combination to return to the command prompt.
4.  From the same Git Bash window, run the following command to start the log stream output for the **customers-service**.
    
    ```
    az spring-cloud app logs -f \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service
    ```

5.  Review the output and verify that it contains the output that has the following format:
    
    `12:26:10.520 INFO 1 --- [Stainer#0-0-C-1] o.s.s.p.c.services.EventHubListener : Received message from kafka queue: Test Data #1 Test Data #1`

6.  Switch to the web browser displaying the Azure portal, navigate to the page of the resource group containing resources you provisioned in this lab, and select the entry representing your Event Hub namespace.
7.  On the Event Hubs namespace page, in the navigation menu, in the **Entities** section, select **Event Hubs** and then select the **telemetry** event hub entry.
8.  On the **Overview** page, review the **Messages** graph to verify that it includes metrics representing incoming and outgoing messages.
