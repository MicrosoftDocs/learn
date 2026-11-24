You secured a Fabric app by choosing a sign-in path and enforcing data permissions on the server. The Adventure Works Cycles scenario shows that protections belong on the data model, because callers can reach the API without using your UI.

## What you learned

- Deployed apps use Microsoft Entra ID through Fabric SSO, and you choose the popup, embedded, token exchange, or external host path that fits the app.
- `allowedRedirectUris` is a security boundary, and sign-in errors belong in the UI.
- `@authenticated()` and `@anonymous()` rules compile to server-side checks, and policies, `include`, and `exclude` restrict rows and fields per action.
- Anonymous access needs a tenant setting and an entity role, and protected hosting doesn't protect the data API.
- You verify denial directly against the server, with a cross-owner record and a request that has no session.

## Clean up resources

Remove the `LabIssueReport` entity, and apply the change with `npx rayfin up db apply --force` after you review the operations that the CLI lists. Also remove the `PermissionLab` component from the app. If you don't plan to reuse the project, delete the app item and any remaining child items from your Fabric workspace.

## Learn more

- [Authentication in Fabric Apps](/fabric/apps/authentication)
- [Fabric SSO for Fabric Apps](/fabric/apps/fabric-authentication)
- [Define data permissions](/fabric/apps/data-permissions)
- [Anonymous data access in Fabric apps](/fabric/apps/anonymous-data-access)
- [Rayfin: Permissions and row-level security](https://rayfin.ai/docs/data/permissions)
