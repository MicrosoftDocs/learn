In this unit, you'll be sending events from a third party system to the **telemetry** event hub.

You will now implement the functionality that will allow you to emulate sending events from a third party system to the telemetry Event Hub. You can find this third party system in the [azure-event-hubs-for-kafka on GitHub](https://github.com/Azure/azure-event-hubs-for-kafka) and use the quickstart/java/producer.

Modify the **producer.config** file in the ***/src/main/resources*** directory:

 -  Update the **bootstrap.servers** config setting so it contains your **EventHub** namespace name.
 -  Update the **sasl.jaas.config** config setting so it contains the connection string to your telemetry event hub.
 -  Update the **TestProducer.java** file in the ***producer**src/main/java*** directory, with **telemetry** as a topic name.

Next, compile and run the producer app, which sends 100 events to your event hub. You can view the events sent to your event hub using the Azure portal.

1.  From the Git Bash shell in the **projects** folder, clone the [azure-event-hubs-for-kafka on GitHub](https://github.com/Azure/azure-event-hubs-for-kafka) project.<br>
    
    ```
    cd ~/projects
    git clone https://github.com/Azure/azure-event-hubs-for-kafka
    ```

2.  In the **projects** folder, use your text editor to open the **azure-event-hubs-for-kafka/quickstart/java/producer/src/main/resources/producer.config** file. Edit line 1 by replacing the `mynamespace`placeholder with the name of the Event Hub namespace you provisioned earlier in this lab.
    
    ```
    bootstrap.servers=mynamespace.servicebus.windows.net:9093
    
    ```

3.  Edit line 4 with the connection string to your **telemetry** event hub. The edit defines the output of your **$EVENTHUB\_CONNECTIONSTRING** environment variable.
    
    ```
    sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="$ConnectionString" password="Endpoint=sb://mynamespace.servicebus.windows.net/;SharedAccessKeyName=XXXXXX;SharedAccessKey=XXXXXX;EntityPath=telemetry";
    ```

3.  Save the changes to ***producer.config*** file.
4.  Open the **TestProducer.java** file in the ***azure-event-hubs-for-kafka/quickstart/java/producer/src/main/java*** directory. Verify that line 16 has `telemetry` shown as a topic name.
    
    ```
    private final static String TOPIC = "telemetry";
    ```

6.  From the Git Bash window, set the current working directory to the **extra** folder and run a Maven build.
    
    ```azurecli
    cd ~/projects/azure-event-hubs-for-kafka/quickstart/java/producer
    mvn clean package
    ```
