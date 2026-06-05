The Microsoft Foundry `azure-ai-evaluation` SDK lets you implement custom LLM-as-judge evaluators and run batch evaluation across your full test dataset. Traditional deterministic metrics like BLEU scores or exact-match accuracy can't assess whether a 14-agent customer service interaction was genuinely helpful.

## Decompose evaluation into specialized judges

These metrics measure surface-level text similarity but miss semantic correctness, tone appropriateness, and task completion. LLM-as-judge evaluation uses a powerful language model to assess holistic properties: whether responses were factually accurate, whether the customer's request was fulfilled, whether the tone was professional and empathetic, and whether information remained consistent across multiple agent interactions.

| Evaluation approach | Measures | Limitation for multi-agent |
|---------------------|----------|----------------------------|
| BLEU, ROUGE | Text overlap with reference | Can't assess semantic correctness or journey coherence |
| Exact match | Identical output | Too brittle for natural language variety |
| LLM-as-judge | Holistic quality via rubric | Best for semantic and contextual evaluation |

Don't ask one judge to evaluate everything—a single prompt trying to assess factual accuracy, task completion, tone, and consistency simultaneously produces unreliable results. Instead, decompose evaluation into specialized judges, each focused on one criterion with a clear rubric.

The **factual accuracy judge** checks whether the agent provided correct product information, order details, and policy statements. This judge compares agent outputs against ground truth data sources: product catalog, order database, and policy documentation. The prompt specifies: "Given the ground truth product information and the agent's response, rate factual accuracy 0-10. A score of 10 means all facts are correct, 5 means some facts are wrong or missing, 0 means completely incorrect information."

The **task completion judge** assesses whether the customer's stated request was fulfilled. This judge requires understanding the customer's intent and verifying that the final system state matches that intent. For an order modification request, the judge checks: was the order successfully updated in the database, do the updated details match what the customer requested, and did the customer receive confirmation?

The **tone and appropriateness judge** evaluates whether the customer interaction maintained professional, empathetic communication. This judge catches inappropriate responses: overly casual language for serious issues (payment failures, order cancellations), defensive or argumentative tone when addressing customer complaints, or robotic responses lacking empathy when customers express frustration.

The **consistency judge** verifies that information remained coherent across the multi-agent interaction. This judge compares the orchestrator's initial response with downstream agents' responses, checking for contradictions: did the first agent say returns are allowed while a later agent rejected the return, or did pricing information change between the product search and checkout phases?

## Design effective judge prompts

A good judge prompt includes four components: the evaluation rubric defining score meanings, the context providing all information needed for assessment, the specific criterion being evaluated, and the required output format.

Here's a complete task completion judge prompt for Adventure Works:

```python
TASK_COMPLETION_JUDGE_PROMPT = """You are evaluating whether a multi-agent customer service interaction successfully completed the customer's stated task.

EVALUATION RUBRIC:
10 - Task fully completed. All customer requirements met, no errors, confirmation provided
8-9 - Task mostly completed. Minor issues or missing non-essential details
5-7 - Task partially completed. Some requirements met but significant gaps remain
3-4 - Task barely completed. Major requirements not met
1-2 - Task attempted but failed. Customer goal not achieved
0 - No attempt to complete the task

CONTEXT:
Customer's original request: {customer_request}

Complete interaction transcript:
{full_transcript}

System state after interaction:
{system_state}

EVALUATION TASK:
Assess whether the customer's original request was successfully completed by the multi-agent system. Consider:
1. Was the stated goal achieved?
2. Are all required details correct (quantities, pricing, addresses, etc.)?
3. Did the customer receive appropriate confirmation?

OUTPUT FORMAT:
Score: [0-10]
Reasoning: [2-3 sentences explaining the score]
Missing requirements: [List any unfulfilled customer requirements, or "None"]
"""
```

This prompt provides clear scoring criteria, all necessary context, specific evaluation dimensions, and a structured output format.

## Calibrate judge reliability

LLM judges have biases: length preference (favoring longer responses regardless of quality), position bias (rating first examples higher than later ones), and verbosity preference (favoring detailed explanations over concise answers). Calibrate your judge by running it on human-labeled examples and measuring agreement.

Create a calibration dataset: 50-100 interactions labeled by human experts with ground truth scores. Run your judge on these examples and calculate correlation with human scores. Cohen's kappa above 0.7 indicates good agreement. If correlation is low, the judge isn't reliable—revise the rubric, add more context, or try a different judge model.

