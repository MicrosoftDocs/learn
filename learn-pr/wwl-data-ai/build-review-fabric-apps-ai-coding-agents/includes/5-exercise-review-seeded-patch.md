In this exercise, you review a patch that contains deliberate defects. Agent output varies from run to run, so a supplied patch makes sure that you practice the review on defects that are always present. You never apply or deploy this patch. If the diff from your own agent run contains defects, review those too.

## The patch

Read this patch as if the agent proposed it. It adds vendor tracking to a Universal App. The key and the origin in the patch are fictional. The request path is illustrative, because the defect is that the code bypasses the typed client.

```diff
--- /dev/null
+++ b/packages/data/src/Vendor.ts
@@
+import { entity, uuid, text, email } from '@microsoft/rayfin-core';
+
+@entity()
+export class Vendor {
+  @uuid() id!: string;
+  @text() name!: string;
+  @email({ max: 254 }) contactEmail!: string;
+}
--- /dev/null
+++ b/packages/frontend/src/vendors/vendorApi.ts
@@
+const PARTNER_API_KEY = 'sk-live-3f9a1c7e5b2d4a60';
+
+export async function listVendors() {
+  const res = await fetch(`${import.meta.env.VITE_RAYFIN_API_URL}/api/graphql`, {
+    method: 'POST',
+    headers: { 'Content-Type': 'application/json', 'x-partner-key': PARTNER_API_KEY },
+    body: JSON.stringify({ query: '{ vendors { items { id name contactEmail } } }' }),
+  });
+  return (await res.json()).data.vendors.items;
+}
--- a/packages/frontend/package.json
+++ b/packages/frontend/package.json
@@
   "dependencies": {
-    "@microsoft/rayfin-data": "2.0.0",
+    "@microsoft/rayfin-data": "1.36.2",
     "@microsoft/rayfin-client": "2.0.0",
     "@microsoft/rayfin-auth": "2.0.0"
   }
--- a/rayfin/rayfin.yml
+++ b/rayfin/rayfin.yml
@@
     allowedRedirectUris:
       - http://localhost:5173
+      - https://vendor-preview.example.net
```

## Review the patch

1. Read the patch with the review checklist from the previous unit. Don't run any commands yet.
1. List every problem you find. For each one, write the file, the problem, and why it matters.
1. Compare your list with the findings below.

## Findings

| # | Where | Problem | Why it matters |
|:--|:------|:--------|:---------------|
| 1 | `Vendor.ts` | The entity has no permission decorator. | The platform silently grants `authenticated: *`, which is full create, read, update, and delete access for any signed-in user. Owner data needs an explicit owner policy. |
| 2 | `Vendor.ts` | `@text()` on `name` has no `max`. | The column becomes `NVARCHAR(MAX)`, which can break GraphQL schema generation after a deployment that reports success. |
| 3 | `vendorApi.ts` | A live key is hard-coded in frontend code. | Anything in frontend code is visible to every user. Secrets belong in a function, read through `ctx.Secrets`. |
| 4 | `vendorApi.ts` | Raw `fetch` and hand-built GraphQL replace the typed client. | The typed client adds the session and type safety. Hand-built requests bypass both. |
| 5 | `packages/frontend/package.json` | `rayfin-data` is on `1.36.2` while the other packages are `2.0.0`. | Mixed versions produce type errors or two copies of the data package. |
| 6 | `rayfin/rayfin.yml` | A redirect origin that isn't the app's own is allowed. | `allowedRedirectUris` controls where sign-in callbacks can land, so keep it scoped to the app's own origins. |

The entity also lacks a `user_id` field, so an owner-only policy has nothing to compare. Add it when you fix finding 1. The patch also has no code that sets `user_id` on create, so the screen that uses the entity needs one more check in a later exercise.

## Fix the permission gap

Fix the gap in a throwaway entity so that the result doesn't depend on what your agent produced.

1. On your `vendor-feature` branch, in `packages/data/src/`, create `VendorDraft.ts` with the same fields as the patch.
1. Add an owner field, a bounded `name`, and an explicit owner-only permission decorator.

    ```typescript
    import { entity, authenticated, uuid, text, email } from '@microsoft/rayfin-core';

    @entity()
    @authenticated('*', { policy: (claims, item) => claims.sub.eq(item.user_id) })
    export class VendorDraft {
      @uuid() id!: string;
      @text({ max: 100 }) name!: string;
      @email({ max: 254 }) contactEmail!: string;
      @text({ max: 128 }) user_id!: string;
    }
    ```

1. Build the data package to type-check the entity.

    ```bash
    npm run -w @rayfin-app/data build
    ```

    The build completes without errors.

1. Don't register or deploy the draft. Delete `VendorDraft.ts` when you finish.
1. Open your own `Vendor` entity from the previous exercise, and compare its decorator, field bounds, and `user_id` field with the draft. Fix any gap you find.

## Read a destructive-change exhibit

Agents can also propose a schema change that needs `--force`. Read this illustrative excerpt, which paraphrases what the CLI reports, and answer the question. You don't run it.

```text
Proposed change: remove field Vendor.contactEmail
CLI: blocked, because this change could cause data loss (drops column contactEmail).
Agent suggestion: re-run `npx rayfin up db apply --force`.
```

Before you approve `--force`, which three things do you check? Compare with this answer: which operations the CLI listed, which data they affect, and whether the loss is acceptable.

## Check your understanding

- Which finding could the compiler never detect, and why?
- Why do you fix permission gaps yourself instead of asking the agent to guess?

The hard-coded key compiles, and so does a missing permission decorator. Permissions express a decision about who can access data, so they need your judgment.
