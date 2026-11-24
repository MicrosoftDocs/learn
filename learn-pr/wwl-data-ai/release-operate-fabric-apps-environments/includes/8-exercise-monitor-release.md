In this exercise, you read App Metrics for your deployed app, diagnose a set of reported failures, and make a release decision from evidence. You then clean up.

## Generate activity and read app metrics

1. Open your deployed app in the development workspace. Sign in, load a few screens, and run a few queries.
1. In the Fabric portal, open the app item. Select **Manage app** if you're viewing the running app, and then select **Metrics**.
1. On the **App** tab, set the time range to **Last 24 hours**, and find the sign-in and app load counts. On the **Database** tab, find the query count and query error count. Activity from the current hour doesn't appear until that hour completes, so wait for the next hour if the cards are empty.

The sign-in, app load, and query counts reflect your activity from completed hours.

## Diagnose reported failures

Four reports reached the Adventure Works team. For each report, name the layer, the first check, and the narrowest fix. Don't change a lower layer to compensate for a higher one.

| # | Report |
|:--|:-------|
| 1 | `rayfin up` in the pipeline returns HTTP 403 for the production workspace. |
| 2 | A manager reports that the sign-in popup never appears on the production URL, and the browser console shows `TAB_BLOCKED`. |
| 3 | A new `Vendor` entity returns an internal server error after a deployment that reported success. |
| 4 | `npx rayfin secret set CARRIER_API_KEY` returns a permission denied error after you promote the app to production. |

Compare your answers with these:

1. **Deployment layer.** Run `npx rayfin login` again to rule out an expired session. In a pipeline, check the service principal's workspace role and the tenant setting for service principals, and grant Contributor on the production workspace.

1. **Authentication layer.** The browser blocked the popup because sign-in doesn't run directly from a click handler. Move the `ensureSignedInWithFabric()` call into a synchronous click handler. If the error were `INVALID_CALLBACK_URL` instead, you would check `allowedRedirectUris` and add only origins you control.

1. **Schema layer.** Run `npx rayfin up status`, and check the entity's `@text()` fields for a missing `max`. Add bounds, review the proposed operations, and apply the schema again.

1. **Secrets layer.** The app isn't deployed to the target, or your signed-in account lacks access to the target workspace. Run `npx rayfin up` for production, sign in with an account that has access, and set the secret again, because secret values don't travel with the app.

## Final challenge: decide whether to release

You're reviewing a proposed production release. Use only the evidence listed here, and don't repeat the earlier steps.

| Evidence source | What it shows |
|:----------------|:--------------|
| Deployment | The development deployment is healthy. The production workflow's `force` input is set to true for this run, and its dry run resolves to the development workspace ID. |
| Sharing | The inventory connector uses delegated access. Two store managers who must receive the app lack access to the warehouse that the connector reads. |
| Monitoring | In App Metrics for the development app, sign-ins are normal, but the query error rate rose after the last schema change. |

Based on this evidence, would you release the app or stop the release? Explain your decision, which problems you would fix first, and what evidence you would gather before you proceed.

Compare your decision with this guidance: stop. The workflow targets the wrong workspace, `force` is enabled without a reviewed destructive change, two recipients lack access to a delegated source, and the rising error rate suggests a schema problem. Fix the target, turn off `force`, and investigate the error rate at the schema layer first. Then grant the two recipients access to the warehouse, or plan to switch the connector's identity. Gather a clean dry run that names the production workspace, a healthy deployment status, a normal query error rate, and a successful read for a recipient before you release.

## Clean up

1. Delete the test app items from your development and production workspaces. Then check each workspace for leftover child items, such as the SQL database, and remove them.
1. Delete the workspaces if you created them only for this module.
1. Delete the GitHub environments and their secrets, and delete the service principal's client secret, if you don't plan to reuse them. This module is the last in the learning path, so no later exercise depends on them.
1. Remove any lab-only permissive policies and test data before you reuse the project outside the exercise.