For Adventure Works, initial calibration showed the task completion judge had 0.62 kappa—moderate agreement but not strong enough for production use. Analysis revealed the judge over-weighted polite language (rating interactions higher if they included "please" and "thank you" regardless of task outcome). Revising the rubric to explicitly state "Ignore politeness; focus only on whether requirements were met" increased kappa to 0.78.

## Use multi-judge consensus

For high-stakes evaluations affecting deployment decisions, use multiple judges and aggregate their scores. Run the same evaluation with three different models (GPT-4o, GPT-4o-mini, and Claude 3.5 Sonnet) or three different prompt variations, then average their scores. This approach reduces individual judge biases—a single judge's length preference gets diluted when averaged with judges using different prompts.

Flag cases with high disagreement (score spread > 3 points) for human review. If one judge rates an interaction 8/10 but another rates it 3/10, the evaluation is uncertain—human review provides the ground truth.

```python
from typing import List, Dict

def task_completion_judge_gpt4o(customer_request: str, transcript: str, 
                                system_state: str) -> Dict:
    """Task completion judge using GPT-4o."""
    # Implementation using GPT-4o
    return {"score": 8, "reasoning": "Task completed with minor gaps"}

def task_completion_judge_gpt4o_mini(customer_request: str, transcript: str,
                                     system_state: str) -> Dict:
    """Task completion judge using GPT-4o-mini."""
    # Implementation using GPT-4o-mini
    return {"score": 7, "reasoning": "Most requirements met"}

def task_completion_judge_claude(customer_request: str, transcript: str,
                                system_state: str) -> Dict:
    """Task completion judge using Claude."""
    # Implementation using Claude
    return {"score": 9, "reasoning": "All requirements satisfied"}

def multi_judge_consensus(customer_request: str, transcript: str,
                         system_state: str) -> Dict:
    """Run multiple judges and aggregate scores."""
    judges = [
        task_completion_judge_gpt4o,
        task_completion_judge_gpt4o_mini,
        task_completion_judge_claude
    ]
    
    results = []
    for judge in judges:
        result = judge(customer_request, transcript, system_state)
        results.append(result)
    
    scores = [r["score"] for r in results]
    avg_score = sum(scores) / len(scores)
    score_spread = max(scores) - min(scores)
    
    return {
        "consensus_score": avg_score,
        "individual_scores": scores,
        "score_spread": score_spread,
        "needs_human_review": score_spread > 3,
        "individual_reasoning": [r["reasoning"] for r in results]
    }

# Usage
result = multi_judge_consensus(
    customer_request="Return damaged chocolate box and get refund",
    transcript="[Full interaction transcript]",
    system_state="Return authorized, refund $45.99 initiated"
)

print(f"Consensus score: {result['consensus_score']:.1f}/10")
print(f"Score spread: {result['score_spread']} points")
if result["needs_human_review"]:
    print("⚠️ High disagreement - flagged for human review")
```

## Integrate with the Microsoft Foundry Evaluation SDK

The Microsoft Foundry `azure-ai-evaluation` package supports custom evaluators through a simple class interface. Define your judge as an evaluator, configure the model endpoint, and run batch evaluation on your test dataset.

