You built app features that read, change, and store data through the typed Fabric Apps client. The Adventure Works Cycles issue tracker shows how a few client behaviors, such as page truncation and field selection, decide whether features are dependable.

## What you learned

- The client composes from an auth adapter and registered services, and queries return only the fields you select.
- `execute()` returns one page, so cursor pagination with `executePaginated()` and `after()` reaches every record, and aggregation runs server-side over numeric fields as its own query.
- `create`, `update`, `delete`, and `upsert` return the key and the fields you sent, and failures belong in the UI.
- Storage folders carry authenticated policies, are remote-only, and delete every object when a declaration is removed.

## Clean up resources

Delete test files from the Storage folder. If you don't plan to reuse the project, delete the app item and any remaining child items from your Fabric workspace.

## Learn more

- [Read and write data with GraphQL in Fabric Apps](/fabric/apps/read-write-data-graphql)
- [Store and manage files in Fabric Apps](/fabric/apps/storage)
- [Rayfin: Querying](https://rayfin.ai/docs/data/querying)
- [Rayfin: Aggregations](https://rayfin.ai/docs/data/aggregations)
- [Rayfin: Storage](https://rayfin.ai/docs/storage)
