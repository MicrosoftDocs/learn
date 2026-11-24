You released a Fabric app through development and production workspaces, shared it, and diagnosed problems by layer. The Adventure Works Cycles scenario shows that a release is a controlled promotion, and that access to an app is separate from access to the data behind it.

## What you learned

- Separate development and production workspaces, `rayfin up --dry-run`, `up list`, and `up switch` provide a controlled promotion, and Git integration and deployment pipelines are a different lifecycle that moves the built definition.

- A GitHub Actions workflow signs in with a service principal, previews the deployment, serializes runs, gates `--force`, and requires approval for production.

- Sharing grants app access through item permissions, while related items and data policies decide what a user sees.

- App Metrics shows usage and isn't a capacity report, and diagnosing by layer finds where a failure sits.

## Clean up resources

Delete test app items and any workspaces that you created for this module. Remove GitHub environment secrets and the service principal secret that you no longer need.

## Learn more

- [Dev and prod workflow for Fabric Apps](/fabric/apps/dev-prod-workflow)
- [Deploy Fabric Apps with GitHub Actions](/fabric/apps/deploy-github-actions)
- [Share a Fabric app](/fabric/apps/share-app)
- [Configure Git integration for your Fabric app](/fabric/apps/source-control)
- [Monitor and troubleshoot Fabric Apps](/fabric/apps/app-metrics)
- [Troubleshoot Fabric Apps](/fabric/apps/troubleshooting)
- [Rayfin: rayfin up](https://rayfin.ai/docs/reference/cli/up)
- [Rayfin: rayfin login](https://rayfin.ai/docs/reference/cli/login)
- [Rayfin: deployment pipelines](https://rayfin.ai/docs/deploy/deployment-pipelines)
