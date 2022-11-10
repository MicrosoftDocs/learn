Azure Spring Apps enables log streaming using Azure CLI to get real-time application console logs for troubleshooting.

In this unit, you'll live stream the logs of the **api-gateway** and the **visits** services.

To live stream the logs for the **api-gateway** service, use the following statements:

```azurecli
az spring app logs \
    --name api-gateway \
    --resource-group $RESOURCE_GROUP \
    --service $SPRING_APPS_SERVICE
    --follow
```

The action above will stream the **api-gatewa**y service app logs to your console.<br>

1.  Switch to the web browser displaying the Spring Petclinic application and navigate throughout the interface. Notice that your actions trigger display of new log entries in the console output.
2.  Enter **Ctrl+c** to stop streaming the logs.
