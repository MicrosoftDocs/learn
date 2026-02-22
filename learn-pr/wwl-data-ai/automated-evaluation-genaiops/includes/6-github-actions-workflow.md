Integrating automated evaluations into GitHub Actions creates continuous quality assurance that validates system changes before they reach production, catching quality regressions early in the development cycle.

In the Adventure Works scenario, the team needs to test the GPT-4 mini model switch and gain confidence that performance meets quality targets. Running evaluations manually before deployment is time-consuming and subjective. GitHub Actions automatically runs evaluation workflows when developers create configuration change pull requests, providing objective quality metrics to guide the model switch decision.

Here, you learn how to configure GitHub Actions workflows for automated evaluation, trigger evaluations on pull requests, and interpret results to guide merge decisions.

| Workflow Component | Purpose | Implementation |
|-------------------|---------|----------------|
| Trigger configuration | Define when evaluations run | Pull request events on prompt file changes |
| Environment setup | Prepare execution environment | Install dependencies, configure credentials |
| Evaluation execution | Run batch evaluations | Execute Python evaluation scripts |
| Results reporting | Communicate findings | Post comments to pull requests, set status checks |

## Understand the pull request evaluation workflow

Pull request (PR) workflows automate quality checks when developers propose changes, ensuring every modification undergoes evaluation before merging into the main branch. This pattern prevents quality regressions from reaching production.

The standard PR evaluation workflow follows these steps:

1. **Developer updates configuration**: Changes model configuration or system prompts in a feature branch
2. **Create pull request**: Opens PR to merge changes into main branch
3. **Trigger evaluation**: GitHub Actions detects configuration file changes and starts evaluation workflow
4. **Run batch evaluation**: Workflow executes evaluation script against test dataset
5. **Report results**: Posts evaluation summary as PR comment and sets status check
6. **Review and merge**: Team reviews results and decides whether the model switch meets quality targets

This workflow ensures no configuration changes merge without evaluation, creating systematic quality gates.

> [!NOTE]
> Automated evaluation doesn't replace human review—it augments it by providing consistent quality metrics that humans interpret alongside their domain expertise.

## Configure GitHub Actions workflow file

GitHub Actions workflows are defined in YAML files stored in the `.github/workflows/` directory. The workflow configuration specifies triggers, environment setup, and execution steps.

**Create evaluation workflow file**:

```yaml
# .github/workflows/evaluate-prompts.yml
name: Evaluate Model Configuration Changes

on:
  pull_request:
    branches:
      - main
      - develop
    paths:
      - 'config/**'
      - 'prompts/**'
      - 'test-data/**'
      - 'evaluation/**'

env:
  PYTHON_VERSION: '3.11'
  AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  AZURE_RESOURCE_GROUP: ${{ secrets.AZURE_RESOURCE_GROUP }}
  FOUNDRY_PROJECT_NAME: ${{ secrets.FOUNDRY_PROJECT_NAME }}

jobs:
  evaluate:
    runs-on: ubuntu-latest
    
    permissions:
      contents: read
      pull-requests: write
      id-token: write
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ env.PYTHON_VERSION }}
      
      - name: Install dependencies
        run: |
          pip install -r evaluation/requirements.txt
      
      - name: Azure login
        uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      
      - name: Run evaluation
        id: eval
        run: |
          python evaluation/run_evaluation.py \
            --test-data test-data/test_dataset_v1.1.jsonl \
            --prompt-file prompts/system_prompt.txt \
            --output evaluation-results.json
      
      - name: Post results to PR
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const results = JSON.parse(fs.readFileSync('evaluation-results.json'));
            
            const comment = `## Evaluation Results
            
            **Overall Metrics:**
            - Groundedness: ${results.summary.groundedness.toFixed(2)}
            - Relevance: ${results.summary.relevance.toFixed(2)}
            - Coherence: ${results.summary.coherence.toFixed(2)}
            - Safety Information: ${results.summary.safety_information.toFixed(2)}
            
            **Quality Gate:** ${results.quality_gate_passed ? '✅ PASSED' : '❌ FAILED'}
            
            **Failing Examples:** ${results.failure_count} of ${results.total_examples}
            
            <details>
            <summary>View detailed results</summary>
            
            ${JSON.stringify(results.category_breakdown, null, 2)}
            </details>
            `;
            
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: comment
            });
      
      - name: Check quality gate
        run: |
          python -c "
          import json
          with open('evaluation-results.json') as f:
              results = json.load(f)
          if not results['quality_gate_passed']:
              print('Quality gate failed. Review evaluation results.')
              exit(1)
          "
```

**Key configuration elements**:

- **Trigger paths**: Workflow runs only when files in `config/`, `prompts/`, `test-data/`, or `evaluation/` directories change
- **Permissions**: `pull-requests: write` enables posting comments; `id-token: write` supports Azure authentication
- **Secrets**: Sensitive credentials stored as GitHub repository secrets rather than hardcoded
- **Quality gate check**: Fails the workflow if quality criteria aren't met, blocking merge

## Set up Azure authentication for GitHub Actions

