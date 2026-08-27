Managing machine learning code manually — one notebook, one person, one run at a time — doesn't scale to a team that needs traceability, safe experimentation, and automated quality gates. This module explained how to build that automation layer step by step.

## What you learned

- Version your training scripts, job definitions, environment files, and configuration in Git. Keep raw data, model artifacts, run outputs, and secrets in purpose-built services such as Azure Machine Learning data assets, the model registry, and GitHub secrets or Azure Key Vault.
- Trunk-based development keeps `main` stable. Short-lived branches isolate changes, pull requests enable review, and branch protection rules enforce required checks before merging.
- GitHub Actions workflows run linting and unit tests automatically on pull requests, surfacing results as status checks that can block a merge.
- Workload identity federation with OIDC is the preferred way to authenticate GitHub Actions to Azure. It removes the need to store long-lived credentials and reduces risk compared to service principal client secrets.
- A GitHub Actions workflow submits a command job or pipeline job to Azure Machine Learning using the Azure CLI. Triggers include pushes, pull requests, manual runs, schedules, and repository dispatch events sent by intermediaries such as Azure Logic Apps or Azure Functions.

## Learn more

- [GitHub Actions documentation](https://docs.github.com/actions)
- [Azure Machine Learning pipelines overview](/azure/machine-learning/concept-ml-pipelines)
- [Use GitHub Actions to connect to Azure with OpenID Connect](/azure/developer/github/connect-from-azure-openid-connect)
- [Workload identity federation](/entra/workload-id/workload-identity-federation)
- [Security hardening for GitHub Actions](https://docs.github.com/actions/security-guides/security-hardening-for-github-actions)
- [Azure Machine Learning CLI and Python SDK v2](/azure/machine-learning/concept-v2)