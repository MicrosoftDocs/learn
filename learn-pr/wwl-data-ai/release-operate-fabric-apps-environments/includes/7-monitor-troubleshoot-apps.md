After release, you need to know how the Adventure Works Cycles app behaves and where a failure sits. This unit introduces App Metrics for monitoring and a layered routine for diagnosing problems.

## Monitor with app metrics

App Metrics is built into the Fabric portal and needs no instrumentation in your code. To open it, you need Write permission on the app. Open the app item, select **Manage app** if you're viewing the running app, and then select **Metrics**. 

:::image type="content" source="../media/fabric-apps-metrics.png" alt-text="Screenshot of the Fabric App Metrics page with the App tab selected, showing sign-in counts and app load charts for the last 30 days." lightbox="../media/fabric-apps-metrics.png":::

Tabs group the metrics:

| Tab | Examples |
|:----|:---------|
| **App** | Sign-ins (including silent sign-ins) and app loads (each time `index.html` is served) |
| **Database** | Query count, query error count and rate, and average query duration |
| **Storage** | Request count and error rate |
| **Functions** | Invocations, failed invocations, error rate, and average duration |
| **Connectors** | Request count, failed requests, error rate, and average duration, excluding semantic model connectors |

Charts use UTC and completed intervals. The **Last 24 hours** range excludes the current hour, and the **Last 7 days** and **Last 30 days** ranges exclude the current day, so activity from a few minutes ago might not appear yet. A GraphQL response can contain errors even when its HTTP status is `200 OK`, so use the query error count and rate to find those failures.

App Metrics is not a capacity report. It shows how an app is used, not what the capacity costs. For consumption, use the Fabric Capacity Metrics app. It also provides no browser performance measurements, custom logs, or individual error drill-down.

Rayfin also offers application telemetry (`rayfin telemetry`), which sends page views, events, and logs to an Application Insights resource that Fabric associates with the app. It's experimental in Rayfin 2.0, and the service must make it available in the target workspace, so treat it as awareness only. App Metrics is the monitoring path for this module.

## Diagnose by layer

Failures look similar from the outside, so start with the layer. Each layer has typical signals and a first check.

| Layer | Typical signals | First check |
|:------|:----------------|:------------|
| Deployment | `rayfin up` returns HTTP 401 or 403, or the static deployment fails with a size limit error | Run `npx rayfin login` again, then `npx rayfin up --dry-run`. For a service principal, check its workspace role. For the size limit, reduce the build output. |
| Authentication | `TAB_BLOCKED`, `INVALID_CALLBACK_URL`, `FABRIC_AUTH_TIMEOUT`, `ACCESS_DENIED`, or `APP_ADMIN_BLOCKED` | Call sign-in from a click handler, check `returnOrigin` and `services.auth.allowedRedirectUris`, and check item permissions and whether an administrator blocked the app |
| Schema | `rayfin up db apply` fails, or new entities return an internal server error after a successful deploy | Run `npx rayfin up status`, check `@text()` fields for a missing `max`, and make sure the remote schema matches the code |
| Secrets | `rayfin secret set` or `rayfin secret list` returns permission denied | Run `npx rayfin up` to provision the app, sign in with an account that has access to the workspace, and retry |
| Access | A user opens the app but sees no data | Trace the layers from the previous unit |

The deployment layer fails when the compressed static archive exceeds 100 MB. Exclude source maps from production builds, optimize large images, and move binary files to Storage.

Two details come up often. The `INVALID_CALLBACK_URL` and origin mismatch errors mean that the app's return origin isn't in `allowedRedirectUris`, so add the origin only if you control it, and run `npx rayfin up` after you change `rayfin.yml`. The schema layer treats the app code as the source of truth, so don't change the remote database through the portal or SQL tools. Renaming, retyping, or removing a column isn't supported, and `--force` can cause permanent data loss, so review the proposed operations before you use it.

Secret commands use a masked prompt. In a CI job, where no interactive terminal exists, the command doesn't prompt. Pipe the value with `--stdin`, or load several secrets with `--env-file`, and keep the values out of shell history and source control. Secret values live in each deployed app item, so set them again in every stage.

## A repeatable routine

1. Reproduce the failure, and record the exact message and code.
1. Identify the layer from the message. Don't change anything yet.
1. Check status, permissions, or configuration for that layer.
1. Make the narrowest change that fixes it.
1. Verify the fix from the user's point of view, and then check App Metrics for the pattern you expect.

Never fix a layer by weakening a lower one. For example, don't widen entity policies to compensate for missing source access.

## Next step

In the final exercise, you generate app activity, read App Metrics, diagnose a supplied set of failures, and make a release decision with evidence.
