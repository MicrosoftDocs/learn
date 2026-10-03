Contoso's second problem has nothing to do with events. The catalog container was created with `/categoryId` as its partition key, and the team now wants the hierarchical key they designed. Changing a partition key isn't a settings edit: the data has to move into a container created with the new key. The portal offers a guided flow for that migration on the container's **Partition Keys** tab, and underneath it runs the same copy job you can run yourself.

The same is true of several other decisions that feel like settings and aren't: consider the unique key constraints and the container name. Decide whether to provision throughput on the database or the container. To use some features, you must enable them when you create the container. Container copy jobs are the service-side mechanism for all of these decisions. In this unit, you run one and learn what it does and doesn't preserve.

> [!NOTE]
> Container copy jobs are in public preview, so their behavior and command surface can change before general availability. Plan a migration around them only after confirming the current eligibility criteria for your account.

## What a copy job is

A copy job is a server-side data movement job you create against the destination account. The platform allocates compute instances in that account, reads the source container's change feed, and writes into a destination container you created in advance. When the job goes idle for 15 minutes, the platform releases the instances.

Copy jobs work within an account and between accounts in the same subscription or a different one. They copy one container per job. Copying a database requires a job for each container in it, and jobs in the same account run one at a time rather than in parallel.

Both modes read the change feed, which is why this capability belongs in a module about it, and the mode each uses explains their different requirements.

| Concern | Offline copy | Online copy |
|:--|:-------------|:------------|
| Reads | Latest version change feed mode | All versions and deletes change feed mode |
| Writes to the source during the copy | Must be stopped | Allowed |
| Extra account setup | None | Continuous backups, all versions and deletes mode, and the online copy capability |
| Request unit cost | Standard request unit charges | Enabling online copy adds a 50 to 100 percent surcharge to replaces and deletes on the source account; creates aren't affected |
| Ending the job | Completes on its own | You call a completion command |

:::image type="content" source="../media/container-copy-modes.png" alt-text="Diagram comparing offline and online container copy, their change feed modes, and their prerequisites." lightbox="../media/container-copy-modes.png":::

Offline copy is the simpler path, and the writes-stopped requirement isn't advisory. Updates and deletes made to the source after the job starts might not be captured, which leaves the destination with missing or duplicated data.

Online copy exists for migrations that can't take that outage. Because it consumes the all-versions-and-deletes feed, it inherits that mode's requirements: continuous backups on the source account, the feature enabled on the account, and the `EnableOnlineContainerCopy` capability added to the source account with `az cosmosdb update`. Wait at least 30 minutes after enabling this capability before creating an online job.

## Run a job

Copy jobs are managed through the Azure CLI. The commands live in the `cosmosdb-preview` extension rather than in the core CLI, so add it with `az extension add --name cosmosdb-preview` before you run a job.

Create the destination container first, with every setting you want the final container to have: partition key, unique keys, throughput, and indexing policy. Then, create the job. Give the job a name that's unique within the account; the CLI generates a random one if you omit it.

```azurecli
az cosmosdb copy create `
    --resource-group $destinationAccountRG `
    --job-name $jobName `
    --dest-account $destinationAccount `
    --src-account $sourceAccount `
    --dest-nosql database=$destinationDatabase container=$destinationContainer `
    --src-nosql database=$sourceDatabase container=$sourceContainer
```

Adding `--mode Online` to the same command creates an online job instead.

Copying between accounts requires extra identity configuration. Assign a managed identity to the source account and configure it as that account's default identity. The identity needs read-write access to the destination. Assign it the `Cosmos DB Built-in Data Contributor` role on the destination account with `az cosmosdb sql role assignment create`. Copies within a single account skip this step.

Monitor progress with `az cosmosdb copy show`. The output reports a total count, meaning the changes present in the source, and a processed count, meaning the changes the job writes. Jobs can also be paused, resumed, cancelled, and listed with the matching subcommands.

An online job doesn't finish by itself. When the processed count reaches the total count, stop writes to the source, wait 5 to 10 minutes for remaining changes to flush, and then run `az cosmosdb copy complete`. That command writes any residual changes and releases the compute. After the command completes, repoint the application at the destination container.

## What affects how fast it runs

Three factors set the pace: the source container's throughput, the destination container's throughput, and the compute the platform allocates. The default allocation is two instances of 4 virtual central processing units and 16 gigabytes (GB) per account, shared across every job running there.

Provision at least twice the source container's throughput on the destination during the copy. Then, scale it back down. Copy jobs carry no service level agreement and run on a best-effort basis, so a destination with insufficient throughput has no performance guarantee.

## Constraints worth knowing before you start

Several behaviors surprise people mid-migration:

- **Copy jobs are available in a subset of Azure regions.** The job runs in the destination account's write region, so that region has to be one of them. Check the supported list before planning the migration.
- **A write region change fails in-flight jobs.** A regional outage or manual failover during a copy means re-creating the job, which then runs in the new write region.
- **Container-level Time to Live isn't copied.** Item-level `ttl` values carry over and are recalculated so that the remaining time until expiration is preserved, but a default Time to Live set on the source container has to be set again on the destination.
- **Changing the partition key can create conflicts.** Uniqueness is enforced on the combination of `id` and partition key value. Two source items sharing an `id` under different partition key values collide when the new key gives them the same value, and the job fails on the insert. Verify uniqueness under the new key before you start.
- **The 20-GB logical partition limit still applies.** A new key that concentrates data past that ceiling fails the job with a 403. With a hierarchical key, a key prefix can exceed 20 GB, but each complete combination of key values remains subject to the limit.
- **Partition merge affects copy-job eligibility.** Copy jobs can’t run while the partition-merge capability is enabled. For online copy, another restriction applies: all-versions-and-deletes mode doesn’t support accounts with a completed partition merge in their history. Disabling partition merge therefore doesn’t make such an account eligible for online copy; use offline copy or another migration approach instead.

> **Guiding question:** Look at a container you own and ask which of its properties you'd have to run a copy job to change. If more than one is on that list, it's worth changing them in a single migration rather than repeating the outage.

For Contoso, the sequence is now complete: create a container with the hierarchical key, run an offline copy during a maintenance window, verify counts, and repoint the storefront. To target the new catalog container and use its hierarchical partition key, update the category-sync consumer's product writes. That consumer still reads category changes from `productMeta`; the copy job doesn't redirect its reads or writes automatically.
