The Adventure Works Cycles app needs two kinds of data: shared inventory levels from the warehouse and sales figures from the semantic model. Before you add anything to the project, you decide which connector fits each source and which identity runs each query.

## Connectors reach existing Fabric data

A Fabric app's own database holds data that the app defines. A connector gives the app typed access to data that already exists in Fabric, so you don't copy it. The source decides what each identity can see.

| Connector type | Source | Operations | Default identity |
|:---------------|:-------|:-----------|:-----------------|
| `fabric-sqlanalytics` | Lakehouse SQL analytics endpoint | read | application |
| `fabric-warehouse` | Warehouse | read, create, update, delete | application |
| `fabric-sqldatabase` | SQL database in Fabric | read, create, update, delete | application |
| `fabric-semanticmodel` | Semantic model | `executeQuery` | delegated only |

Connectors that expose tables, such as the warehouse and SQL database, generate entity configuration for typed queries. A semantic model connector exposes function-style operations that run DAX.

## Two identities

Each connector entry in `rayfin/rayfin.yml` has an `auth` block with a lowercase `type`, either `application` or `delegated`.

- **Application access** runs each call as the app identity. In current Fabric apps, that identity is the owner of the app item. Every user sees the same view of the data. Row-level policies keyed on `claims` no longer distinguish users, and any row-level security at the source is evaluated against the app owner.

- **Delegated access** runs each call as the signed-in user through an on-behalf-of token exchange. The user needs their own permission on the Fabric workspace and item, because Rayfin doesn't grant source access on their behalf. The caller's claims stay meaningful for policies on connector entities.

:::image type="content" source="../media/application-delegated-access.png" alt-text="Diagram contrasting app-owner permissions for shared warehouse data with each manager's permissions for delegated semantic model access." lightbox="../media/application-delegated-access.png":::

Semantic models support delegated access only. The warehouse, lakehouse endpoint, and SQL database support both, with `application` as the default.

Neither identity grants access by itself. Rayfin passes the identity through, and the source decides. For delegated calls, each user needs access to the Fabric workspace and item. For application calls, the app identity needs that access.

## Choose by what each user should see

Treat the identity choice as a data-governance decision, not a configuration detail.

| Question | If yes |
|:---------|:-------|
| Should every user see the same data, such as shared inventory levels? | Application access |
| Should each user see only what they're allowed to see at the source, such as their own sales figures? | Delegated access |
| Is the source a semantic model? | Delegated access, because it's the only option |

For Adventure Works, shared warehouse inventory fits application access. Sales figures that each manager can see under their own permissions fit delegated access on the semantic model. Don't choose application access for per-user access control. Enforce it in your app instead.

## Set the identity explicitly

`rayfin connector add` writes the type's default identity. In Rayfin 2.0, you choose the identity at add time with `--auth delegated` or `--auth application`:

```bash
npx rayfin connector add --type fabric-warehouse --workspace-id <id> --item-id <id> --name adventureworksconnectors --auth application
```

The CLI rejects an identity that the type doesn't allow before it writes anything. Even so, always check `auth.type` in `rayfin.yml` yourself. Re-adding an existing connector resets `auth.type` to the type's default unless you pass `--auth` again.

## Discovery permissions differ from runtime identity

Schema discovery during `connector add` runs under your developer identity, so you need SQL endpoint permissions on the source. Runtime queries then use the configured `auth.type`. For a semantic model, direct CLI invocation calls Power BI under your identity and needs Read and Build permissions on the model.
