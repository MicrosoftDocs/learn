The Adventure Works Cycles recall notice must be visible without sign-in, but issue reports must never be. This unit shows when anonymous access fits, which controls govern it, and how to prove that everything else stays denied.

## When anonymous access fits

Anonymous access lets unauthenticated users perform selected data operations. It is an authorization option, not a replacement for authentication. Use it when the app must offer limited functionality without sign-in:

| Scenario | Recommended scope |
|:---------|:------------------|
| Public reference data, such as a recall notice | `read` |
| Feedback or a survey response | `create` |

Don't use anonymous access when the app must identify the user, enforce ownership, or apply identity claims. The `anonymous` role has no claims to compare, so policies like `claims.sub.eq(item.user_id)` don't apply. Anyone who can reach the app URL can use the operations you grant, so never expose personal, confidential, financial, or internal data.

## Controls that govern anonymous access

Anonymous access depends on independent controls, and enabling one of them doesn't grant it:

- **A tenant setting.** A Fabric tenant administrator must enable **Enable anonymous data access for Fabric Apps (Preview)**. It's off by default, and the administrator can limit it to security groups. If it's limited to groups, the app owner must be in one of them, because the owner applies the schema.
- **An entity role.** The entity uses `@anonymous()` with the narrowest set of actions.

> [!NOTE]
> Anonymous requests also need app-level access to the app's data service.

You can combine roles on one entity when public and signed-in users need different access:

```typescript
@entity()
@anonymous('read')
@authenticated(['create', 'update', 'delete'], {
  policy: (claims, item) => claims.sub.eq(item.createdBy),
})
export class RecallNotice { /* fields */ }
```

Apply these guidelines whenever you grant anonymous access:

- Grant the minimum. Prefer `read` or `create` alone.
- Limit exposed fields with `include` or `exclude`.
- Plan for untrusted input, because public writes attract spam and automation.

## Static hosting isn't API protection

The `services.staticHosting.assetAccess` setting in `rayfin.yml` controls who can load your frontend files. Set it explicitly: `protected` requires Fabric sign-in to load the app, and `public` allows anyone to load it. This setting covers only static assets. A protected frontend doesn't protect the data API, and a public frontend doesn't make data public. The data API is protected by the entity permissions you write. The tenant setting for anonymous access covers the data API only, and public hosting is configured separately.

:::image type="content" source="../media/hosting-vs-data-permissions.png" alt-text="Diagram separating frontend access in rayfin.yml from data API access governed by entity permissions and the anonymous-access tenant setting.":::

## Verify that denied stays denied

A permission you haven't tested is an assumption. Test operations directly against the server and not only through your UI:

- **A record owned by someone else.** With one signed-in user, a lab entity that allows creating a record with any owner lets you confirm that owner-only rules hide and protect it.
- **A request without a session.** Sign out and call the same query. The server should reject it.
- **Operations omitted from a role.** Confirm that each action you didn't grant is rejected.

You don't need a second user for these checks. They prove that row policies run on the server and that authentication is required.

In the next exercise, you check hosting and anonymous access settings without enabling anonymous access, and you confirm that an unauthenticated request is denied.