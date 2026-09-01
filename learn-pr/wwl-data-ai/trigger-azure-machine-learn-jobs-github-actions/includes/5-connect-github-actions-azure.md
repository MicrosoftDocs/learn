Your validation workflows can now catch code errors before they reach `main`. The next step is letting those workflows talk to Azure Machine Learning — submitting jobs, reading results, and registering models. That requires authentication, and how you handle it matters for security.

## Secrets and variables

GitHub provides two places to store workflow configuration:

- **Secrets** are encrypted values for credentials and other sensitive configuration. GitHub masks recognized secret values in logs, but workflows must still avoid exposing them.
- **Variables** hold non-sensitive configuration. Use them for workspace names, resource group names, and similar values you want to reuse across workflows.

Environment-scoped secrets are narrower than repository secrets: a job must target that environment before it can access them.

## Service principals and least privilege

One way to authenticate a workflow to Azure is with a **service principal** — a non-human identity in Microsoft Entra ID. You create the principal, assign it an Azure role, and store its credentials as a GitHub secret.

The role and scope matter. Assign an appropriate role at the narrowest scope the workflow needs, such as the Azure Machine Learning workspace or its resource group.

## Workload identity federation with OpenID Connect

Storing long-lived credentials as a secret creates risk: if the secret is exposed, it remains valid until you rotate it. **Workload identity federation** with OpenID Connect (OIDC) avoids storing that long-lived credential.

Instead of storing client secrets, you configure a trust relationship between your GitHub repository and a Microsoft Entra application. When a workflow runs, GitHub issues a short-lived OIDC token. Azure validates the token and returns an access token — no stored credential is exchanged.

> [!TIP]
> Prefer workload identity federation over service principal client secrets for new workflows. Short-lived tokens reduce exposure and remove the need to rotate a stored client secret.

## Workflow authentication and Git tracking

When you submit source files from a local Git repository, Azure Machine Learning can record the repository, branch, and commit with the training job. This tracking works with any compatible Git service and doesn't attach a specific GitHub repository to the workspace.

Git tracking and workflow authentication solve different problems. Tracking connects a job to the source version that produced it. Authentication grants the workflow permission to submit that job.

> [!TIP]
> Which workflow values are identifiers, and which are credentials that must remain secret?
