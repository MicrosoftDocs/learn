In this exercise, you create a new starter app and deploy it to separate development and production workspaces. You preview the production deployment and verify the active target.

## Prerequisites

You don't need to complete another exercise or bring an existing app. You need:

- A Microsoft Fabric account in a tenant where Fabric Apps is enabled.
- Access to a Fabric trial or paid capacity, permission to create workspaces, and permission to assign those workspaces to the capacity. Ask your administrator for help if you don't have these permissions.
- Node.js 24 with npm, and Visual Studio Code with a Bash terminal available.

A trial capacity allows only a few SQL databases, and each deployed app creates one. Ensure that your capacity has room for two app deployments. Use only test data in this exercise.

## Create the workspaces

1. Open the [Fabric portal](https://app.fabric.microsoft.com), and sign in with your Fabric account.
1. Select **Workspaces**, and then **New workspace**. Name the workspace **Adventure Works Dev**.
1. In the workspace's license settings, select your Fabric trial or paid capacity, and save the workspace. If you can't assign a capacity, ask your administrator to do so before you continue.
1. Repeat the process to create **Adventure Works Prod** on the capacity. This is a practice production workspace, not a workspace that serves real users.

## Create a starter app

1. Open Visual Studio Code and a Bash terminal in a local folder where you keep your projects. Use a new folder name so that you don't overwrite an existing app.
1. Create a project from the CLI's bundled default template without installing its dependencies yet.

    ```bash
    npm exec --package=@microsoft/rayfin-cli@2.0.1 -- rayfin init adventure-release-lab --template blankapp --skip-install
    ```

    If prompted, use **adventure-release-lab** as the project name. The default template supplies an authenticated welcome page and the configuration needed to deploy it. You don't need to add connectors, functions, or custom app features.

1. Enter the generated folder, and install its dependencies.

    ```bash
    cd adventure-release-lab
    npm install
    ```

1. Open the generated folder in Visual Studio Code, and run the build from its root terminal.

    ```bash
    npm run build
    ```

    Confirm that the build succeeds before you deploy. Run all remaining CLI commands from this project root, which contains `package.json` and the `rayfin` folder.

## Deploy to development

1. Sign in, and deploy to the development workspace.

    ```bash
    npm exec -- rayfin login
    npm exec -- rayfin up --workspace "Adventure Works Dev"
    npm exec -- rayfin up status
    ```

1. If the CLI asks for consent to create or reuse an item, or to assign capacity, accept for the development workspace only.

1. In the Fabric portal, open the development workspace and confirm that the app item exists. Open the app, sign in if prompted, and confirm that its welcome page appears.

The status command reports a healthy deployment, and the development workspace contains one app item.

## Preview and deploy to production

1. Preview the production deployment, and read the output.

    ```bash
    npm exec -- rayfin up --workspace "Adventure Works Prod" --dry-run
    ```

    Example output follows. The local path and workspace ID are anonymized. Your output can differ by CLI version and project configuration.

    ```text
    👀 Found Rayfin project root: /Users/learner/projects/adventure-release-lab

    🔍 DRY RUN MODE - No resources will be created or modified

    Workspace: "Adventure Works Prod" (ID: 00000000-0000-0000-0000-000000000000)

    Planned operations:
      ✓ Check whether the target workspace has usable Fabric capacity
      ✓ Select one premium capacity automatically or ask when several are available
      ✓ Start a Fabric trial if required
      ✓ Require confirmation before assigning the selected or trial capacity
      ✓ Create or reuse Rayfin item "adventure-release-lab" (AppBackend)
      ✓ POST runtime settings (auth=true, data=false)
      ✓ Declare package versions:
          • @microsoft/rayfin-auth 2.0.1
          • @microsoft/rayfin-cli 2.0.1
      ✓ Build, package, and deploy static content
      ✓ Persist deployment metadata to rayfin/.deployments.json
    ```

    A dry run validates inputs and resolves the workspace. It doesn't deploy or change anything.

1. Confirm that the resolved target is the production workspace. If it isn't, stop and fix the name.

1. Deploy to production, and confirm health.

    ```bash
    npm exec -- rayfin up --workspace "Adventure Works Prod"
    npm exec -- rayfin up status
    ```

    Don't pass `--force`. If the CLI blocks a destructive change, stop and review it.

The production workspace now contains its own app item, separate from the development item. Open that app in the Fabric portal, and confirm that its welcome page also appears.

## Verify the active target

1. List the recorded deployments, and note the name that the CLI prints for each one.

    ```bash
    npm exec -- rayfin up list
    ```

1. Switch to the development deployment by using the name from the list, and check the status. Replace the placeholder, including its angle brackets, with the recorded workspace name. Keep quotation marks around names that contain spaces.

    ```bash
    npm exec -- rayfin up switch "<development-name-from-list>"
    npm exec -- rayfin up status
    ```

1. Open `rayfin/.env`, and note the development target's public configuration values. Switch back to production, and check the status again.

    ```bash
    npm exec -- rayfin up switch "<production-name-from-list>"
    npm exec -- rayfin up status
    ```

1. Check `rayfin/.env` again. Its values now point at the production deployment. This file is a local pointer, not a source of truth about which workspace serves production users.

## Explain the result

- What did the dry run prevent you from doing?
- Why does `rayfin/.env` not tell you which workspace is production?

The dry run let you confirm the target before you changed it. `rayfin/.env` is a local pointer to the active deployment, so it reflects your last switch, not what production is.

## Clean up the practice resources

If you continue to the deployment workflow exercise in this module, keep this project and both workspaces until you finish that exercise. Otherwise, delete the resources you created:

1. In the Fabric portal, open **Adventure Works Dev**, open **Workspace settings**, and delete the workspace. Confirm that you're deleting the practice workspace, not an existing team workspace.
1. Repeat for **Adventure Works Prod**. Deleting these workspaces removes their app items and data, so don't use this cleanup procedure for real production resources.
1. Remove the local **adventure-release-lab** folder when you no longer need it.
