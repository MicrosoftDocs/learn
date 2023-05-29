In your retail application, the software built by the inventory and shipping departments needs to respond to each other’s events as part of a typical workflow. For example, the inventory microservice needs to deduct the item from its inventory once an order is shipped.

In this exercise, implement Pub/Sub in an Azure Cache for Redis instance using multiple console windows.

## Open the Azure Cache for Redis console in two browser instances

Observe two separate clients sending and receiving messages by using two unique browser instances. Each browser instance has the Redis console to help illustrate real-time Pub/Sub functionality.

### Open the first browser instance

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Within the **Azure services** category, select **More services**, select the **Databases** category and then select **Azure Cache for Redis**.

1. Select the Azure Cache for Redis instance you created in a previous exercise.

    :::image type="content" source="../media/4-resource-list.png" lightbox="../media/4-resource-list-full.png" alt-text="Screenshot of the Azure Cache for Redis resource list.":::

1. In the resource pane, select **Console** to open the Redis console.

    :::image type="content" source="../media/4-console-option.png" lightbox="../media/4-console-option-full.png" alt-text="Screenshot of the Console option in the resource pane.":::

1. Leave the console open to complete subsequent tasks in this exercise.

### Open the second browser instance

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox and a separate browser window or tab.

1. Within the **Azure services** category, select **More services**, select the **Databases** category and then select **Azure Cache for Redis**.

1. Select the Azure Cache for Redis instance you created in a previous exercise.

1. In the resource pane, select **Console** to open the Redis console.

1. Leave the console open to complete subsequent tasks in this exercise.

1. At this point, you should have two browser instances open each with an instance of the Redis console.

    :::image type="content" source="../media/4-console-pair.png" lightbox="../media/4-console-pair-full.png" alt-text="Screenshot of two instances of Azure Cache for Redis console running.":::

    > [!TIP]
    > If your operating system supports it, we recommend *docking* the browser windows side-by-side to simplify the remainder of this exercise.

## Subscribe and publish messages to a known channel

Subscribe to channels using the ``SUBSCRIBE`` command and then publish messages using the ``PUBLISH`` command.

1. In the console of the **first** browser instance, perform the following actions:

    1. Enter the following command and use the **ENTER** key to begin listening for messages on the **org.shipping.alerts** channel.

        ```Redis
        SUBSCRIBE org.shipping.alerts
        ```

    1. Observe the response from the console indicating that it's now listening on the **org.shipping.alerts** channel.

        ```Redis
        Reading messages... (press ENTER to quit)
        1) "subscribe"
        2) "org.shipping.alerts"
        3) (integer) 1
        ```

1. In the console of the **second** browser instance, perform the following actions:

    1. Enter the following command and use the **ENTER** key to send a new message with the content **labelprint-sdf9878** to the **org.shipping.alerts** channel.

        ```Redis
        PUBLISH org.shipping.alerts labelprint-sdf9878
        ```

    1. Enter the following command and use the **ENTER** key to send a new message with the content **labelprint-sdf9878** to the **org.shipping.alerts** channel.

        ```Redis
        PUBLISH org.shipping.alerts packagesent-sdf9878
        ```

1. Back in the console of the **first** browser instance, perform the following actions:

    1. Observe the first response from the console indicating that it has received a new message on the **org.shipping.alerts** channel.

        ```Redis
        1) "message"
        2) "org.shipping.alerts"
        3) "labelprint-sdf9878"
        ```

    1. Observe the second response from the console indicating that it has received a new message on the **org.shipping.alerts** channel.

        ```Redis
        1) "message"
        2) "org.shipping.alerts"
        3) "packagesent-sdf9878"
        ```

        :::image type="content" source="../media/4-simple-pubsub.png" lightbox="../media/4-simple-pubsub-full.png" alt-text="Screenshot of the Redis console pair running PUBLISH and SUBSCRIBE commands":::

    1. Use the **ENTER** key to stop the console from listening to events.

    1. Enter the following command and use the **ENTER** key to clear the console output.

        ```Redis
        clear
        ```

1. Back in the console of the **second** browser instance, perform the following actions:

    1. Enter the following command and use the **ENTER** key to clear the console output.

        ```Redis
        clear
        ```

## Subscribe to a channel pattern and listen for messages

Subscribe to a pattern of channels using the ``PSUBSCRIBE`` command and then publish a message using the ``PUBLISH`` command.

1. In the console of the **first** browser instance, perform the following actions:

    1. Enter the following command and use the **ENTER** key to begin listening for messages on the **org.shipping.alerts** channel.

        ```Redis
        PSUBSCRIBE org.inventory.*
        ```

    1. Observe the response from the console indicating that it's now listening on the **org.inventory.\*** channel pattern.

        ```Redis
        Reading messages... (press ENTER to quit)
        1) "psubscribe"
        2) "org.inventory.*"
        3) (integer) 1
        ```

1. In the console of the **second** browser instance, perform the following actions:

    1. Enter the following command and use the **ENTER** key to send a new message with the content **item-sku-318947** to the **org.inventory.empty** channel.

        ```Redis
        PUBLISH org.inventory.empty item-sku-318947
        ```

    1. Enter the following command and use the **ENTER** key to send a new message with the content **order-dsy3821** to the **org.shipping.sent** channel.

        ```Redis
        PUBLISH org.shipping.sent order-dsy3821
        ```

        > [!NOTE]
        > Since this channel does not match the **org.inventory.\*** pattern, you shouldn't expect this command to send a message that your other client will receive.

1. Back in the console of the **first** browser instance, perform the following actions:

    1. Observe the response from the console indicating that it has received only a single new message using the **org.inventory.\*** channel pattern.

        ```Redis
        1) "pmessage"
        2) "org.inventory.*"
        3) "org.inventory.empty"
        4) "item-sku-318947"
        ```

        :::image type="content" source="../media/4-pattern-pubsub.png" lightbox="../media/4-pattern-pubsub-full.png" alt-text="Screenshot of the Redis console pair running PUBLISH and PSUBSCRIBE commands":::

    1. Use the **ENTER** key to stop the console from listening to events.
