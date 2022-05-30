Azure Spring Apps enables log streaming using Azure CLI to get real-time application console logs for troubleshooting.

In this unit, you'll live stream the logs of the **api-gateway** and the **visits** services.

1.  To live stream the logs for the **api-gateway** service, use the following statements:
    
    ```azurecli
    az spring-cloud app logs \
        --name api-gateway \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_CLOUD_SERVICE
    ```

To stream the logs to your console, do the following procedure.

1.  Open a couple of web pages in the application and see the logs change in the console output.
2.  Enter ***Ctrl+c*** to stop streaming the logs.
3.  To live stream the logs of the customer service, you can use the below statement:
    
    ```azurecli
    az spring-cloud app logs \
        --name customer \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_CLOUD_SERVICE
    ```

The logs have now steamed to your console. To view the streaming output, do the following actions.

1.  Open a couple of web pages in the application and see the logs update in the console output.
2.  Enter ***Ctrl+c*** to stop streaming the logs.
