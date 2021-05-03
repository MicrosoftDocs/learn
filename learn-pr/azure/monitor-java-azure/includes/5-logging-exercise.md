In this exercise, we look at Logging and Log Analytics.

# Logging

## Streaming logs

To avoid repeatedly specifying your resource group and service instance name, set your default resource group name and cluster name.

```azurecli
az configure --defaults group=<service group name>
az configure --defaults spring-cloud=<service instance name>
```

In following examples, the resource group and service name will be omitted in the commands.

### Tail log

You can view the log of the app instance with the following command:

```azurecli
az spring-cloud app logs -n customers-service
```

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

By default, `az spring-cloud app log tail` prints only existing logs streamed to the app console and then exits. If you want to stream new logs, add -f (--follow):  

```azurecli
az spring-cloud app logs -n customers-service -f
```

In the next unit, we'll discuss Application Performance Monitoring (APM).
