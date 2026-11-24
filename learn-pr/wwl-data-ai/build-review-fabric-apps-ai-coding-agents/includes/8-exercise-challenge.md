In this challenge, you direct a small follow-up change, review it, and verify it using the same approval boundaries, without step-by-step instructions.

## Challenge

1. Write a new prompt for GitHub Copilot in agent mode that adds a status filter to the vendors screen, so that managers can show active or paused vendors. Include the outcome, the commands the agent should run, the review points, and the approval gates.

1. Let the agent work. Complete any sign-in yourself.

1. Review the agent's diff with the checklist from this module. Look for permission changes, schema changes, new dependencies, secrets, and raw data access.

1. Verify the change with the build (`npm run build:fabric`) and `npx rayfin up --dry-run`. Approve a deployment only if the review is clean, and then confirm health with `npx rayfin up status`.

1. On the deployed app, run the owner check and the unauthenticated check from the previous exercise again.

1. Write three sentences: what evidence supports release, what the checks don't prove, and which decision you made.

If you need a hint: a filter is a UI change that uses `where`. It shouldn't touch entity permissions or the schema. If the diff changes either, send the agent back with a precise instruction.

## Remove lab-only entities

The `VendorProbe` entity has a create rule that accepts any owner. Remove it before the app is reused.

1. Delete the `VendorProbe` class, its registration, and the `VendorProbeCheck` component.

1. Run `npx rayfin up db apply` and read the operation that the CLI lists. Removing the entity drops the lab table, so the CLI blocks the change and describes it.

1. Because the table holds only lab data, make a reviewed decision to approve it with `--force`.

    ```bash
    npx rayfin up db apply --force
    ```

1. Run `npx rayfin up status`, and confirm that the deployment is healthy.

## Clean up

1. Merge or discard the `vendor-feature` branch.
1. Delete the vendor records you created for testing, and confirm that `VendorDraft.ts` no longer exists.
1. If you won't reuse the app, delete the app item from your Fabric workspace and confirm that no child items remain.

## Check your understanding

An agent says that the follow-up change is complete and the build passes. What evidence do you still need before you release? You need a clean diff review, a dry run, a healthy deployment, and a deployed-app test of ownership and sign-in requirements.
