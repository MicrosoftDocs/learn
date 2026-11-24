In this challenge, you combine what you practiced without step-by-step instructions. You change the frontend, deploy it, and use the prototype as evidence for the Adventure Works fit decision.

## Challenge

1. Make a small, visible change to the frontend in `packages/frontend`. For example, change the heading or empty-state text in the main app component to **Regional sales dashboard**.

1. Preview the deployment, deploy it, and confirm that the deployment is healthy.

1. Open the hosted app URL and confirm that your change appears.

    If you changed the heading to **Regional sales dashboard**, your updated app should look similar to this example.

    :::image type="content" source="../media/fabric-app-updated.png" alt-text="Screenshot of the updated Fabric Apps home page showing the heading Regional sales dashboard above the template's feature tiles.":::

If you need a hint: the command sequence is the same one you used in the previous exercise. You only changed frontend code, so you can also redeploy only the static content with `npx rayfin up staticapp deploy`. If the CLI reports that it skipped the static upload because nothing changed, confirm that you saved your edit, or run `npx rayfin up --force-static-deploy`.

## Clean up

Trial capacities allow only a few SQL databases, so remove what you no longer need.

1. If you plan to reuse the app in later work, keep it and skip the rest of this section.
1. Otherwise, in the Fabric portal, open your workspace and delete the app item.
1. Confirm that no child items for the app remain in the workspace. Delete any that do.
1. Delete the local project folder if you no longer need it.
