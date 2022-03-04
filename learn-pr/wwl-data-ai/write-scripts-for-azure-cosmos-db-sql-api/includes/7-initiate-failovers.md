Changing the region with priority **= 0** will trigger a manual failover for an Azure Cosmos account.

The **az cosmosdb update** command is used to update the failover policies for an account. If you use this command and change the failover priority for the region that is already set to **0**, the command will trigger a manual failover.

Let's assume that we have an Azure Cosmos DB account with the following regions:

| **Region** | **Failover Priority** |
| ---: | :--- |
| **East US** | *0* |
| **West US 2** | *1* |

To trigger a manual failover, use the **az cosmosdb update** command with the **--failover-policies** argument switching the priorities of the two regions.

```azurecli
az cosmosdb failover-priority-change \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --failover-policies 'westus2=0' 'eastus=1'
```

> [!TIP]
> Any priority change to a region that is **!= 0** will not trigger a failover.
