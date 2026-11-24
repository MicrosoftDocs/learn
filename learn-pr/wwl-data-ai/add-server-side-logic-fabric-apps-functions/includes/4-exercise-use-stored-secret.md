In this exercise, you store a demonstration API key as a Rayfin secret, read it in a shipment lookup function, and confirm that the value never reaches the browser. A supplied carrier simulation lets you complete the exercise without a carrier account or an external mock service.

## Prerequisites

Use the `adventure-functions` project created and deployed in the first exercise of this module. It includes the Functions registration file, generated types, configured client, and greeting component. No project or data model from another module is required.

The simulation below checks that a secret is available and returns a status based on the tracking number. It doesn't authenticate with a real carrier. In a production implementation, the function uses the secret in its server-side request to the carrier rather than returning it to the frontend.

## Store the secret

Anything delivered to the browser is visible to the user. Source code, frontend environment variables, and committed settings files aren't safe places for API credentials. A Rayfin publishable key identifies the app and is safe in the client, but a carrier API key authenticates access to another service. It belongs on the server and must not appear in code, chat, logs, or function responses.

Secrets attach to a deployed app. The initial deployment from the first exercise provides the remote endpoint that `secret set` needs. Without that deployment, the command reports `No remote endpoint configured`.

1. Declare the secret. Use a demonstration value, not a real credential.

    ```bash
    npx rayfin secret set CARRIER_API_KEY --describe="API key used by lookupShipment"
    ```

1. Enter the value at the masked prompt.

  The `--describe` option uses an equals sign. The masked prompt keeps the value out of the command arguments and terminal history.

1. Run `npx rayfin secret list` and confirm that the name appears with a timestamp and no value.

1. Open `rayfin/rayfin.yml`. Confirm that `secrets:` lists the name and description, and that the value isn't there.

1. Confirm that the CLI updated `secrets.generated.ts` in the Functions package. Don't open or edit it.

The CLI stores the value on the deployed app and records only its name and description in `rayfin/rayfin.yml`. The generated secret declarations provide the typed names available to the function, not the secret values. `secret list` shows names and timestamps, while `secret delete CARRIER_API_KEY` removes the secret and its metadata.

To rotate a deployed value, run `secret set` again with the same name and enter the replacement at the masked prompt. A deployed function fetches secrets on first read and can cache them for a few minutes, so rotation isn't necessarily visible to every invocation immediately.

## Write the function

`ctx.Secrets.CARRIER_API_KEY` reads the declared secret through the typed runtime context. An undeclared name is a TypeScript error. The function can use a secret without sending that value to the client.

1. In `packages/functions/src/function_app.ts`, append the following registration after `greet`. Keep the imports, empty `AppSchema`, and `udf` instance from the first exercise.

    ```typescript
    udf.func(
      'lookupShipment',
      async (trackingNumber: string, ctx: RayfinContext<AppSchema>): Promise<{ status: string }> => {
        const apiKey = ctx.Secrets.CARRIER_API_KEY;
        if (!apiKey.trim()) throw new Error('The demonstration carrier key is empty.');
        const tracking = trackingNumber.trim();
        if (!tracking) throw new Error('Enter a tracking number.');
        return { status: tracking.startsWith('DEL') ? 'delivered' : 'in transit' };
      },
      [],
    );
    ```

    The function returns only the status. It never returns or logs the key.

1. For local debugging, open `packages/functions/local.settings.json` and add this property inside its existing `Values` object. Keep the other settings, and add a comma between properties where needed:

    ```json
    "CARRIER_API_KEY": "local-development-value"
    ```

    Local functions don't receive the deployed secret bag. During local development, `Values` supplies the environment value used by the Functions host. The scaffold excludes `local.settings.json` from Git, so leave that exclusion in place and use only a demonstration value here.

  When the function reads a secret, the runtime first checks the secrets supplied for that invocation, then falls back to `process.env` for local development. If neither contains a value, it throws an error naming the missing secret. Updating the deployed value doesn't replace the local placeholder.

## Call it from the app

1. Restart `npm run dev` so the Functions host loads the new function and regenerates `types.ts`.
1. Create `packages/frontend/src/ShipmentLookup.tsx` with the following complete component:

    ```tsx
    import { useState, type FormEvent } from 'react';
    import { FunctionsError } from '@microsoft/rayfin-functions';
    import { getRayfinClient } from './lib/rayfin-client';

    export function ShipmentLookup() {
      const [trackingNumber, setTrackingNumber] = useState('DEMO-001');
      const [message, setMessage] = useState('');
      const [loading, setLoading] = useState(false);

      async function lookup(event: FormEvent<HTMLFormElement>) {
        event.preventDefault();
        setLoading(true);
        try {
          const client = await getRayfinClient();
          const result = await client.functions.lookupShipment.invoke({ trackingNumber });
          setMessage(`Status: ${result.status}`);
        } catch (error) {
          setMessage(error instanceof FunctionsError
            ? `Function failed: ${error.message}`
            : 'Unable to complete the lookup.');
        } finally {
          setLoading(false);
        }
      }

      return (
        <section className="p-400 text-foreground">
          <h2 className="mb-400 text-600 font-semibold">Shipment lookup</h2>
          <form onSubmit={lookup} className="flex flex-wrap items-end gap-400">
            <label className="flex flex-col gap-200">
              Tracking number
              <input
                value={trackingNumber}
                onChange={(event) => setTrackingNumber(event.target.value)}
                className="border border-border rounded-md px-400 py-200"
                required
              />
            </label>
            <button
              type="submit"
              disabled={loading}
              className="bg-primary text-primary-foreground px-400 py-200 rounded-md disabled:opacity-60"
            >
              {loading ? 'Looking up...' : 'Look up shipment'}
            </button>
          </form>
          <p role="status" className="mt-400">{message}</p>
        </section>
      );
    }
    ```

1. In `packages/frontend/src/App.tsx`, add `import { ShipmentLookup } from './ShipmentLookup';`. Replace only the `App` component with the following code, keeping the existing `Greeting` import and default export:

    ```tsx
    function App() {
      return (
        <>
          <Greeting />
          <ShipmentLookup />
        </>
      );
    }
    ```

1. Submit `DEMO-001` and confirm that the app displays **Status: in transit**. Submit `DEL-001` and confirm that it displays **Status: delivered**. These are simulated results, not real shipment data.

## Verify that the key stays on the server

1. Open the browser developer tools. In the **Network** tab, inspect the request to the function and the response. Confirm that the request contains the tracking number and the response contains only the status, with no key value.
1. Search the frontend bundle in the **Sources** tab for the key value. Confirm that it isn't there.

## Explain the result

Answer these questions before you move on:

- Where does the value of `CARRIER_API_KEY` exist at runtime?
- What happens if a function reads a declared secret that has no value?
- Why might a deployed function briefly use the previous value after rotation?

The value exists on the deployed Fabric app, and locally in `local.settings.json` during development. The runtime throws an error that names the secret when neither source has a value. A deployed function can cache its retrieved values for a few minutes, so rotation can take time to reach an invocation.

## Next step

In the next exercise, you learn how audiences and the app identity support calls to Microsoft services, add a Fabric API function, and verify it after deployment.
