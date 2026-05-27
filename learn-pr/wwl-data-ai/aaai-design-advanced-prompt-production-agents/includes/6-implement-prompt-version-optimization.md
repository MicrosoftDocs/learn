Production system prompts degrade — model updates, shifting requirements, and accumulated edits erode quality in ways that aren't obvious until something breaks. Microsoft Foundry evaluation runs give you the quantitative signal to detect and respond to those changes before they reach production.

A system prompt that produces excellent results in January might degrade in April when the underlying model is updated. You discover that changing "analyze these lab results" to "interpret these clinical findings" improves accuracy by 12% — but without version control, you can't reproduce the old behavior if the change breaks edge cases. Production prompt engineering requires the same rigor as code engineering: version control, regression testing, A/B comparison, and evidence-based optimization decisions.

| Versioning Practice | Purpose | Tool |
|-------------------|---------|------|
| Git-based prompt storage | Reproduce past behavior, diff changes, roll back regressions | Git repository with semantic versioning |
| A/B variant testing | Compare prompt versions with quantitative metrics | Microsoft Foundry evaluation runs |
| Automated regression testing | Detect quality degradation before production deployment | CI/CD integration with evaluation SDK |
| Semantic diff analysis | Understand which prompt changes caused which behavioral changes | Prompt diff + test delta correlation |

## Store prompts as versioned artifacts in source control

System prompts are code. They define behavior, they change over time, they have bugs, they need debugging. Store them in Git repositories with the same discipline you apply to application code.

Create a prompt repository structure that supports multiple agents and prompt versions:

```
prompts/
├── agents/
│   ├── clinical-agent/
│   │   ├── v1.0.0.txt          # Initial production version
│   │   ├── v1.1.0.txt          # Added injection defense instructions
│   │   ├── v1.2.0.txt          # Refined escalation triggers
│   │   └── v2.0.0.txt          # Major revision: new reasoning structure
│   ├── medication-safety-agent/
│   │   ├── v1.0.0.txt
│   │   └── v1.1.0.txt
│   └── lab-interpreter-agent/
│       └── v1.0.0.txt
├── schemas/
│   ├── clinical_decision_output.json
│   └── medication_analysis_output.json
└── tests/
    ├── behavioral_stability_tests.json
    └── clinical_accuracy_tests.json
```

Use semantic versioning to signal change impact. Major version increments (1.x.x → 2.x.x) indicate breaking changes where agent behavior significantly differs — new reasoning structure, different output format, expanded scope. Minor version increments (1.1.x → 1.2.x) indicate backward-compatible improvements — refined instructions, better injection defenses, clearer escalation triggers. Patch version increments (1.1.1 → 1.1.2) indicate bug fixes or clarifications that don't change intended behavior.

Git commit messages document the behavioral intent of each change, not just text changes. Bad commit message: "Updated system prompt." Good commit message: "Add explicit persona stability instructions to resist authority assertion attacks. Addresses test failures in behavioral_stability_tests.json cases 015-018. Pass rate improves from 87% to 94%."

Branching supports experimental prompt variants. Create a feature branch for a new reasoning approach. Test it against your evaluation dataset. If quality metrics improve, merge to main. If metrics degrade, the branch documents what you tried and why it didn't work — preventing future teams from repeating unsuccessful experiments.

Tags mark production-deployed versions. When you deploy v1.2.0 to production, create a Git tag `production-2026-04-07`. This creates a permanent marker of what prompt version was running on what date. If you need to investigate production behavior from two months ago, you check out that tag and see exactly what system prompt was active.

## Run A/B tests to compare prompt variants quantitatively

Intuition says the new prompt is better. Evidence says you need metrics. A/B testing compares two prompt versions against the same evaluation dataset and measures quality differences objectively.

Design A/B tests that isolate one variable. Don't change reasoning structure, injection defenses, and output format simultaneously — you won't know which change caused quality differences. Change reasoning structure only. Test both prompts. Measure coherence, groundedness, and clinical accuracy. Select the winner based on data.

Northwind Health's prompt team tests two variants for their medication review agent: variant A uses a simple "analyze this medication list" instruction, while variant B uses nested reasoning with explicit steps ("extract each medication → check pairwise interactions → assess with patient's renal function"). On a 127-case evaluation set, variant B scores 0.89 groundedness versus variant A's 0.82 — because the structured reasoning forces the agent to cite specific interaction mechanisms rather than making general safety statements.

Your A/B test workflow:

