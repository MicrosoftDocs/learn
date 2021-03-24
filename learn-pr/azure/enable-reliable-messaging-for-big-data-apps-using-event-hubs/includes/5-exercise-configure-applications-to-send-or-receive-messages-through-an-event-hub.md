You're now ready to configure your publisher and consumer applications for your Event Hub.

In this unit, you'll configure these applications to send or receive messages through your Event Hub. These applications are stored in a GitHub repository.

You'll configure two separate applications; one acts as the message sender (**SimpleSend**), the other as the message receiver (**EventProcessorSample**). These are Java applications, which enable you to do everything within the browser. However, the same configuration is needed for any platform, such as .NET.

## Create a general-purpose, standard storage account

The Java receiver application, that you'll configure in this unit, stores messages in Azure Blob Storage. Blob Storage requires a storage account.

1. In the Cloud Shell, create a storage account (general-purpose V2) running the `storage account create` command. Remember we set a default resource group and location, so even though those parameters are normally _required_, we can leave them off.

    |Parameter      |Description|
    |---------------|-----------|
    |--name (required)  | A name for your storage account. |
    |--resource-group (required)  | The resource group owner. We'll use the pre-created sandbox resource group. |
    |--location (optional) | An optional location if you want the storage account in a specific place vs. the resource group location. |

    Set the storage account name into a variable. It must be between 3 and 24 characters in length and use numbers and lower-case letters only. It also must be unique within Azure.

    ```azurecli
    STORAGE_NAME=storagename$RANDOM
    ```

    Then use this command to create the storage account.

    ```azurecli
    az storage account create --name $STORAGE_NAME --sku Standard_RAGRS --encryption-service blob
    ```

    > [!TIP]
    > If the storage account creation fails, change your environment variable and try again.

1. List all the access keys associated with your storage account running the `account keys list` command. It takes your account name and the resource group (which is defaulted).

    ```azurecli
    az storage account keys list --account-name $STORAGE_NAME
    ```

    Access keys associated with your storage account are listed. Copy and save the value of **key** for future use. You'll need this key to access your storage account.

1. View the connections string for your storage account running the following command.

    ```azurecli
    az storage account show-connection-string -n $STORAGE_NAME
    ```

    This command returns the connection details for the storage account. Copy and save the _value_ of **connectionString**. It should look something like.

    ```output
    "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=storage_account_name;AccountKey=VZjXuMeuDqjCkT60xX6L5fmtXixYuY2wiPmsrXwYHIhwo736kSAUAj08XBockRZh7CZwYxuYBPe31hi8XfHlWw=="
    ```

1. Create a container called **messages** in your storage account running the following command. Use the **connectionString** you copied in the previous step.

    ```azurecli
    az storage container create --name messages --connection-string "<connection string here>"
    ```

## Clone the Event Hubs GitHub repository

Perform the following steps to clone the Event Hubs GitHub repository with `git`. You can execute this right in the Cloud Shell.

1. The source files for the applications that you'll build in this unit are located in a [GitHub repository](https://github.com/Azure/azure-event-hubs). Run the following commands to make sure that you are in your home directory in Cloud Shell, and then to clone this repository.

    ```bash
    cd ~
    git clone https://github.com/Azure/azure-event-hubs.git
    ```

    The repository is cloned to your home folder.

## Edit SimpleSend.java

You're going to use the built-in Cloud Shell editor. You'll use the editor to modify the SimpleSend application, and add your Event Hubs namespace, Event Hub name, shared access policy name, and primary key. The main commands appear at the bottom of the editor window.

You'll need to write out your edits by pressing <kbd>Ctrl+O</kbd>, and then pressing <kbd>Enter</kbd> to confirm the output file name. Exit the editor by pressing <kbd>Ctrl+X</kbd>. Alternatively, the editor has a "..." menu in the top/right corner for all the editing commands.

1. Change to the **SimpleSend** folder.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend/src/main/java/com/microsoft/azure/eventhubs/samples/SimpleSend
    ```

1. Open the Cloud Shell editor in the current folder. This shows a list of files on the left and an editor space on the right.

    ```bash
    code .
    ```

1. Open the **SimpleSend.java** file by selecting it from the file list.

1. In the editor, locate and replace the following strings:

    - `"Your Event Hubs namespace name"` with the name of your Event Hub namespace.
    - `"Your Event Hub"` with the name of your Event Hub.
    - `"Your policy name"` with **RootManageSharedAccessKey**.
    - `"Your primary SAS key"` with the value of the **primaryKey** key for your Event Hub namespace that you saved earlier.

    > [!TIP]
    > Unlike the terminal window, the editor can use typical copy/paste keyboard accelerator keys for your OS.

    If you've forgotten some of them, you can switch down to the terminal window below the editor and run the `echo` command to list out one of the environment variables. For example:

    ```bash
    echo $NS_NAME
    echo $HUB_NAME
    echo $STORAGE_NAME
    ```

    When you create an Event Hubs namespace, a 256-bit SAS key called **RootManageSharedAccessKey** is created that has an associated pair of primary and secondary keys that grant send, listen, and manage rights to the namespace. In the previous unit, you displayed the key running an Azure CLI command, and you can also find this key by opening the **Shared access policies** page for your Event Hubs namespace in the Azure portal.

1. Save **SimpleSend.java** either through the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

1. Close the editor with the "..." menu, or the accelerator key <kbd>CTRL+Q</kbd>.

## Use Maven to build SimpleSend.java

You'll now build the Java application running **mvn** commands.

1. Revert to the main **SimpleSend** folder.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend
    ```

