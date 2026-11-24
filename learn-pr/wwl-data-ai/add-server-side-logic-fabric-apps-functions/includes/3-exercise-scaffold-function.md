In this exercise, you confirm that Functions work in your workspace before you design around them, scaffold the Functions package, and run a function locally.

## Prerequisites

You need Node.js 24, Visual Studio Code, and permission to create app items in a Fabric workspace on a trial or paid capacity. Functions aren't supported in Power BI Pro workspaces and aren't available in every region or tenant. No existing app, data model, or completed module is required.

Install Azure Functions Core Tools version 4 before you run the local host, or accept the CLI prompt that offers to install it.

## Create the module project

Create a new project for these exercises. The following exercises in this module use this same project.

1. In a terminal, confirm that `node --version` reports Node.js 24.
1. Scaffold the app, replacing `<workspace-name>` with your development workspace's name. Accept the default Universal App template.

    ```bash
    npm create @microsoft/rayfin@latest --registry=https://packagefeedproxy.microsoft.io/npm/ -- adventure-functions --workspace <workspace-name>
    cd adventure-functions
    ```

1. Open the `adventure-functions` folder in Visual Studio Code. In its integrated terminal, sign in with the account that can create items in your workspace.

    ```bash
    npx rayfin login
    ```

1. Deploy the starter app and check its status. This establishes the app item used by the remaining exercises.

    ```bash
    npx rayfin up

    npx rayfin up status
    ```

## Run the availability smoke test

1. In the project root, add Functions to the app.

    ```bash
    npm run pack:add -- functions
    ```

    The pack creates `packages/functions`, installs the matching SDKs, and wires the frontend service and root development commands. Don't use `rayfin functions init` for this Universal App: that command targets the legacy `rayfin/functions` location and can leave a second Functions project with different generated types.

1. Open `rayfin/rayfin.yml` and confirm that `services.functions.enabled` is `true` and `services.functions.auth.type` is `application`.
1. Deploy and confirm that the deployment succeeds.

    ```bash
    npx rayfin up
    npx rayfin up status
    ```

If deployment reports that Functions aren't available in the workspace's region or tenant, use a supported development workspace before continuing. A different deployment error can indicate a configuration or permission issue rather than service availability.

## Explore the package

1. Open the Functions package. In a Universal App, it's `packages/functions/`. Find the registration file `src/function_app.ts` and the generated `src/types.ts`.

1. Confirm that handlers are registered with `udf.func(name, handler, [])` and that the context is the last parameter.

1. Don't edit `types.ts`. The tooling regenerates it.

## Add a function and run it locally

### Register the greeting

Replace the starter code in `packages/functions/src/function_app.ts` with the following complete registration file. This exercise doesn't require entities or a data model, so `AppSchema` is empty. Later exercises add handlers to this same file.

```typescript
import {
    UserDataFunctions,
    type RayfinContext,
} from '@microsoft/fabric-user-data-functions';

export type AppSchema = Record<string, never>;
const udf = new UserDataFunctions();

udf.func(
    'greet',
    async (name: string, _ctx: RayfinContext<AppSchema>): Promise<string> => `Hello, ${name}.`,
    [],
);
```

### Configure the frontend client

The Functions pack installs the SDK and wires the client. Open `packages/frontend/src/lib/rayfin-client.ts` and confirm that these imports appear at the top of the file, alongside the other imports. Add them only if they are missing:

```typescript
import { functionsService } from '@microsoft/rayfin-functions';
import type { AppFunctionsSchema } from '@rayfin-app/functions/types';
```

Find `function createClient(config: { ... })` near the bottom of the file. Its `return RayfinClient.create(...)` block must have the following structure. If yours differs, replace only that return block, not the rest of the file:

```typescript
return RayfinClient.create({
    ...config,
    auth: browserSession({ storage: true }),
    services: {
        data: dataService<UniversalAppSchema>(),
        functions: functionsService<AppFunctionsSchema>(),
    },
});
```

`functions` is inside `services`, alongside `data`. Keep `getRayfinClient`, `resolveClient`, the `createClient` signature, and the configuration-resolution code unchanged.

### Verify the TypeScript project references

Complete both checks below before you continue. If a Functions reference is already present, leave that file unchanged. If it is missing, add it once. Don't assume that running the capability pack added these entries.

Open `packages/frontend/tsconfig.json` and find its `references` array near the bottom. Confirm that it contains both entries shown below. Add `{ "path": "../functions" }` after the existing shared reference if it is missing:

```json
[
    { "path": "../shared" },
    { "path": "../functions" }
]
```

Open `tsconfig.json` in the project root, not the file inside `packages/functions`. Find its `references` array. Add `{ "path": "./packages/functions" }` before the frontend reference if it is missing. The array includes these entries:

```json
[
    { "path": "./packages/shared" },
    { "path": "./packages/data" },
    { "path": "./packages/functions" },
    { "path": "./packages/frontend" }
]
```

These examples show only the `references` arrays, not complete configuration files. Preserve all other settings and any additional project references. Add commas between array entries, save both files, and leave `packages/functions/tsconfig.json` unchanged.

An error stating that `types.ts` isn't listed within the frontend project indicates a missing project reference, not a problem with the `AppFunctionsSchema` import. Don't add the generated file to the frontend's `include` list or edit it to bypass the error.

### Add the greeting component

Create `packages/frontend/src/Greeting.tsx` with the following code. This supplies the frontend call and result display without relying on a component from another module.

```tsx
import { useState } from 'react';
import { getRayfinClient } from './lib/rayfin-client';

export function Greeting() {
    const [message, setMessage] = useState('');

    async function greet() {
        try {
            const client = await getRayfinClient();
            setMessage(await client.functions.greet.invoke({ name: 'Ada' }));
        } catch (error) {
            setMessage(error instanceof Error ? error.message : 'Greeting failed.');
        }
    }

    return (
        <section className="p-400 text-foreground">
            <h2 className="mb-400 text-600 font-semibold">Greeting</h2>
            <button
                type="button"
                onClick={greet}
                className="bg-primary text-primary-foreground px-400 py-200 rounded-md"
            >
                Greet Ada
            </button>
            <p role="status" className="mt-400">{message}</p>
        </section>
    );
}
```

### Render and run the app

In `packages/frontend/src/App.tsx`, replace the starting view's import and `App` component with the following code. Keep any file header and the default export. Leave the template's sign-in setup unchanged.

```tsx
import { Greeting } from './Greeting';

function App() {
    return <Greeting />;
}

export default App;
```

Run `npm run dev` from the project root. It starts the Functions host and frontend and generates the function types. Sign in, select **Greet Ada**, and confirm that the app displays **Hello, Ada.** If Core Tools is missing, the CLI asks for consent to install it. If the call returns HTTP 502, check that the local Functions host started successfully.

Before invoking the greeting, wait for the initial type-generation pass. Inspect `packages/functions/src/types.ts` and confirm that `AppFunctionsSchema` lists `greet`, with an input containing `name: string` and an output of `string`. If it still lists only `helloWorld`, the schema is stale. Keep the root development session running and check its generation output. Don't edit `types.ts`, deploy just to regenerate it, or cast the client to bypass a missing function.

In another terminal at the project root, run `npm run validate:functions` and `npm run typecheck` after generation completes. The first checks that registered handlers match the generated schema. The second checks that the frontend uses that schema correctly.