GitHub Actions needs secure access to Azure AI Foundry resources to run evaluations. Federated identity credentials provide secure, keyless authentication without storing secrets.

**Configure Azure federated identity**:

```bash
# Create Azure AD application
az ad app create --display-name "github-actions-evaluation"

# Get application ID
APP_ID=$(az ad app list --display-name "github-actions-evaluation" --query "[0].appId" -o tsv)

# Create service principal
az ad sp create --id $APP_ID

# Create federated credential for GitHub Actions
az ad app federated-credential create \
  --id $APP_ID \
  --parameters '{
    "name": "github-actions-main",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:your-org/your-repo:ref:refs/heads/main",
    "audiences": ["api://AzureADTokenExchange"]
  }'

# Assign role to access Foundry project
az role assignment create \
  --assignee $APP_ID \
  --role "Cognitive Services User" \
  --scope "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.CognitiveServices/accounts/{foundry-resource}"

# Output values for GitHub secrets
echo "AZURE_CLIENT_ID: $APP_ID"
echo "AZURE_TENANT_ID: $(az account show --query tenantId -o tsv)"
echo "AZURE_SUBSCRIPTION_ID: $(az account show --query id -o tsv)"
```

**Configure GitHub repository secrets**:

1. Navigate to repository **Settings** > **Secrets and variables** > **Actions**
2. Add the following secrets:
   - `AZURE_CLIENT_ID`: Application (client) ID from Azure AD app
   - `AZURE_TENANT_ID`: Directory (tenant) ID
   - `AZURE_SUBSCRIPTION_ID`: Azure subscription ID
   - `AZURE_RESOURCE_GROUP`: Resource group containing Foundry project
   - `FOUNDRY_PROJECT_NAME`: Foundry project name

> [!TIP]
> Use environment-specific secrets for multiple deployment targets (development, staging, production) by creating GitHub environments with environment-specific secret values.

## Implement evaluation script for CI/CD

The evaluation script executed by GitHub Actions needs command-line interface (CLI) support, structured output for reporting, and clear quality gate logic.

**Create evaluation script** (`evaluation/run_evaluation.py`):

```python
import argparse
import json
import sys
from pathlib import Path
from azure.ai.inference import ChatCompletionsClient
from azure.ai.evaluation import evaluate
from azure.identity import DefaultAzureCredential
import pandas as pd

def load_test_data(file_path: str) -> pd.DataFrame:
    """Load test dataset from JSONL"""
    import json
    test_examples = []
    with open(file_path, 'r') as f:
        for line in f:
            test_examples.append(json.loads(line))
    return pd.DataFrame(test_examples)

def load_prompt(file_path: str) -> str:
    """Load system prompt from file"""
    with open(file_path, 'r') as f:
        return f.read()

def run_evaluation(test_data: pd.DataFrame, system_prompt: str, config: dict) -> dict:
    """Run batch evaluation on test dataset"""
    
    # Initialize clients
    credential = DefaultAzureCredential()
    inference_client = ChatCompletionsClient(
        endpoint=config['endpoint'],
        credential=credential
    )
    
    # Generate responses
    responses = []
    for _, row in test_data.iterrows():
        messages = [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": row['query']}
        ]
        result = inference_client.complete(messages=messages)
        responses.append(result.choices[0].message.content)
    
    test_data['response'] = responses
    
    # Run evaluators
    evaluation_results = evaluate(
        data=test_data,
        evaluators={
            'groundedness': GroundednessEvaluator(credential=credential),
            'relevance': RelevanceEvaluator(credential=credential),
            'coherence': CoherenceEvaluator(credential=credential),
        },
        azure_ai_project=config['project']
    )
    
    # Add custom evaluators
    risk_scores = [
        evaluate_risk_disclosure(response) 
        for response in test_data['response']
    ]
    test_data['risk_disclosure_score'] = risk_scores
    
    return {
        'scores': test_data.to_dict(orient='records'),
        'summary': {
            'groundedness': test_data['groundedness_score'].mean(),
            'relevance': test_data['relevance_score'].mean(),
            'coherence': test_data['coherence_score'].mean(),
            'risk_disclosure': test_data['risk_disclosure_score'].mean(),
        }
    }

def check_quality_gate(results: dict, thresholds: dict) -> bool:
    """Determine if quality criteria are met"""
    summary = results['summary']
    
    for metric, threshold in thresholds.items():
        if summary.get(metric, 0) < threshold:
            print(f"Quality gate failed: {metric} = {summary[metric]:.2f} < {threshold}")
            return False
    
    return True

def main():
    parser = argparse.ArgumentParser(description='Run automated evaluation')
    parser.add_argument('--test-data', required=True, help='Path to test dataset')
    parser.add_argument('--prompt-file', required=True, help='Path to system prompt')
    parser.add_argument('--output', required=True, help='Output file for results')
    parser.add_argument('--config', default='evaluation/config.json', help='Configuration file')
    
    args = parser.parse_args()
    
    # Load configuration
    with open(args.config, 'r') as f:
        config = json.load(f)
    
    # Load test data and prompt
    test_data = load_test_data(args.test_data)
    system_prompt = load_prompt(args.prompt_file)
    
    print(f"Running evaluation on {len(test_data)} examples...")
    
    # Run evaluation
    results = run_evaluation(test_data, system_prompt, config)
    
    # Calculate additional metrics
    failure_threshold = config.get('failure_threshold', 3.0)
    failures = sum(
        1 for score in results['scores']
        if any(score.get(f'{metric}_score', 5) < failure_threshold 
               for metric in ['groundedness', 'relevance', 'coherence', 'risk_disclosure'])
    )
    
    # Check quality gate
    quality_gate_passed = check_quality_gate(
        results, 
        config.get('quality_thresholds', {})
    )
    
    # Prepare output
    output = {
        'total_examples': len(test_data),
        'failure_count': failures,
        'summary': results['summary'],
        'quality_gate_passed': quality_gate_passed,
        'category_breakdown': test_data.groupby('category').agg({
            f'{metric}_score': 'mean' 
            for metric in ['groundedness', 'relevance', 'coherence', 'risk_disclosure']
        }).to_dict()
    }
    
    # Save results
    with open(args.output, 'w') as f:
        json.dump(output, f, indent=2)
    
    print(f"Evaluation complete. Results saved to {args.output}")
    print(f"Quality gate: {'PASSED' if quality_gate_passed else 'FAILED'}")
    
    # Exit with error code if quality gate fails
    sys.exit(0 if quality_gate_passed else 1)

if __name__ == '__main__':
    main()
```

