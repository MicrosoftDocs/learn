In this exercise, you query the Adventure Works Cycles sales semantic model and add a sales-by-region view to the app. You learn how the connector returns results, display query errors, and verify the view alongside the inventory view in the deployed app.

## Confirm the connector setup

Warehouse connectors expose entities for typed table queries. A semantic model connector instead exposes the function-style operation `executeQuery`, which accepts DAX and returns a result set. The app uses measures defined in the model rather than rebuilding their calculations in TypeScript.

Three requirements support this flow:

- **Delegated identity.** Each call runs as the signed-in user. Semantic models don't support application access, so every manager needs their own source permissions.

- **A runtime hook.** `fabricSemanticModel()` decodes the query response. Its key in `connectorRuntimes` matches the connector name.

- **Permissions and tenant settings.** Users need Read and Build permissions on the model, and an administrator enables the **Semantic Model Execute Queries REST API** tenant setting.

1. Open `rayfin/rayfin.yml`. Confirm that `adventureworkssales` has `auth.type: delegated`. If you re-added the connector, check the value again: re-adding uses the type's default unless you pass `--auth`.

1. Open `packages/frontend/src/lib/connectors.ts`. Confirm that `connectorRuntimes` registers `fabricSemanticModel()` under `adventureworkssales`. Keep the warehouse connector's schema and configuration entries from the inventory exercise.

1. Run `npx rayfin connector list`. It reads the local configuration without calling Fabric. Confirm that both connectors appear.

## Query sales by region

A DAX query starts with `EVALUATE`, which returns a table. In the following query, `SUMMARIZECOLUMNS` groups by `Sales[Region]` and evaluates `[Total Sales]` for each region. The quoted alias `"Total Sales"` names the result column; `[Total Sales]` refers to the measure already defined in the model.

```dax
EVALUATE
SUMMARIZECOLUMNS(
  'Sales'[Region],
  "Total Sales", [Total Sales]
)
```

The model applies each group's filter context to the measure. The app displays the returned totals without recomputing them.

1. Create `rayfin/queries/sales-by-region.dax` with the query above. Use the table, column, and measure names from the model; don't infer them from the app's TypeScript types.

1. Verify the query from the project root:

    ```bash
    npx rayfin connector inspect --name adventureworkssales --query rayfin/queries/sales-by-region.dax
    ```

    Example output follows. Query timings and row order can vary because the DAX query doesn't specify an `ORDER BY` clause.

    ```text
    ✔ Querying connector:adventureworkssales complete (12.4s)

    Inspect result for connector:adventureworkssales
    connector type: fabric-semanticmodel
    rows: 3
    query mode: raw
    Columns: Sales[Region] (unknown), [Total Sales] (unknown)
    | Sales[Region] | [Total Sales] |
    |---------------|---------------|
    | West          | 2000          |
    | North         | 2000          |
    | South         | 1600          |
    ```

    Direct CLI queries run under your developer identity. Success confirms your model access, not access for every app recipient. Read and Build permissions are required for this query; workspace write access isn't.

Keep DAX inputs controlled. A small `TOPN` query helps you inspect unfamiliar results, while validated model measures keep calculations consistent. Don't construct DAX from unvalidated user input.

## Understand the query response

`executeQuery` returns a status and either a table or an error. Checking `result.status` before reading the table distinguishes a successful empty result from a failed query.

- **Success:** `result.table.columns` describes the columns, and each entry in `result.table.rows` is an array whose values follow the same column order. The component below pairs names and values before reading `Sales[Region]` and `[Total Sales]`.

- **Failure:** `result.error` has a message and a category: `network`, `api`, `query`, `overflow`, or `unknown`. An `api` error can indicate a permission, authentication, or throttling problem. The app displays the error rather than substituting mock data.

`resultSetRowCountLimit` bounds the response. If the result exceeds that limit, the connector returns an `overflow` error rather than a table that appears complete. The example sets the limit to 500, well above its three regional totals.

