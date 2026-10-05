Contoso's accounts already exist, spread across three subscriptions. Building the fleet doesn't touch them: you create the fleet, create at least one fleetspace inside it, and then register each account as a fleetspace account. This unit walks that sequence in the Azure portal and shows the equivalent command-line calls, so you can organize an estate by hand once and script it afterward.

The order is fixed. A fleetspace can't exist without a fleet, and an account can't be enrolled without a fleetspace to put it in.

> [!NOTE]
> Fleet resources have their own Azure CLI command groups: `az cosmosdb fleet`, `az cosmosdb fleetspace`, and `az cosmosdb fleetspace account`. The fleets how-to article shows the same operations through the generic `az resource` commands with an explicit resource type, and those commands also work. Bicep and Azure Resource Manager templates cover the declarative path. The `az cosmosdb fleet analytics` command group ships in the `cosmosdb-preview` extension.

## Create a fleet

A fleet is a regional Azure resource in a subscription and resource group of your choosing. Its name is globally unique, and its region determines only where the fleet resource itself lives. The accounts you enroll keep whatever regions they already have.

To create a fleet in the Azure portal:

1. Enter *Cosmos DB fleet* in the global search bar and select **Azure Cosmos DB Fleets** under **Services**.
1. Select **+ Create**.
1. On the **Basics** pane, set the subscription, the resource group, a globally unique **Fleet Name**, and a **Region**.
1. Select **Review + create**, wait for validation to pass, and select **Create**.

The equivalent Azure CLI call takes only a name and a location, because a fleet carries no configuration of its own:

```azurecli
az cosmosdb fleet create `
    --resource-group $resourceGroup `
    --fleet-name $fleetName `
    --location $location
```

The same command group retrieves, lists, and deletes a fleet with `az cosmosdb fleet show`, `az cosmosdb fleet list`, and `az cosmosdb fleet delete`.

## Create a fleetspace

A fleetspace is a child of the fleet, and it's where the interesting configuration lives. Creating one is where you decide whether the accounts you're about to enroll share throughput.

A fleetspace accepts these properties, all of them under the resource's `properties` object:

| Property | Value |
| :--- | :--- |
| `fleetspaceApiKind` | `NoSQL` |
| `serviceTier` | `GeneralPurpose` or `BusinessCritical` |
| `dataRegions` | The list of regions for accounts in the throughput pool |
| `throughputPoolConfiguration.minThroughput` | A whole number, at least 100,000, and a multiple of 1,000 |
| `throughputPoolConfiguration.maxThroughput` | A whole number, at least 100,000, not less than `minThroughput`, and a multiple of 1,000 |

Notice that the service tier and the data regions sit beside `throughputPoolConfiguration` rather than inside it. They describe the accounts the fleetspace accepts, which is why they still apply when pooling is turned off.

In the portal, the same choices appear as a **Fleetspace name**, an **Enable throughput pooling** checkbox, and, when the checkbox is selected, the regions, the write-region type, and the minimum and maximum pool request units per second.

Two of these settings are permanent. The service tier and the data regions are fixed when the fleetspace is created and can't be changed afterward, so a mistake there means creating a new fleetspace and re-enrolling its accounts. The pool minimum and maximum can be changed at any time.

To create a fleetspace from the command line, put the body in a JSON file:

```json
{
  "properties": {
    "fleetspaceApiKind": "NoSQL",
    "serviceTier": "GeneralPurpose",
    "dataRegions": [ "westus2" ],
    "throughputPoolConfiguration": {
      "minThroughput": 100000,
      "maxThroughput": 100000
    }
  }
}
```

Then, reference that file rather than passing the JSON inline:

```azurecli
az cosmosdb fleetspace create `
    --resource-group $resourceGroup `
    --fleet-name $fleetName `
    --fleetspace-name $fleetspaceName `
    --body "@fleetspace.json"
```

> [!IMPORTANT]
> Pass JSON to the Azure CLI with the `@<file>` convention rather than as an inline string. PowerShell strips out the quotation marks from an inline JSON argument before the CLI ever sees it, so `'{"key": "value"}'` arrives as `{key: value}` and fails to parse. The leading `@` is also a special character in PowerShell, which is why the value is wrapped in quotation marks.

## Enroll accounts in a fleetspace

A fleetspace account registers an account that already exists. The account isn't moved, copied, or reconfigured, and it can sit in any subscription or resource group your identity can reach, which is the whole point of the exercise for a team like Contoso's.

Enrollment takes two properties, both nested under `globalDatabaseAccountProperties`:

| Property | Value |
| :--- | :--- |
| `globalDatabaseAccountProperties.armLocation` | The location of the Azure Cosmos DB account |
| `globalDatabaseAccountProperties.resourceId` | The fully qualified resource ID of the target account |

In the portal, select **Database accounts** in the **Fleet resources** section of the fleet's resource menu, choose the fleetspace, enable **Browse accounts to add to this fleetspace**, select an account, and select **+ Add to fleetspace**.

From the command line, keep the fleet's subscription active for registration. Look up the account's resource ID in its own subscription:

```azurecli
$accountId = az cosmosdb show `
    --subscription "<account-subscription-id>" `
    --resource-group $accountResourceGroup `
    --name $accountName `
    --query "id" `
    --output tsv
```

Put those two properties in a file, substituting that resource ID. Then, create the registration with `az cosmosdb fleetspace account create`, passing `--resource-group`, `--fleet-name`, `--fleetspace-name`, `--fleetspace-account-name`, and `--body "@fleetspace-account.json"`.

The exclusive membership rule limits enrollment. An account that's already registered in a fleetspace can't be added to another one, in the same fleet or a different fleet, until the existing fleetspace account is deleted. Plan the fleetspace layout before you start enrolling, because undoing a misplaced account is a delete followed by a create rather than a move.

## Organize fleets for the estate, not for the resource graph

The temptation with a new grouping resource is to mirror something that already exists, such as one fleet per subscription or one fleet per region. Both are the wrong axis.

A fleet corresponds to one multitenant application, because the application is the scope at which the reporting question is asked. "What does it cost to serve each customer?" is a question about a product, and if the product's accounts are split across two fleets, the answer has to be reassembled by hand, which is the problem the fleet was adopted to remove.

Fleetspaces are where the physical constraints land. Because every account in a pooled fleetspace shares a regional configuration and a service tier, the fleetspace layout falls out of the accounts themselves: one fleetspace per distinct combination of regions and write configuration in use. Accounts that don't need to share throughput can sit in a fleetspace with pooling turned off, which still gives them fleet-level analytics.