1. **Define evaluation metrics**: What defines quality for your agent? Clinical accuracy (does the recommendation align with evidence-based guidelines)? Groundedness (are conclusions supported by cited facts)? Coherence (is reasoning logical and traceable)? Safety (does the agent refuse unsafe requests)?

2. **Create evaluation dataset**: Build a test set that covers typical cases, edge cases, and adversarial cases. Include ground truth labels where possible (known correct answers for clinical scenarios). Include safety test cases (injection attempts, authority assertions).

3. **Run both prompts against the dataset**: Use Microsoft Foundry evaluation runs to test prompt variant A and prompt variant B on the same inputs. Collect quality scores for each metric.

4. **Compare distributions, not single numbers**: Don't just compare average scores. Look at the distribution of scores across the dataset. Does variant B improve average accuracy but produce more extreme failure cases? That's a quality-stability trade-off.

5. **Make evidence-based selection**: Select the prompt that optimizes your priority metric while maintaining acceptable performance on other metrics. Document the decision and the supporting data.

The following code runs both prompt variants through an identical evaluation pipeline and compares their quality scores:

```python
from azure.ai.evaluation import evaluate, GroundednessEvaluator, CoherenceEvaluator, RelevanceEvaluator
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import os
import pandas as pd

# Initialize inference client
chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
    credential_scopes=["https://cognitiveservices.azure.com/.default"],
)

# Configure model for evaluators
model_config = {
    "azure_endpoint": os.environ["AZURE_OPENAI_ENDPOINT"],
    "azure_deployment": os.environ["AZURE_OPENAI_DEPLOYMENT"],
}

# Load prompt variants
system_prompt_v1 = open("prompts/agents/clinical-agent/v1.1.0.txt").read()
system_prompt_v2 = open("prompts/agents/clinical-agent/v1.2.0.txt").read()  # Candidate variant

# Load evaluation dataset
eval_data = pd.read_json("tests/clinical_accuracy_tests.json")

def run_agent_with_prompt(system_prompt, user_input):
    """Execute agent with given system prompt."""
    response = chat_client.complete(
        model=os.environ["MODEL_DEPLOYMENT_NAME"],
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_input}
        ]
    )
    return response.choices[0].message.content
```

The setup phase initializes the Azure AI Evaluation SDK with the inference client, evaluator model configuration, and both prompt versions. The helper function wraps the completion call so each prompt variant can be tested against the same evaluation dataset.

```python
# Run evaluation for variant A (baseline)
eval_results_v1 = evaluate(
    evaluation_name="clinical-agent-v1.1.0",
    data=eval_data,
    evaluators={
        "groundedness": GroundednessEvaluator(model_config=model_config),
        "coherence": CoherenceEvaluator(model_config=model_config),
        "relevance": RelevanceEvaluator(model_config=model_config)
    },
    evaluator_config={
        "default": {
            "model_config": {
                "azure_deployment": "gpt-4o-eval"
            }
        }
    },
    output_path="./eval_results_v1"
)

# Run evaluation for variant B (candidate)
eval_results_v2 = evaluate(
    evaluation_name="clinical-agent-v1.2.0",
    data=eval_data,
    evaluators={
        "groundedness": GroundednessEvaluator(model_config=model_config),
        "coherence": CoherenceEvaluator(model_config=model_config),
        "relevance": RelevanceEvaluator(model_config=model_config)
    },
    evaluator_config={
        "default": {
            "model_config": {
                "azure_deployment": "gpt-4o-eval"
            }
        }
    },
    output_path="./eval_results_v2"
)
```

Each variant runs through an identical evaluation pipeline measuring groundedness, coherence, and relevance. Using the same dataset and evaluator configuration ensures that performance differences reflect actual prompt quality, not evaluation methodology variance.

