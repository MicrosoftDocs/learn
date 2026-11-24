In this exercise, you verify the work that the agent produced in your project, approve a deployment, and test the deployed app. You group the changes so that one deployment covers them. You also add a lab-only entity so that one signed-in user can test cross-owner behavior.

> [!WARNING]
> The create rule on the lab-only entity deliberately doesn't restrict `user_id`. Use it only in this lab. You remove it in the final challenge.

## Fix the agent's work first

1. On your `vendor-feature` branch, review the agent's diff with the checklist. Confirm that `Vendor` has an explicit owner-only permission decorator, that every text field has `max`, that the Vendors screen sets `user_id` from the session, that the code uses the typed client, that no secret appears in frontend code, and that all Rayfin packages share one version.

1. Fix any problem yourself. Don't ask the agent to guess at permission rules.

## Add a lab-only probe entity

The `Vendor` policy compares the signed-in user to `user_id`, and your app always stamps your own ID. To test cross-owner behavior with one account, add an entity that mirrors the owner-only rules for read, update, and delete but lets you choose the owner on create.

1. In `packages/data/src/`, create `VendorProbe.ts`.

    ```typescript
    import { entity, authenticated, uuid, text } from '@microsoft/rayfin-core';

    @entity()
    @authenticated('create') // lab only: no policy, so any owner id can be set on create
    @authenticated(['read', 'update', 'delete'], {
      policy: (claims, item) => claims.sub.eq(item.user_id),
    })
    export class VendorProbe {
      @uuid() id!: string;
      @text({ max: 100 }) label!: string;
      @text({ max: 128 }) user_id!: string;
    }
    ```

1. Register `VendorProbe` in the registration file, in both the `AppSchema` type and the `schema` array. Import it with a `.js` extension.
1. Add a component that runs the checks. Adjust the client import to match your project.

    ```tsx
    import { useState } from 'react';
    import { client } from './lib/rayfin-client';

    export function VendorProbeCheck() {
      const [log, setLog] = useState<string[]>([]);
      const add = (m: string) => setLog((l) => [...l, m]);

      async function ownerCheck() {
        const me = client.auth.getSession().user?.id;
        if (!me) return add('Sign in first.');
        await client.data.VendorProbe.create({ label: 'Mine', user_id: me });
        const other = await client.data.VendorProbe.create({ label: 'Not mine', user_id: 'someone-else' });
        const visible = await client.data.VendorProbe.select(['id', 'label']).execute();
        add(`Visible rows: ${visible.map((r) => r.label).join(', ')}`);
        try {
          await client.data.VendorProbe.update({ id: other.id }, { label: 'Changed' });
          add('Update succeeded (unexpected).');
        } catch (e) {
          add(`Update refused: ${e instanceof Error ? e.message : 'error'}`);
        }
        try {
          await client.data.VendorProbe.delete({ id: other.id });
          add('Delete succeeded (unexpected).');
        } catch (e) {
          add(`Delete refused: ${e instanceof Error ? e.message : 'error'}`);
        }
      }

      async function unauthenticatedCheck() {
        await client.auth.signOut();
        try {
          const rows = await client.data.Vendor.select(['id', 'name']).execute();
          add(`Unexpected: received ${rows.length} vendors without a session.`);
        } catch (e) {
          add(`Rejected without a session: ${e instanceof Error ? e.message : 'error'}`);
        }
      }

      return (
        <section>
          <button onClick={ownerCheck}>Run owner check</button>
          <button onClick={unauthenticatedCheck}>Run unauthenticated check</button>
          <ul>{log.map((l, i) => <li key={i}>{l}</li>)}</ul>
        </section>
      );
    }
    ```

1. Render `VendorProbeCheck` somewhere in the app.

## Run the checks

1. Build the workspace. In a Universal App, this runs the shared, data, and frontend builds, which type-check the code.

    ```bash
    npm run build:fabric
    ```

    If your project has tests or a separate type-check script, run those too.

1. Preview the deployment, and read the output.

    ```bash
    npx rayfin up --dry-run
    ```

    Confirm that the output targets the workspace you expect. A dry run validates inputs and resolves the workspace without creating or modifying resources, so it doesn't apply the schema.

1. Review your diff one more time for removed fields, narrowed types, or renamed entities. The deployment in the next section runs without `--force`, so the CLI blocks a destructive change and describes it instead of applying it. If it blocks a change, stop and review the listed operations.

## Approve and deploy

1. Approve the deployment yourself, and deploy once for all of the changes.

    ```bash
    npx rayfin up
    npx rayfin up status
    ```

1. Wait until the status is healthy before you test the new entities. To get the hosting URL for the deployed app, run `npx rayfin up status --json` and read `deployment.hostingUrl`.

## Test permissions on the deployed app

A passing build doesn't prove that permissions work. Test the deployed app, not the local one.

1. Open the deployed app at the hosting URL, sign in, and select **Run owner check**.
1. Confirm that the visible rows include **Mine** but not **Not mine**, and that the update and delete attempts on the other record don't succeed. The server made these decisions, not your code.
1. Select **Run unauthenticated check**. Confirm that the request for vendors is rejected. Sign in again afterward.

If an entity returns errors right after deployment even though the status is healthy, run `npx rayfin up db apply`, and test again. Don't add `--force` unless the CLI reports a destructive change that you reviewed and accept.

## Write the release evidence

In three sentences, state what evidence supports release, and what the checks don't prove. Use this structure: what passed, what the deployed checks showed, and what you didn't test.

## Check your understanding

- Why don't passing client tests prove that backend permissions work?
- Why add a lab-only `VendorProbe` entity instead of weakening the `Vendor` rules?

Client tests exercise your code, and the backend enforces policies. The probe lets you test cross-owner behavior with one account, and weakening `Vendor` would expose real data. The probe mirrors the `Vendor` read, update, and delete rule, so it tests the same policy pattern but not the `Vendor` entity itself. The unauthenticated check runs against `Vendor`.
