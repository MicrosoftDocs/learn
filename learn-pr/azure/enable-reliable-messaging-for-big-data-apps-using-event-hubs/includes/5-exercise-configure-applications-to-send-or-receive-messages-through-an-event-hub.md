You're now ready to configure your publisher and consumer applications for your event hub.

In this unit, you configure applications to send or receive messages through your event hub. One application acts as the message sender (**SimpleSend**), the other as the message receiver (**EventProcessorSample**). The applications are stored in a GitHub repository.

## Create a general-purpose, standard storage account

The Java receiver application stores messages in Azure Blob Storage, which requires a storage account. To create a storage account (general-purpose V2), use the `storage account create` command. We define the following parameters for this command:

| Parameter       | Description |
| --------------- | ----------- |
| name (required) | A name for your storage account. |
| resource-group (required) | The resource group owner is the sandbox resource group, which is already defined as a default value. |
| location (optional) | Region is already defined as a default value, but you can include it if you want to set a different region from the default resource group location. |
| sku | The default SKU value of the storage account is *Standard_RAGRS*. But in this exercise, we specify that value. |

In the previous exercise, we defined default values for resource group and location, so we can omit those parameters from the command.

1. In Azure Cloud Shell, set the storage account name to a variable. A storage account name must be unique within Azure and must contain 3 to 24 numbers or lower-case letters.

    ```azurecli
    STORAGE_NAME=storagename$RANDOM
    ```

1. Run the following command to create the storage account.

    ```azurecli
    az storage account create --name $STORAGE_NAME --sku Standard_RAGRS --encryption-service blob
    ```

    > [!TIP]
    > It can take a moment to create this storage account. If storage account creation fails, change your environment variable, and try again.

1. Run the following command to obtain the access keys associated with your storage account.

    ```azurecli
    az storage account keys list --account-name $STORAGE_NAME
    ```

1. Two keys associated with your storage account are output in JSON format. Copy and save the value of **key1** for future use. You need this key to access your storage account.

1. Run the following command to obtain the connection string for your storage account.

    ```azurecli
    az storage account show-connection-string -n $STORAGE_NAME
    ```

1. The output contains the connection details for your storage account. Copy and save the value of **connectionString**. It should look something like this:

    ```output
   "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=storage_account_name;AccountKey=xxxxxxxxxxx"
    ```

1. Run the following command to create a container called **messages** in your storage account. Use the **connectionString** value you copied in the previous step.

    ```azurecli
    az storage container create --name messages --connection-string "<connection string here>"
    ```

