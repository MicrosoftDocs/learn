The Adventure Works Cycles managers need an issue list that shows the right fields in the right order. This unit explains client composition and typed queries through code examples; you apply these concepts in the next exercise.

## Client composition

An app creates one client with `RayfinClient.create` and reuses it across its features. The client takes an auth adapter and registered services, such as the data service shown in this example:

```typescript
import { RayfinClient } from '@microsoft/rayfin-client';
import { browserSession } from '@microsoft/rayfin-auth';
import { dataService } from '@microsoft/rayfin-data';
import type { AppSchema } from '@rayfin-app/data';

export const client = RayfinClient.create({
  baseUrl: import.meta.env.VITE_RAYFIN_API_URL,
  publishableKey: import.meta.env.VITE_RAYFIN_PUBLISHABLE_KEY,
  auth: browserSession({ storage: true }),
  services: { data: dataService<AppSchema>() },
});
```

The environment values come from `rayfin dev` and `rayfin up`. A project scaffolded from the Universal App template already contains this client in `packages/frontend/src/lib/rayfin-client.ts`. The path to the schema type depends on your project layout.

Publishable keys (`pk-*`) are safe in client code. The registered services determine which capabilities the client exposes.

## The query chain

Every entity becomes `client.data.<Entity>`, a typed query builder. The following example chains `select`, `where`, and `orderBy`, and finishes with `execute`:

```typescript
const issues = await client.data.Issue
  .select(['id', 'title', 'severity', 'store.name'])
  .where({ status: { eq: 'open' } })
  .orderBy({ reportedOn: 'desc' })
  .execute();
```

Several behaviors matter here.

- **Results contain only the fields you select.** A query without `select` returns only the primary key, and so do `findById()`, `findMany()`, and `findFirst(filter)`. The result type reflects this, so reading an unselected field is a compile-time error.
- **`select` returns a new builder.** Calling `select` and ignoring its result leaves the original builder unchanged.
- **Dates and booleans can have different representations.** A selected `@date()` field is typed `Date | string`, and a `@boolean()` field is typed `boolean | 'true' | 'false'`. The expressions `new Date(value)` and `value === true || value === 'true'` convert these values to a date and a boolean, respectively.
- **Optional fields can be `null`.** Expressions with `== null` or `??` handle missing values.
- **Sort directions are lowercase,** `'asc'` or `'desc'`.

The following example selects two fields and calls `findFirst()` to read one record:

```typescript
const issue = await client.data.Issue
  .select(['id', 'title'])
  .where({ id: { eq: issueId } })
  .findFirst();
```

## Filters and combined conditions

`where` takes an object keyed by field name. A bare value means `eq`, and other operators need an operator object. Text fields support `eq`, `neq`, `contains`, `startsWith`, `isNull`, `in`, and comparison operators. Several keys in one object are ANDed. Explicit `and` and `or` arrays support combined or nested conditions.

Relationship filters use the foreign key column, such as `store_id`, rather than a dot path. Dot paths are for `select` only:

```typescript
.where({ store_id: { eq: storeId } })   // correct
.where({ 'store.id': { eq: storeId } }) // wrong: dot paths are select-only
```

## Related data and dot paths

In `select`, a dot follows a `@one()` relationship, and the `[]` marker follows a `@many()` relationship:

```typescript
.select(['id', 'title', 'store.name'])            // to-one
.select(['id', 'name', 'issues[].title'])         // to-many
```

Each path follows one relationship to one scalar field. `store.name` works, but a third level such as `store.region.name` is rejected. A relationship selection includes at least one field, because a bare relationship name is a type error.

## Client typing and server permissions

The typed client gives compile-time safety and clear errors, but it isn't the control that protects data. The server enforces permissions on every request. Your filters shape what the UI shows. They don't decide what a user is allowed to see.

A coding agent can also generate queries from a description of the selected fields, filter, and sort order. The same field-selection and query rules apply to generated code.

## Next step

In the next exercise, you define the entities for the issue tracker and build a list screen with an explicit field selection, a filter, and ordering.
