Azure Event Hubs is a big data streaming platform and event ingestion service. It can receive and process millions of events per second. Data sent to an event hub can be transformed and stored by using any real-time analytics provider or batching/storage adapters.

The following scenarios are some of the scenarios where you can use Event Hubs:

 -  Application logging
 -  Analytics pipelines, such as clickstreams
 -  Live dashboards
 -  Archiving data
 -  Transaction processing
 -  User telemetry processing
 -  Device telemetry streaming

:::image type="content" source="../media/event-hubs-pipeline-eaec2d20.png" alt-text="Diagram showing how Data sent to an event hub can be transformed and stored by using any real-time analytics provider.":::
Data is valuable only when there's an easy way to process and get timely insights from data sources. Event Hubs provides a distributed stream processing platform with low latency and seamless integration, with data and analytics services inside and outside Azure to build your complete big data pipeline.

Event Hubs represents the "front door" for an event pipeline, often called an *event ingestor* in solution architectures. An event ingestor is a component or service that sits between event publishers and event consumers to decouple the production of an event stream from the consumption of those events. Azure Event Hubs provides a unified streaming platform with time retention buffer, decoupling event producers from event consumers.

:::image type="content" source="../media/azure-event-hubs-platform-8b0aa6b7.png" alt-text="Diagram showing how Azure Event Hubs provides a unified streaming platform with time retention buffer.":::
 In this unit, you'll do the following tasks:

 -  Create an Azure Event Hubs namespace for events to be received.
 -  Create an Event Hubs namespace and assign a globally unique name.
 -  From the namespace, you'll create an **eventhub** named *telemetry*.
 -  Add the connection string to the telemetry **eventhub** in your Key Vault.

> [!NOTE]
> Alternatively, you can use the Managed Identity of your microservice to connect to the **eventhub**.

> [!NOTE]
> The connection to the eventhub needs to be stored in the `spring.kafka.properties.sasl.jaas.config` application property. You'll need to name your Key Vault secret **SPRING-KAFKA-PROPERTIES-SASL-JAAS-CONFIG**.

1.  The name you use for your new namespace should be globally unique, so you'll need to modify environment variable value.
    
    ```azurecli
    EVENTHUBS_NAMESPACE=javalab-eh-ns
    
    az eventhubs namespace create \
        --resource-group $RESOURCE_GROUP \
        --name $EVENTHUBS_NAMESPACE \
        --location $LOCATION
    ```

2.  To create an eventhub in this namespace, use the following commands.
    
    ```azurecli
    EVENTHUB_NAME=telemetry
    
    az eventhubs eventhub create \
        --name $EVENTHUB_NAME \
        --resource-group $RESOURCE_GROUP \
        --namespace-name $EVENTHUBS_NAMESPACE
    ```

3.  To create a new authorization rule for sending and listening to the telemetry **eventhub**, use the following commands.
    
    ```azurecli
    RULE_NAME=listensendrule
    
    az eventhubs eventhub authorization-rule create \
        --resource-group $RESOURCE_GROUP \
        --namespace-name $EVENTHUBS_NAMESPACE \
        --eventhub-name $EVENTHUB_NAME \
        --name $RULE_NAME \
        --rights Listen Send
    ```

4.  To retrieve the connection string for this authorization rule in an environment variable, use the following command.
    
    ```azurecli
    EVENTHUB_CONNECTIONSTRING=$(az eventhubs eventhub authorization-rule keys list \
        --resource-group $RESOURCE_GROUP \
        --namespace-name $EVENTHUBS_NAMESPACE \
        --eventhub-name $EVENTHUB_NAME \
        --name $RULE_NAME \
        --query primaryConnectionString \
        --output tsv)
    ```

5.  To echo the connection string in your command window, use the following command.
    
    > [!NOTE]
    > You'll see that only access to your telemetry eventhub is granted.
    
    ```azurecli
    $EVENTHUB_CONNECTIONSTRING
    ```

    > [!NOTE]
    > The connection string should have the following format. Where the *&lt;event-hub-namespace&gt;* placeholder represents the name of your Event Hub namespace and the *&lt;shared-access-key&gt;* placeholder represents a Shared Access Signature value corresponding to the listensendrule access key.<br>`Endpoint=sb://<event-hub-namespace>.servicebus.windows.net/;SharedAccessKeyName=listensendrule;SharedAccessKey=<shared-access-key>;EntityPath=telemetry`

6.  From the Git Bash window, in your local application repository, use your text editor to create a file named **secretfile.txt.** Use with the following content to replace the *&lt;connection-string&gt;* placeholder with the value of the connection string you displayed in the previous step. Exclude the trailing string ;EntityPath=telemetry and save the file.
    
    ```
    org.apache.kafka.common.security.plain.PlainLoginModule required username="$ConnectionString" password="<connection-string>";
    ```

7.  Create a new Key Vault secret for the connection string.
    
    ```azurecli
    az keyvault secret set \
        --name SPRING-KAFKA-PROPERTIES-SASL-JAAS-CONFIG \
        --file secretfile.txt \
        --vault-name $KEYVAULT_NAME
    ```

8.  In your configuration repository's **application.yml** file, add the kafka configuration in the **spring** section by appending the following YAML fragment. Make sure to replace the *&lt;eventhub-namespace&gt;* placeholder in the value of the **bootstrap-servers** parameter.
    
    ```
    kafka:
        bootstrap-servers: javalab-eh-ns.servicebus.windows.net:9093
        client-id: first-service
        group-id: $Default
        properties:
            sasl.jaas.config:
            sasl.mechanism: PLAIN
            security.protocol: SASL_SSL
            spring.json:
                use.type.headers: false
                value.default.type: com.targa.labs.dev.telemetrystation.Message
    ```
    
    The result is similar to what's seen below.
    
    ```
    spring:
        config:
            activate:
                on-profile: mysql
        sql.init.mode: always
        sql.init.platform: mysql    jms:
            servicebus:
                connection-string: ${spring.jms.servicebus.connectionstring}
                idle-timeout: 60000
                pricing-tier: premium
        datasource:
            schema: classpath*:db/mysql/schema.sql
            data: classpath*:db/mysql/data.sql
            url: jdbc:mysql://javaopenlabmysql.mysql.database.azure.com:3306/db?useSSL=true
            initialization-mode: ALWAYS
        kafka:
            bootstrap-servers: javalab-eh-ns.servicebus.windows.net:9093
            client-id: first-service
            group-id: $Default
            group.id: $Default
            properties:
                sasl.mechanism: PLAIN
                security.protocol: SASL_SSL
                spring.json:
                    use.type.headers: false
                    value.default.type: com.targa.labs.dev.telemetrystation.Message
        topic:
            name: telemetry
        azure:
            keyvault:
                enabled: true
                uri: https://springcloudlab2-kv.vault.azure.net/
    ```

9.  Commit and push your changes to the remote repository using the following commands.
    
    ```
    cd ~/projects/spring-petclinic-microservices-config
    git add .
    git commit -m 'added event hub'
    git push
    ```
