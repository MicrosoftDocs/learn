In this exercise, you expose the Adventure Works Cycles inventory table through a typed connector and build a view of the lowest stock levels. You use the generated metadata, limit access to read operations, wire the client, and verify the view in the deployed app.

## What `connector add` generates

For tabular sources, `connector add` writes the `connectors:` entry in `rayfin.yml`, scaffolds `rayfin/connectors/<name>/schema.ts`, and runs schema discovery that writes `metadata.json`. It doesn't install packages, and it doesn't write entity `.ts` files. You write one entity file for each table that the app needs, using `metadata.json` as the only source of truth. A coding agent can draft these files, but you review them against the metadata.

The connector folder follows its name in `rayfin/rayfin.yml`, not the source's table name. The earlier exercise names the warehouse connector `adventureworksconnectors` and the semantic model connector `adventureworkssales`.

1. Open `rayfin/connectors/adventureworksconnectors/` and find `schema.ts` and `metadata.json`.

1. In `metadata.json`, find `ProductInventory` under the `dbo` schema. Confirm the columns and their types. For the sample table, `primaryKeyColumns` contains `ProductID`, `productName` has `maxLength: 100`, and `warehouseLocation` has `maxLength: 50`.

1. Open `rayfin/rayfin.yml`. Confirm that `adventureworksconnectors` has `auth.type: application` and only the `read` operation. If you added it through interactive search, remove `create`, `update`, and `delete` from its `operations` list.

These rules guide the entity definition:

- **`metadata.json` decides primary keys and relationships.** Don't infer a primary key from a column name. If a table has no key in the metadata, the entity is keyless and doesn't support operations that address a row by key. Lakehouse SQL endpoints commonly have no key metadata.

- **Don't edit `metadata.json`.** Re-add the connector to refresh it, preserving the intended name, operations, and identity flags. Generated frontend wiring has an explicit ownership mechanism, which you use later in this exercise.

- **Run the version-pinned `npm install` that `connector add` prints, verbatim.** A different version of a connector package can pull a second copy of `@microsoft/rayfin-data`.

## Define an entity from metadata

An entity class extends `Source({...})`, which names the schema, table, and primary key. Each property uses a field decorator that matches the SQL type, and `column` maps a property to a column whose name differs.

1. Create `rayfin/connectors/adventureworksconnectors/ProductInventory.ts` with the following code. Keep relative imports in `rayfin/` ending in `.js`.

    ```typescript
    import { authenticated, entity, int, text } from '@microsoft/rayfin-core';
    import { Source } from '@microsoft/rayfin-connectors';

    @authenticated(['read'])
    @entity()
    export class ProductInventory extends Source({
      schema: 'dbo',
      table: 'ProductInventory',
      primaryKey: ['productId'],
    }) {
      @int({ column: 'ProductID' }) productId!: number;
      @text({ max: 100 }) productName!: string;
      @text({ max: 50 }) warehouseLocation!: string;
      @int() quantityOnHand!: number;
    }
    ```

    The metadata names the SQL key `ProductID`. The entity maps that column to the property `productId`, so `primaryKey` uses `productId`. The `max` values come from each column's `maxLength`. If your table has no key metadata, omit `primaryKey` rather than guessing one.

    `@authenticated(['read'])` grants read access to signed-in users, within the source permissions of the configured identity. The entity role and the connector's operations both allow only `read`.

## Register the entity in `schema.ts`

The generated `schema.ts` is a placeholder for tabular sources. An aggregate exports the entity, the connector schema type, and the `connectorConfig` value. The `entities` map gives each entity a default list of scalar property names.

1. Replace the contents of `rayfin/connectors/adventureworksconnectors/schema.ts` with the following code:

    ```typescript
    import type { GraphQLBackedConnector } from '@microsoft/rayfin-connector-fabric-graphql';
    import type { ConnectorConfig } from '@microsoft/rayfin-connectors';
    import type { ProductInventory } from './ProductInventory.js';

    export type { ProductInventory } from './ProductInventory.js';

    export const connectorConfig = {
      connector: 'fabric-warehouse',
      operations: ['read'],
      entities: {
        ProductInventory: ['productId', 'productName', 'warehouseLocation', 'quantityOnHand'],
      },
    } as const satisfies ConnectorConfig;

    export type InventorySchema = GraphQLBackedConnector<
      { ProductInventory: typeof ProductInventory },
      typeof connectorConfig
    >;
    ```

Use entity property names in `entities`, not SQL column names. Prefer string arrays unless the app selects relationship paths. The class form supports relationship selections, but it puts TC39 decorators in the browser bundle, and the bundler must compile them. The 2.0 templates already enable that.

## Wire the connector into the client

Each connector is available as `client.connectors.<name>`. Its key matches the name in `rayfin/rayfin.yml`, the schema type, and the configuration map. The semantic model also needs a client-side runtime; the warehouse doesn't.

1. Open `packages/frontend/src/lib/connectors.ts`. It already wires `adventureworkssales`. The warehouse wasn't wired when you added it because its schema didn't yet export `connectorConfig`.

