In this exercise, you add an optional field to the `Issue` entity and confirm that existing records remain. You then attempt a rename, read the CLI's data-loss warning, and stop without approving it.

## Add an optional field

1. In `Issue.ts`, add a part number field that is optional and bounded.

    ```typescript
    @text({ max: 50, optional: true }) partNumber?: string;
    ```

1. In `packages/shared/src/index.ts`, add `partNumber?: string;` to `IssueRecord` so the client type matches the entity.
1. Apply the change.

    ```bash
    npx rayfin up
    ```

1. Confirm that the deployment is healthy.

    ```bash
    npx rayfin up status
    ```

1. Run `npm run dev`, sign in, and confirm that the three issues you seeded still appear.

The new column exists, and the existing records have no value for it. Nothing was lost.

## Attempt a rename

The store staff ask for a clearer name for the `unitsAffected` field. You try the rename and read what the CLI reports.

1. Stop the development loop with Ctrl+C. Restarting `npm run dev` applies the schema, so keep it stopped while you test a destructive change.
1. In `Issue.ts`, rename `unitsAffected` to `quantityAffected`. Change nothing else.
1. Apply only the database schema.

    ```bash
    npx rayfin up db apply
    ```

1. Read the CLI output. The command reports that the change could cause data loss and identifies the rename. Your output looks similar to this example. Paths and identifiers are replaced with placeholders.

     ```output
     🌐 DB Apply (Remote Mode)

     🎯 Target: Remote Rayfin item workload endpoint
     📍 Endpoint: https://api.fabric.microsoft.com/v1/workspaces/<workspace-id>/appBackends/<app-backend-id>
     🔧 Generating DAB configuration...
     👀 Found Rayfin project root: /path/to/issue-tracker

     > @rayfin-app/data@0.0.0 build
     > tsc -b

     ✅ Configuration generated: /path/to/issue-tracker/rayfin/.temp/dab-config.json

     🚀 Apply DAB configuration to server

     📄 Reading config from: /path/to/issue-tracker/rayfin/.temp/dab-config.json
     📡 Applying configuration to Rayfin server...
     ❌ Failed to apply configuration to remote endpoint
         DAB server responded with error: 400 Bad Request
         Details: Performing Rename column 'unitsAffected' to 'quantityAffected' in table 'Issues' migration would result in data loss but force mode is not enabled. Set 'force' to true in the request can allow the operation.
         RootActivityId: <activity-id>

     💡 Troubleshooting tips for remote apply:
         • Verify the Rayfin item workload is running and healthy
         • Check if 'rayfin up' completed successfully
         • Ensure your network can reach the remote endpoint
     ```

1. Don't run the command with `--force`. Instead, record in a sentence which column the CLI wants to drop and why that matters for the three issues.

## Restore the safe model

1. Rename the property back to `unitsAffected`, exactly as it was.

    ```typescript
    @int({ min: 1, default: 1 }) unitsAffected!: number;
    ```

1. Apply the schema again and confirm that the CLI no longer reports a destructive operation.

    ```bash
    npx rayfin up db apply
    npx rayfin up status
    ```

Adding an optional field preserves existing records. Renaming a field can cause data loss, so the CLI blocks the change unless you approve it with `--force`. Review the affected data and confirm that any loss is acceptable before you approve a destructive change.
