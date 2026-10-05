A support script at Contoso removed a set of catalog records, and someone then deleted the `product` container while investigating. The account runs in continuous mode, so the team can recover without a support request. What the team still has to decide is where the recovered data lands, which moment to recover to, and how to prove the recovery worked. Those three decisions are the point-in-time recovery workflow.

## Choose a restore target

Continuous backup offers two restore targets, and they solve different problems.

**Restore into the same account.** Same-account restore, also called in-account restore, brings back a deleted database or container to the account it was deleted from. It's the cheaper path, because it moves no data between accounts, and it's usually the right one for an accidental delete.

**Restore into a new account.** A new-account restore creates a separate account holding the source account's state as of the restore point. New-account restore is the path for a resource that still exists but holds wrong data, for a deleted account, and for producing a copy in another region where backups exist.

:::image type="content" source="../media/restore-target-paths.png" alt-text="Diagram showing a deleted container restored into the same account and a modified container restored into a new account." lightbox="../media/restore-target-paths.png":::

The dividing line is whether the resource still exists. Same-account restore handles deleted resources only. It doesn't restore a live database or container, and it doesn't overwrite one, so a container holding corrupted data has to be recovered through a new account and then reconciled.

Same-account restore carries its own conditions. A parent database must exist before its child container is restored, so a deleted database is restored first. No more than three restore operations run at once on an account, and a restore is blocked while a delete is in progress on the same resource or while an account-level operation such as adding a region or failing over is running.

## Identify the restore point

The restore point is a timestamp in Coordinated Universal Time. If the team recorded the moment before the incident, use it. When nobody did, the service's event feed reconstructs the history.

Start by finding the account's instance identifier, which every enumeration command needs:

```azurecli
az cosmosdb restorable-database-account list `
    --account-name "contoso-catalog"
```

The `name` property in the response is the instance identifier. To list the database and container events, use the instance identifier. Each event carries an `operationType` and an `eventTimestamp`:

```azurecli
az cosmosdb sql restorable-database list `
    --instance-id "<instance-id>" `
    --location "West US"

az cosmosdb sql restorable-container list `
    --instance-id "<instance-id>" `
    --database-rid "<database-resource-id>" `
    --location "West US"
```

An event with an `operationType` of `Delete` marks a deleted resource. Choose a timestamp within the available backup window, before deletion and no earlier than resource creation. The `--database-rid` value is the `ownerResourceId` returned for the database by the previous command, not the database name.

The Azure portal exposes the same history as an event feed on the **Point In Time Restore** page, filtered by resource and date range. The feed reports create, replace, and delete events on databases and containers. It doesn't report item-level changes, so a single deleted item leaves no event. For that case, choose a timestamp from application logs or the latest restorable timestamp captured before the change.

For same-account restore, the resource must exist in the account's current write region at the timestamp you pick. For new-account restore, it must exist in the selected restore region at that timestamp.

## Run the restore

Same-account restore uses a dedicated command per resource type. The restore timestamp is optional, and omitting it restores the most recently deleted instance:

```azurecli
az cosmosdb sql container restore `
    --resource-group "contoso-data" `
    --account-name "contoso-catalog" `
    --database-name "cosmicworks" `
    --name "product" `
    --restore-timestamp "2026-09-04T14:10:00Z" `
    --disable-ttl True
```

```azurepowershell
$parameters = @{
    ResourceGroupName     = 'contoso-data'
    AccountName           = 'contoso-catalog'
    DatabaseName          = 'cosmicworks'
    Name                  = 'product'
    RestoreTimestampInUtc = '2026-09-04T14:10:00Z'
    DisableTtl            = $true
}
Restore-AzCosmosDBSqlContainer @parameters
```

`az cosmosdb sql database restore` restores a deleted database, along with the containers it held.

The `--disable-ttl` flag matters more than its position in the command suggests. A restore reapplies the container's properties, including its time-to-live setting. Restoring a container whose items are already past their expiry can delete the recovered data almost immediately. Disabling time to live on the restored resource lets you inspect what came back before you re-enable expiry deliberately.

A new-account restore names a target account instead:

```azurecli
az cosmosdb restore `
    --resource-group "contoso-data" `
    --target-database-account-name "contoso-catalog-recovered" `
    --account-name "contoso-catalog" `
    --restore-timestamp "2026-09-04T14:10:00Z" `
    --location "West US" `
    --public-network-access Disabled `
    --disable-ttl True
```

To recover selected resources instead of the whole account, add `--databases-to-restore name=cosmicworks collections=product`. Restoring the entire account when a single container is at fault takes longer and costs more, because the restore charge is based on the volume of data restored.

Set `--public-network-access Disabled` deliberately. A restored account doesn't inherit the source account's firewall rules, virtual network configuration, or private endpoints, so without this argument the recovered data is reachable from the public network while you reapply those controls.

## Validate the result

A completed restore operation isn't the same as recovered data.

Track progress first. The restored resource reports a status of `Creating` while the operation runs and `Online` when it finishes. For same-account restores, the account's activity log records the operation under the **InAccount Restore Deleted** filter, including the principal who started it, which is the evidence an incident review asks for.

Then, verify the data itself. Read a specific item by its actual identifier and partition key, and compare a count against what you expect. Constructing a client successfully proves nothing about the restored contents.

Finally, restore the surroundings. For a new-account restore, reapply the firewall rules, virtual network configuration, private endpoints, and data-plane role assignments the application depends on. For a same-account restore, the existing account's network settings and account-scoped role assignments remain in place. Recreate any stored procedures, triggers, or user-defined functions. Client applications need attention too: a restored resource is a new resource to the service, so cached session and continuation tokens become invalid and change feed processors restart from the beginning of the restored resource's lifetime. Restart affected clients rather than letting them reuse stale tokens.

Restore permissions are separate from ordinary account permissions. The built-in `CosmosRestoreOperator` role grants the restore action and the reads that populate the restore experience. Assign it at subscription scope or to the source **restorable account resource**, whose `id` comes from `az cosmosdb restorable-database-account list`. This resource isn't the ordinary Cosmos DB account and doesn't support resource-group scope. Creating a new target account also requires `Microsoft.DocumentDB/databaseAccounts/write` on the destination resource group, which the `Cosmos DB Operator` role provides. That destination permission can be assigned at resource-group scope.

Learn more about [restoring an account with continuous backup](/azure/cosmos-db/restore-account-continuous-backup), [same-account restore](/azure/cosmos-db/restore-in-account-continuous-backup-introduction), the [steps to restore a deleted container or database](/azure/cosmos-db/how-to-restore-in-account-continuous-backup), and [restore permissions](/azure/cosmos-db/continuous-backup-restore-permissions).

Continuous backup covers days. The next unit examines the option for retention measured in years.
