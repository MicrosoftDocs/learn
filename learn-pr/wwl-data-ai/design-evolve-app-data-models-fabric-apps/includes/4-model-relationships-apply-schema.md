The Adventure Works Cycles issue tracker needs more than one entity, because each issue belongs to a store. This unit shows how to relate entities, register them, and apply the result to the database.

## Model one-to-many relationships

The code and commands in this unit illustrate the concepts. You don't need to edit your app or run any commands yet. In the next exercise, you add the `Store` entity, relate it to `Issue`, and apply the schema.

Fabric Apps supports one-to-many and many-to-one relationships with two decorators:

- `@one(() => Target)` goes on the "many" side and refers to one related record. The platform generates a foreign key column named `{property}_id`.
- `@many(() => Target)` goes on the "one" side and gives a read-only collection of related records. It doesn't generate a column.

```typescript
// Store.ts
@entity()
@authenticated('*')
export class Store {
  @uuid() id!: string;
  @text({ max: 100 }) name!: string;
  @many(() => Issue) issues?: Issue[];
}

// Issue.ts (relevant fields)
@uuid({ optional: true }) store_id?: string;
@one(() => Store, { optional: true }) store?: Store;
```

Keep these rules in mind when you define a relationship:

- **Refer to the class with an arrow function**, such as `() => Store`. This delays the reference so two entity files can import each other.
- **Use `import`, not `import type`.** The decorator needs the actual class at runtime.
- **Use the expected foreign key name.** For a relationship named `store`, the key is `store_id`. Declare it with `@uuid()` if your code needs to read or set it directly. Custom foreign key names aren't supported.
- **Use only `optional` and `unique` as relationship options.** Other field options don't apply to `@one()` or `@many()`.

The `owner_id` field is different: it stores the signed-in user's ID from `claims.sub`, not a relationship to another app entity. It uses `@text()`, not `@uuid()`.

Fabric Apps doesn't support `@one()` relationships to built-in system entities such as the user.

## Use a join entity for many-to-many

Many-to-many relationships aren't supported. Model them as you would in SQL, with an explicit join entity that has two `@one()` fields. The following example relates issues to tags, where `Tag` is another entity.

```typescript
@entity()
@authenticated('*')
export class IssueTag {
  @uuid() id!: string;
  @uuid() issue_id!: string;
  @one(() => Issue) issue!: Issue;
  @uuid() tag_id!: string;
  @one(() => Tag) tag!: Tag;
}
```

You query through the join entity. For example, you select `IssueTag` records for an issue and include `tag.name`.

## Register entities

The client and the CLI only see entities that you register. In the Universal App, registration has two parts. Add each entity class to the `schema` array in `packages/data/src/index.ts`, and add its record type to `UniversalAppSchema` in `packages/shared/src/index.ts`. Keep the two in step. A class that's in the array but missing from the type is reachable at runtime but invisible to the compiler.

```typescript
// packages/data/src/index.ts
import { Issue } from './Issue.js';
import { Store } from './Store.js';

export const schema = [Item, Issue, Store];

// packages/shared/src/index.ts
export type UniversalAppSchema = {
  Item: ItemRecord;
  Issue: IssueRecord;
  Store: StoreRecord;
};
```

Defining a class doesn't change the database. Registration makes the entity visible, and applying makes it real.

## Apply and verify

Two commands apply schema changes.

| Command | What it does |
|:--------|:-------------|
| `npx rayfin up` | Syncs settings, applies the schema, and deploys static content in one step. Run it after every change to an entity file. |
| `npx rayfin up db apply` | Applies only the database schema. Use it for a schema-only change after the app exists. |

During development, `npm run dev` runs `rayfin dev`, which applies the declared schema when the session starts. Restart it after you edit entities.

A deployment that reports success doesn't guarantee that you can read a new entity. After any change to an entity file, run `npx rayfin up status` and confirm that the deployment is healthy before you test the entity in the app. If the new entity still returns GraphQL errors, check every `@text()` field for a missing `max`, rebuild the frontend, and run `npx rayfin up db apply` explicitly.

> [!NOTE]
> `rayfin up db apply` applies schema to an app that already exists in Fabric. Run `npx rayfin up` once first to create the app.

## Next step

In the next exercise, you add the `Store` entity, relate issues to stores, apply the schema, and display seeded records.
