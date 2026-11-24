You start the Adventure Works Cycles issue-reporting tool with the smallest useful piece: a single `Issue` entity. Before writing it, you learn how decorators describe a table and which platform rules shape the design.

## Treat the model as the source of truth

In Fabric Apps, you describe data as TypeScript classes. Each class marked with `@entity()` becomes a table in the app's SQL database in Fabric. The platform also generates a GraphQL API and a typed client from the same classes, so a field you add to a class becomes a column, an API field, and a typed property.

Because the code is the source of truth, you change the model in code and then apply the change. You never change the database directly through the Fabric portal or SQL tools. A change made outside the model leaves the database out of step with the code that the platform reads.

The following example shows the shape of an entity. The permission decorator states who can reach the entity, each property decorator declares a field type, and an options object sets modifiers. You don't need to add this code or make any changes to your app yet. In the next exercise, you define the `Issue` entity yourself.

```typescript
@entity()
@authenticated('*', {
	policy: (claims, item) => claims.sub.eq(item.owner_id),
})
export class Issue {
	@uuid() id!: string;
	@text({ max: 200 }) title!: string;
	@set('low', 'medium', 'high') severity!: 'low' | 'medium' | 'high';
	@text({ max: 2000, optional: true }) description?: string;
	@text({ max: 200 }) owner_id!: string;
}
```

The decorators come from `@microsoft/rayfin-core`. The class has a generated `id`, a required title, a required severity from a fixed list, an optional description, and an owner. The permission decorator and the `owner_id` field are the access decision, which the last section of this unit explains.

## Choose field decorators and modifiers

A field decorator sets the type of the column and the type of the generated API field. Every property needs exactly one field decorator.

| Decorator | Use for |
|:----------|:--------|
| `@uuid()` | Generated unique identifiers, such as an entity's `id` |
| `@text()` | Strings, such as titles and descriptions |
| `@int()` | Whole numbers |
| `@decimal()` | Numbers with a fractional part |
| `@boolean()` | True or false values |
| `@date()` | Date and time values |
| `@email()` | Email addresses |
| `@set()` | One value from a fixed list of allowed strings |

> [!NOTE]
> The boolean decorator is `@boolean()`. Some reference pages show `@bool()`, which doesn't exist in `@microsoft/rayfin-core`.

Modifiers refine a field. You pass them to the field decorator in an options object.

| Modifier | Effect |
|:---------|:-------|
| `optional` | Allows a record to have no value for the field |
| `unique` | Prevents two records from sharing the same value |
| `default` | Supplies a value when the app doesn't provide one |
| `min` and `max` | Bound the allowed range of a number or the length of text |
| `column` | Sets the name of the database column |

To make a field nullable, set `{ optional: true }` in the decorator and add `?` to the TypeScript property. Either one alone is inconsistent. The `?` only changes the TypeScript type and doesn't make the column nullable.

Use `optional` deliberately. A required field promises that every record has a value. That promise is easy to make for a new entity and harder to keep after records exist, which a later unit returns to.

## Understand data model requirements

Fabric Apps maps your classes to a SQL database and exposes them through GraphQL. Those two targets impose rules that you design around from the start, because breaking them surfaces as a failed deployment, not as a compile-time hint.

| Constraint | Design consequence |
|:-----------|:-------------------|
| One UUID `id` per entity | Every entity has a single generated key. Composite keys aren't available, so identify a record by its `id`. |
| Explicit `max` on `@text()` | Choose a length for every text field based on the data it holds. |
| Valid GraphQL names | Property names use letters, digits, and underscores, and don't start with a digit or two underscores. Use `column` to map an unusual column name. |
| Reserved entity names | Names such as `Date`, `String`, `Int`, `UUID`, `Query`, and `Mutation` collide with GraphQL built-in types. |
| The app owns its database | The app creates its schema from your classes. You can't map the model onto an existing database. |
| No many-to-many relationships | Relate entities with one-to-many links and a join entity, as the next unit shows. |

> [!WARNING]
> Always specify a finite length for text fields by setting the `max` option, for example `@text({ max: 200 })`. Omitting this option produces an `NVARCHAR(MAX)` column on SQL Server. The SQL type's `MAX` is different from the decorator's `max` option: it allows large text values rather than setting your chosen length limit. This column type can break GraphQL schema generation, causing an internal server error at runtime even after a deployment reports success. Set a finite `max` value on every `@text()` and `@email()` field.

If you need a reserved name, rename the class or pass a different entity name, for example `@entity('EventDate')`.

For Adventure Works, these constraints become concrete choices. The `Issue` title is short, so a limit of 200 characters is enough. The description is longer, so it gets 2,000 characters. Severity is a small fixed list of values.

## Decide access for every entity

A data model isn't complete until each entity states who can reach it. Every entity needs an explicit permission decorator, and you decide this while you design the model, not after the first deployment. An entity with no permission decorator can silently receive full create, read, update, and delete access for any signed-in user, with no row-level restriction.

Two shorthand decorators cover the common cases:

- `@authenticated()` grants access to signed-in users.
- `@anonymous()` grants access without sign-in. It also requires a tenant administrator to turn on anonymous data access, so this module uses `@authenticated()`.

Each decorator takes the allowed actions, where `'*'` means create, read, update, and delete, and an options object that can hold a row-level `policy`. The following excerpt from the `Issue` example shows the permission decorator and owner field.

```typescript
@entity()
@authenticated('*', {
	policy: (claims, item) => claims.sub.eq(item.owner_id),
})
export class Issue {
	// Other fields omitted.
	@text({ max: 200 }) owner_id!: string;
}
```

The policy, `claims.sub.eq(item.owner_id)`, compares the signed-in user's ID to the record's `owner_id`, so each user sees only their own records. A policy checks ownership but doesn't fill in the owner. When your code creates a record in an owner-scoped entity, it sets `owner_id` explicitly.

In the Adventure Works tool, each staff member reports issues and sees their own reports, so `Issue` is owner-scoped. Stores are shared reference data, so `Store` grants access to every signed-in user. Writing row-level and field-level policies in depth is beyond this module. Here, the decision is narrower: pick a permission decorator for every entity and keep access visible next to the fields.

## Where entity files live

In the next exercise, you enable the data service in the default Universal App with `npm run pack:add -- data-modeling`, create the `Issue` entity in `packages/data/src/`, register it in `packages/data/src/index.ts`, and add its client-facing record type in `packages/shared/src/index.ts`. You don't need to run the command or edit these files yet.

Relative imports between entity files must end in `.js`, even though the source files end in `.ts`, because the CLI compiles the files as ES modules. An import such as `./Store` without the extension fails with a `TS2835` error. When you add Rayfin to an existing project that isn't an ES module, the CLI adds a `rayfin/package.json` file that sets `"type": "module"`. Keep that file.

You now have the vocabulary to describe a single entity: a class with `@entity()`, typed fields, bounded text, and a permission decorator. In the next unit, you apply it by defining the `Issue` entity in a Fabric Apps project.