A call waits up to five minutes by default, matching the backend deadline. An optional second argument, such as `{ timeoutMs: 30000 }`, gives the call a shorter timeout. Narrow slow queries rather than relying on longer waits.

## Build the sales view

1. Create `packages/frontend/src/SalesView.tsx` with the following code. It uses `getRayfinClient()`, checks the result status, and displays loading, empty, and error states. The table reuses the template's styling tokens.

    ```tsx
    import { useEffect, useState } from 'react';
    import { getRayfinClient } from './lib/rayfin-client';

    type SalesRow = { region: string; totalSales: number };

    const salesByRegion = `EVALUATE
    SUMMARIZECOLUMNS(
      'Sales'[Region],
      "Total Sales", [Total Sales]
    )`;

    export function SalesView() {
      const [rows, setRows] = useState<SalesRow[]>([]);
      const [error, setError] = useState('');
      const [loading, setLoading] = useState(true);

      useEffect(() => {
        async function loadSales() {
          try {
            const client = await getRayfinClient();
            const result = await client.connectors.adventureworkssales.executeQuery({
              query: salesByRegion,
              resultSetRowCountLimit: 500,
            });
            if (result.status !== 'success') {
              setError(`${result.error.category}: ${result.error.message}`);
              return;
            }
            setRows(
              result.table.rows.map((row) => {
                const record = Object.fromEntries(
                  result.table.columns.map((column, index) => [column.name, row[index]]),
                );
                return {
                  region: String(record['Sales[Region]'] ?? ''),
                  totalSales: Number(record['[Total Sales]'] ?? 0),
                };
              }),
            );
          } catch (error) {
            setError(error instanceof Error ? error.message : 'Query failed.');
          } finally {
            setLoading(false);
          }
        }
        loadSales();
      }, []);

      return (
        <section className="p-400 text-foreground">
          <h2 className="mb-400 text-600 font-semibold">Sales by region</h2>
          {loading && <p role="status">Loading sales...</p>}
          {error && <p role="alert" className="mb-400 text-destructive">{error}</p>}
          {!loading && !error && rows.length === 0 && <p>No sales results.</p>}
          {rows.length > 0 && (
            <div className="overflow-x-auto">
              <table className="w-full max-w-xl text-300">
                <thead className="bg-muted">
                  <tr>
                    <th scope="col" className="px-400 py-300 text-left font-semibold">
                      Region
                    </th>
                    <th scope="col" className="px-400 py-300 text-right font-semibold">
                      Total sales
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {rows.map((row) => (
                    <tr key={row.region} className="border-b border-border hover:bg-accent">
                      <td className="px-400 py-300">{row.region}</td>
                      <td className="px-400 py-300 text-right tabular-nums">
                        {row.totalSales.toLocaleString()}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </section>
      );
    }
    ```

1. In `packages/frontend/src/App.tsx`, add `import { SalesView } from './SalesView';` alongside the existing `InventoryView` import. Replace only the `App` component with the following code. Keep the imports, any file header, and the default export.

    ```tsx
    function App() {
      return (
        <>
          <InventoryView />
          <SalesView />
        </>
      );
    }
    ```

## Deploy and verify both views

Connector calls need the deployed app, not a `rayfin dev` session. The same frontend can show inventory through application access and sales through delegated access, because each connector declares its own identity mode.

1. From the project root, preview the deployment and deploy the related changes together. Resolve build or type errors before testing.

    ```bash
    npx rayfin up --dry-run
    npx rayfin up
    npx rayfin up status
    ```

1. Open the deployed app and sign in. Confirm that the inventory view still returns five products and the sales view returns three regions with the expected totals.
1. Run the following command. Confirm that `adventureworksconnectors` uses `application` and `adventureworkssales` uses `delegated`.

    ```bash
    npx rayfin connector list --json
    ```

## Next step

In the next exercise, you predict and verify what sharing the app grants to a new manager, and distinguish app access from source access.
