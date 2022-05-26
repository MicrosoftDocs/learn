Now you're able to view the output for the **customers** microservice to monitor the messages being received.

1.  In your command prompt, start the log stream output for **customers-service**.

```azurecli
az spring-cloud app logs -f 
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name customers-service
```

The output should display the events that are registered by the event hub.
