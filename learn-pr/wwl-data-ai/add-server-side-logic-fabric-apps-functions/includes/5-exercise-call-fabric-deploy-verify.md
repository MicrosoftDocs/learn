In this exercise, you learn how resource audiences and function identities support a call to the Fabric REST API. You add a workspace-list function, deploy it alongside the shipment lookup, and compare local and deployed behavior.

## Prerequisites

Use the `adventure-functions` project from the preceding exercises in this module. It already includes `greet`, the simulated `lookupShipment`, the Functions client registration, and the `Greeting` and `ShipmentLookup` components. No app, data model, or carrier account from another module is required.

## Understand identities and audiences

Fabric expects a Microsoft Entra token rather than the carrier-style API key used in the previous exercise. A token is issued for a specific resource, called its audience. The function declares that audience in its context type, and the runtime supplies the corresponding token.

A deployed function has two separate identity paths:

| Access path | Identity used |
| :---------- | :------------ |
| App-owned data through `ctx.getDataClient()` | The signed-in caller, with the caller's entity policies. |
| External resources through `ctx.Tokens` | The app identity, with that identity's source permissions. |

For current Fabric apps, the app identity is the owner of the app item. `services.functions.auth.type: application` applies to external resource tokens, not to the caller's data access. It doesn't make `ctx.getDataClient()` use the app owner's permissions.

This exercise uses an empty `AppSchema` and doesn't create entities. When a function works with app-owned records, its context includes the app's schema and it uses `ctx.getDataClient()` to preserve caller policies. Owner fields come from `ctx.user.id`, not from manually decoded access tokens.

## Add the Fabric function

`AudienceType.Fabric` is the second type argument of `RayfinContext`. That annotation declares the resource token needed by the handler. `ctx.Tokens.Fabric` then supplies the token for the Fabric REST API; the third `udf.func` argument remains `[]`.

1. In `packages/functions/src/function_app.ts`, add `AudienceType` to the existing import from `@microsoft/fabric-user-data-functions`. Keep the `AppSchema`, `udf`, and earlier handlers. Append the following function after `lookupShipment`:

    ```typescript
    udf.func(
      'listWorkspaces',
      async (ctx: RayfinContext<AppSchema, AudienceType.Fabric>): Promise<{ names: string[] }> => {
        const response = await fetch('https://api.fabric.microsoft.com/v1/workspaces', {
          headers: { Authorization: `Bearer ${ctx.Tokens.Fabric}` },
        });
        if (!response.ok) throw new Error(`Fabric API returned ${response.status}`);
        const body = (await response.json()) as { value: { displayName: string }[] };
        return { names: body.value.map((workspace) => workspace.displayName) };
      },
      [],
    );
    ```

    The function returns workspace names only. It never returns the token.

    The audience declaration doesn't grant workspace access. The identity represented by the token still needs the permissions required by the Fabric API. Tokens stay inside the function and must not appear in frontend code, logs, or responses.

1. Restart `npm run dev`. Because the function declares an audience, the local host signs you in as it starts. Complete the sign-in prompt if one appears. The host also regenerates the frontend function types.

1. Create `packages/frontend/src/WorkspaceList.tsx` with the following complete component:

    ```tsx
    import { useState } from 'react';
    import { getRayfinClient } from './lib/rayfin-client';

    export function WorkspaceList() {
      const [names, setNames] = useState<string[]>([]);
      const [error, setError] = useState('');
      const [loading, setLoading] = useState(false);

      async function listWorkspaces() {
        setLoading(true);
        setError('');
        try {
          const client = await getRayfinClient();
          const result = await client.functions.listWorkspaces.invoke();
          setNames(result.names);
        } catch (error) {
          setError(error instanceof Error ? error.message : 'Unable to list workspaces.');
        } finally {
          setLoading(false);
        }
      }

      return (
        <section className="p-400 text-foreground">
          <h2 className="mb-400 text-600 font-semibold">Workspaces</h2>
          <button
            type="button"
            onClick={listWorkspaces}
            disabled={loading}
            className="bg-primary text-primary-foreground px-400 py-200 rounded-md disabled:opacity-60"
          >
            {loading ? 'Loading...' : 'List workspaces'}
          </button>
          {error && <p role="alert" className="mt-400 text-destructive">{error}</p>}
          <ul className="mt-400">
            {names.map((name, index) => <li key={`${index}-${name}`}>{name}</li>)}
          </ul>
        </section>
      );
    }
    ```

