In this exercise, you preview a deployment, publish the production frontend to Microsoft Fabric, and verify the deployment's health. The previous exercise already created the app item and provisioned its backend in Fabric. You now publish the frontend to Fabric hosting and compare it with your local development session.

## Preview and deploy

1. In the project folder, preview what a deployment does without changing anything.

    ```bash
    npx rayfin up --dry-run
    ```

    Read the output. A dry run validates your local inputs and resolves the target workspace without creating or changing anything.

    You should see output similar to this anonymized example. The project path and workspace ID are placeholders, and package versions might differ. The listed operations are planned work, not changes that have already occurred.

    ```text
    ~/git/fabric-apps/adventure-dashboard  npx rayfin up --dry-run
    👀 Found Rayfin project root: <project-path>/adventure-dashboard

    🔍 DRY RUN MODE - No resources will be created or modified

    Workspace: "fabric-apps-workspace" (ID: <workspace-id>)

    Planned operations:
        ✓ Reuse the recorded workspace and keep its current capacity
        ✓ Create or reuse Rayfin item "adventure-dashboard" (AppBackend)
        ✓ POST runtime settings (auth=true, data=false)
        ✓ Declare package versions:
                • @microsoft/rayfin-auth 2.0.1
                • @microsoft/rayfin-cli 2.0.1
        ✓ Build, package, and deploy static content
        ✓ Persist deployment metadata to rayfin/.deployments.json
    ```

1. Deploy the app.

    ```bash
    npx rayfin up
    ```

    The command builds and deploys the static frontend, syncs your settings, and applies any pending schema changes in one step. If it asks for a workspace, choose the same workspace as before. It reuses the app item created by `rayfin dev`; if the item doesn't exist, it creates it.

    A successful deployment produces output similar to this anonymized example. Paths, identifiers, the publishable key, and generated hostnames are placeholders. The `staticHosting: success` result confirms that the frontend was published. Use the real portal and app URLs printed by your own deployment.

    ```text
    ~/git/fabric-apps/adventure-dashboard  npx rayfin up
    👀 Found Rayfin project root: <project-path>/adventure-dashboard
    ✅ Updated rayfin.yml configuration

    Component results:
        runtime: success
        data: disabled
        storage: disabled
        connectors: disabled
        staticHosting: success
        functions: disabled

    📝 Deployment details:
        - Rayfin Item Name: adventure-dashboard
        - Rayfin Item ID: <item-id>
        - Endpoint: https://<region>.pbidedicated.windows.net/v1/tenants/<tenant-id>/workspaces/<workspace-id>/appbackends/<item-id>/BaaSService/
        - Fabric Workspace: <workspace-id>
        - Portal: https://app.fabric.microsoft.com/groups/<workspace-id>/appbackends/<item-id>?ctid=<tenant-id>
        - Publishable Key: <publishable-key>
        - Static Hosting URL: https://<app-hostname>.webapp.fabricapps.net

    🎉 Project "adventure-dashboard" is now deployed to Fabric!
         • Open in Fabric portal: https://app.fabric.microsoft.com/groups/<workspace-id>/appbackends/<item-id>?ctid=<tenant-id>
         • Your app is live at: https://<app-hostname>.webapp.fabricapps.net
    ```

    If the command returns a 401 or 403 error, run `npx rayfin login` again and retry.

## Verify the deployment

1. Check the deployment state.

    ```bash
    npx rayfin up status
    ```

    Add `--json` if you want machine-readable output.

1. After a successful deployment, the CLI prints the hosted app URL and a link to the item in the Fabric portal. The `rayfin up status` output also includes the hosting URL. Open both links.

    In the status output, find **Portal** for the Fabric item, **Static app** for the published frontend, and **Endpoint** for the backend API. This abbreviated example uses placeholders; use the actual URLs printed by your command.

    ```text
    Rayfin Cloud Deployment Status
    Project: adventure-dashboard

    Deployment
        Endpoint:   https://<region>.pbidedicated.windows.net/v1/tenants/<tenant-id>/workspaces/<workspace-id>/appbackends/<item-id>/BaaSService/
        Portal:     https://app.fabric.microsoft.com/groups/<workspace-id>/appbackends/<item-id>?ctid=<tenant-id>
        Static app: https://<app-hostname>.webapp.fabricapps.net
    ```

1. In the portal, confirm that the `adventure-dashboard` app item is present.

## Compare with the development session

1. Open the hosted app URL in a private browser window.
1. Note the sign-in behavior. The template sets `services.staticHosting.assetAccess` to `protected`, so loading the app requires Fabric sign-in.
1. Compare the hosted app with the local one. The frontend served from the hosted URL comes from the production build that `rayfin up` uploaded.