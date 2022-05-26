In this unit, you'll be sending events from a third party system to the **telemetry** event hub.

The third party system is located in the /***extra***directory of the starter project.

Modify the **producer.config** file in the ***/src/main/resources*** directory:<br>

 -  Update the **bootstrap.servers** config setting so it contains your **EventHub** namespace name.
 -  Update the **sasl.jaas.config** config setting so it contains the connection string to your telemetry event hub.

Update the ***TestProducer.java*** file in the ***/src/main/java*** directory, with **telemetry** as a topic name.

Next, compile and run the producer app, which sends 100 events to your event hub. You can view the events sent to your event hub using the Azure portal.

1.  From Visual Studio Code, open the **producer.config** file in the***/src/main/resources*** directory. Edit line 1 to with your namespace name by replacing **mynamespacename** with the namespace used for your eventhub.

`bootstrap.servers=mynamespace.servicebus.windows.net:9093`

2.  Edit line 4 with the connection string to your telemetry event hub. The edit defines the output of your $EVENTHUB\_CONNECTIONSTRING environment variable.

`sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="$ConnectionString" password="Endpoint=sb://mynamespace.servicebus.windows.net/;SharedAccessKeyName=XXXXXX;SharedAccessKey=XXXXXX";`

3.  Save the **producer.config**file.
4.  Open the **TestProducer.java** file in the ***/src/main/java*** directory. Edit line 16 to refence the telemetry event hub.

`private final static String TOPIC = "telemetry";`

5.  From the command prompt, change directory to ***producer*** folder and run the following build.

```azurecli
mvn clean package
```

6.  Run the **TestProducer** application.

```azurecli
mvn exec:java -Dexec.mainClass="TestProducer"
```

7.  The output should display events being sent to the **telemetry** event hub.
8.  From the Azure portal, navigate to your resource group and select your Event Hubs namespace.
9.  Select **Event Hubs** and your **telemetry** event hub.
10. From the overview page, you should be able to view events were sent to your event hub.
