The Adventure Works Cycles issue tracker now holds real reports, and requirements change. This unit teaches you to classify a change to a class before you apply it to data that already exists.

## Why schema changes carry risk

The code is the source of truth, so every edit to an entity class is a schema change the next time you apply it. Adding a field is usually harmless. Removing or narrowing one can destroy data, because the platform makes the database match your classes.

To protect existing data, the CLI inspects pending changes. If a change could cause data loss, such as dropping a column, narrowing a type, or renaming a table, the CLI blocks it and lists what it found.

## Classify the change

Use this table to decide how to treat a change before you apply it.

| Change | Typical risk | What to do |
|:-------|:-------------|:-----------|
| Add an optional field | Low. Existing rows get no value. | Apply with `rayfin up`. |
| Add a field with a `default` | Low. The default supplies a value. | Apply with `rayfin up`. |
| Add a new entity | Low. No existing data is involved. | Register it and apply. |
| Remove a field | High. The column and its data are dropped. | Stop and review. |
| Narrow a type or a length | High. Values can be truncated or rejected. | Stop and review. |
| Rename a field | High. The old column is dropped and a new one is added. | Stop and review. |

> [!NOTE]
> A required field promises a value in every record, but existing records have none. Prefer an optional field or a `default` when you add a field to an entity that already holds records.

The rule of thumb is simple: additions are safe, and anything that removes, narrows, or renames needs a decision.

## Treat force as a reviewed exception

When the CLI blocks a change, you have three choices:

- Revert the model change, which restores the previous schema.
- Rework the change so it avoids data loss. For a rename, add a new field and keep the old one until you copy the data, or rename the property and keep the existing column by setting the `column` option to its current name.
- Accept the loss with `--force`.

```bash
npx rayfin up db apply --force
```

`--force` permits destructive changes such as dropping a table, dropping a column, or altering a type. Use it only after you review the operations the CLI lists and confirm that the loss is acceptable. Never use it to silence a warning that you haven't read. Because `--force` permits every destructive operation in the pending change, review the whole list.

## Never edit the database directly

The database that Fabric Apps creates belongs to the app, and the code defines its schema. Don't change it through the Fabric portal, SQL Server Management Studio, or other SQL tools. Manual changes create conflicts between the database and the code, and they can break the app and its deployment. Make every schema change in your entity classes, then apply it.

## A change workflow you can repeat

1. Edit the entity class and register any new entity.
1. Apply the change by restarting `npm run dev` during development or by running `npx rayfin up` for a deployment.
1. Run `npx rayfin up status` and confirm that the deployment is healthy.
1. If the CLI blocks a change, read its list of operations, then revert, rework, or force with a recorded reason.

## Next step

In the next exercise, you add an optional field, verify that existing records remain, and then see the CLI block a destructive change.
