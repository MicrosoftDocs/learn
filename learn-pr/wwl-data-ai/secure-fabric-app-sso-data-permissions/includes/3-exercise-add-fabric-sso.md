In this exercise, you review the sign-in setup in your Fabric Apps project, add sign-in and sign-out controls that show errors, and confirm that allowed redirect origins are scoped. You use the same project for the rest of the module.

## Prepare the project

Use a Universal App project that runs with `npm run dev` and has the data service enabled. If you don't have a project, create one with `npm create @microsoft/rayfin@latest`, and then run `npx rayfin login`. If your project doesn't have the data service, run `npm run pack:add -- data-modeling` from the project root. That capability pack enables the data service and adds a starter `Item` entity with owner-scoped access.

The Universal App template already includes Fabric auth wiring and a configured client in `packages/frontend`, so you adapt existing code instead of starting from nothing. In Rayfin 2.0, the client comes from `RayfinClient.create()` with `browserSession()` as its `auth` adapter. A client without `browserSession()` has no `client.auth` and can't use Fabric SSO.

## Review the configuration

1. Open `rayfin/rayfin.yml`. Find `services.auth`.
1. Confirm that `enabled` and `fabric.enabled` are `true`, and that `allowedRedirectUris` contains `http://localhost:5173`. Remove any origin that you don't control.
1. Run `npm run dev`. If you edited `rayfin.yml`, restart the session, because auth settings changes need a backend restart or a redeploy.

## Add sign-in and sign-out controls

1. Open `packages/frontend/src/lib/rayfin-client.ts` and locate `RayfinClient.create()`.

1. Open `packages/frontend/src/services/rayfin-auth.service.ts` and locate the call to `ensureSignedInWithFabric()` in its `signIn()` method.

1. Review `packages/frontend/src/hooks/auth.context.ts` to see the session state and sign-in controls exposed by `useAuth()`.

1. Create `packages/frontend/src/SessionPanel.tsx` and add the following code. Reuse the existing auth context and shared client rather than creating a separate client or duplicating the Fabric sign-in configuration.

    ```tsx
    import { useState } from 'react';

    import { useAuth } from './hooks/auth.context';
    import { getRayfinClient } from './lib/rayfin-client';

    export function SessionPanel() {
      const { session, isAuthenticated, signIn, isSigningIn, signInError, canSignIn } = useAuth();
      const [error, setError] = useState('');
      const [isSigningOut, setIsSigningOut] = useState(false);

      async function signOut() {
        setError('');
        setIsSigningOut(true);
        try {
          const client = await getRayfinClient();
          await client.auth.signOut();
        } catch (error) {
          setError(error instanceof Error ? error.message : 'Sign-out failed.');
        } finally {
          setIsSigningOut(false);
        }
      }

      return (
        <div className="flex flex-wrap items-center gap-300 p-400">
          {isAuthenticated ? (
            <>
              <span>{session?.user?.email ? `Signed in as ${session.user.email}` : 'Signed in'}</span>
              <button onClick={signOut} disabled={isSigningOut}>
                {isSigningOut ? 'Signing out...' : 'Sign out'}
              </button>
            </>
          ) : (
            <button onClick={signIn} disabled={!canSignIn || isSigningIn}>
              {isSigningIn ? 'Signing in...' : 'Sign in with Fabric'}
            </button>
          )}
          {(error || signInError) && <p role="alert">{error || signInError?.message}</p>}
        </div>
      );
    }
    ```

1. Open `packages/frontend/src/App.tsx` and add the following import alongside the existing imports:

    ```tsx
    import { SessionPanel } from './SessionPanel';
    ```

1. In the JSX returned by `App`, locate the existing `<header>` element and add `<SessionPanel />` inside it, after the app title or navigation. Keep the existing header content and page content. If the header is a separate component, add the import and `<SessionPanel />` in that component instead, and adjust the import path relative to its file.

    The header includes the panel as follows:

    ```tsx
    <header>
      <SessionPanel />
    </header>
    ```

    If the app doesn't have a header, add this element before the main content inside the component's existing JSX wrapper. Keep the existing auth provider and `AuthGate` in place. When the gate hides the app after sign-out, its sign-in screen handles the next sign-in.

1. Save your changes and open the local app at the URL printed by `npm run dev`. After authentication completes, confirm that the header shows your email and **Sign out**. If the session doesn't include an email, the panel shows **Signed in** instead.

  The existing auth service resolves the Fabric sign-in configuration. `useAuth()` provides the current session, sign-in state, and sign-in errors, so the panel doesn't need its own `fabricOptions` object or session subscription. The sign-out handler awaits `getRayfinClient()` to use the same configured client as the rest of the app. It disables the button while sign-out is in progress and displays any failure in an alert.

## Verify both states

1. In the app, sign out and confirm that the existing auth gate hides the protected content and shows its sign-in screen.

1. Select the sign-in button, and close the sign-in window before you finish. Confirm that the sign-in screen shows an error message instead of nothing. The message comes from the `FABRIC_AUTH_POPUP_CLOSED` error.

  :::image type="content" source="../media/sign-in-canceled.png" alt-text="Screenshot of the Fabric app sign-in screen showing an error that sign-in was canceled because the sign-in window was closed.":::

1. Select the button again and complete sign-in. Confirm that your email appears with a **Sign out** button.

## Explain the result

The sign-in call runs from the click handler because the popup flow can be blocked when it runs on page load or after an unrelated `await`. The auth provider catches sign-in failures and exposes them through `signInError`. The panel displays that message when it's rendered, while the existing auth gate handles the signed-out screen. Sign-out failures appear through the panel's own error state.

The redirect list matters for a different reason. Each origin in `allowedRedirectUris` can receive a Fabric SSO handoff for your app, so an origin you don't own, or a wildcard, lets another site start a sign-in against your backend. After you deploy in a later exercise, `rayfin up` adds the deployed origin to this list. Review the list again then.
