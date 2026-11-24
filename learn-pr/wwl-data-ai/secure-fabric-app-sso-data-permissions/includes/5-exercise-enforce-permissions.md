In this exercise, you write owner-only permissions for a lab entity and test them with a single signed-in user. A lab-only create rule lets you create a record owned by a made-up user. You then confirm that the server hides that record and refuses to change it.

> [!WARNING]
> The create rule in this exercise deliberately doesn't restrict `user_id`, so one account can create a record with another owner. Use it only in this lab. Remove the lab-only entity before you reuse the app.

## Define the lab entity

1. In your data package (`packages/data/src/` in a Universal App), create `LabIssueReport.ts`.

    ```typescript
    import {
      entity,
      authenticated,
      uuid,
      text,
    } from '@microsoft/rayfin-core';

    @entity()
    @authenticated('create') // lab only: no policy, so any owner id can be set on create
    @authenticated('read', {
      policy: (claims, item) => claims.sub.eq(item.user_id),
      exclude: ['internalNote'],
    })
    @authenticated(['update', 'delete'], {
      policy: (claims, item) => claims.sub.eq(item.user_id),
    })
    export class LabIssueReport {
      @uuid() id!: string;
      @text({ max: 200 }) title!: string;
      @text({ max: 500, optional: true }) internalNote?: string;
      @text({ max: 128 }) user_id!: string;
    }
    ```

1. Register `LabIssueReport` in the registration file, in both the `AppSchema` type and the `schema` array. Import it with a `.js` extension.
1. Apply the schema and confirm that the deployment is healthy. The first `rayfin up` also publishes the static app and adds the deployed origin to `allowedRedirectUris`, so review that list afterward.

    ```bash
    npx rayfin up
    npx rayfin up status
    ```

## Test as the owner

1. Add a component that creates one record owned by you and one owned by a made-up user, and then tries to read and change them. The `attempt` helper logs each call's outcome, so a rejection and a result look different. Change the `client` import to match your project.

    ```tsx
    import { useState } from 'react';
    import { client } from './lib/rayfin-client';

    export function PermissionLab() {
      const [log, setLog] = useState<string[]>([]);
      const add = (line: string) => {
        console.log(line);
        setLog((l) => [...l, line]);
      };

      async function attempt(label: string, call: () => Promise<unknown>) {
        try {
          add(`${label}: returned ${JSON.stringify(await call())}`);
        } catch (e) {
          add(`${label}: rejected (${e instanceof Error ? e.message : 'error'})`);
        }
      }

      async function run() {
        const me = client.auth.getSession().user?.id;
        if (!me) return add('Sign in first.');
        const mineId = crypto.randomUUID();
        const otherId = crypto.randomUUID();
        const lab = client.data.LabIssueReport;

        await attempt('Create mine', () =>
          lab.create({ id: mineId, title: 'Mine', internalNote: 'Private note', user_id: me }));
        await attempt('Create not mine', () =>
          lab.create({ id: otherId, title: 'Not mine', user_id: 'someone-else' }));
        await attempt('Read titles', () => lab.select(['id', 'title']).execute());
        await attempt('Read excluded field', () => lab.select(['id', 'internalNote']).execute());
        await attempt('Update mine', () => lab.update({ id: mineId }, { title: 'Mine, edited' }));
        await attempt('Update not mine', () => lab.update({ id: otherId }, { title: 'Changed' }));
        await attempt('Delete not mine', () => lab.delete({ id: otherId }));
      }

      return (
        <section>
          <button onClick={run}>Run permission check</button>
          <ul>{log.map((l, i) => <li key={i}>{l}</li>)}</ul>
        </section>
      );
    }
    ```

    The code supplies its own `id` values, so the update and delete calls don't depend on reading back a record that you can't read. The `user_id: 'someone-else'` value stands in for another user, because you have only one account.

1. Render `PermissionLab`, run the app, sign in, and select **Run permission check**.

## Read the result

Work through the log from top to bottom.

1. **Create mine** and **Create not mine** are accepted. The lab-only create rule has no policy, so it accepts any `user_id`.
1. **Read titles** lists **Mine** but not **Not mine**. The read policy compares `claims.sub` to `user_id`, so the server hides the record that another user owns.
1. **Read excluded field** doesn't return the `internalNote` value. Note whether the server rejects the request or leaves the field out.
1. **Update mine** succeeds, and the result shows the new title. This confirms that the update policy lets you change your own record.
1. **Update not mine** and **Delete not mine** don't change the other record. A refused call appears as `rejected` in the log. If your project reports no error instead, the call matched no row that you're allowed to change. Either way, the decision came from the server and not from your code.
1. Open the browser developer tools **Network** tab and find the data requests. Your code sent every request, and the server alone decided each outcome.

## Explain the result

The app can create a record owned by `someone-else` only because the lab-only create rule has no policy. The read rule is what keeps that record hidden, and the `exclude` option keeps `internalNote` out of every read, including your own record. A real app would never ship the unconstrained create rule, because it lets any signed-in user write rows that belong to someone else. You remove the lab-only entity when you clean up resources at the end of the module.