1. Take ownership of this file as described in its header: remove the `@generated by` banner line. Keep any copyright header, and replace the imports and exports with the following code. The CLI no longer overwrites this file after you remove the banner, so you maintain these entries yourself.

    ```typescript
    import type {
      ConnectorConfigs,
      ConnectorsRuntime,
    } from '@microsoft/rayfin-connectors';
    import { fabricSemanticModel } from '@microsoft/rayfin-connector-fabric-semanticmodel';
    import {
      connectorConfig as inventoryConfig,
      type InventorySchema,
    } from '../../../../rayfin/connectors/adventureworksconnectors/schema';
    import {
      connectorConfig as salesConfig,
      type AdventureworkssalesSchema,
    } from '../../../../rayfin/connectors/adventureworkssales/schema';

    export type AppConnectorsSchema = {
      adventureworksconnectors: InventorySchema;
      adventureworkssales: AdventureworkssalesSchema;
    };

    export const connectorConfigs = {
      adventureworksconnectors: inventoryConfig,
      adventureworkssales: salesConfig,
    } satisfies ConnectorConfigs<AppConnectorsSchema>;

    export const connectorRuntimes: ConnectorsRuntime = {
      adventureworkssales: fabricSemanticModel(),
    };
    ```

1. Open `packages/frontend/src/lib/rayfin-client.ts`. Confirm that `RayfinClient.create` registers the connectors service using these maps. Leave the existing authentication and configuration resolution unchanged.

    ```typescript
    connectors: connectorsService<AppConnectorsSchema>({
      configs: connectorConfigs,
      runtime: connectorRuntimes,
    }),
    ```

## Build the inventory view

Queries use the same chain as the data client, with one difference. A chain that uses `where`, `orderBy`, or `first` needs an explicit `select([...])`, or it throws `SELECTION_REQUIRED`.

1. Create `packages/frontend/src/InventoryView.tsx` with the following code. It uses the template's `getRayfinClient()` function and reads the fields needed for the view.

    ```tsx
    import { useEffect, useState } from 'react';
    import { getRayfinClient } from './lib/rayfin-client';

    type Row = {
      productId: number;
      productName: string;
      quantityOnHand: number;
    };

    export function InventoryView() {
      const [rows, setRows] = useState<Row[]>([]);
      const [error, setError] = useState('');

      useEffect(() => {
        async function loadInventory() {
          try {
            const client = await getRayfinClient();
            const result = await client.connectors.adventureworksconnectors.ProductInventory
              .select(['productId', 'productName', 'quantityOnHand'])
              .orderBy({ quantityOnHand: 'asc' })
              .first(20)
              .execute();
            setRows(result as Row[]);
          } catch (error) {
            setError(error instanceof Error ? error.message : 'Query failed.');
          }
        }
        loadInventory();
      }, []);

      return (
        <section className="p-400 text-foreground">
          <h2 className="mb-400 text-600 font-semibold">Lowest stock</h2>
          {error && <p role="alert" className="mb-400 text-destructive">{error}</p>}
          <div className="overflow-x-auto">
            <table className="w-full max-w-xl text-300">
              <thead className="bg-muted">
                <tr>
                  <th scope="col" className="px-400 py-300 text-left font-semibold">
                    Product
                  </th>
                  <th scope="col" className="px-400 py-300 text-right font-semibold">
                    Quantity on hand
                  </th>
                </tr>
              </thead>
              <tbody>
                {rows.map((row) => (
                  <tr key={row.productId} className="border-b border-border hover:bg-accent">
                    <td className="px-400 py-300">{row.productName}</td>
                    <td className="px-400 py-300 text-right tabular-nums">
                      {row.quantityOnHand}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>
      );
    }
    ```

1. In `packages/frontend/src/App.tsx`, replace the starting view's import and the `App` component with the following code. Keep any file header and the default export. Leave the template's authentication setup unchanged.

    ```tsx
    import { InventoryView } from './InventoryView';

    function App() {
      return <InventoryView />;
    }

    export default App;
    ```

## Limit what a connector can do

TypeScript types describe the shape of data and don't decide who can see it, so they aren't an authorization boundary. Apply these controls together:

1. **Limit operations.** Use `--operations read` when you add the connector, or edit the `operations` list. You can narrow the catalog defaults but not widen them.

1. **Add roles to connector entities.** Use `@authenticated`, `@anonymous`, or `@role` on each entity, with actions that are a subset of the connector's `operations`. If an entity role includes an action that the connector doesn't list, `rayfin up connector apply` fails.

1. **Add row policies or field rules when users need only part of an entity.** With delegated access, `claims` represents the real caller, so a policy can compare `claims.sub` or `claims.email` to a column. With application access, `claims` doesn't distinguish users in the source query.

1. **Choose the identity deliberately.** With application access, enforce per-user access through app and entity permissions. With delegated access, also verify each user's source access.

## Deploy and verify the inventory view

`rayfin dev` reads the `connectors:` block but doesn't wire it, so connector calls need a deployed app. The `npx rayfin up connector apply` command applies only the generated connector configuration. It's in Preview and needs a prior `rayfin up`.

1. From the project root, preview the deployment and then deploy. Resolve any build or type errors before testing the app. A missing `adventureworksconnectors` property usually means the connector name differs between the configuration and client maps.

  ```bash
  npx rayfin up --dry-run
  npx rayfin up
  npx rayfin up status
  ```

1. Open the deployed app URL and sign in. Confirm that the five sample products appear, ordered by quantity from lowest to highest: Brake lever, Mountain bike, Road bike, Touring bike, and Helmet.

## Next step

In the next exercise, you learn how the semantic model connector returns DAX query results and use them to build a sales view alongside the inventory view.
