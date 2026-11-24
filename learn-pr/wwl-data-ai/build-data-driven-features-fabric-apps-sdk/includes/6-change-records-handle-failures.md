Managers at Adventure Works Cycles also need to report, edit, and remove issues. This unit explains how the typed client changes records, what those operations return, and how an app communicates write errors through illustrative code examples.

## The four mutations

`client.data.<Entity>` exposes `create`, `update`, `delete`, and `upsert`. Each is fully typed against the entity, and a field that the entity doesn't declare is a compile-time error.

The following example shows how an app creates an issue, changes its status, and deletes it:

```typescript
const session = client.auth.getSession();
if (!session.isAuthenticated || !session.user) throw new Error('Sign in first.');

// create: pass every required field; id is optional
const issue = await client.data.Issue.create({
  title: 'Loose brake lever',
  severity: 'low',
  status: 'open',
  unitsAffected: 1,
  reportedOn: new Date(),
  user_id: session.user.id,
  store: { id: storeId },
});

// update: a partial patch; only id is supported in the filter
await client.data.Issue.update({ id: issue.id }, { status: 'closed' });

// delete: returns the primary key only
await client.data.Issue.delete({ id: issue.id });
```

`update` sends only the fields that changed. It doesn't replace the whole row.

## What mutations return

A mutation returns the record's primary key plus the fields you sent. It doesn't return the whole row.

| Mutation | Result |
| :--------- | :------- |
| `create(input)` | Primary key plus the scalar, date, and relationship fields in the input |
| `update(where, input)` | Primary key plus the fields in the input |
| `delete(where)` | Primary key only |
| `upsert(where, create, update)` | The result shape of the branch that ran |

Fields you didn't send, such as server defaults, aren't in the result. A separate query with `select([...]).where({ id: { eq: id } }).findFirst()` retrieves those fields. Returned dates and booleans follow the same `Date | string` and `boolean | 'true' | 'false'` typing as query results.

## Relationship values and ownership

For an entity with a `@one()` field, a mutation accepts the related record's key as an object, such as `store: { id: storeId }`. The client writes the foreign key. A mutation can instead specify the foreign key field directly, but it can't include both representations. A relationship value needs a concrete key and can't be `null`. An omitted optional relationship stays unset during creation. Fields marked with `@many()` are the read-only inverse side and aren't mutation inputs. A change to a child's own `@one()` value reassigns that child.

Policies check ownership but don't fill it in. The creation example supplies `user_id` from the signed-in session so the new row has an owner.

## Upsert behavior and concurrency

`upsert(where, create, update)` applies `update` if a record matching `where` exists, and `create` otherwise:

```typescript
await client.data.Store.upsert(
  { id: storeId },
  { id: storeId, name: 'Seattle flagship', user_id: me },
  { name: 'Seattle flagship' },
);
```

`upsert` performs a read followed by a write, not one atomic operation. Two callers can both find no matching record and then attempt to create one, so `upsert` doesn't provide a transaction or concurrency guarantee. A field's `unique` option enforces uniqueness independently of that initial read. The app still needs to handle a rejected write.

## Write errors and user feedback

A write can fail because validation rejects a value, a policy refuses the action, or the session has expired. The following example uses `try` and `catch` to capture an update error in component state, which the UI can display:

```tsx
try {
  await client.data.Issue.update({ id }, { status: 'closed' });
} catch (error) {
  setError(error instanceof Error ? error.message : 'The update failed.');
}
```

Visible feedback tells the user that the change wasn't saved. For example, the issue model limits `title` to 200 characters, so an update with 201 characters is rejected. An error message helps the user understand the limit and revise the value.

A coding agent can also generate create and edit controls. Generated code follows the same requirements: creation supplies required fields and ownership values, relationship inputs use concrete keys, and error handling makes rejected writes visible.

## Next step

In the next exercise, you configure file storage, upload and manage photos of defective parts, and connect a photo to an issue.
