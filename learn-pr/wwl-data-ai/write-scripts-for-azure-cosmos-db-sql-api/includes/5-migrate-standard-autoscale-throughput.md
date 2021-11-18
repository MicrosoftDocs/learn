Containers that manually provisioned throughput can be migrated to autoscale throughput. The **az cosmosdb sql container throughput migrate** command contains a special argument named **--throughput-type** that can be set to a value of **autoscale** or **manual**.

Use the **az cosmosdb sql container throughput migrate** command with the **--throughput-type** argument set to **autoscale** to migrate a container to autoscale throughput.

:::code language="azurecli" source="../media/5-script.sh" range="1-6" highlight="1,6":::

Once migrated, you can manage the maximum allowed throughput by using the **az cosmosdb sql container throughput update** command and the **--max-throughput** argument. In this example, the maximum throughput is changed to **5,000 RU/s**.

:::code language="azurecli" source="../media/5-script.sh" range="8-13" highlight="1,6":::

You can also invoke the **az cosmosdb sql container throughput show** command to view the minimum throughput of an autoscale container

:::code language="azurecli" source="../media/5-script.sh" range="22-28" highlight="1,6-7":::

At any time, you can migrate the container back to manually provisioned throughput by invoking the **az cosmosdb sql container throughput migrate** command again with the **--throughput-type** argument set to **manual**

:::code language="azurecli" source="../media/5-script.sh" range="15-20" highlight="6":::
