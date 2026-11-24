In this exercise, you sign in with the Rayfin CLI and run the scaffolded app in a development session. You then identify which parts of the session run on your machine and which run in Fabric.

## Sign in and start the development loop

1. Open a terminal in the `adventure-dashboard` project folder. If you're still in the parent folder where you scaffolded the app, run:

    ```bash
    cd adventure-dashboard
    ```

1. Sign in to Fabric from the CLI. A browser window opens for Microsoft Entra ID sign-in.

    ```bash
    npx rayfin login
    ```

    Run this command from the project root so npm uses the `rayfin` executable installed with `@microsoft/rayfin-cli`. Outside the project, npm might try to download a different package named `rayfin` and return a package-not-found error.

    After you complete browser sign-in, you should see output similar to the following example. The email address is fictional, and the tenant ID and expiration value are placeholders.

    ```text
    ~/git/fabric-apps  cd adventure-dashboard
    ~/git/fabric-apps/adventure-dashboard  npx rayfin login
    🔑 Opening browser for sign-in...

    ✅ Signed in successfully
       User:      developer@example.com
       Tenant:    <tenant-id>
       Expires:   <expiration-date-and-time>
    ```

    The browser displays a sign-in confirmation. Return to the terminal and wait for **Signed in successfully** before continuing.

    :::image type="content" source="../media/command-line-sign-in-confirmation.png" alt-text="Screenshot of the Rayfin CLI browser confirmation showing Sign-in received and asking you to return to the terminal to finish signing in.":::

    If sign-in fails because the operating system keychain isn't available, you can add `--encryption-fallback-enabled` in a development container. That option stores tokens in plaintext, so don't use it on a personal machine.

1. Start the development loop. The `dev` script runs `rayfin dev`, not plain Vite.

    ```bash
    npm run dev
    ```

1. If the CLI asks which workspace to use, choose the workspace you used when you scaffolded the project. If it asks for consent to provision the backend, accept.

1. Wait for the terminal to print the local URL. The preferred port is `5173`.

    On the first run, you should see output similar to the following example. Your workspace name, Vite version, and startup time might differ. The **Created Fabric backend** message confirms backend provisioning, and **Local** shows the URL for your frontend.

    ```text
    ~/git/fabric-apps/adventure-dashboard  npm run dev

    > adventure-dashboard@0.0.0 dev
    > rayfin dev

    ? Choose a Fabric workspace for this deployment: Select existing workspace
    ? Which Fabric workspace should the "adventure-dashboard" backend live in? fabric-apps-workspace
    Preparing Fabric backend "adventure-dashboard" in "fabric-apps-workspace"...
    Created Fabric backend "adventure-dashboard" in "fabric-apps-workspace".

    > @rayfin-app/frontend@0.0.0 dev
    > vite


      VITE v8.3.8  ready in 1037 ms

      ➜  Local:   http://localhost:5173/
      ➜  Network: use --host to expose
    ```

1. Open the local URL in a browser. The template signs you in with your `rayfin login` session when the app has protected hosting. If the app shows a sign-in prompt instead, sign in with your Fabric account.

    You should see the default Fabric Apps home page, similar to the following screenshot.

    :::image type="content" source="../media/fabric-app-home.png" alt-text="Screenshot of the default Fabric Apps home page with tiles for screens, insights, business rules, records, secure actions, data, and appearance.":::

> [!NOTE]
> The first run provisions the app backend in Fabric and creates an app item in your workspace, so it takes longer than later runs. Seeing this item in the portal doesn't mean the production frontend has been published. During this development session, the backend runs in Fabric, but you open the frontend at the local URL. In the next exercise, `rayfin up` builds and publishes the frontend to Fabric hosting.

## Identify what runs where

1. Read the terminal output from `rayfin dev`. It signs in, provisions or reuses the backend in Fabric, applies settings from `rayfin/rayfin.yml`, writes `rayfin/.env`, and then starts the frontend. For the full list of startup steps, see [Develop locally](https://rayfin.ai/docs/start/develop-locally).

1. In a second browser tab, open the Fabric portal and the workspace. Find `adventure-dashboard`, listed with the **App** type.

    The `adventure-dashboard` app item appears after `rayfin dev` provisions the backend. Its presence doesn't mean the production frontend has been published.

    :::image type="content" source="../media/fabric-app-portal.png" alt-text="Screenshot of the fabric-apps-workspace in the Fabric portal showing adventure-dashboard listed as an App item.":::

1. Open `rayfin/.env`. Find the `RAYFIN_PUBLIC_*` values, such as the API URL and workspace ID. These values point your local frontend at the Fabric backend.

    Your file should look similar to this anonymized example. The region, tenant ID, workspace ID, item ID, and publishable key are placeholders. Keep the values generated for your own project.

    ```dotenv
    # Rayfin environment configuration
    # Auto-managed by `rayfin dev` and `rayfin up` - safe to hand-edit.

    RAYFIN_WORKSPACE_NAME=fabric-apps-workspace
    RAYFIN_PUBLIC_API_URL=https://<region>.pbidedicated.windows.net/v1/tenants/<tenant-id>/workspaces/<workspace-id>/appbackends/<item-id>/BaaSService/
    RAYFIN_PUBLIC_PUBLISHABLE_KEY=<publishable-key>
    RAYFIN_PUBLIC_ITEM_ID=<item-id>
    RAYFIN_PUBLIC_WORKSPACE_ID=<workspace-id>
    RAYFIN_PUBLIC_TENANT_ID=<tenant-id>
    RAYFIN_PUBLIC_PORTAL_URL=https://app.fabric.microsoft.com
    RAYFIN_PUBLIC_FRONTEND_PORT=5173
    ```

`rayfin dev` provisions or reuses the backend in Fabric, but never builds or uploads the production frontend. Keep using the local URL to view the frontend until you publish it with `rayfin up`.

## Try it with a coding agent (optional)

You can ask a coding agent such as GitHub Copilot to run the same steps. Review the generated files and command output before you let the agent deploy anything. This prompt comes from the Fabric Apps quickstart:

```text
Set up a new Fabric App project called "rayfin-app-ws".

1. Run: npx -y @microsoft/create-rayfin@latest --project-name rayfin-app-ws --template blankapp
2. Open the scaffolded project directory.
3. Explore the project structure and understand the Rayfin app framework.
4. Run: npm run dev
5. Make changes to the app based on my instructions.
6. When ready, deploy with: npx rayfin up
```

## Stop the session

Press **Ctrl+C** in the terminal to stop the local frontend. The Fabric backend is durable, so stopping the session doesn't delete it.

## Check your understanding

- Which part of the app runs on your machine during `rayfin dev`, and which part runs in Fabric?
- After you stop the session, does the app item still exist in the workspace?

The frontend dev server runs locally. The backend (database, authentication, and API) runs in Fabric. The app item stays in the workspace after you stop the session.
