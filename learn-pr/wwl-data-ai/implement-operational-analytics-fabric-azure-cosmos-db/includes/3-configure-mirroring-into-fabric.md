Contoso keeps its account in Azure and mirrors it into Fabric. Setting up mirroring takes a handful of portal steps, but two of the prerequisites are irreversible changes and one of them can't be satisfied with any built-in role. In this unit, you work through what the source account needs, what identity Fabric connects with, and what you're choosing when you select a database to mirror.

## What the source account has to be

Mirroring is available only for **Azure Cosmos DB for NoSQL** accounts. The other APIs, including API for MongoDB, Cassandra, Gremlin, and Table, aren't supported, and neither is DocumentDB (vCore-based). Mirroring also isn't available in sovereign clouds.

Beyond the API, three account-level conditions apply.

**Continuous backup is required.** The account must be configured with either 7-day or 30-day continuous backup. If you're enabling it specifically for mirroring, choose the 7-day tier: it costs nothing, and mirroring behaves identically on either. You configure continuous backup on the Azure Cosmos DB account, not in Fabric, and every existing limitation of continuous backup applies to mirroring as a result.

That inheritance is the part worth pausing on, because it drags in a rule that has nothing obviously to do with analytics: **continuous backup can't be disabled once it's enabled**, and it doesn't support multi-region write accounts. So enabling mirroring on an account is a permanent change to that account's backup configuration, and an account with more than one write region can't be a mirroring source at all.

**Analytical store history matters.** You can enable both the analytical store and continuous backup on the same account, and you can't disable the analytical store afterward. Conversely, an account where the analytical store was previously *disabled* on a container can never have continuous backup enabled, and therefore can never be mirrored. In that case, the only remaining option is a new account.

**The account has to already exist in Azure.** Mirroring configures replication from a provisioned account; it doesn't create one.

> [!TIP]
> In the Azure portal, the quickest way to tell whether continuous backup is already on is to look for **Point in Time Restore** in the account's resource menu. If the option isn't there, the account either doesn't have continuous backup or is still migrating to it.

## The connection identity

Fabric connects to the source account with either a read-write account key or a Microsoft Entra ID identity. Two options it can't use are worth naming, because both are the option a security-minded engineer reaches for first: **read-only account keys aren't supported, and neither are managed identities.**

If you use keys, rotating them breaks replication until you update the connection. The recovery is to stop replication, update the credentials, and start it again.

For Microsoft Entra ID, Fabric documentation names exactly two required data actions:

- `Microsoft.DocumentDB/databaseAccounts/readMetadata`
- `Microsoft.DocumentDB/databaseAccounts/readAnalytics`

Here's the limitation, and it's the step that costs people an afternoon. **Neither built-in data role grants `readAnalytics`.** Cosmos DB Built-in Data Reader covers `readMetadata`, item reads, `executeQuery`, and `readChangeFeed`, and Built-in Data Contributor adds the write actions. `readAnalytics` appears in neither, and it isn't in the list of individually assignable data actions in the Azure Cosmos DB data-plane security reference either. So there's no role you can pick from a list. You have to define one.

A custom role definition with both actions has this shape:

```json
{
  "RoleName": "CosmosMirroringReader",
  "Type": "CustomRole",
  "AssignableScopes": [
    "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.DocumentDB/databaseAccounts/<account-name>"
  ],
  "Permissions": [
    {
      "DataActions": [
        "Microsoft.DocumentDB/databaseAccounts/readMetadata",
        "Microsoft.DocumentDB/databaseAccounts/readAnalytics"
      ]
    }
  ]
}
```

Create it and assign it to the identity that sets up the mirror:

```azurecli
az cosmosdb sql role definition create `
    --account-name $accountName `
    --resource-group $resourceGroup `
    --body "@mirroring-role.json"
```

> [!IMPORTANT]
> Pass the role definition from a file with the `@` convention shown here, and keep the quotation marks around it. PowerShell strips out the quotation marks from an inline JSON argument before the Azure CLI ever sees it, so `--body '{"RoleName": ...}'` arrives as malformed JSON. The quotation marks around `"@mirroring-role.json"` are needed for a second reason: `@` is a PowerShell special character.

Because the definition names its assignable scope, the same file can't be reused against a different account without editing that value.

## Creating the mirror

With the account ready, the rest happens in Fabric. You need the **admin** or **member** role in the target workspace; a contributor or viewer can't enable mirroring.

1. In the Fabric portal, open or create a workspace.
1. Select **Create**, find the **Data Warehouse** section, and choose **Mirrored Azure Cosmos DB**.
1. Name the mirrored database and create it.
1. In the connection step, supply the account endpoint, a connection name, and the authentication kind: **Account key** or **Organizational account** for Microsoft Entra ID.
1. Choose the database to mirror, and optionally narrow the selection to specific containers.
1. Select **Mirror database**.

Replication starts immediately and the portal moves you to the replication status view.

### What you chose when you chose a database

Mirroring is configured **one database at a time**, and that granularity has consequences worth knowing before you set up several.

- You can mirror the same source database more than once, into different workspaces or even different tenants. Within a single workspace, you generally shouldn't, because every lakehouse, warehouse, and report in that workspace can reuse one shared mirrored copy.
- Container selection is a filter, not a schema contract. Containers you add to the source database later are picked up automatically, so you can start by mirroring an empty database and let it fill in.
- Deleting a container and creating a similar one replaces the data in the warehouse table with only the new container's data. The old rows don't survive as history.

Two items appear in the workspace as a result. The mirrored database item holds the replication controls and a read-only view of the source. An automatically generated SQL analytics endpoint sits over the Delta tables that mirroring lands in OneLake. You can add a Power BI semantic model on top.

:::image type="content" source="../media/mirroring-pipeline.png" alt-text="Diagram of mirroring from an Azure Cosmos DB account through the mirrored database item into OneLake Delta tables and the analytics surfaces." lightbox="../media/mirroring-pipeline.png":::

## Networking and cost

An account behind a virtual network or private endpoint can still be mirrored. Fabric uses the Network ACL Bypass feature to let an authorized workspace reach the account without a data gateway. Data landed in OneLake, on the other hand, doesn't support private endpoints, customer-managed keys, or double encryption, so the analytical copy has a different security profile from the source and needs its access secured on the Fabric side.

On cost, the replication compute is free and your capacity size covers OneLake storage for mirrored data. What you do pay for is the compute that runs your queries, the continuous backup you enabled on the source account at standard Azure Cosmos DB rates, and any browsing you do through the mirrored database's source view. That browsing cost surprises people: the read-only data explorer in Fabric routes its reads to Azure and **consumes request units on the source account**, which is exactly what mirroring exists to avoid. Query the SQL analytics endpoint instead when you want a free read.

In this unit, you learn how to configure mirroring from an Azure Cosmos DB account into Fabric OneLake, understand the networking and cost implications, and make informed decisions about how to set up and use the mirrored data.
