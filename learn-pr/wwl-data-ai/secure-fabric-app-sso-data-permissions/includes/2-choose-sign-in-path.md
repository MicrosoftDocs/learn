You need store managers at Adventure Works Cycles to sign in before they see any issue reports. This unit compares the sign-in paths that Fabric Apps offers so you can choose the one that fits the app and configure it safely.

## Choose a sign-in path

Deployed Fabric apps authenticate with Microsoft Entra ID only. There is no separate login form, and you don't add alternate sign-in UI. Authentication must be enabled for an app to deploy. Email-and-password sign-in works only against a local backend, not a deployed one.

Because the identity provider is fixed, your decision is which path installs the session. Every path installs the same opaque session on `client.auth`, and the client's registered services then send the signed-in context automatically.

:::image type="content" source="../media/fabric-apps-sign-in-paths.png" alt-text="Diagram of Fabric SSO popup, embedded SSO, delegated Entra token sign-in, and external embed host paths.":::

The Adventure Works app is a standalone web app that managers open from a link, so the popup flow is the right choice. Many apps support both the popup and embedded flows so they work wherever a manager opens them.

## Understand the Fabric SSO flows

In the popup flow, a button click calls `ensureSignedInWithFabric()`. The SDK opens a Fabric broker window, exchanges a handoff code protected with Proof Key for Code Exchange (PKCE), and installs a session. PKCE binds the code to a random verifier that the SDK creates for that sign-in attempt. To exchange the code, the SDK must present the matching verifier, so someone who intercepts only the code can't use it to obtain a session. The SDK handles this protection automatically. No callback page is required.

In the embedded flow, the Fabric portal loads your app in an iframe, and `initEmbeddedAuth()` requests a handoff from the parent without a popup.

:::image type="content" source="../media/popup-vs-embedded-flow.png" alt-text="Diagram comparing popup and embedded Fabric sign-in flows, including handoff codes, PKCE verification, and session setup.":::

Two timing rules matter:

- **Call `ensureSignedInWithFabric()` from a user gesture,** such as a click handler. Calling it on page load or after an unrelated `await` can trigger popup blockers.
- **Await `initEmbeddedAuth()` once at startup** before you render authenticated content. It never opens a popup and never rejects. It resolves to `null` when the app isn't embedded, so you then show a sign-in button.

## Use token exchange or an external host

`signInWithEntraToken()` exchanges a delegated Entra token that your code already holds for a Rayfin session. An external embed host lets a trusted parent portal broker sign-in for the embedded app, and the portal never sends its own token to the iframe. Both paths need `services.auth.fabric.externalEntraExchange: true` in `rayfin/rayfin.yml` and **Execute** permission on the item. 

```yaml
services:
  auth:
    enabled: true
    fabric:
      enabled: true
      externalEntraExchange: true
```

The exchange needs a delegated token issued in the item's owning tenant, and it doesn't support app-only service principal tokens. Your identity library acquires the token. The Rayfin SDK doesn't.

## Configure redirect origins and sign-in errors

### Scope redirect origins

Enable the auth service and the Fabric provider in `rayfin/rayfin.yml`:

```yaml
services:
  auth:
    enabled: true
    allowedRedirectUris:
      - http://localhost:5173
    fabric:
      enabled: true
```

`allowedRedirectUris` lists bare origins, such as `http://localhost:5173` or `https://app.example.com`, that can complete sign-in. Treat it as a security boundary. `rayfin up` adds the deployed origin, and you keep the list limited to your own origins. A broad list lets another site start a sign-in against your backend.

### Show sign-in errors

`ensureSignedInWithFabric()` rejects with an error that has a user-safe `message` and a `code`. Catch every sign-in call and show `error.message`. Never swallow the error with an empty `catch`, because a silent failure leaves the user with no explanation. Use `code` only for branching. For example, `FABRIC_AUTH_POPUP_CLOSED` means the user closed the sign-in window, and `TAB_BLOCKED` means the browser blocked the popup.

In the next exercise, you review the template's sign-in code, add sign-out, and make sign-in errors visible.
