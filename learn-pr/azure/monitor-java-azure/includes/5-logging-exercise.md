In this exercise, we look at exercises for viewing the logs of your sample application.

## Streaming logs exercise

### Tail log

In your existing Azure Cloud Shell window, view the log of the application instance with the following command:

```azurecli
az spring app logs --name customers-service
```

> [!IMPORTANT]
> If you closed the original Azure Cloud Shell window, or want to run the commands in your local development environment, you must specify your resource group and Azure Spring Apps service name:
>```azurecli
>az spring app logs --name customers-service --resource-group <resource group name> --service <service >instance name>
>```

This command will return logs:

```output
...
2021-04-23 09:13:59.516  INFO [customers-service,,,] 1 --- [           main] o.s.s.p.c.CustomersServiceApplication    : Started CustomersServiceApplication in 48.032 seconds (JVM running for 79.933)
2021-04-23 09:14:05.385  INFO [customers-service,,,] 1 --- [nio-1025-exec-2] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
2021-04-23 09:14:05.385  INFO [customers-service,,,] 1 --- [nio-1025-exec-2] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2021-04-23 09:14:05.410  INFO [customers-service,,,] 1 --- [nio-1025-exec-2] o.s.web.servlet.DispatcherServlet        : Completed initialization in 25 ms
...
```

### Continuously stream new logs

By default, `az spring app log tail` prints only existing logs streamed to the app console and then exits. If you want to stream new logs, add `-f` (`--follow`):  

```azurecli
az spring app logs --name customers-service -f
```

## Errors and warnings exercise

Next, we'll create an error, to show the value of how you can quickly debug and find its root cause.

1. Open the customers-service and follow the logs:

    ```azurecli
    az spring app logs --name customers-service -f
    ```

2. Next, in a web browser, open a new window and trigger a warning with the following command: (Replace the "\<spring-apps-name\>" with the name of your spring apps instance)

    ```html
    https://<spring-apps-name>-api-gateway.azuremicroservices.io/api/customer/owners/George
    ```

3. Accessing the above URL triggers a warning, as the variable "George" cannot be cast into a number to search for a customer.
You now can see a warning similar to the below screen:

   :::image type="content" source="../media/5-warning.jpg" alt-text="screenshot of Azure Cloud Shell with log warning" lightbox="../media/5-warning.jpg":::

4. To resolve this warning, in a web browser, rather search for the customer using the customer ID:

    ```html
    https://<spring-apps-name>-api-gateway.azuremicroservices.io/api/customer/owners/1
    ```
