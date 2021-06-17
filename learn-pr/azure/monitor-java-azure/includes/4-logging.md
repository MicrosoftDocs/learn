In this unit, we'll look at Logging concepts.

## Types of Logging

With your sample application setup, there are two ways to see logs: log streaming of real-time logs per application instance or Log Analytics for aggregated logs with advanced query capability. In this unit we will explore log streaming via the Azure CLI.

The log streaming feature allows developers to get real-time application logs in Azure CLI and know what’s happening with specified application instance running in Azure Spring Cloud.

### Log streaming

You can use log streaming in the Azure CLI with the following command.

```azurecli
az spring-cloud app logs --name <application> --resource-group <resource group name> --service <service instance name> -f
```

### Tail log for application with multiple instances

If multiple instances exist for the application named `app`, you can view the instance log by using the `-i/--instance` option.

First, you can get the application instance names with following command.

```azurecli
az spring-cloud app show --name app --resource-group <resource group name> --service <service instance name> --query properties.activeDeployment.properties.instances -o table
```

With results:

```output
Name                                         Status    DiscoveryStatus
-------------------------------------------  --------  -----------------
app-12-75cc4577fc-pw7hb  Running   UP
app-12-75cc4577fc-8nt4m  Running   UP
app-12-75cc4577fc-n25mh  Running   UP
```

Then, you can stream logs of an application instance with the option `-i/--instance` option:

```azurecli
az spring-cloud app logs --name app --resource-group <resource group name> --service <service instance name> -i app-12-75cc4577fc-pw7hb
```

You can also get details of application instances from the Azure portal.  After selecting **Apps** in the left navigation pane of your Azure Spring Cloud service, select **App Instances**.

> [!TIP]
> Use `az spring-cloud app logs -h` to explore more parameters and log stream functionality.

In the next exercise, we'll view the logs for your sample Spring application.
