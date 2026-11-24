Signed-in managers at Adventure Works Cycles should see only their own reports, even if someone calls the API directly. This unit teaches you to express that rule on the data model, so the server enforces it on every request.

## Permissions live on the entity

You declare permissions as decorators on the entity class. When you apply the schema, Rayfin compiles them into server-side data access rules. There is no separate permissions file to keep in sync, and the rules run whether a request comes from your UI or from anyone else.

Rayfin recognizes two built-in roles: `anonymous` for public access, and `authenticated` for a signed-in session. Use the shorthand decorators `@authenticated()` and `@anonymous()`:

```typescript
@authenticated(actions, options)   // same as @role('authenticated', ...)
@anonymous(actions, options)       // same as @role('anonymous', ...)
```

> [!NOTE]
> Documentation often show `@role('authenticated', ...)`. The two forms are equivalent, and the shorthand reads better at the call site. The `role()` form accepts only the role names `authenticated` and `anonymous`.

The `actions` argument specifies which operations the permission allows. Use a single value, such as `'read'`, or an array, such as `['read', 'update']`. Use `'*'` to allow all four operations: create, read, update, and delete. If you omit `actions`, it defaults to `'*'`.

Every entity needs an explicit permission decorator. If you omit permission decorators, the entity receives `authenticated: *` by default. This lets any signed-in user create, read, update, and delete all rows. Don't rely on that default.

## Restrict rows with a policy

A `policy` limits which rows a role can act on. It compares claims from the signed-in user to fields on the row:

```typescript
@authenticated('*', {
  policy: (claims, item) => claims.sub.eq(item.user_id),
})
```

The supported base claims are `claims.sub` (the user's ID), `claims.email`, and `claims.role`. Operators include `eq` and `neq`, and you combine conditions with `and` and `or`. The `item` object autocompletes from the class, so renaming a field is a compile-time error everywhere it's used.

Two points prevent common mistakes:

- **Policies check ownership but don't fill it in.** When your code creates a row, set the owner field itself, for example from `session.user.id`. In a function, set it from `ctx.user.id`.
- **A policy compares a claim to a field on the same row.** It can't join to another table. Sharing across an organization needs a stored `organization_id` and a membership entity, or an app-defined claim.

For Adventure Works, store managers see their own reports with an owner policy. A regional lead who needs a wider view is a different identity, and you can layer a role-based override on the same rule:

```typescript
@authenticated('*', {
  policy: (claims, item) =>
    claims.role
      .eq('admin')
      .or(claims.sub.eq(item.user_id)),
})
```

This rule lets a caller whose `role` claim is `admin` act on every row, and lets everyone else act only on rows they own. `claims.role` carries a value only when the sign-in produces one, so confirm that your sign-in actually supplies the role before you depend on it. Scoping rows to a region needs a region value on the signed-in identity. App-defined claims can supply it, but they're outside this module.

## Restrict fields and actions

Use `include` or `exclude` in the options to control which fields a role can see or write:

```typescript
@authenticated('read', { exclude: ['internalNote'] })
```

`exclude` hides a field from reads while leaving it writable on create and update. `include` lists the only fields a role can touch, which suits a restricted create form.

When rules differ per action, apply several decorators with one action each. The platform aggregates every decorator on the class per role:

```typescript
@entity()
@authenticated('create')
@authenticated(['read', 'update', 'delete'], {
  policy: (claims, item) => claims.sub.eq(item.user_id),
})
export class LabIssueReport { /* fields */ }
```

Conflicting rules for the same role and action produce a warning when the schema is generated.

## Keep the UI honest about the server

Because the server enforces permissions, a denied request returns an error to your UI. Don't hide a failure. Show the error so the user knows the action was refused.

> [!IMPORTANT]
> Never treat the UI as a security boundary. Protected static hosting controls who can load your frontend files. It doesn't replace authorization on the data API.

In the next exercise, you write owner-only rules for a lab entity, create a record owned by someone else, and watch the server refuse to show or change it.