1. Build the Java SimpleSend application. This ensures that your application uses the connection details for your Event Hub.

    ```bash
    mvn clean package -DskipTests
    ```

    The build process may take several minutes to complete. Ensure that you see the **[INFO] BUILD SUCCESS** message before continuing.

    ![Build results for sender application](../media/5-sender-build.png)

## Edit EventProcessorSample.java

You'll now configure a **receiver** (also known as **subscribers** or **consumers**) application to ingest data from your Event Hub.

For the receiver application, two classes are available: **EventHubReceiver** and **EventProcessorHost**. EventProcessorHost is built on top of EventHubReceiver, but provides simpler programmatic interface than EventHubReceiver. EventProcessorHost can automatically distribute message partitions across multiple instances of EventProcessorHost using the same storage account.

In this unit, you'll use the EventProcessorHost method. You'll edit the EventProcessorSample application to add your Event Hubs namespace, Event Hub name, shared access policy name and primary key, storage account name, connection string, and container name.

1. Change to the **EventProcessorSample** folder running the following command.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample/src/main/java/com/microsoft/azure/eventhubs/samples/eventprocessorsample
    ```

1. Open the Cloud Shell editor.

    ```bash
    code .
    ```

1. Select the **EventProcessorSample.java** file.

1. Locate and replace the following strings in the editor:

    - `----ServiceBusNamespaceName----` with the name of your Event Hubs namespace.
    - `----EventHubName----` with the name of your Event Hub.
    - `----SharedAccessSignatureKeyName----` with **RootManageSharedAccessKey**.
    - `----SharedAccessSignatureKey----` with the value of the **primaryKey** key for your Event Hubs namespace that you saved earlier.
    - `----AzureStorageConnectionString----` with your storage account connection string that you saved earlier.
    - `----StorageContainerName----` with "messages".
    - `----HostNamePrefix----` with the name of your storage account.

1. Save **EventProcessorSample.java** either with the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

1. Close the editor.

## Use Maven to build EventProcessorSample.java

1. Change to the main **EventProcessorSample** folder running the following command.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample
    ```

1. Build the Java SimpleSend application running the following command. This ensures that your application uses the connection details for your Event Hub.

    ```bash
    mvn clean package -DskipTests
    ```

    The build process may take several minutes to complete. Ensure that you see a **[INFO] BUILD SUCCESS** message before continuing.

    :::image type="content" source="../media/5-receiver-build.png" alt-text="Build results for receiver application." loc-scope="other"::: <!-- no-loc -->

## Start the sender and receiver apps

1. Run Java application from the command line by running the **java** command, and specifying a .jar package. Run the following commands to start the SimpleSend application.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend
    java -jar ./target/simplesend-1.0.0-jar-with-dependencies.jar
    ```

1. When you see **Send Complete...**, press <kbd>Enter</kbd>.

    ```output
    jar-with-dependencies.jar
    SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
    SLF4J: Defaulting to no-operation (NOP) logger implementation
    SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
    2018-09-18T19:42:15.146Z: Send Complete...
    ```

1. Start the EventProcessorSample application running the following command.

    ```bash
    cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample
    java -jar ./target/eventprocessorsample-1.0.0-jar-with-dependencies.jar
    ```

1. When messages stop appearing on the console, press <kbd>Enter</kbd> or press <kbd>CTRL+C</kbd> to end the program.

    ```output
    ...
    SAMPLE: Partition 0 checkpointing at 1064,19
    SAMPLE (3,1120,20): "Message 80"
    SAMPLE (3,1176,21): "Message 84"
    SAMPLE (3,1232,22): "Message 88"
    SAMPLE (3,1288,23): "Message 92"
    SAMPLE (3,1344,24): "Message 96"
    SAMPLE: Partition 3 checkpointing at 1344,24
    SAMPLE (2,1120,20): "Message 83"
    SAMPLE (2,1176,21): "Message 87"
    SAMPLE (2,1232,22): "Message 91"
    SAMPLE (2,1288,23): "Message 95"
    SAMPLE (2,1344,24): "Message 99"
    SAMPLE: Partition 2 checkpointing at 1344,24
    SAMPLE: Partition 1 batch size was 3 for host mystorageacct2018-46d60a17-7060-4b53-b0e0-cca70c970a47
    SAMPLE (0,1120,20): "Message 81"
    SAMPLE (0,1176,21): "Message 85"
    SAMPLE: Partition 0 batch size was 10 for host mystorageacct2018-46d60a17-7060-4b53-b0e0-cca70c970a47
    SAMPLE: Partition 0 got event batch
    SAMPLE (0,1232,22): "Message 89"
    SAMPLE (0,1288,23): "Message 93"
    SAMPLE (0,1344,24): "Message 97"
    SAMPLE: Partition 0 checkpointing at 1344,24
    SAMPLE: Partition 3 batch size was 8 for host mystorageacct2018-46d60a17-7060-4b53-b0e0-cca70c970a47
    SAMPLE: Partition 2 batch size was 9 for host mystorageacct2018-46d60a17-7060-4b53-b0e0-cca70c970a47
    SAMPLE: Partition 0 batch size was 3 for host mystorageacct2018-46d60a17-7060-4b53-b0e0-cca70c970a47
    ```

## Summary

You've now configured a sender application ready to send messages to your Event Hub. You've also configured a receiver application ready to receive messages from your Event Hub.
