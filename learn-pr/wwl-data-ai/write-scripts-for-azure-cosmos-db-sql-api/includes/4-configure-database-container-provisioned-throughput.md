You can manage the provisioned throughput for both containers and databases using the CLI. Each of the **container** and **database** CLI groups includes a **throughput** subgroup with an **update** command.

## Update container throughput

The **az cosmosdb sql container throughput update** command can change the throughput of the indicated container using the **--throughput** argument. In this example, the container is updated to **1,000 RU/s** throughput.

:::code language="azurecli" source="../media/4-script.sh" range="1-6" highlight="1,6":::

## Update database throughput

Similar to updating throughput for a container, a database's throughput can be changed using the **--throughput** argument of the **az cosmosdb sql database throughput update** command. In this example, the database is updated to **4,000 RU/s** throughput.

:::code language="azurecli" source="../media/4-script.sh" range="8-12" highlight="1,5":::
