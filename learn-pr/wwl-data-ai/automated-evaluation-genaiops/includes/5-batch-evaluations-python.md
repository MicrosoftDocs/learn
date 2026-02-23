Cloud evaluations enable systematic quality assessment by running multiple evaluators across entire test datasets in Microsoft Foundry. These automated evaluations eliminate the need to manage local compute infrastructure and support large-scale automated testing workflows.

Adventure Works needs to evaluate 500 test examples against multiple quality criteria to validate their prompt update before deployment. Cloud evaluation with the Foundry SDK completes this work efficiently, running evaluators in parallel and storing results for analysis.

> [!NOTE]
> Cloud evaluation requires the Microsoft Foundry SDK (`azure-ai-projects>=2.0.0b1`) and authentication with `DefaultAzureCredential()`. The SDK provides an OpenAI-compatible client through `project_client.get_openai_client()` for evaluation operations.

## Define data schema and evaluators

Cloud evaluation needs to understand your data structure before running evaluators. You define this structure through a **data source config** that describes the fields in your JSONL dataset and specifies which evaluators to run.

**Why you need a data schema:**

The data schema tells the evaluation service what fields exist in your dataset and which ones are required. The data schema enables validation before execution and helps the service allocate the right resources. Think of it as a contract between your data and the evaluation service.

```python
from openai.types.eval_create_params import DataSourceConfigCustom

data_source_config = DataSourceConfigCustom(
    type="custom",
    item_schema={
        "type": "object",
        "properties": {
            "query": {"type": "string"},
            "response": {"type": "string"},
            "context": {"type": "string"},
            "ground_truth": {"type": "string"},
        },
        "required": ["query", "response"],  # Only these fields must be present
    },
)
```

**Configure evaluators with data mappings:**

After defining your data schema, you specify which evaluators to run and how they access your data. The `testing_criteria` list contains your evaluator configurations—each entry defines one evaluator to execute against your dataset.

Each evaluator in `testing_criteria` specifies:

- **Evaluator name**: The built-in evaluator to use (for example, `builtin.intent_resolution`)
- **Initialization parameters**: Configuration like which model deployment to use for AI-assisted evaluation
- **Data mapping**: How to connect your dataset fields to evaluator parameters using `{{item.field}}` syntax

Data mapping is critical—it tells each evaluator where to find its required inputs. The `{{item.field}}` syntax references fields from your JSONL dataset.

```python
testing_criteria = [
    {
        "type": "azure_ai_evaluator",
        "name": "intent_resolution",  # Your name for this evaluator in results
        "evaluator_name": "builtin.intent_resolution",  # The built-in evaluator to use
        "initialization_parameters": {
            "deployment_name": model_deployment_name  # Which model to use for evaluation
        },
        "data_mapping": {
            "query": "{{item.query}}",  # Map dataset's "query" field to evaluator's "query" parameter
            "response": "{{item.response}}",  # Map dataset's "response" field to evaluator's "response" parameter
        },
    },
    {
        "type": "azure_ai_evaluator",
        "name": "groundedness",
        "evaluator_name": "builtin.groundedness",
        "initialization_parameters": {
            "deployment_name": model_deployment_name
        },
        "data_mapping": {
            "query": "{{item.query}}",
            "response": "{{item.response}}",
            "context": "{{item.context}}",  # Groundedness needs context to verify claims
        },
    },
]
```

> [!IMPORTANT]
> Field names in `data_mapping` are case-sensitive and must match your JSONL dataset exactly. If your dataset has "Question" (capitalized) but you specify `"{{item.question}}"` (lowercase), the evaluation fails. Always verify field names match between your data schema and data mapping.

## Create evaluation definition and run

Cloud evaluation separates the **evaluation definition** (what to evaluate and how) from **evaluation runs** (executing against specific datasets). This separation enables reuse—define evaluation criteria once, then run multiple times against different datasets or versions.

**Create evaluation definition:**

