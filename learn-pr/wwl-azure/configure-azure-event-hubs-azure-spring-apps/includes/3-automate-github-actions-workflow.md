In this unit, you'll be sending events from a third party system to the **telemetry** event hub.

The third party system is located in the ***/extra*** directory of the starter project.

Modify the **producer.config** file in the ***/src/main/resources*** directory:

 -  Update the **bootstrap.servers** config setting so it contains your **EventHub** namespace name.
 -  Update the **sasl.jaas.config** config setting so it contains the connection string to your telemetry event hub.
 -  Update the **TestProducer.java** file in the ***/src/main/java*** directory, with **telemetry** as a topic name.

Next, compile and run the producer app, which sends 100 events to your event hub. You can view the events sent to your event hub using the Azure portal.

1.  From Visual Studio Code, open the **producer.config** file in the ***/src/main/resources*** directory. Edit line 1 to with your namespace name by replacing **mynamespacename** with the namespace used for your eventhub.
    
    ```
    bootstrap.servers=mynamespace.servicebus.windows.net:9093
    
    ```

2.  Edit line 4 with the connection string to your **telemetry** event hub. The edit defines the output of your **$EVENTHUB\_CONNECTIONSTRING** environment variable.
    
    ```
    sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="$ConnectionString" password="Endpoint=sb://mynamespace.servicebus.windows.net/;SharedAccessKeyName=XXXXXX;SharedAccessKey=XXXXXX"; 
    
    Endpoint=sb://javalab-eh-ns-3080227949.servicebus.windows.net/;SharedAccessKeyName=listensendrule;SharedAccessKey=OOqTHuZYbLoQ4CLlNAD9e4R6viBOUx9QWLasXsFqnZI=;EntityPath=telemetry
    ```

3.  Save the changes to ***producer.config*** file.
4.  Open the **TestProducer.java** file in the ***/src/main/java*** directory. Edit line 16 by replacing the `test` placeholder with **telemetry** so it uses the telemetry event hub and save the change.
    
    ```
    private final static String TOPIC =
    
    ```

6.  From the Git Bash window, set the current working directory to the **extra** folder and run a Maven build.
    
    ```azurecli
    mvn clean package
    ```
