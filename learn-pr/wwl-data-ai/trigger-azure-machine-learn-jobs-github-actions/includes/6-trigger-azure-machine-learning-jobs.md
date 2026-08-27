With authentication configured, your GitHub Actions workflow can reach Azure Machine Learning. Next, decide what starts the workflow and what it submits.

## Trigger types

GitHub Actions supports several trigger types, each suited to a different scenario:

- **`push`** — runs when commits land on a branch, typically `main`. Use this to train or register a model after an approved change merges.
- **`pull_request`** — runs for selected pull request activity. Use this for validation workflows that can block a failing change.
- **`workflow_dispatch`** — allows a team member to start an on-demand workflow from the GitHub UI.
- **`schedule`** — runs the workflow on a defined schedule. Use this for regular retraining against updated data.
- **`repository_dispatch`** — allows an external system to start the workflow by calling the GitHub REST API. This is the entry point for Azure-initiated events.

## Command jobs and pipeline jobs

Azure Machine Learning offers two job types your workflow can submit:

- A **command job** runs a single script on Azure Compute. It's straightforward for a training run that fits in one step.
- A **pipeline job** connects multiple components — data preparation, training, evaluation — into a directed graph. Components are reusable and can be registered as versioned assets.

Your workflow submits the job definition (a YAML file checked into the repository) using the Azure CLI. A workflow step can wait for the job to complete and check its exit status. If the job fails, the workflow fails — and if branch protection requires that workflow's check, the pull request can't merge.

## Triggering from Azure-side events

GitHub Actions responds to GitHub events, but retraining signals often originate in Azure. For example, Azure Event Grid can report that new data arrived in storage.

GitHub Actions doesn't natively subscribe to Azure Event Grid events. An intermediary, such as Azure Logic Apps or Azure Functions, can receive the Azure event, authenticate to GitHub, and call the GitHub REST API with a `repository_dispatch` payload. The GitHub Actions workflow then submits the Azure Machine Learning job.

> [!NOTE]
> Retraining triggered by a data change and retraining triggered by a code change can use the same workflow logic. The trigger source differs, but the job submission steps are the same.

> [!TIP]
> Match each event to a trigger: a proposed change, an approved merge, a monthly run, and new data. When is an intermediary necessary?