The evaluation definition is your reusable template. It combines your data schema with testing criteria but doesn't reference any specific dataset yet.

```python
# Create the evaluation definition
eval_object = client.evals.create(
    name="adventure-works-prompt-evaluation",
    data_source_config=data_source_config,
    testing_criteria=testing_criteria,
)

print(f"Created evaluation: {eval_object.id}")
```

**Create evaluation run:**

An evaluation run executes your evaluation definition against a specific dataset. You reference the uploaded dataset by its ID (from the previous unit).

```python
from openai.types.evals.create_eval_jsonl_run_data_source_param import (
    CreateEvalJSONLRunDataSourceParam,
    SourceFileID,
)

# Create a run using the uploaded dataset
eval_run = client.evals.runs.create(
    eval_id=eval_object.id,
    name="prompt-v2-evaluation",
    data_source=CreateEvalJSONLRunDataSourceParam(
        type="jsonl",
        source=SourceFileID(
            type="file_id",
            id=data_id,  # Dataset ID from upload
        ),
    ),
)

print(f"Started evaluation run: {eval_run.id}")
print(f"Status: {eval_run.status}")
```

**What happens during execution:**

When you create a run, the evaluation service:

1. Loads your dataset from cloud storage
2. Validates data against your schema
3. Distributes evaluation work across evaluators in parallel
4. Stores results in your Foundry project
5. Generates a web-based report for visualization

> [!TIP]
> Evaluation runs are asynchronous and can take several minutes for large datasets. The service handles retries, rate limiting, and parallel execution automatically. Poll the run status to know when results are ready.

## Poll for completion and retrieve results

Evaluation runs execute asynchronously in the cloud. You need to poll the run status until completion before retrieving results.

**Why polling is necessary:**

Large datasets with multiple evaluators can take several minutes to complete. The evaluation service distributes work across parallel workers, handles rate limiting with model deployments, and retries failed requests automatically. Polling lets your script wait efficiently without blocking on network calls.

```python
import time

while True:
    run = client.evals.runs.retrieve(
        run_id=eval_run.id,
        eval_id=eval_object.id
    )
    if run.status in ("completed", "failed"):
        break
    time.sleep(5)  # Check every 5 seconds
    print("Waiting for evaluation run to complete...")

print(f"Evaluation completed with status: {run.status}")
```

> [!IMPORTANT]
> **Handling failures**: If `run.status` is "failed", check the error details in the run object. Common failures include insufficient model quota, invalid data mappings, or dataset access issues. The evaluation service provides detailed error messages to help diagnose problems.

**Retrieve detailed results:**

Once complete, retrieve the scored results for each item in your dataset:

```python
# Get detailed results for each item
output_items = list(
    client.evals.runs.output_items.list(
        run_id=run.id,
        eval_id=eval_object.id
    )
)

print(f"Retrieved {len(output_items)} evaluation results")
print(f"View detailed report: {run.report_url}")
```

**Understanding evaluator output:**

All evaluators return a standardized schema for each evaluated item:

- **Label**: Binary "pass" or "fail" label, similar to a unit test's output—use the label for quick comparisons across evaluators
- **Score**: Score from the evaluator's natural scale (1-5 for quality evaluators, 0-7 for safety evaluators, 0-1 for similarity metrics)
- **Threshold**: Default threshold that determines pass/fail from the score (you can override this)
- **Reason**: Explanation for the score (for LLM-judge evaluators only)
- **Details**: Optional additional information for debugging (for some evaluators like tool_call_accuracy)

For aggregate results across your entire dataset, access `run.result_counts` for overall pass/fail counts and `run.per_testing_criteria_results` for per-evaluator breakdowns.

> [!TIP]
> Use the `report_url` to view results in the Foundry portal with filtering, sorting, and visualization tools. For CI/CD workflows, parse `output_items` programmatically to enforce quality gates.

In the next unit, you learn how to integrate these evaluation workflows into GitHub Actions to automate quality assurance on every code change.
