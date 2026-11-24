In this exercise, you inspect the controls that govern hosting and anonymous access without enabling anonymous access. You then confirm that a request without a session is denied.

## Inspect the controls

1. Open `rayfin/rayfin.yml` and find `services.staticHosting.assetAccess`. Note whether it's `protected` or `public`. The Universal App template sets `protected`.
1. Search your data package for `@anonymous` or `@role('anonymous')`. Confirm that no entity grants anonymous access. The entities in this module use `@authenticated()` only.
1. Decide who can change the tenant control. The **Enable anonymous data access for Fabric Apps (Preview)** setting belongs to a Fabric tenant administrator, and it's off by default. Don't ask for it to be enabled for this exercise.

## Send a request without a session

1. Add this function inside `PermissionLab`, next to `run`, and a second button that calls it.

    ```tsx
    async function unauthenticatedCheck() {
      await client.auth.signOut();
      await attempt('Read without a session', () =>
        client.data.LabIssueReport.select(['id', 'title']).execute());
    }
    ```

    ```tsx
    <button onClick={unauthenticatedCheck}>Run signed-out check</button>
    ```

1. Run the app, sign in, and then select **Run signed-out check**. If the template's sign-in gate hides `PermissionLab` after sign-out, read the result in the browser console, because `attempt` also writes each line there.
1. Confirm that the call is rejected, or at minimum that it returns no rows. Open the **Network** tab, find the request, and note its status code and message.
1. Sign in again, run **Run permission check**, and confirm that your own record is visible again.

The call reached the data API through the same client, with no session. The server refused it, regardless of what your UI would have shown.