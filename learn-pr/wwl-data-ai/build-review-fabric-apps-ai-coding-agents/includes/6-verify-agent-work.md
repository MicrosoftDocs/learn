You reviewed the diff for the Adventure Works Cycles app and fixed the findings. Review isn't enough on its own, because it can't prove how the deployed app behaves. This unit describes the evidence to gather before you approve a release, and what each piece of evidence doesn't prove.

## Layer the evidence

No single check proves that agent work is safe. Gather evidence in layers:

| Check | What it shows | What it doesn't show |
|:------|:--------------|:---------------------|
| Type-check and build | The code compiles and the bundle builds | That permissions are correct |
| Tests | Client code behaves as the tests describe | That the backend enforces policies |
| `rayfin up --dry-run` | Local inputs are valid and the target workspace resolves | That the schema applies or that the deployed app works |
| `rayfin up` and `rayfin up status` | The deployment completed and the item is reachable | That every entity is readable or protected |
| Checks against the deployed app | The server enforces the rules you expect | Anything you didn't test |

## Preview before you deploy

`npx rayfin up --dry-run` validates local inputs and resolves the target workspace without creating or modifying resources. Run it before you approve deployment, and read the output to confirm that the target is the workspace you expect. A dry run doesn't apply the schema, so it can't tell you whether a schema change is destructive. Your diff review does that.

## Deploy and confirm health

After you approve, deploy with `npx rayfin up`, and confirm health with `npx rayfin up status`. Use `npx rayfin up status --json` when you need the hosting URL, which appears as `deployment.hostingUrl` after static content deploys. A deployment can report success while a newly added entity isn't yet readable, so don't test the new entity until the status is healthy.

The CLI blocks a destructive schema change and describes the impact unless the command includes `--force`. Deploy without `--force`. If the CLI blocks the change, stop, review the listed operations, and decide yourself whether the loss is acceptable. Never let an agent pass `--force` without your confirmation.

## Test permissions on the deployed app

A passing build doesn't prove that the permissions are correct. Run two checks against the deployed app:

1. **A record owned by someone else stays hidden and protected.** With one signed-in user, use a lab-only entity that lets you create a record with a different owner, and confirm that the server hides it and refuses to update or delete it.
1. **An unauthenticated request is rejected.** Sign out and call the same query. The server should reject it.

Client-side tests that stub `fetch` or the client verify your client code, such as stamping `user_id` from the session. They don't verify backend enforcement. Link them to the part of the diff they cover, and don't count them as permission proof.

## Next step

In the next exercise, you run the checks, approve a deployment, and verify the deployed app with an owner-only check and an unauthenticated request.
