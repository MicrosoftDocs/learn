The **az cosmosdb update** command is used to change the characteristics of an Azure Cosmos DB account. These characteristics includes changing the regions, modifying failover priorities, and enabling multi-region writes.

Let's assume that we have an Azure Cosmos DB account that we created in the **East US** region using this command. We will use this account as an assumption throughout the next set of examples.

```azurecli
az cosmosdb create \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus'
```

## Add account regions

Assuming that our Azure Cosmos DB account only contains data in a single region (**East US**), we can add more regions using the **az cosmosdb update** command. When adding new regions, it's important to configure the failover priorities of each region using the unique syntax for this command. In this example, we configured the **East US** region as the first priority, replicated data to the **West US** region and set it as the second priority, and then finally replicated data to the **Central US** region and set it as the third priority for failover.

```azurecli
az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus' failoverPriority=0 isZoneRedundant=False \
    --locations regionName='westus2' failoverPriority=1 isZoneRedundant=False \
    --locations regionName='centralus' failoverPriority=2 isZoneRedundant=False
```

> [!NOTE]
> If you are performing any operation involving an account region, you cannot many any other changes to your account and must wait for the operation to complete.

## Enable automatic failover

Even though we have data replicated across multiple regions, we still need to enable the automatic failover mechanisms in Azure Cosmos DB. The **--enable-automatic-failover** argument takes a boolean value to enable or disable this feature. This example enables the feature using the priorities we set in previous examples.

```azurecli
az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --enable-automatic-failover 'true'
```

## Change failover priorities

As of now, the Azure Cosmos DB account is configured for automatic failover with the following priorities:

| **Region** | **Failover Priority** |
| ---: | :--- |
| **East US** | *0* |
| **West US 2** | *1* |
| **Central US** | *2* |

To change the priority values, use the **az cosmosdb failover-priority-change** command with the **failover-policies** argument. The **failover-policies** argument has a unique **\<region-name\>=\<value\>** syntax. In this example, the **West US 2** and **Central US** regions will switch priorities.

```azurecli
az cosmosdb failover-priority-change \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --failover-policies 'eastus=0' 'centralus=1' 'westus2=2'
```

> [!NOTE]
> Even if you are not changing the priorities of every region, you must include all regions in the **failover-policies** argument.

The Azure Cosmos DB account would then be configured for automatic failover with these new priority values:

| **Region** | **Failover Priority** |
| ---: | :--- |
| **East US** | *0* |
| **Central US** | *1* |
| **West US 2** | *2* |

## Enable multi-region write

The **az cosmosdb update** command can be used with the **--enable-multiple-write-locations** argument to enable or disable multi-region writes using a boolean value. In this example, multi-region writes is enabled on our account.

```azurecli
az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --enable-multiple-write-locations 'true'
```

## Remove account regions

To remove a region from an Azure Cosmos DB account, use the **az cosmosdb update** command to specify the locations that you want to remain using the **--locations** argument one or more times. Any location that is not included in the list will be removed from the account.

```azurecli
az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus' failoverPriority=0 isZoneRedundant=False \
    --locations regionName='westus2' failoverPriority=1 isZoneRedundant=False
```
