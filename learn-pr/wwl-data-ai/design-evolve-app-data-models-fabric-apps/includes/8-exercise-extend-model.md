In this challenge, you apply what you practiced without step-by-step instructions. Adventure Works wants to record which staff member handles the follow-up for each issue.

## Challenge

1. Add a bounded, optional text field named `followUpBy` to the `Issue` entity. Choose a `max` length that fits a person's name.
1. Before you apply it, predict what happens to the three existing records.
1. Apply the change and confirm that the deployment is healthy.
1. Verify in the app that the existing issues still appear. Then change the seed code so a new issue includes a `followUpBy` value, and confirm that the value is stored.

If you need a hint, the pattern is the same as the `partNumber` field. Use `@text` with `max` and `optional: true`, add `?` to the property, and keep the record type in `packages/shared/src/index.ts` in step.

## Clean up

A trial capacity allows only a few SQL databases, so keep one app and remove what you no longer need.

1. Stop the development loop with Ctrl+C.
1. Delete the app item from your Fabric workspace, confirm in the workspace item list that no child items remain, and delete the local project folder. If a child item remains, delete it too.