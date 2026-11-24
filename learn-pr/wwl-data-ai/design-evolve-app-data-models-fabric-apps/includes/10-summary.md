You designed a Fabric app's data model with TypeScript decorators and applied schema changes while protecting existing data. The Adventure Works Cycles issue tracker shows how a few well-chosen entities and a careful change workflow keep a model reliable as requirements change.

## What you learned

- Entity and field decorators generate the SQL schema, and platform constraints such as a single UUID key and bounded text shape the design from the start.
- One-to-many relationships use `@one()` and `@many()`, many-to-many relationships need a join entity, and entities must be registered before the client and CLI see them.
- `rayfin up` and `rayfin up db apply` apply changes, and `rayfin up status` confirms that a change reached the server.
- Additions are low risk, while removing, narrowing, or renaming needs review, and `--force` is a reviewed exception.

## Clean up resources

If you don't plan to reuse the project, delete the app item and any remaining child items from your Fabric workspace. A trial capacity allows only a limited number of SQL databases. If you reuse the project, delete the test records and replace the lab-only `Store` permission.

## Learn more

- [Define data models for Fabric Apps](/fabric/apps/data-models)
- [Apply and verify schema changes](/fabric/apps/apply-schema-changes)
- [Troubleshoot Fabric Apps](/fabric/apps/troubleshooting)
- [Rayfin: Modeling entities](https://rayfin.ai/docs/data/modeling)
- [Rayfin: Relationships](https://rayfin.ai/docs/data/relationships)
- [Rayfin: Schema changes](https://rayfin.ai/docs/data/migrations)
