You moved sensitive and external work to server-side functions that call services as the app identity. The Adventure Works Cycles scenario shows that a function can look correct locally and still fail in Fabric, so you verify the deployed function.

## What you learned

- Functions suit secrets, privileged data access, external calls, and orchestration, and they run for at most 240 seconds, in regions and workspaces where the service is available.
- Secrets are declared with `rayfin secret set` and read through typed `ctx.Secrets`, so the value never reaches the browser.
- Audiences in the `RayfinContext` annotation supply tokens in `ctx.Tokens`, and deployed tokens belong to the app identity, which needs explicit permissions.
- Local tokens use your own account, so test the deployed function, and use `ctx.getDataClient()` to keep the caller's data policies.

## Clean up resources

Remove test secrets with `npx rayfin secret delete <NAME>`, and remove test functions that you don't need. If you don't plan to reuse the project, delete the app item and any remaining child items from your Fabric workspace. Trial capacities allow only a limited number of SQL databases.

## Learn more

- [Use Functions in Fabric Apps](/fabric/apps/functions)
- [Manage function secrets](/fabric/apps/manage-function-secrets)
- [Connect Functions to external resources](/fabric/apps/functions-connect-external-resources)
- [Rayfin: Secrets in functions](https://rayfin.ai/docs/functions/secrets)
- [Rayfin: Connections](https://rayfin.ai/docs/functions/connections)
