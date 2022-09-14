Now that you've deployed all of your microservices, verify that the application is accessible using a web browser.

1.  To list all deployed apps, from the Git Bash shell, run the following CLI statement, which will also list all publicly accessible endpoints:
    
    ```Bash
    az spring app list \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --output table
    ```

2.  Alternatively, you can switch to the web browser window displaying the Azure portal interface, navigate to your Spring Apps instance and select **Apps** from the vertical navigation menu. In the list of apps, select **api-gateway**, on the **api-gateway \| Overview** page, note the value of the **URL** property.
3.  Open another web browser tab and navigate to the URL of the api-gateway endpoint to display the application web interface.
