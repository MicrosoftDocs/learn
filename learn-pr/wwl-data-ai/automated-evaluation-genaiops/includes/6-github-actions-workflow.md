Integrating automated evaluations into GitHub Actions creates continuous quality gates that catch quality regressions before they reach production.

In the Adventure Works scenario, the team needs to validate a prompt update before deployment. GitHub Actions automatically runs evaluations on pull requests, providing objective quality metrics that guide the merge decision.

Here, you learn how to configure GitHub Actions workflows for automated evaluation and interpret results to guide decisions.

| Workflow Component | Purpose |
|-------------------|---------|
| Trigger configuration | Run evaluations on pull request events |
| Python environment | Install dependencies from previous unit |
| Azure authentication | Configure federated credentials for secure access |
| Run evaluation script | Execute the Python script from previous unit |
| Results reporting | Post metrics as pull request comments |

## Understand the pull request evaluation workflow

Pull request (PR) workflows automate quality checks before changes merge, preventing quality regressions from reaching production.

The evaluation workflow follows these steps:

1. **Developer creates PR**: Proposes changes to model configuration or prompts
2. **GitHub Actions triggers**: Workflow detects configuration file changes  
3. **Evaluation runs**: Script executes against test dataset
4. **Results posted**: Metrics appear as PR comment with pass/fail status
5. **Team decides**: Review results and approve or request changes

This creates systematic quality gates without manual intervention.

> [!NOTE]
> Automated evaluation augments human review by providing consistent quality metrics.

## Configure GitHub Actions workflow file

GitHub Actions workflows are YAML files in `.github/workflows/` that define when and how evaluations run. This workflow automates the Python evaluation script from the previous unit.

**Evaluation workflow for pull requests**:

```yaml
# .github/workflows/evaluate-on-pr.yml
name: Evaluate Prompt Changes

on:
  pull_request:
    branches: [main]
    paths:
      - 'prompts/**'
      - 'config/**'

permissions:
  id-token: write
  contents: read
  pull-requests: write

jobs:
  run-evaluation:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Azure login
        uses: azure/login@v2
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}
          tenant-id: ${{ vars.AZURE_TENANT_ID }}
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}

      - name: Run evaluation script
        run: |
          python run_evaluation.py \
            --test-data test-data/test_dataset.jsonl \
            --output results.json
        env:
          AZURE_SUBSCRIPTION_ID: ${{ vars.AZURE_SUBSCRIPTION_ID }}
          AZURE_RESOURCE_GROUP: ${{ vars.AZURE_RESOURCE_GROUP }}
          FOUNDRY_PROJECT_NAME: ${{ vars.FOUNDRY_PROJECT_NAME }}

      - name: Post results to PR
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const results = JSON.parse(fs.readFileSync('results.json'));
            
            const comment = `## Evaluation Results
            
            **Metrics:**
            - Groundedness: ${results.metrics.groundedness.toFixed(2)}
            - Relevance: ${results.metrics.relevance.toFixed(2)}
            - Coherence: ${results.metrics.coherence.toFixed(2)}
            
            **Status:** ${results.passed ? '✅ PASSED' : '❌ FAILED'}
            
            Evaluated ${results.total_examples} examples.`;
            
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: comment
            });
```

**Key elements**:

- **Trigger**: Runs automatically when PRs modify prompt or config files
- **Python setup**: Installs Python 3.11 and dependencies from `requirements.txt`
- **Azure auth**: Uses federated credentials for secure access
- **Environment variables**: Pass Azure configuration to evaluation script
- **Results posting**: Uses `github-script` action to comment on PR with metrics

## Set up Azure authentication

GitHub Actions needs secure access to Microsoft Foundry. Use federated identity credentials for keyless authentication.

**Configure Azure service principal**:

```bash
# Create app registration
az ad app create --display-name "github-actions-eval"
APP_ID=$(az ad app list --display-name "github-actions-eval" --query "[0].appId" -o tsv)

# Create federated credential
az ad app federated-credential create --id $APP_ID --parameters '{
  "name": "github-main",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:YOUR_ORG/YOUR_REPO:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}'

# Assign permissions
az role assignment create \
  --assignee $APP_ID \
  --role "Cognitive Services User" \
  --scope /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.CognitiveServices/accounts/{foundry}
```

**Add GitHub variables**:

Navigate to repository **Settings** > **Secrets and variables** > **Actions** > **Variables** tab and add:

- `AZURE_CLIENT_ID`: Application ID from service principal
- `AZURE_TENANT_ID`: Azure tenant ID  
- `AZURE_SUBSCRIPTION_ID`: Subscription ID
- `AZURE_RESOURCE_GROUP`: Resource group containing your Foundry project
- `FOUNDRY_PROJECT_NAME`: Your Microsoft Foundry project name

> [!TIP]
> Use GitHub environments for multiple deployment targets (dev, staging, production).

## Prepare your evaluation script for CI/CD

The evaluation script from the previous unit needs to output results in a structured format that the workflow can parse and display.

**Required script output format** (`results.json`):

```json
{
  "metrics": {
    "groundedness": 4.25,
    "relevance": 4.10,
    "coherence": 3.85
  },
  "passed": true,
  "total_examples": 150,
  "failed_examples": 5
}
```

**Dependencies file** (`requirements.txt`):

```txt
azure-ai-evaluation
azure-identity
azure-ai-inference
pandas
```

The workflow installs these dependencies, runs your script with the test dataset, and parses the JSON output to post formatted results to the pull request.

## Interpret evaluation results

The workflow posts evaluation results as a PR comment, showing quality metrics and pass/fail status. Use these results to decide whether to merge or request changes.

**Example PR comment**:

```
## Evaluation Results

**Metrics:**
- Groundedness: 4.25
- Relevance: 4.10
- Coherence: 3.45 ⚠️

**Status:** ❌ FAILED

Evaluated 150 examples.
```

**How to use results for merge decisions**:

- **✅ PASSED**: All metrics meet thresholds—approve and merge the PR
- **❌ FAILED**: One or more metrics below threshold—review the output, investigate why scores dropped, and request changes to the prompt

The automated evaluation provides consistent quality metrics, but human judgment remains essential to interpret context and make final merge decisions.

Now that you understand how to integrate automated evaluations into GitHub Actions workflows, you're ready to practice setting up this continuous quality assurance system.
