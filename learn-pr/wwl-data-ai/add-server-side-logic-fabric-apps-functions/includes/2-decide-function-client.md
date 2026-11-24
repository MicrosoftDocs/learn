The shipment lookup at Adventure Works Cycles depends on a carrier API key, so some work belongs on the server rather than in the browser. This unit explains that distinction and illustrates function registration and invocation through code examples that prepare you for the next exercise.

## What belongs in a function

Functions are TypeScript functions that run on the server inside your Fabric app. The following kinds of work belong on the server:

| Server-side work | Why |
| :------------------- | :---- |
| Calls that need a secret, such as an API key | The browser can't keep a secret. Anything in frontend code is visible. |
| Privileged data access | The server can read or write with checks you control. |
| Calls to external services | The server holds the credentials and shapes the response. |
| Orchestration near the data | Several steps run together without round trips from the client. |

Work that needs no secret or privileged access can stay in the client, such as filtering a list the user already has. For the shipment lookup, the carrier call needs a key, so it belongs on the server. The component that shows the result stays in the browser.

## Function limits and availability

The following limits shape what a function can handle:

- A function can run for up to 240 seconds, which is the service's maximum execution time. The SDK client waits up to 250 seconds by default and caps `timeoutMs` there.

- The request payload is limited to 4 MB for all parameters combined, and the response to 30 MB. These limits come from the Fabric user data functions service that Rayfin Functions build on.

- The Functions deployment package, a ZIP file, can't exceed 30 MB.

- Functions aren't available in every Fabric region or tenant, and they aren't supported in Power BI Pro workspaces. The next exercise includes an availability check.

## Function registration

A function is registered with `udf.func(name, handler, [])` from `@microsoft/fabric-user-data-functions`. Bare exported functions aren't discovered. The following example registers a greeting function, with the context as the handler's last parameter:

```typescript
import {
  UserDataFunctions,
  type RayfinContext,
} from '@microsoft/fabric-user-data-functions';

export type AppSchema = Record<string, never>;
const udf = new UserDataFunctions();

udf.func(
  'greet',
  async (name: string, ctx: RayfinContext<AppSchema>): Promise<string> => {
    return `Hello, ${name}.`;
  },
  [],
);
```

The third argument in the example is an empty array, `[]`. The Rayfin CLI generates `types.ts` for the frontend from registered functions, so that file is tooling-managed rather than manually maintained.

The `rayfin functions init` command adds Functions to an existing app. It creates the Functions package, enables the service in `rayfin/rayfin.yml`, installs dependencies, builds, and generates the initial `types.ts`. In a Universal App, the package is `packages/functions`. The next exercise uses this command to scaffold the package.

## Application authentication

Enabled Functions need `services.functions.auth.type: application` in `rayfin/rayfin.yml`. The scaffold creates the following configuration:

```yaml
services:
  functions:
    enabled: true
    auth:
      type: application
```

This setting means that calls to external resources through `ctx.Tokens` use the app identity. It doesn't change how data access works. A later unit explains both.

## Client invocation

The frontend uses `@microsoft/rayfin-functions` to register the functions service when it creates the client. The generated `AppFunctionsSchema` type describes the available functions and their parameters. The following configuration passes that type to `functionsService`:

```typescript
services: {
  functions: functionsService<AppFunctionsSchema>(),
},
```

```typescript
const message = await client.functions.greet.invoke({ name: 'Ada' });
```

In the invocation example, the `name` key matches the handler's parameter. `invoke()` resolves to the function's output directly. A failed call throws `FunctionsError`, which the app can catch and display. The function is callable when it's deployed or its local Functions host is running.

## Next step

In the next exercise, you check that Functions work in your workspace, scaffold a function package, and run it locally.
