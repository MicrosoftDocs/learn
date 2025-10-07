Azure App Configuration implements key-value pair storage architecture for configuration data persistence.

## Keys

Keys constitute identifiers for key-value pairs enabling corresponding value storage and retrieval operations.

Hierarchical key namespace organization utilizing character delimiters (`/` or `:`) represents common practice aligned with application-specific conventions.

App Configuration implements atomic key treatment without key name structure parsing or rule enforcement beyond reserved character constraints.

App Configuration keys implement case-sensitive Unicode string representation.

Keys _app1_ and _App1_ constitute distinct entries within App Configuration store inventories.

Application configuration consumption requires awareness that certain frameworks implement case-insensitive configuration key handling introducing potential inconsistencies.

Unicode character utilization within key names supports comprehensive internationalization excluding reserved characters (`*`, `,`, `\`).

Reserved character inclusion requires escape sequence notation `\{Reserved Character}`.

Key-value pair combined size constraints impose 10,000 character limits encompassing key, value, and associated optional attribute content.

Size limit constraints permit extensive hierarchical key level implementations within aggregate character boundaries.

### Design key namespaces

Configuration data key naming strategies encompass flat and hierarchical approaches.

Application usage perspectives demonstrate functional equivalence, while hierarchical naming confers operational advantages:

- **Enhanced readability:** Delimiter-based hierarchical structure replaces monolithic character sequences with semantic segmentation improving human comprehension
- **Simplified management:** Hierarchical key nomenclature represents logical configuration data groupings facilitating organizational workflows
- **Optimized query operations:** Pattern-matching query construction targeting hierarchical structures enables selective configuration data retrieval

**Hierarchical key structure examples:**

- **Component service-based organization:**

  ```
  AppName:Service1:ApiEndpoint
  AppName:Service2:ApiEndpoint
  ```

- **Deployment region-based organization:**

  ```
  AppName:Region1:DbEndpoint
  AppName:Region2:DbEndpoint
  ```

### Label keys

App Configuration key values support optional label attribute specification enabling key differentiation.

Labels facilitate identical key identifier differentiation through variant designation.

Key _app1_ with labels _A_ and _B_ constitutes two distinct entries within App Configuration stores.

Label attribute defaults specify empty or null values.

Labels provide convenient key variant creation mechanisms. Environmental configuration differentiation represents common label application patterns:

```
Key = AppName:DbEndpoint & Label = Test
Key = AppName:DbEndpoint & Label = Staging
Key = AppName:DbEndpoint & Label = Production
```

### Version key values

App Configuration omits automatic key value versioning during modification operations.

Labels enable multiple key value version creation methodologies.

Application version numbers or Git commit identifiers embedded within labels facilitate key value association with specific software build artifacts.

### Query key values

Key values maintain unique identification through key and label combinations supporting `null` label specifications. App Configuration store query operations employ pattern specification methodologies for key value retrieval.

App Configuration stores return pattern-matching key values with corresponding values and attributes.

## Values

Key-assigned values constitute Unicode strings supporting comprehensive Unicode character utilization.

Optional user-defined content type attributes associate with individual values.

Content type attributes facilitate value metadata storage including encoding schemes enabling appropriate application processing.

App Configuration store persisted configuration data including keys and values maintains encryption at rest and in transit.

**App Configuration doesn't constitute Azure Key Vault replacement solutions.** Application secret storage requires dedicated Key Vault services.
