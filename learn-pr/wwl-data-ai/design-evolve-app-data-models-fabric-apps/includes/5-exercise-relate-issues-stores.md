In this exercise, you add a `Store` entity, relate issues to stores, and apply the schema. You then seed a few records and show them in the app.

## Add the Store entity and the relationship

1. In `packages/data/src/`, create `Store.ts`. Store records are shared reference data, so the entity grants access to every signed-in user.

    ```typescript
    import { entity, authenticated, uuid, text, many } from '@microsoft/rayfin-core';
    import { Issue } from './Issue.js';

    @entity()
    @authenticated('*')
    export class Store {
      @uuid() id!: string;
      @text({ max: 100 }) name!: string;
      @many(() => Issue) issues?: Issue[];
    }
    ```

1. In `Issue.ts`, add `one` to the `@microsoft/rayfin-core` import and import `Store`. Then add the foreign key and the relationship inside the `Issue` class.

    ```typescript
    import { Store } from './Store.js';

    // inside the Issue class
    @uuid({ optional: true }) store_id?: string;
    @one(() => Store, { optional: true }) store?: Store;
    ```

1. In `packages/data/src/index.ts`, import `Store` and add it to the `schema` array.

    ```typescript
    import { Store } from './Store.js';

    export const schema = [Item, Issue, Store];
    ```

1. In `packages/shared/src/index.ts`, add the `Store` record type, add the relationship to `IssueRecord`, and add `Store` to `UniversalAppSchema`.

    ```typescript
    export interface StoreRecord {
      id: string;
      name: string;
      issues?: IssueRecord[];
    }

    // add these two properties to IssueRecord
    //   store_id?: string;
    //   store?: StoreRecord;

    export type UniversalAppSchema = {
      Item: ItemRecord;
      Issue: IssueRecord;
      Store: StoreRecord;
    };
    ```

## Apply the schema and verify

1. Deploy the changes. The first deployment creates the app item and its SQL database in your workspace, which can take a few minutes. If the CLI asks for a workspace, select the one you use for this module.

    ```bash
    npx rayfin up
    ```

    If the CLI reports a compile error, fix it and run the command again. A `TS2835` error means a relative import is missing `.js`.

1. Check the deployment state.

    ```bash
    npx rayfin up status
    ```

    Wait until the deployment is healthy before you read the new entities in the app.

1. In the Fabric portal, open your workspace and confirm that the app item and its SQL database child item exist. Don't change the database there.

## Seed records and show them in the app

The template already includes a sign-in gate and a configured Rayfin client. You add a small component that creates sample records and lists them. A policy checks ownership but doesn't fill in the owner, so your code sets `owner_id` itself.

The component loads existing issues when it first appears. When you select **Seed sample data**, it creates one store and three related issues, then reloads the list to show them.

1. In `packages/frontend/src/`, create `IssueList.tsx`. The template's `lib/rayfin-client.ts` exports `getRayfinClient()`, which resolves the typed client.

    ```tsx
    import { useEffect, useState } from 'react';
    import { getRayfinClient } from './lib/rayfin-client';

    // Describe the selected fields, not the full Issue entity. The store is optional.
    type Row = { id: string; title: string; store?: { name: string } };

    async function seed() {
      // Get the configured client, typed for the app's registered entities.
      const client = await getRayfinClient();
      const session = client.auth.getSession();
      if (!session.isAuthenticated || !session.user) throw new Error('Sign in first.');

      const store = await client.data.Store.create({ name: 'Seattle flagship' });
      for (const title of ['Cracked frame weld', 'Loose brake lever', 'Paint chipped on fork']) {
        await client.data.Issue.create({
          title,
          severity: 'medium',
          unitsAffected: 1,
          reportedOn: new Date(),
          // Set ownership explicitly so the record passes the permission policy.
          owner_id: session.user.id,
          // Link this issue to the store created above.
          store: { id: store.id },
        });
      }
    }

    async function loadIssues(): Promise<Row[]> {
      const client = await getRayfinClient();
      // Request only these fields, including the related store's name.
      const rows = await client.data.Issue.select(['id', 'title', 'store.name']).execute();
      return rows as Row[];
    }

    export function IssueList() {
      const [rows, setRows] = useState<Row[]>([]);
      const refresh = async () => setRows(await loadIssues());
      // Load existing issues when the component mounts.
      useEffect(() => { void refresh(); }, []);
      return (
        <section>
          <button onClick={async () => { await seed(); await refresh(); }} className="bg-primary text-primary-foreground px-400 py-200 rounded-md">
            Seed sample data
          </button>
          <ul>
            {rows.map((r) => <li key={r.id}>{r.title} ({r.store?.name})</li>)}
          </ul>
        </section>
      );
    }
    ```

1. In `packages/frontend/src/App.tsx`, replace the `EmptyStatePreview` import with a named import for `IssueList`, and render `<IssueList />` in the `App` component. The braces in the import match the `export function IssueList()` declaration in the previous step.

    ```tsx
    import { IssueList } from './IssueList';

    function App() {
      return <IssueList />;
    }

    export default App;
    ```

    Leave the template's sign-in gate and authentication setup unchanged.

1. Start the development loop, sign in, and select **Seed sample data**.

    ```bash
    npm run dev
    ```

If you prefer, give a coding agent such as GitHub Copilot this task: add a component that seeds one store and three issues, and lists issues with their store name by using `client.data.Issue.select(['id', 'title', 'store.name']).execute()`. Review the result against the code in this exercise.

You see three issues, each with the store name. Select the button once, because each selection adds another store and three more issues. That visible result confirms that the relationship, the owner-scoped policy, and the registration work together.