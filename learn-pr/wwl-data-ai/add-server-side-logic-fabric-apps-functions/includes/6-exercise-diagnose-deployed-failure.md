In this challenge, you diagnose a failure that shows up only after deployment. You apply what you learned about identities without step-by-step instructions.

The report below supplies the scenario and all facts needed for the diagnosis. You don't need a second user, a teammate's project, or work from another module.

:::image type="content" source="../media/local-deployed-function-failure.png" alt-text="Diagram of listTeamItems returning item metadata locally but HTTP 403 Forbidden after deployment with unchanged code." lightbox="../media/local-deployed-function-failure.png":::

## The report

A teammate built a function named `listTeamItems` that reads item metadata from the team's Fabric workspace through the Fabric REST API. The code declares `AudienceType.Fabric` and reads `ctx.Tokens.Fabric`. It works every time during `npm run dev`. After a colleague runs `npx rayfin up`, every call from the deployed app fails with an HTTP 403 error from the Fabric API. The teammate checked that the code returns no token and logs no secret.

Other facts you have:

- The teammate has Member access to the team's workspace.
- The colleague owns the Fabric app item and deploys it from a different workspace.
- The colleague has no access to the team's workspace.

## Challenge

1. Identify which identity makes the Fabric call locally, and which identity makes it after deployment.
1. Identify the missing permission, and on which resource.
1. Propose the narrowest correction. Name the identity, the resource, and the level of access.
1. State how you would verify the correction against the deployed function, and what you would not change.

If you need a hint: a local call uses the account you signed in with, a deployed call uses the app identity, and declaring an audience doesn't grant permissions.

## Compare with the expected diagnosis

- **Identities:** Locally, the call uses the teammate's account, which has Member access. After deployment, it uses the app identity, which is the colleague who owns the app item.

- **Missing permission:** The app identity needs access to the team's workspace, at the lowest level that allows reading item metadata. The teammate's own access doesn't transfer to the app identity.

- **Fix:** Grant the app identity the lowest suitable role on the team's workspace. Don't widen the function's audience, don't move the token to the frontend, and don't weaken caller policies on app data.

- **Verification:** Redeploy if needed, call the deployed function, and confirm the response. Test the deployed function, because local success doesn't prove the app identity has access.

## Clean up

Remove the project and app created for this module. The scenario's team workspace is hypothetical, so there are no scenario resources to delete.

1. Stop the local development session.
1. In the Fabric portal, open your development workspace and delete the `adventure-functions` app item.
1. Check for any child items created for the app and delete those that remain. Don't delete unrelated workspace items.
1. Close editor windows and terminals using the project, and delete the local `adventure-functions` folder.
