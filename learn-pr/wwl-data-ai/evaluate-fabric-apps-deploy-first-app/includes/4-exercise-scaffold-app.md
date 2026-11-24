In this exercise, you scaffold the Adventure Works Cycles sales dashboard as a Fabric app. You first confirm that your tenant and workspace are ready, then you create the project and find its key files. You keep the project for the next exercises.

## Check your environment

Before you create the project, confirm each requirement. These checks prevent most first-run failures.

- **Tenant setting:** A Fabric administrator enabled the **Fabric Apps** tenant setting for you. If you can't create Fabric Apps items, ask an administrator.
- **Workspace:** Open a workspace where you have the Contributor, Member, or Admin role. Confirm that the workspace is assigned to a Fabric trial or paid capacity. If you don't have a capacity, see [Fabric trial capacity](/fabric/fundamentals/fabric-trial).
- **Region:** Confirm that the capacity region supports Fabric Apps. Check [Fabric region availability](/fabric/admin/region-availability), because Fabric Apps isn't available in every region yet.
- **Node.js:** In a terminal, run `node --version`. The output starts with `v24` if you use the recommended version. The CLI supports Node.js 20, 22, and 24, and the default project template needs 22.13 or later.

## Scaffold the project

1. In a terminal, go to the folder where you keep projects.
1. Run the scaffold command. Replace `<workspace-name>` with the name of your workspace.

    ```bash
    npm create @microsoft/rayfin@latest -- adventure-dashboard --workspace <workspace-name>
    ```

    At **How would you like to start?**, select **Use default template** and press Enter. This creates a Universal App. Answer any prompts that remain.

1. Go to the new folder, install dependencies, and open the folder in your editor.

    ```bash
    cd adventure-dashboard
    npm install
    ```

    This installs the project's dependencies, including the Rayfin CLI and SDK packages used by the template. You don't need to install the CLI globally.

    You should see scaffold output similar to the following example. Your folder path, workspace name, and Node.js version might differ. The **Project created successfully!** message confirms that scaffolding completed.

    ```text
    ~/git/fabric-apps  node --version
    v24.22.3
    ~/git/fabric-apps  npm create @microsoft/rayfin@latest -- adventure-dashboard --workspace fabric-apps-workspace

    > npx
    > 'create-rayfin' adventure-dashboard --workspace fabric-apps-workspace

    ? How would you like to start? ✨ Use default template
     ____              __ _
    |  _ \ __ _ _   _ / _(_)_ __
    | |_) / _` | | | | |_| | '_ \
    |  _ < (_| | |_| |  _| | | | |
    |_| \_\__,_|\__, |_| |_|_| |_|
                |___/
    Let's create your project.

    🔖 Project name: adventure-dashboard

    🚀 Creating project "adventure-dashboard" (adventure-dashboard) from "✨ Use default template" template

    ✔ ✅ Template files copied
    ✔ ✅ Template customized
    ✔ ✅ Dependencies installed
    ✔ ✅ Scaffolding files synchronized

    🎉 Project created successfully!

    Next steps:

    cd adventure-dashboard
    npx rayfin dev

    📌 Persisted Fabric environment overrides into rayfin/.env
    ```

## Identify the key files

1. Open `rayfin/rayfin.yml`. Find `services.staticHosting` and note its `path` value. It points to the frontend package.
1. In the same file, find `services.data`. The value of `enabled` is `false` because data is opt-in in a Universal App.
1. Expand `packages/`. Find the `frontend`, `data`, and `shared` folders.
1. Open the `package.json` in the project root. Find the `dev` script and confirm that it runs `rayfin dev`.

Your `rayfin/rayfin.yml` file should look similar to this example:

```yaml
id: adventure-dashboard
name: adventure-dashboard
version: 1.0.0
services:
    auth:
        enabled: true
        fabric:
            enabled: true
            externalEntraExchange: true
        password:
            enabled: false
        allowedRedirectUris:
            - http://localhost:5173
    data:
        enabled: false # Data is opt-in; this template starts with it disabled.
        path: packages/data
        buildCommand: npm run build
    staticHosting:
        enabled: true
        path: packages/frontend # Frontend package used for static hosting.
        folder: dist
        buildCommand: npm run build:fabric
        indexDocument: index.html
        assetAccess: protected
        embedded:
            only: false
```