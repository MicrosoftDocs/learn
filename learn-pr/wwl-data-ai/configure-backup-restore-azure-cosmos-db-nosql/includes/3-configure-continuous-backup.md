Contoso settled on continuous backup at the 7-day tier. Two accounts need the change: a catalog account you're about to create, and an existing reporting account that already runs in periodic mode. Applying the policy takes a single command in both cases, but the migration path is one-way and the window you gain isn't immediately as long as the tier suggests. Your task is to apply the policy correctly and then verify what the account can restore.

## Enable continuous backup on a new account

Set the backup policy when you create the account. In the Azure CLI, pass `--backup-policy-type Continuous` and name the tier explicitly:

```azurecli
az cosmosdb create `
    --name "contoso-catalog" `
    --resource-group "contoso-data" `
    --backup-policy-type "Continuous" `
    --continuous-tier "Continuous7Days" `
    --default-consistency-level "Session" `
    --locations regionName="West US"
```

The equivalent Azure PowerShell command uses `-BackupPolicyType` and `-ContinuousTier`:

```azurepowershell
$parameters = @{
    ResourceGroupName = 'contoso-data'
    Name              = 'contoso-catalog'
    Location          = 'West US'
    ApiKind           = 'Sql'
    BackupPolicyType  = 'Continuous'
    ContinuousTier    = 'Continuous7Days'
}
New-AzCosmosDBAccount @parameters
```

The tier argument is optional in both tools, and omitting it is the most common way teams end up paying for storage they didn't choose. Without a tier, the account is provisioned at `Continuous30Days`, which is a charged tier. Name the tier every time, even when you want the default.

In an infrastructure-as-code deployment, the policy lives in the `backupPolicy` property:

```bicep
resource catalogAccount 'Microsoft.DocumentDB/databaseAccounts@2025-04-15' = {
  name: 'contoso-catalog'
  properties: {
    // Other required properties omitted for brevity
    backupPolicy: {
      type: 'Continuous'
      continuousModeProperties: {
        tier: 'Continuous7Days'
      }
    }
  }
}
```

Declaring the policy in the template matters more than it looks. If the template omits `backupPolicy` and a later deployment redeploys the account, the template, not any change someone made in the portal, defines the account's backup configuration.

In the Azure portal, choose **Continuous** on the **Backup Policy** tab while creating the account, then select the tier.

## Migrate an existing account from periodic mode

An account already running in periodic mode migrates in place. The operation needs the `Microsoft.DocumentDB/databaseAccounts/write` permission on the account.

```azurecli
az cosmosdb update `
    --resource-group "contoso-data" `
    --name "contoso-reporting" `
    --backup-policy-type "Continuous" `
    --continuous-tier "Continuous7Days"
```

```azurepowershell
$parameters = @{
    ResourceGroupName = 'contoso-data'
    Name              = 'contoso-reporting'
    BackupPolicyType  = 'Continuous'
    ContinuousTier    = 'Continuous7Days'
}
Update-AzCosmosDBAccount @parameters
```

In the portal, open the account's **Backup & Restore** pane, select the **Backup Policies** tab, and change the mode.

Two properties of this migration deserve attention before you run it.

**The change can't be reversed.** Once an account uses continuous mode, it can't return to periodic mode. Confirm the account conditions from the previous unit first, particularly the Azure Synapse Link condition, because an account that ever had Synapse Link disabled on a container can't migrate at all.

**Migration takes time proportional to the data.** While it runs, the `backupPolicy` object reports a `migrationState` with a `status` of `InProgress` and a `targetType` of `Continuous`, while `type` still reads `Periodic`. When it finishes, `migrationState` becomes `null` and `type` becomes `Continuous`.

Changing tiers later uses the same command with a different `--continuous-tier` value. Treat a move to a shorter window as a deliberate reduction in recoverability, because the older restore points become unavailable as soon as the change applies.

## Verify the policy and the real restore window

Enabling a policy isn't the same as having a window to restore from. Check both.

Confirm the applied policy on the account:

```azurecli
az cosmosdb show `
    --resource-group "contoso-data" `
    --name "contoso-catalog" `
    --query "backupPolicy"
```

A completed configuration returns `type` set to `Continuous`, the chosen `tier` under `continuousModeProperties`, and a `migrationState` of `null`.

Then, ask the service how far forward the backups reach. The latest restorable timestamp is the most recent moment a container can be restored to, and it's the value to build a restore around rather than the current clock time:

```azurecli
az cosmosdb sql retrieve-latest-backup-time `
    --resource-group "contoso-data" `
    --account-name "contoso-catalog" `
    --database-name "cosmicworks" `
    --container-name "product" `
    --location "West US"
```

```azurepowershell
$parameters = @{
    ResourceGroupName = 'contoso-data'
    AccountName       = 'contoso-catalog'
    DatabaseName      = 'cosmicworks'
    Name              = 'product'
    Location          = 'West US'
}
Get-AzCosmosDBSqlContainerBackupInformation @parameters
```

The command reports the value for a single container. A database's effective restorable timestamp is the earliest of the timestamps across its containers, and an account's is the earliest across all of them. A newly seeded container reaches its first restorable timestamp shortly after the writes land, so a restore attempted immediately after a bulk load can target a point that predates the data.

Record the tier, the region, and a verified restorable timestamp alongside the account. During an incident, that record is faster to consult than the portal, and it prevents the team from assuming a 30-day window on an account provisioned at 7 days.

Learn more about [provisioning an account with continuous backup](/azure/cosmos-db/provision-account-continuous-backup), [migrating from periodic to continuous mode](/azure/cosmos-db/migrate-continuous-backup), and [getting the latest restorable timestamp](/azure/cosmos-db/get-latest-restore-timestamp).

The account now has a window to restore from. To recover a resource to a chosen point in time, the next unit uses it.
