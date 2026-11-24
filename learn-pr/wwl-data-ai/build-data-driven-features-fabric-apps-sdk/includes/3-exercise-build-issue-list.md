In this exercise, you set up the Adventure Works Cycles issue tracker and build its first list screen with a typed query. You run the app against a backend hosted in your own Fabric workspace and reuse the project for the rest of the module.

## Prerequisites

You need a Universal App project that signs in and runs, in a workspace on a trial or paid capacity. If you don't have one, scaffold it as described in the Fabric Apps quickstart, and then enable the data service:

```bash
npm create @microsoft/rayfin@latest -- issue-tracker --workspace <workspace-name>
cd issue-tracker
npx rayfin login
npm run pack:add -- data-modeling
```

A trial capacity allows only a few SQL databases, so reuse one app for the whole module. This exercise defines the `Issue` and `Store` entities, including a `status` field for filtering issues.

## Define the entities

1. In `packages/data/src/`, create or update `Store.ts` and `Issue.ts` with the entity definitions in the following code. Adding a field to an existing entity is a schema change. If the deployment in a later step reports an error because the table already contains rows, delete the sample rows in the app, or use a new project.

    ```typescript
    // Store.ts
    import { entity, authenticated, uuid, text, many } from '@microsoft/rayfin-core';
    import { Issue } from './Issue.js';

    @entity()
    @authenticated('*', { policy: (claims, item) => claims.sub.eq(item.user_id) })
    export class Store {
      @uuid() id!: string;
      @text({ max: 100 }) name!: string;
      @many(() => Issue) issues?: Issue[];
      @text({ max: 128 }) user_id!: string;
    }

    // Issue.ts
    import { entity, authenticated, uuid, text, int, date, set, one } from '@microsoft/rayfin-core';
    import { Store } from './Store.js';

    @entity()
    @authenticated('*', { policy: (claims, item) => claims.sub.eq(item.user_id) })
    export class Issue {
      @uuid() id!: string;
      @text({ max: 200 }) title!: string;
      @set('low', 'medium', 'high') severity!: 'low' | 'medium' | 'high';
      @set({ default: 'open' }, 'open', 'in-review', 'closed') status!: 'open' | 'in-review' | 'closed';
      @int({ min: 1, default: 1 }) unitsAffected!: number;
      @date() reportedOn!: Date;
      @uuid({ optional: true }) store_id?: string;
      @one(() => Store, { optional: true }) store?: Store;
      @text({ max: 128 }) user_id!: string;
    }
    ```

1. In `packages/data/src/index.ts`, import and export both entities, and add them to the `schema` array. Keep the template's existing `Item` registration and its `UniversalAppSchema` type export.

    ```typescript
    import { Item } from './Item.js';
    import { Issue } from './Issue.js';
    import { Store } from './Store.js';

    export type { UniversalAppSchema } from '@rayfin-app/shared';
    export { Item, Issue, Store };

    export const schema = [Item, Issue, Store];
    ```

1. In `packages/shared/src/index.ts`, keep the existing `ItemRecord` interface, add the following record interfaces, and update `UniversalAppSchema` as shown. These browser-safe types describe the data available to the frontend without importing the decorated entity classes.

    ```typescript
    export interface StoreRecord {
      id: string;
      name: string;
      issues?: IssueRecord[];
      user_id: string;
    }

    export interface IssueRecord {
      id: string;
      title: string;
      severity: 'low' | 'medium' | 'high';
      status: 'open' | 'in-review' | 'closed';
      unitsAffected: number;
      reportedOn: Date;
      store_id?: string;
      store?: StoreRecord;
      user_id: string;
    }

    export type UniversalAppSchema = {
      Item: ItemRecord;
      Issue: IssueRecord;
      Store: StoreRecord;
    };
    ```

1. Deploy and verify. The first deployment creates the app item and its SQL database, so it takes a few minutes.

    ```bash
    npx rayfin up
    npx rayfin up status
    ```

## Build the list

