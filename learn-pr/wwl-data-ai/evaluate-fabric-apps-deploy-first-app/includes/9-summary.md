You evaluated whether Fabric Apps suits an application scenario and proved the answer with a prototype scaffolded, run, and deployed to Microsoft Fabric. The Adventure Works Cycles dashboard scenario shows how the decision rests on both the platform's limits and evidence from a real workspace.

## What you learned

- A Fabric app is a managed Fabric item whose child services come from `rayfin/rayfin.yml`, and the Rayfin CLI and SDK handle development-time and runtime work.
- Fit depends on the scenario, the constraints (TypeScript only, no custom identity providers, no existing schemas), the licensing option, and the capacity that the app's services consume.
- `rayfin dev` runs the frontend locally against a backend in Fabric, while `rayfin up` publishes the app and `rayfin up status` verifies it.

## Clean up resources

If you don't plan to reuse the prototype, delete the app item and any remaining child items from your workspace. Trial capacities allow only a limited number of SQL databases.

## Learn more

- [What is Fabric Apps?](/fabric/apps/overview)
- [Choose a licensing option for Fabric Apps](/fabric/apps/licensing)
- [Pricing for Fabric apps on capacity](/fabric/apps/pricing)
- [Create and deploy your first Fabric app with the Rayfin CLI](/fabric/apps/create-app-with-cli)
- [Fabric trial capacity](/fabric/fundamentals/fabric-trial)
- [Rayfin: Develop locally](https://rayfin.ai/docs/start/develop-locally)
- [Rayfin: Project structure](https://rayfin.ai/docs/start/project-structure)