## Clone the event hubs GitHub repository
The source files for the applications that you build in this unit are located in a [GitHub repository](https://github.com/Azure/azure-event-hubs). 

1. Launch GitBash on your computer. 
1. Run the following command to clone the Git project solution:

    ```bash
    cd ~
    git clone https://github.com/Azure/azure-event-hubs.git
    ```
1. Launch VS Code on your computer. 


## Edit SimpleSend.java that sends events to the event hub

In this exercise, you use Visual Studio Code (VS Code) to modify the SimpleSend application. You need to add your Event Hubs namespace, event hub name, shared access policy name, and primary key.

1. Launch VS Code. 
1. Select **File** -> **Open Folder**, and select the **SimpleSend** folder under c:/users/USERID/azure-event-hubs/samples/java/basic. 
1. In the Code Explorer in the left pane, expand **src**, and then double-click **SimpleSend.java** to open it in the editor. 
1. In the editor, locate and replace the following strings under `ConnectionStringBuilder``:

    - `<EVENT HUBS NAMESPACE - CONNECTION STRING>` with the connection string to your Event Hubs namespace. 
    - `<EVENT HUB NAME>` with the name of your event hub.

     For your primary SAS key, when you create an Event Hubs namespace, a 256-bit SAS key called **RootManageSharedAccessKey** is created and includes primary and secondary keys that grant send, listen, and manage rights to the namespace. Earlier in this exercise, you obtained the key by running an Azure CLI command; however, you can also find the keys and connection strings by selecting your Event Hubs namespace in the Azure portal, and then in the menu under the **Settings**, select **Shared access policies**; now select the policy name **RootManageSharedAccessKey** to display the SAS Policy keys. 
1. Save the **SimpleSend.java** file. 


## Use Maven to build SimpleSend.java

Now, you build the Java application by running **mvn** commands.

1. In the Code Explorer, right-click **SimpleSend.java**, and select **Open in Integrated Terminal**. 
1. Enter the following command to navigate to the main **SimpleSend** folder.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend
    ```
1. Build the Java SimpleSend application. This command builds your application using the connection details for your event hub.

    ```bash
    mvn clean package -DskipTests
    ```

    The build process can take several minutes to complete. Ensure that you see the **[INFO] BUILD SUCCESS** message before continuing.

    ![Build results for sender application.](../media/5-sender-build.png)

## Edit EventProcessorSample.java that receives events to the event hub

You now configure a **receiver** (also known as a **subscriber** or **consumer**) application to ingest data from your event hub.

For the receiver application, two classes are available: **EventHubReceiver** and **EventProcessorClient**. EventProcessorClient is built on top of EventHubReceiver, but provides a simpler programmatic interface than EventHubReceiver. EventProcessorClient can automatically distribute message partitions across multiple instances of EventProcessorClient using the same storage account.

In this procedure, you use the `EventProcessorClient` method. You edit the EventProcessorSample application to add the following values: Your Event Hubs namespace, event hub name, shared access policy name and primary key, storage account name, connection string, and container name.

1. Launch another instance of the VS Code. 
1. Select **File** -> **Open Folder**, and select the **EventProcessorSample** folder under c:/users/USERID/azure-event-hubs/samples/java/basic. 
1. In the Code Explorer in the left pane, expand **src**, and then double-click **EventProcessorSample.java** to open it in the editor. 
1. In the editor, locate and replace the following strings in the editor:

    - `<EVENT HUBS NAMESPACE - CONNECTION STRING>` - connection string to the Event Hubs namespace.
    - `<EVENT HUB NAME>` - name of the event hub.
    - `<AZURE STORAGE - CONNECTION STRING>` - connection string to the Azure Storage account.
    - Confirm that the blob container name is **messages**. If you're using a different name for the container, use that name. 
1. Save **EventProcessorSample.java**.


## Use Maven to build EventProcessorSample.java

1. In the Code Explorer, right-click **EventProcessorSample.java**, and select **Open in Integrated Terminal**. 
1. Change to the main **EventProcessorSample** folder by running the following command.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample
    ```
1. Build the Java SimpleSend application by running the following command to ensure that your application uses the connection details for your event hub.

    ```bash
    mvn clean package -DskipTests
    ```

    The build process can take several minutes to complete. Ensure that you see a **[INFO] BUILD SUCCESS** message before continuing.

    :::image type="content" source="../media/5-receiver-build.png" alt-text="Build results for receiver application." loc-scope="other"::: <!-- no-loc -->
## Start the sender and receiver apps

1. Start the EventProcessorSample application by running the following command.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample
    java -jar ./target/eventprocessorsample-1.0.0-jar-with-dependencies.jar
    ```
1. You should see the following output from the receiver app:

    ```bash
    Starting event processor
    Press enter to stop.
    ```    
1. Switch to the VS Code window that has the sending application (SimpleSend) code open. In the integrated terminal, run the Java application from the command line by running the following `java` command, and specifying a .jar package. 

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend
    java -jar ./target/simplesend-1.0.0-jar-with-dependencies.jar
    ```
1. When you see the **Send Complete...** message, <kbd>Enter</kbd> or <kbd>CTRL+C</kbd> to stop the application.

    ```output
    jar-with-dependencies.jar
    SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
    SLF4J: Defaulting to no-operation (NOP) logger implementation
    SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
    2018-09-18T19:42:15.146Z: Send Complete...
    ```
1. In the VS Code with the receiver application running, verify that you see messages. Press <kbd>Enter</kbd> or press <kbd>CTRL+C</kbd> to end the program.

    ```output
    ...
    Starting event processor
    Press enter to stop.
    Processing event from partition 0 with sequence number 1 with body: Message 0
    Processing event from partition 0 with sequence number 2 with body: Message 1
    Processing event from partition 0 with sequence number 3 with body: Message 2
    Processing event from partition 0 with sequence number 4 with body: Message 3
    Processing event from partition 0 with sequence number 5 with body: Message 4
    ```

## Summary

In this unit, you configured a sender application ready to send messages to your event hub. You also configured a receiver application ready to receive messages from your event hub.