1. Create `packages/frontend/src/IssueList.tsx` and paste the following complete file. It uses the template's `getRayfinClient()` function to load open issues, newest first, with the store name. Leave `packages/frontend/src/lib/rayfin-client.ts` unchanged.

    ```tsx
    import { useEffect, useState } from 'react';
    import { getRayfinClient } from './lib/rayfin-client';

    async function loadOpenIssues() {
      const client = await getRayfinClient();
      return client.data.Issue
        .select(['id', 'title', 'status', 'reportedOn', 'store.name'])
        .where({ status: { eq: 'open' } })
        .orderBy({ reportedOn: 'desc' })
        .execute();
    }

    type Row = Awaited<ReturnType<typeof loadOpenIssues>>[number];

    export function IssueList() {
      const [rows, setRows] = useState<Row[]>([]);
      useEffect(() => {
        loadOpenIssues().then(setRows);
      }, []);
      return (
        <ul>
          {rows.map((issue) => (
            <li key={issue.id}>
              {issue.title} ({issue.store?.name ?? 'No store'}) - {new Date(issue.reportedOn).toLocaleDateString()}
            </li>
          ))}
        </ul>
      );
    }
    ```

1. Open `packages/frontend/src/App.tsx`. Replace the `EmptyStatePreview` import and the `App` component with the following code. Keep any file header and the default export. Leave the template's authentication setup in `main.tsx` and `Root.tsx` unchanged.

    ```tsx
    import { IssueList } from './IssueList';

    function App() {
      return <IssueList />;
    }

    export default App;
    ```

1. In `IssueList.tsx`, insert the following `seedIssues` function immediately before `export function IssueList()`, outside the component. Policies check ownership but don't fill in the owner, so this function sets `user_id` for each sample record.

    ```typescript
    async function seedIssues() {
      const client = await getRayfinClient();
      const session = client.auth.getSession();
      if (!session.isAuthenticated || !session.user) throw new Error('Sign in first.');
      const store = await client.data.Store.create({
        name: 'Seattle flagship',
        user_id: session.user.id,
      });
      const titles = ['Cracked frame weld', 'Loose brake lever', 'Paint chipped on fork'];
      for (const [index, title] of titles.entries()) {
        await client.data.Issue.create({
          title,
          severity: (['high', 'medium', 'low'] as const)[index],
          status: index === 2 ? 'closed' : 'open',
          unitsAffected: 1 + index,
          reportedOn: new Date(Date.now() - index * 60_000),
          user_id: session.user.id,
          store: { id: store.id },
        });
      }
    }
    ```

1. Inside the `IssueList` component, insert this handler after the `useEffect` block and before `return`. It creates the sample records and reloads the list.

    ```typescript
    async function handleSeedIssues() {
      await seedIssues();
      setRows(await loadOpenIssues());
    }
    ```

1. Replace only the component's `return` block with the following code to add the **Seed 3 issues** button above the list. Keep the state, effect, and handler inside the component unchanged.

    ```tsx
    return (
      <div>
        <button type="button" onClick={handleSeedIssues} className="bg-primary text-primary-foreground px-400 py-200 rounded-md">
          Seed 3 issues
        </button>
        <ul>
          {rows.map((issue) => (
            <li key={issue.id}>
              {issue.title} ({issue.store?.name ?? 'No store'}) - {new Date(issue.reportedOn).toLocaleDateString()}
            </li>
          ))}
        </ul>
      </div>
    );
    ```

1. From the project root, run `npm run dev`, open the app, and sign in. Select **Seed 3 issues** once. The list refreshes after the sample records are created.

## Verify the result

1. Confirm that the list shows only the two open issues, newest first, each with the store name **Seattle flagship**. The closed issue doesn't appear.
1. Temporarily remove `'title'` from the `select` array. The TypeScript compiler flags the `issue.title` read, and the list shows no titles, because the result contains only the fields you select.
1. Restore `'title'`.

## Check your understanding

- Why does the date column call `new Date(...)` before it formats the value?
- Why filter on `status` in `where` and not in the component?

Returned dates are typed `Date | string`, so you convert them explicitly. Filtering on the server returns only the rows you need, but it doesn't replace permissions, which the server enforces separately.