**Create configuration file** (`evaluation/config.json`):

```json
{
  "endpoint": "https://your-foundry-project.openai.azure.com",
  "project": {
    "subscription_id": "${AZURE_SUBSCRIPTION_ID}",
    "resource_group": "${AZURE_RESOURCE_GROUP}",
    "project_name": "${FOUNDRY_PROJECT_NAME}"
  },
  "quality_thresholds": {
    "groundedness": 4.0,
    "relevance": 4.0,
    "coherence": 3.5,
    "risk_disclosure": 4.0
  },
  "failure_threshold": 3.0
}
```

## Interpret evaluation results and make decisions

Evaluation results guide merge decisions by revealing quality impacts of proposed changes. Understanding how to interpret results and when to require additional work is critical.

**Quality gate patterns**:

| Result Pattern | Interpretation | Action |
|---------------|----------------|---------|
| All metrics pass thresholds | Changes maintain or improve quality | Approve and merge |
| One metric slightly below | Minor regression in specific area | Review failing examples, consider accepting |
| Multiple metrics below | Significant quality degradation | Request changes, investigate root cause |
| New failure categories | Changes introduce new problem types | Block merge, revise prompts |

**Review evaluation comments**:

When GitHub Actions posts evaluation results to pull requests, review the summary metrics and failing examples:

```
## Evaluation Results

**Overall Metrics:**
- Groundedness: 4.25
- Relevance: 4.10
- Coherence: 3.80
- Safety Information: 3.45 ⚠️

**Quality Gate:** ❌ FAILED

**Failing Examples:** 23 of 500

**Analysis:** Safety information scores below threshold (4.0). 
Review suggests GPT-4 mini responses are less comprehensive in safety details.
```

This result indicates the model switch maintained information quality (groundedness, relevance) but reduced safety information completeness, requiring investigation before proceeding with the GPT-4 mini deployment.

> [!IMPORTANT]
> Treat evaluation results as guidance, not absolute verdicts. Human judgment remains essential for interpreting context and making final merge decisions.

## Optimize workflow performance

Evaluation workflows running on every pull request need optimization to provide fast feedback without excessive costs.

**Cache dependencies**:

```yaml
- name: Cache Python dependencies
  uses: actions/cache@v4
  with:
    path: ~/.cache/pip
    key: ${{ runner.os }}-pip-${{ hashFiles('evaluation/requirements.txt') }}
    restore-keys: |
      ${{ runner.os }}-pip-
```

**Run evaluations conditionally**:

```yaml
on:
  pull_request:
    paths:
      - 'config/**'  # Only run when config files change
      - 'prompts/**'  # Or when prompt files change
      - 'test-data/**'  # Or when test data updates
```

**Use subset testing for rapid feedback**:

```python
# Quick evaluation on PR creation (100 examples)
if is_pr_created:
    test_data = test_data.sample(n=100, random_state=42)

# Full evaluation on pre-merge (500 examples)
if is_ready_for_merge:
    test_data = load_test_data(full_dataset_path)
```

**Parallel execution**:

```yaml
strategy:
  matrix:
    category: [trail_recommendations, accommodation_booking, gear_suggestions]
  
steps:
  - name: Run evaluation for ${{ matrix.category }}
    run: |
      python evaluation/run_evaluation.py \
        --category ${{ matrix.category }}
```

Now that you understand how to integrate automated evaluations into GitHub Actions workflows, you're ready to practice setting up this continuous quality assurance system in the hands-on exercise.
