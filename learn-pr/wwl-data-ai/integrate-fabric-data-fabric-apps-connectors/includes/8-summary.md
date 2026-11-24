You brought existing Fabric data into an app and chose the identity that accesses it. The Adventure Works Cycles scenario shows that the identity setting decides who sees what, so it's a governance decision.

## What you learned

- Connector types map to Fabric sources, and application or delegated access decides whose permissions each query uses.
- `connector search`, `add`, `inspect`, and `invoke` prove a connection from the command line before you build a user interface, and connectors run only in a deployed app.
- Entity connectors expose chosen tables and columns, `metadata.json` supplies keys, and a filtered or ordered query needs an explicit `select`.
- A semantic model connector runs DAX as the signed-in user and returns a result that you check before you use it.
- Limited operations, entity roles, and an accurate view of what sharing grants secure connector access. Sharing an app doesn't grant access to related items that stay unshared under delegated access.

## Clean up resources

Remove connectors that you no longer need and delete leftover connector folders. If you don't plan to reuse the project, delete the app item and any remaining child items from your Fabric workspace.

## Learn more

- [Connect Fabric Apps to Fabric data](/fabric/apps/connectors)
- [Create an app connected to a semantic model](/fabric/apps/data-apps-template)
- [Share a Fabric app](/fabric/apps/share-app)
- [Rayfin: Delegated and application access](https://rayfin.ai/docs/auth/delegated-access)
- [Rayfin: Connector authentication](https://rayfin.ai/docs/connectors/auth)
- [Rayfin: Wiring connectors into your app](https://rayfin.ai/docs/connectors/client-setup)
- [Rayfin: rayfin connector reference](https://rayfin.ai/docs/reference/cli/connector)
