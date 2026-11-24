In this exercise, you create a new app and direct GitHub Copilot in agent mode to add a vendor-tracking feature. You start from a fresh project without completing exercises in other modules.

## Prerequisites

- Node.js 24 with npm, and Git installed on your computer.
- Visual Studio Code with GitHub Copilot enabled and access to agent mode.
- A Microsoft Fabric account and a workspace on a trial or paid Fabric capacity. You need permission to create items, such as the Contributor workspace role. Your administrator must enable Fabric Apps for your account.

## Prepare a new project

### Create the app

1. Open a terminal in a folder where you keep your projects. Create a new Universal App with the default template.

    ```bash
    npm exec --package=@microsoft/rayfin-cli@2 -- rayfin init vendor-agent-lab --template blankapp
    ```

    Complete any interactive sign-in yourself, and select your capacity-backed workspace when prompted. Don't deploy the app yet.

1. Open the new `vendor-agent-lab` folder in Visual Studio Code. Open an integrated terminal in the project root, which contains `package.json`.

1. Install dependencies, and enable the data service and starter data model.

    ```bash
    npm install
    npm run pack:add -- data-modeling
    ```

    The app now has the `packages/data/src` location used in the agent prompt. You don't need an existing data model, connector, or deployed app.

1. Sign in with the account that has access to your workspace.

    ```bash
    npx rayfin login
    ```

### Check the guidance and record a baseline

1. In the project root, check the managed agent files that the scaffold installs.

    ```bash
    npx rayfin init ai-files status
    ```

    Inspect the output for skills such as `skill:rayfin` and the Model Context Protocol (MCP) configuration `mcp:rayfin`. Each component reports a state such as `up-to-date`, `update-available`, or `missing`. If every component is `up-to-date`, skip the next step.

1. If a component reports `missing` or `update-available`, install or refresh it.

    ```bash
    npx rayfin init ai-files install
    ```

    At **Select Rayfin agent files to install**, use **Space** to select the missing or outdated components and clear selections for components that don't need changes. Press **Enter** to continue. Run `npx rayfin init ai-files status` again to confirm that the selected components are now `up-to-date`.

1. Open `AGENTS.md` and `.mcp.json`, and list the files under `.agents/skills/`. Identify the rules for data models, permissions, typed client calls, and deployment approval.

1. Build and type-check the unchanged app to confirm that the starting project works. Resolve any setup errors before you continue.

    ```bash
    npm run build:fabric
    npm run typecheck
    ```

1. In the project root, initialize a Git repository, record the starting project, and create a branch for the agent's changes. Run the following commands, but review the staged files and confirm that they don't contain credentials before you run the commit command.

    ```bash
    git init
    git add .
    git diff --cached --stat
    git commit -m "Record vendor app baseline"
    git checkout -b vendor-feature
    git status --short
    ```

    The final command should produce no output. Keep the agent's feature changes uncommitted so that you can inspect them and use them in the later review exercise in this module.

## Direct the agent

1. Open the project in your editor, and start GitHub Copilot in agent mode.
1. Paste this prompt. It names the outcome, requires commands, sets approval gates, and keeps sign-in with you.

    ```text
    Add vendor tracking to this Rayfin 2.0 Universal App. Read AGENTS.md and the Rayfin skill first.

    1. In packages/data/src, add a Vendor entity with: name (text, max 100), contactEmail (email, max 254),
       status ('active' or 'paused'), and user_id (text, max 128) for ownership. Give it an explicit
       @authenticated permission decorator with an owner-only policy that compares claims.sub to user_id.
       Register it in the schema registration file, and use .js extensions on relative imports.
    2. Add a Vendors screen to the frontend that lists vendors and creates a vendor through the typed Rayfin
       client. Set user_id from the signed-in session. Select every field you read. Do not use raw fetch
       or hand-built GraphQL.
    3. Run `npm run build:fabric` and any type-check script in package.json yourself, and fix any errors.
    4. Run `npx rayfin up --dry-run` and show me the output.
    5. Do NOT run `npx rayfin up` and do NOT pass --force until I approve.
    I complete any interactive sign-in myself.
    ```

1. When the agent needs you to sign in, run `npx rayfin login` yourself in a terminal, and then tell the agent to continue.
1. Read each terminal command that Copilot asks to run before you approve it. Let the agent finish, and answer any questions. Don't approve deployment yet.

## Inspect what the agent did

1. In your editor, open the source control view and list the changed files.
1. Open the `Vendor` entity. Check whether it has a permission decorator, and whether every text field has `max`.
1. Note anything that surprised you or that you would question. You review these changes in detail in a later exercise.

### Check your understanding

- Which parts of the prompt acted as approval gates?
- Why did you complete the sign-in yourself?

The instructions not to run `rayfin up` and not to pass `--force` until you approve were the gates. Sign-in is interactive and tied to your identity, so you complete it.