1. In `packages/frontend/src/App.tsx`, add `import { WorkspaceList } from './WorkspaceList';`. Replace only the `App` component with the following code. Keep the `Greeting` and `ShipmentLookup` imports and the default export.

    ```tsx
    function App() {
      return (
        <>
          <Greeting />
          <ShipmentLookup />
          <WorkspaceList />
        </>
      );
    }
    ```

1. Sign in and select **List workspaces**. Confirm that names appear. Locally, the call uses the account you signed in with.

## Review the identity

For current Fabric apps, the app identity is the user account that owns the app item. You don't create a separate app registration or workspace identity for this exercise, and you don't retrieve or copy a token yourself. Identify the owner's account before checking its source permissions.

Declaring an audience and granting permissions are different actions. The following built-in audiences identify the target resource, not a role assignment:

Declare the audience in `packages/functions/src/function_app.ts`, as the second type argument of the handler's `RayfinContext`, such as `RayfinContext<AppSchema, AudienceType.Fabric>`.

| Audience | Resource |
| :------- | :------- |
| `Fabric` | Microsoft Fabric REST APIs |
| `Sql` | Fabric SQL endpoints and Azure SQL |
| `Storage` | OneLake and Azure Storage |
| `AzureAI` | Microsoft Foundry endpoints |
| `ADO` | Azure DevOps APIs |

For another Entra-protected resource, a custom audience can be a string literal containing the application ID or an `https://` or `api://` resource URI. It isn't a `/.default` scope. The token is read with the same audience string, such as `ctx.Tokens['api://contoso-api']`. Each API determines which identities and permissions it supports.

1. In the Fabric portal, open **OneLake catalog** and find the `adventure-functions` app in your development workspace. Open its item details and select **Overview**. Check the app item, not its Functions child item.

1. Find **Owner** and identify the account's email address. Selecting the name opens an email addressed to that account. For the new app in this module, the owner is the account that created the app item during the first deployment, unless ownership has changed.

  The catalog can display an item contact in the **Owner** field. If it shows a contact, or ownership is unclear, ask your workspace administrator to confirm the actual app item owner. A contact or another workspace member isn't necessarily the app identity. For the field's details, see [View item details in the OneLake catalog](/fabric/governance/onelake-catalog-item-details#overview-tab).

1. Use the confirmed owner's email address to identify the account in each target workspace's **Manage access** settings. Confirm that this account has the access required by the function. If access is missing, ask the workspace administrator to grant the lowest suitable role. If access is already sufficient, no permission change is needed. Don't use the app's name, item GUID, or publishable key as the identity.

1. Write down which identity the deployed function uses for `ctx.Tokens.Fabric`, and which identity `ctx.getDataClient()` uses. The Fabric REST API returns workspaces accessible to the app owner, while the app's own data client preserves the signed-in caller's entity policies.

## Deploy and verify

Locally, `ctx.Tokens` uses the account you sign in with when the Functions host starts. After deployment, it uses the app identity. A successful local query therefore doesn't establish that the deployed identity has permission to run it.

1. Deploy the app, and confirm that it's healthy.

    ```bash
    npx rayfin up --dry-run
    npx rayfin up
    npx rayfin up status
    ```

1. Open the deployed app by using the URL that `rayfin up` prints. Submit `DEMO-001` in **Shipment lookup** and confirm that it returns the simulated **in transit** status. Select **List workspaces** and confirm that it returns workspace names.

1. Compare the deployed result with the local one. The list can differ if the app identity can see different workspaces than the account you used locally. If the deployed call returns an authorization error, the app identity lacks access. Grant it the access you identified, and call the function again.

## Next step

In the next challenge, you diagnose a supplied scenario where a function works locally but fails after deployment because the identities have different workspace access.
