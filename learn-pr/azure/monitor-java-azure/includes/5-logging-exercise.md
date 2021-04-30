In this exercise, we look at Logging and Log Analytics.

# Logging

## Streaming logs

To avoid repeatedly specifying your resource group and service instance name, set your default resource group name and cluster name.

```azurecli
az configure --defaults group=<service group name>
az configure --defaults spring-cloud=<service instance name>
```

In following examples, the resource group and service name will be omitted in the commands.

### Tail log for app with single instance

If an app named customers-service has only one instance, you can view the log of the app instance with the following command:

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

### Tail log for app with multiple instances

If multiple instances exist for the app named `customers-service`, you can view the instance log by using the `-i/--instance` option.

First, you can get the app instance names with following command.

```azurecli
az spring-cloud app show -n customers-service --query properties.activeDeployment.properties.instances -o table
```

With results:

```output
Name                                         Status    DiscoveryStatus
-------------------------------------------  --------  -----------------
customers-service-default-12-75cc4577fc-pw7hb  Running   UP
customers-service-default-12-75cc4577fc-8nt4m  Running   UP
customers-service-default-12-75cc4577fc-n25mh  Running   UP
```

Then, you can stream logs of an app instance with the option `-i/--instance` option:

```azurecli
az spring-cloud app logs -n customers-service -i customers-service-default-12-75cc4577fc-pw7hb
```

You can also get details of app instances from the Azure portal.  After selecting **Apps** in the left navigation pane of your Azure Spring Cloud service, select **App Instances**.

### Continuously stream new logs

By default, `az spring-cloud ap log tail` prints only existing logs streamed to the app console and then exits. If you want to stream new logs, add -f (--follow):  

```azurecli
az spring-cloud app logs -n customers-service -f
```

To check all the logging options supported:

```azurecli
az spring-cloud app logs -h 
```

In the next unit, we'll discuss Application Performance Monitoring (APM).