```python
# Compare results
print("\n=== A/B Test Results ===")
print(f"\nVariant A (v1.1.0) - Baseline:")
print(f"  Groundedness: {eval_results_v1['metrics']['groundedness.groundedness']:.3f}")
print(f"  Coherence:    {eval_results_v1['metrics']['coherence.coherence']:.3f}")
print(f"  Relevance:    {eval_results_v1['metrics']['relevance.relevance']:.3f}")

print(f"\nVariant B (v1.2.0) - Candidate:")
print(f"  Groundedness: {eval_results_v2['metrics']['groundedness.groundedness']:.3f}")
print(f"  Coherence:    {eval_results_v2['metrics']['coherence.coherence']:.3f}")
print(f"  Relevance:    {eval_results_v2['metrics']['relevance.relevance']:.3f}")

# Calculate deltas
groundedness_delta = eval_results_v2['metrics']['groundedness.groundedness'] - eval_results_v1['metrics']['groundedness.groundedness']
coherence_delta = eval_results_v2['metrics']['coherence.coherence'] - eval_results_v1['metrics']['coherence.coherence']
relevance_delta = eval_results_v2['metrics']['relevance.relevance'] - eval_results_v1['metrics']['relevance.relevance']

print(f"\nDelta (B - A):")
print(f"  Groundedness: {groundedness_delta:+.3f} ({groundedness_delta/eval_results_v1['metrics']['groundedness.groundedness']*100:+.1f}%)")
print(f"  Coherence:    {coherence_delta:+.3f} ({coherence_delta/eval_results_v1['metrics']['coherence.coherence']*100:+.1f}%)")
print(f"  Relevance:    {relevance_delta:+.3f} ({relevance_delta/eval_results_v1['metrics']['relevance.relevance']*100:+.1f}%)")

# Decision logic
if groundedness_delta > 0.05 and coherence_delta >= 0 and relevance_delta >= 0:
    print("\n✅ RECOMMENDATION: Deploy variant B (v1.2.0)")
    print("   Reason: Significant groundedness improvement with no degradation in other metrics")
else:
    print("\n⚠️  RECOMMENDATION: Keep variant A (v1.1.0)")
    print("   Reason: Insufficient improvement or regression detected")
```

A/B testing removes guesswork from prompt optimization. You don't deploy changes because they "seem better" — you deploy changes because evaluation metrics confirm improvement.

## Evaluate agent-specific behavior with agentic evaluators

The quality evaluators used in A/B testing — groundedness, coherence, relevance — measure response content as if the agent were a static text generator. Production agents have additional failure modes these evaluators don't capture: failing to understand what the user actually needed, calling the wrong tool, or ignoring the constraints defined in their system prompt. The Azure AI Evaluation SDK includes a dedicated agentic evaluator category that targets these agent-specific behaviors.

Three agentic evaluators are directly relevant to Northwind Health's clinical agent:

**`IntentResolutionEvaluator`** measures whether the agent correctly identified and addressed what the user actually needed. A response can be coherent and grounded yet still answer the wrong question — particularly in multi-turn conversations where a patient's real concern surfaces gradually. Intent resolution catches cases where the agent produced a technically accurate response that missed the user's intent.

**`TaskAdherenceEvaluator`** measures whether the agent followed the rules and constraints defined in its system prompt — the same constraints you built in Unit 4. An agent might produce a well-grounded response while silently violating a constraint such as "always require clinician review for medication changes", and no groundedness or coherence metric will flag it. Task adherence is the evaluation counterpart to the system prompt frameworks you design.

**`ToolCallAccuracyEvaluator`** measures whether the agent selected and invoked the correct tools. For a clinical agent that calls drug interaction checkers, dosing calculators, and lab value interpreters, tool selection errors produce confidently wrong recommendations that output-quality evaluators won't detect — because the downstream reasoning looks sound even when it's built on the wrong tool result.

Add agentic evaluators alongside quality evaluators in your evaluation runs to cover both dimensions:

```python
from azure.ai.evaluation import (
    evaluate,
    GroundednessEvaluator,
    CoherenceEvaluator,
    RelevanceEvaluator,
    IntentResolutionEvaluator,
    TaskAdherenceEvaluator,
    ToolCallAccuracyEvaluator,
)

eval_results = evaluate(
    evaluation_name="clinical-agent-v1.2.0-full",
    data=eval_data,
    evaluators={
        # Quality evaluators — response content
        "groundedness": GroundednessEvaluator(model_config=model_config),
        "coherence": CoherenceEvaluator(model_config=model_config),
        "relevance": RelevanceEvaluator(model_config=model_config),
        # Agentic evaluators — agent-specific behavior
        "intent_resolution": IntentResolutionEvaluator(model_config=model_config),
        "task_adherence": TaskAdherenceEvaluator(model_config=model_config),
        "tool_call_accuracy": ToolCallAccuracyEvaluator(model_config=model_config),
    },
    output_path="./eval_results_v2_full"
)
```

Each agentic evaluator returns a pass/fail result with a reasoning explanation. A `task_adherence` failure identifies which system prompt constraint was violated and why. An `intent_resolution` failure surfaces the gap between what the user asked and what the agent addressed. This diagnosis guides the specific prompt change needed rather than requiring trial-and-error reruns.



