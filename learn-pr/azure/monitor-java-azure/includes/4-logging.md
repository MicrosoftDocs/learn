In this unit, we'll look at logging concepts and commands, and then in the next exercise, run the commands.

## Types of Logging

With the sample application, there are two ways to see logs: **Log streaming** of real-time logs per application instance, or **Log Analytics** for aggregated logs with advanced query capability.
In this unit, we'll explore log streaming via the Azure CLI.

### Log streaming

Log streaming allows developers to get real-time application logs via the Azure CLI and know what’s happening with specified application instance in your Azure Spring Apps.

You can use log streaming in the Azure CLI via the Azure Shell with the following command.

```azurecli
az spring app logs --name <application> --resource-group <resource group name> --service <service instance name> -f
```

### Tail log for application with multiple instances

First, you can get the application instance names with following command.

```azurecli
az spring app logs -f --name customers-service
```

With results:

```output
Name                                         Status    DiscoveryStatus
Multiple app instances found:
customers-service-default-17-7bc5f9dd79-fshb9
customers-service-default-17-7bc5f9dd79-pf69h
Please use '-i/--instance' parameter to specify the instance name
```

If multiple instances exist for the application named `app`, you can view the instance log by using the `-i/--instance` option.

```azurecli
az spring app logs -f --name customers-service --instance customers-service-default-17-7bc5f9dd79-fshb9
```

You can also get details of application instances from the Azure portal.  After selecting **Apps** in the left navigation pane of your Azure Spring Apps service, select **App Instances**.

> [!TIP]
> You can use `az spring app logs -h` to explore more parameters and log stream functionality.