```python
from azure.ai.evaluation import evaluate
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import os

# Define custom task completion evaluator
class TaskCompletionEvaluator:
    """Custom evaluator for multi-agent task completion."""
    
    def __init__(self, model_config: dict):
        self.model_config = model_config
        self.chat_client = ChatCompletionsClient(
            endpoint=model_config["endpoint"],
            credential=DefaultAzureCredential(),
        )
    
    def __call__(self, *, customer_request: str, transcript: str, 
                 system_state: str, **kwargs):
        """Evaluate task completion for a single interaction."""
        
        prompt = f"""You are evaluating whether a multi-agent customer service interaction successfully completed the customer's stated task.

EVALUATION RUBRIC:
10 - Task fully completed. All requirements met, no errors
8-9 - Task mostly completed. Minor issues remain
5-7 - Task partially completed. Significant gaps
3-4 - Task barely completed. Major requirements unmet
1-2 - Task failed. Customer goal not achieved
0 - No attempt to complete the task

Customer's request: {customer_request}

Interaction transcript:
{transcript}

System state after interaction:
{system_state}

Provide your evaluation as:
Score: [0-10]
Reasoning: [brief explanation]
"""
        
        # Call judge model
        response = self.chat_client.complete(
            model=self.model_config["deployment"],
            messages=[{"role": "user", "content": prompt}]
        )
        
        # Parse response (simplified - production code needs robust parsing)
        result_text = response.choices[0].message.content
        score = int(result_text.split("Score:")[1].split("\n")[0].strip())
        reasoning = result_text.split("Reasoning:")[1].strip()
        
        return {
            "task_completion_score": score,
            "reasoning": reasoning
        }

# Run evaluation on test dataset
model_config = {
    "endpoint": os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    "deployment": os.environ["MODEL_DEPLOYMENT_NAME"]
}

evaluator_config = {
    "task_completion": TaskCompletionEvaluator(model_config)
}

# Test dataset with ground truth
test_data = [
    {
        "customer_request": "Return damaged item and get refund",
        "transcript": "[Full interaction transcript]",
        "system_state": "Return authorized, refund initiated"
    },
    # ... more test cases
]

# Run batch evaluation
results = evaluate(
    data=test_data,
    evaluators=evaluator_config
)

# Access aggregated summary metrics
avg_score = results.metrics["task_completion.task_completion_score"]
print(f"Average task completion score: {avg_score:.2f}/10")

# Access per-row results for filtering
import pandas as pd
rows_df = pd.DataFrame(results.rows)
low_scoring = rows_df[rows_df["task_completion.task_completion_score"] < 7]
print(f"Evaluations with score < 7: {len(low_scoring)}")
```

> [!NOTE]
> **Pause and reflect:** Your multi-judge consensus shows a score spread of 5 points on 12% of evaluations. How would you investigate whether the disagreement stems from judge prompt ambiguity, genuine evaluation difficulty, or model-specific biases?

This integration enables systematic evaluation at scale: run the judge on 1,000 test interactions, aggregate scores by interaction type, track trends over time, and establish quality gates for deployment.

For common signal types, the `azure-ai-evaluation` SDK also provides built-in multi-agent evaluators to use alongside custom judges: `IntentResolutionEvaluator` (whether the agent correctly identified and acted on the customer's intent), `ToolCallAccuracyEvaluator` (whether tool calls were formed and executed correctly), `TaskAdherenceEvaluator` (whether the agent stayed on task without scope drift), and `ResponseCompletenessEvaluator` (whether the response covered all required elements). Use these pre-built evaluators for standard signal types and reserve custom evaluator classes for domain-specific criteria—such as Adventure Works' business rules for refund calculations or return policy enforcement—that the built-in options don't cover.

## Microsoft Foundry AI Red Teaming Agent

LLM-as-judge evaluation measures quality for expected inputs. The Microsoft Foundry AI Red Teaming Agent extends evaluation to adversarial inputs by systematically probing your multi-agent system with crafted inputs designed to find failures that normal evaluation wouldn't surface.

The AI Red Teaming Agent automates attack-category coverage aligned to the OWASP LLM Top 10: prompt injection attempts (direct and indirect), system-prompt extraction, jailbreak attempts, cross-tenant data leakage probes, and denial-of-service via token-exhaustion payloads. For each category, it generates synthetic adversarial inputs at scale, submits them to your agent endpoints, and evaluates responses for policy violations. The output is a structured report with per-category pass/fail rates.

Use the AI Red Teaming Agent as a complement to LLM-as-judge evaluation in your continuous integration/continuous deployment (CI/CD) pipeline:
- **LLM-as-judge** evaluates quality on production-representative inputs (accuracy, task completion, tone, consistency).
- **AI Red Teaming Agent** evaluates safety and security on adversarial inputs (injection resistance, boundary enforcement, data isolation).

Together, they cover the full quality-and-safety evaluation surface. Schedule the Red Teaming Agent run in your deployment pipeline so that every version produces fresh adversarial test evidence. Compliance frameworks such as SOC 2 and the EU AI Act technical file require this evidence before deployment.

## Key takeaways

- **Specialized judges** decompose evaluation into focused criteria (factual accuracy, task completion, tone, consistency) rather than asking one judge to assess everything.
- **Judge prompts** include four components: evaluation rubric, context, specific criterion, and required output format to ensure consistent scoring.
- **Calibration** maps raw judge scores to actual accuracy using human-labeled datasets, with Cohen's kappa above 0.7 indicating reliable agreement.
- **Multi-judge consensus** runs the same evaluation across multiple models and averages scores to reduce individual judge biases.
- **Microsoft Foundry integration** enables batch evaluation at scale through custom evaluator classes and the `azure-ai-evaluation` SDK.
