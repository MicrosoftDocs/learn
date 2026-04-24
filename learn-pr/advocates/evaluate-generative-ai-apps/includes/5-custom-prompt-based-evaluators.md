Custom evaluators help you measure qualities that the built-in catalog doesn't fully capture. Examples include brand tone, response format compliance, friendliness, domain-specific policy language, or whether an answer follows your organization's style rules.

## When to use prompt-based evaluators

A prompt-based evaluator uses an LLM judge to score each item against criteria that you define. It is best for subjective or context-sensitive judgments, such as tone, helpfulness, completeness, empathy, or semantic correctness.

If you need deterministic, rule-based validation instead, use a code-based evaluator. Code-based evaluators use a Python `grade(sample, item)` function that returns a float between 0.0 and 1.0 (higher is better), and are a better fit for format checks, keyword rules, or rule-based policy validation. They run in a sandboxed environment with no network access, code size under 256 KB, up to two minutes per grading call, 2 GB of memory, 1 GB of disk, and 2 CPU cores. Any logic that depends on external services should be replaced with a prompt-based evaluator or a separate workflow.

| Evaluator type | Best for | Output contract |
|---------|---------|---------|
|Prompt-based|Subjective quality judgments, tone, semantic nuance, rubric-based scoring|JSON object with `result` and `reason`. The `result` type matches the chosen scoring method: an integer for ordinal, a float for continuous, or a boolean for binary|
|Code-based|Length checks, format validation, keyword rules, deterministic policy checks|Python `grade(sample, item)` function that returns a float between 0.0 and 1.0 (higher is better)|

## How prompt-based evaluators work

A prompt-based evaluator uses a judge prompt template and maps your dataset fields into that template with variables such as `{{query}}`, `{{response}}`, or `{{ground_truth}}`.

Current Microsoft Learn guidance supports three scoring methods:

- **Ordinal**: Integer scores on a discrete scale, such as 1-5
- **Continuous**: Float scores on a range, such as 0.0-1.0
- **Binary**: `true`/`false` for pass-style checks

The prompt must return a JSON object with both a `result` and a `reason`. The `result` type must match the scoring method that you chose.

For example, a friendliness evaluator might use an ordinal 1-5 scale and instruct the judge model to return:

```json
{
  "result": 4,
  "reason": "The response is polite and supportive, but not especially warm."
}
```

## Create and use custom evaluators

Current Foundry guidance lets you create custom evaluators in two ways:

1. In **Evaluation** > **Evaluator catalog** in the Foundry portal
2. Through the Foundry SDK

After creation, add the custom evaluator to an evaluation run just like a built-in evaluator. In the portal, the **Criteria** step prompts for the runtime values the evaluator needs. Prompt-based evaluators require a model deployment and a threshold so the judge model can run and the service can label results as passing or failing. Code-based evaluators require a pass threshold, and the underlying evaluator definition (and SDK initialization) also requires a valid `deployment_name` for run orchestration even though `grade()` itself doesn't call an LLM. You can pass any valid model deployment name from your project. The `grade()` function still returns a float score between 0.0 and 1.0. If a code-based grading call raises an exception or times out, the run records that item as an error and assigns it a `0.0` score, so design the function defensively with `try/except` around risky logic and a clear fallback score.

Use custom evaluators alongside built-in evaluators rather than instead of them. For example, you might pair a custom friendliness evaluator with coherence, groundedness, and safety evaluators to measure both the tone and the trustworthiness of an answer.

> [!NOTE]
> Current Microsoft Learn guidance documents custom evaluators as preview. For the supported workflow, use the current evaluator catalog and SDK documentation rather than older promptflow-era material. See [Custom evaluators](/azure/foundry/concepts/evaluation-evaluators/custom-evaluators) and [Azure OpenAI graders](/azure/foundry/concepts/evaluation-evaluators/azure-openai-graders) when you need SDK-only grading patterns.
