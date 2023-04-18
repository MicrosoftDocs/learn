To help you understand basic ways to troubleshoot container instances, perform some basic operations like:

* Pulling container logs
* Viewing container events
* Attaching to a container instance

## Get logs from your prior deployed container instance

Run the following `az container logs` command to see the output from the cats and dogs voting app container you created in the prior exercise:

```azurecli
az container logs \
  --resource-group learn-deploy-aci-rg \
  --name aci-demo
```

You get a similar output to:

```output
Checking for script in /app/prestart.sh
Running script /app/prestart.sh
Running inside /app/prestart.sh, you could add migrations to this file, e.g.:

#! /usr/bin/env bash

# Let the DB start
sleep 10;
# Run migrations
alembic upgrade head
…
```

## Get container events

The `az container attach` command provides diagnostic information during container startup. Once the container has started, it also writes standard output and standard error streams to your local terminal.

Run `az container attach` to attach to your container:

```azurecli
az container attach \
  --resource-group learn-deploy-aci-rg \
  --name aci-demo
```

You get a similar output to:

```output
Container 'aci-demo' is in state 'Running'...
(count: 1) (last timestamp: 2021-09-21 23:48:14+00:00) pulling image "mcr.microsoft.com/azuredocs/azure-vote-front"
(count: 1) (last timestamp: 2021-09-21 23:49:09+00:00) Successfully pulled image "mcr.microsoft.com/azuredocs/azure-vote-front"
(count: 1) (last timestamp: 2021-09-21 23:49:12+00:00) Created container
(count: 1) (last timestamp: 2021-09-21 23:49:13+00:00) Started container

Start streaming logs:
Checking for script in /app/prestart.sh
Running script /app/prestart.sh
…
```

> [!TIP]
> Enter <kbd>Ctrl+C</kbd> to disconnect from your attached container.

## Execute a command in your container

As you diagnose and troubleshoot issues, you may need to run commands directly on your running container.

1. To see commands in your container, run the following `az container exec` command to start an interactive session on your container:

    ```azurecli
    az container exec \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo \
      --exec-command /bin/sh
    ```

    At this point, you're effectively working inside of the container.

1. Run the `ls` command to display the contents of the working directory.

    ```azurecli
    # ls
    __pycache__  config_file.cfg  main.py  prestart.sh  static  templates  uwsgi.ini
    ```

1. You can explore the system further if you wish. When you're done, run the `exit` command to stop the interactive session.

## Monitor CPU and memory usage on your container

See how to monitor CPU and memory usage on your container.

1. Run the following `az container show` command to get the ID of your Azure container instance and store the ID in a Bash variable:

    ```azurecli
    CONTAINER_ID=$(az container show \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo \
      --query id \
      --output tsv)
    ```

1. Run the `az monitor metrics list` command to retrieve CPU usage information:

    ```azurecli
    az monitor metrics list \
      --resource $CONTAINER_ID \
      --metrics CPUUsage \
      --output table
    ```

    Note the `--metrics` argument. Here, **CPUUsage** specifies to retrieve CPU usage.

    You see text similar to the following output:

    ```output
    Timestamp            Name          Average
    -------------------  ------------  -----------
    2021-09-21 23:39:00  CPU Usage
    2021-09-21 23:40:00  CPU Usage
    2021-09-21 23:41:00  CPU Usage
    2021-09-21 23:42:00  CPU Usage
    2021-09-21 23:43:00  CPU Usage      0.375
    2021-09-21 23:44:00  CPU Usage      0.875
    2021-09-21 23:45:00  CPU Usage      1
    2021-09-21 23:46:00  CPU Usage      3.625
    2021-09-21 23:47:00  CPU Usage      1.5
    2021-09-21 23:48:00  CPU Usage      2.75
    2021-09-21 23:49:00  CPU Usage      1.625
    2021-09-21 23:50:00  CPU Usage      0.625
    2021-09-21 23:51:00  CPU Usage      0.5
    2021-09-21 23:52:00  CPU Usage      0.5
    2021-09-21 23:53:00  CPU Usage      0.5
    ```

1. Run this `az monitor metrics list` command to retrieve memory usage information:

    ```azurecli
    az monitor metrics list \
      --resource $CONTAINER_ID \
      --metrics MemoryUsage \
      --output table
    ```

    Here, you specified **MemoryUsage** for the `--metrics` argument to retrieve memory usage information.

    You see text similar to the following output:

    ```output
    Timestamp            Name          Average
    -------------------  ------------  -----------
    2021-09-21 23:43:00  Memory Usage
    2021-09-21 23:44:00  Memory Usage  0.0
    2021-09-21 23:45:00  Memory Usage  15917056.0
    2021-09-21 23:46:00  Memory Usage  16744448.0
    2021-09-21 23:47:00  Memory Usage  16842752.0
    2021-09-21 23:48:00  Memory Usage  17190912.0
    2021-09-21 23:49:00  Memory Usage  17506304.0
    2021-09-21 23:50:00  Memory Usage  17702912.0
    2021-09-21 23:51:00  Memory Usage  17965056.0
    2021-09-21 23:52:00  Memory Usage  18509824.0
    2021-09-21 23:53:00  Memory Usage  18649088.0
    2021-09-21 23:54:00  Memory Usage  18845696.0
    2021-09-21 23:55:00  Memory Usage  19181568.0
    ```

In the Azure portal, Azure Container Instances CPU and memory usage information look like this:

:::image type="content" source="../media/6-cpu-memory.png" alt-text="Screenshot that shows the Azure portal view of Azure Container Instances CPU and memory usage information.":::

## Clean up resources

In this module, you created resources using your Azure subscription. You should clean up these resources so that you aren't still charged for them.

1. In the Azure **home** page, select **All resources**.

1. Find the **learn-deploy-aci-rg** resource group, or whatever resource group name you used, and select it.

1. In the **Overview** tab of the resource group, select **Delete resource group**.

1. A new dialog box opens. Enter the name of the resource group again, and select **Delete**. All of the resources we created in this module are deleted.
