Containers that manually provisioned throughput can be migrated to autoscale throughput. The **az cosmosdb sql container throughput migrate** command contains a special argument named **--throughput-type** that can be set to a value of **autoscale** or **manual**.

Use the **az cosmosdb sql container throughput migrate** command with the **--throughput-type** argument set to **autoscale** to migrate a container to autoscale throughput.

```azurecli
az cosmosdb sql container throughput migrate \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --throughput-type 'autoscale'
```

Once migrated, you can manage the maximum allowed throughput by using the **az cosmosdb sql container throughput update** command and the **--max-throughput** argument. In this example, the maximum throughput is changed to **5,000 RU/s**.

```azurecli
az cosmosdb sql container throughput update \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --max-throughput '5000'
```

You can also invoke the **az cosmosdb sql container throughput show** command to view the minimum throughput of an autoscale container

```azurecli
az cosmosdb sql container throughput show \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --query 'resource.minimumThroughput' \
    --output 'tsv'
```

At any time, you can migrate the container back to manually provisioned throughput by invoking the **az cosmosdb sql container throughput migrate** command again with the **--throughput-type** argument set to **manual**

```azurecli
az cosmosdb sql container throughput migrate \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --throughput-type 'manual'
```
