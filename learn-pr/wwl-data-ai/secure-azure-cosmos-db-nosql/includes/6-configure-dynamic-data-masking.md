Contoso's support application needs customer context, but routine support work doesn't require complete email addresses or phone numbers. The previous units establish the application's identity, role permissions, and network boundary. Your final control addresses which customer values appear in its responses. You configure dynamic data masking and check its behavior with separate managed identities before considering production use.

## Limit field exposure in read responses

Dynamic data masking (DDM) applies server-side masking to read and query response projections in Azure Cosmos DB for NoSQL. Stored data remains unchanged. A full-document read retains the document's structure while masking selected properties. A query that projects selected properties returns a smaller result rather than a full document. Treat both response shapes as validation targets, not as evidence that the underlying values change.

For Contoso, use the existing `cosmicworks` database and `customer` container, partitioned on `/customerId`. This container holds both customer and sales order documents, distinguished by `type`. Customer documents contain `emailAddress` and `phoneNumber`, so the policy targets are real. A masking policy applies container-wide, not conditionally by `type`. The example covers only those two fields. Names, addresses, and other properties remain unchanged.

DDM requires Microsoft Entra ID authentication with a **managed identity**. Account keys aren't supported. Don't assume the earlier local developer credential pattern supports this feature. Use one managed identity for the masked support workload and a separate managed identity for authorized unmasked reads. Both still need appropriate data-plane permissions and an allowed network path.

:::image type="content" source="../media/cosmos-masking-read-responses.png" alt-text="Diagram showing two managed identities reading the same stored customer, with masked or original values based on unmask permission." lightbox="../media/cosmos-masking-read-responses.png":::

## Enable masking and define property paths

Assess the feature in a sandbox or nonproduction account first. Check dependent workflows before enabling it, including the change feed and write-response limitations described later in this unit.

> [!IMPORTANT]
> Enabling DDM is an irreversible account change: you can't disable the account feature afterward. Removing all masking policy paths prevents masking, but it doesn't roll back feature enablement. Complete your nonproduction assessment before enabling it on a production account.

With that decision approved, configure the account feature before the container policy:

1. In the Azure portal, open the account's **Settings**, then **Features**, and enable dynamic data masking.
2. Allow for activation, which can take up to 15 minutes. Confirm that the feature is enabled before configuring a container policy.
3. Open the target container's **Settings**, then **Masking Policy**. This option appears only when the account feature is enabled. Configure the selected paths and strategies.

### Describe the policy as shared JSON

The following JSON shows the `dataMaskingPolicy` property wrapped in an object for an existing container configuration. It's a **configuration fragment**, not a complete container creation document or a customer data document. The policy is language-neutral and doesn't require separate C# and Python versions.

```json
{
  "dataMaskingPolicy": {
    "includedPaths": [
      {
        "path": "/emailAddress",
        "strategy": "Email"
      },
      {
        "path": "/phoneNumber",
        "strategy": "Default"
      }
    ]
  }
}
```

Here, `Email` retains the first username letter and the domain ending while masking other portions. `Default` returns `XXXX` for strings, `0` for numbers, and `false` for Boolean values. Contoso's phone field uses string masking. These replacements reduce detail but don't guarantee that every remaining value lacks identifying information.

### Keep identifiers outside the policy

Keep `id` and the partition key, `customerId`, unmasked. Masking these properties makes the Data Explorer document view unavailable. Don't mask the root `/` without excluding these identifiers. The `excludedPaths` property is supported only when the root path is included. This two-property example doesn't need exclusions.

For other requirements, `MaskSubstring` uses `startPosition` and `length` to mask part of a string. Array element paths use `[]`, but a path can't end in `[]` or address an element by numeric index. Select paths from the actual document structure instead of assuming positional addressing.

## Separate masked and unmasked permissions

With the policy defined, apply the role distinction from the RBAC unit. **Cosmos DB Built-in Data Reader** (`00000000-0000-0000-0000-000000000001`) lacks unmask permission. Use it for the masked reader. **Cosmos DB Built-in Data Contributor** (`00000000-0000-0000-0000-000000000002`) includes unmask through its `items/*` wildcard, but also grants writes. Don't choose Contributor solely to reveal original values.

Instead, define a custom read-only role for the second identity. Retain Reader's `readMetadata`, `items/read`, `executeQuery`, and `readChangeFeed` actions, and add `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/unmask`. A role definition alone grants nothing. Assign the role to the intended managed identity at `/dbs/cosmicworks/colls/customer`.

Use the principal **object ID** for the assignment and, for a user-assigned managed identity, its **client ID** for application credential selection. Create native data-plane definitions and assignments with a supported management tool such as the Azure CLI, not portal **Access control (IAM)**. Review every applicable assignment: a broader grant with unmask defeats the intended masked-reader boundary. Native `notDataActions` can't subtract that permission.

> [!IMPORTANT]
> DDM adds a requirement to the earlier unit's general Reader description: change feed access is unavailable without unmask permission, even when `readChangeFeed` is granted. This restriction applies to both latest version mode and all versions and deletes mode.

## Validate application behavior and plan for limits

In the nonproduction assessment, compare the same existing customer under both managed identities. Use its actual `id` and `customerId`, without inventing sample values. Test representative point reads and queries from an allowed application network:

- **Compare selected fields.** Confirm masked results for the support identity and original values for the intended unmask identity.
- **Check response shapes.** Cover full documents and projected property fragments. Confirm that other fields remain unchanged and that the application handles masked types and values.
- **Measure request cost.** Masking adds query processing and request unit cost. Measure representative requests instead of assuming a fixed overhead.
- **Record limited evidence.** Capture the principal, scope, operation, and pass or fail result. Don't log original customer values or tokens.

To define acceptance criteria for the support workflow, use these results. The business owner confirms that the remaining customer context supports the task. Security reviewers check for unexpected originals in responses and for broader role assignments. Operations compares request costs against the workload budget and records which response shapes the application accepts. A passing comparison covers those tested operations only. Repeat it when the policy, query shape, role assignments, or application response mapping changes.

### Protect paths outside masked reads

Read validation doesn't establish comprehensive data protection. Complex queries can expose or infer original values, so restrict direct database query access and control application responses. Masking supplements least privilege and network restrictions rather than replacing them.

Writes need separate attention: create, replace, upsert, and patch act on underlying unmasked data and can return unmasked values. Never use a masked document as a write payload, because it can overwrite original values with masked replacements. Review write permissions and response handling independently of the read comparison.

Also, account for dependent services: backups and materialized views operate on original unmasked data. Fabric mirroring and analytical store aren't supported by default on DDM-enabled accounts. Contact Support when planning those combinations. Learn more about [dynamic data masking configuration and limitations](/azure/cosmos-db/dynamic-data-masking).

For Contoso, acceptance evidence combines identity, permissions, network access, and the values its support application exposes. Carry those boundaries into the module's exercise without treating successful masked reads as a production-wide security guarantee.