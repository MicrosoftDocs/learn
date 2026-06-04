Microsoft Foundry provides the evaluation infrastructure to collect and aggregate quality signals across all layers of your multi-agent system. You use Foundry's measurement capabilities to define success metrics that capture end-to-end customer outcomes, not just individual agent performance.

## Understand the four evaluation targets

Effective multi-agent evaluation addresses four targets, each with distinct measurement strategies:

| Evaluation target | What you measure |
|---|---|
| **Memory evaluation** | Whether the agent recalls past context correctly. Measures whether memory injection improves accuracy and whether failure modes like sliding-window amnesia and summary drift reduce quality. |
| **Knowledge evaluation** | Whether the retrieval-augmented generation (RAG) pipeline retrieves the right documents. Measured by nDCG, MRR, and downstream answer accuracy. |
| **Tool evaluation** | Whether tools return correct results within SLA. Measured by tool result validation accuracy and circuit-breaker activation rates. |
| **Prompt evaluation** | Whether prompts produce consistent, high-quality outputs across input variations. Measured by A/B variant testing with semantic diff and regression stability. |

System-level evaluation, the primary focus of this module, measures whether the combination of memory, knowledge, tools, and prompts produces correct end-to-end task completion. Individual-target evaluation identifies which layer is failing when system-level quality degrades.

Microsoft Foundry provides the evaluation infrastructure to collect and aggregate quality signals across all layers of your multi-agent system. Evaluating individual agent correctness—"Did the orchestrator agent answer the question accurately?"—doesn't measure whether the customer's complete journey succeeded. A product search agent may return perfect product details while the orchestration layer routes to the wrong next agent, causing customer confusion despite technically correct individual responses. System-level metrics measure end-to-end outcomes rather than component performance.

| Metric level | Question answered | Example |
|--------------|-------------------|---------|
| Component-level | Did this agent execute its task correctly? | Product search returned accurate SKU |
| System-level | Did the customer accomplish their goal? | Order placed successfully with correct items |

## Measure task completion rate

Task completion rate serves as the primary system metric: was the customer's original intent fully accomplished by the end of the interaction? This metric requires defining task-specific success criteria for each interaction type Adventure Works supports.

For product search interactions, task completion means the customer found relevant products matching their query. Success criteria: at least one product returned, products match the query category, and pricing information is current. For order placement interactions, task completion means the order entered the system with correct items, quantities, shipping address, and payment method. For returns processing, success means the return authorization generated with correct refund amount, return shipping label provided, and timeline expectations set.

Each interaction type needs explicit binary success criteria—either the task completed or it didn't. This binary assessment enables straightforward tracking: Adventure Works currently achieves 82% task completion across all interaction types, with product search at 94%, order placement at 89%, and complex multi-item modifications at 67%. The low completion rate for complex scenarios reveals where multi-agent coordination struggles.

Implement task completion as a function that maps interaction type to its success criteria and evaluates the outcome:

```python
from dataclasses import dataclass
from typing import Dict, List, Optional

@dataclass
class InteractionOutcome:
    interaction_id: str
    interaction_type: str  # "product_search", "order_placement", "return", "multi_item_mod"
    agent_responses: List[Dict]
    final_state: Dict

def compute_task_completion(outcome: InteractionOutcome) -> bool:
    """Evaluate whether the customer's original intent was fully accomplished."""
    criteria = {
        "product_search": lambda o: (
            len(o.final_state.get("results", [])) > 0
            and o.final_state.get("category_match", False)
            and o.final_state.get("pricing_current", False)
        ),
        "order_placement": lambda o: (
            o.final_state.get("order_id") is not None
            and o.final_state.get("items_verified", False)
            and o.final_state.get("payment_confirmed", False)
        ),
        "return": lambda o: (
            o.final_state.get("return_auth_id") is not None
            and o.final_state.get("refund_amount", 0) > 0
            and o.final_state.get("label_generated", False)
        ),
    }
    evaluator = criteria.get(outcome.interaction_type)
    if evaluator is None:
        raise ValueError(f"No success criteria defined for {outcome.interaction_type}")
    return evaluator(outcome)
```

The function returns a simple boolean—did the task complete or not? This feeds directly into the task completion rate metric: `completed_count / total_count`.

## Apply the goal achievement index

Binary task completion provides a clear outcome metric, but it loses nuance—a nearly successful interaction that fails on a single detail scores the same as an interaction that fails completely. The goal achievement index provides graduated scoring that captures how close the agent system came to success.

Design the index with a 0-10 scale decomposed into weighted subgoals. For Adventure Works order interactions:

- **Information accuracy** (0-3 points) measures whether product details, pricing, and availability information were correct.
- **Action correctness** (0-4 points) measures whether the intended transaction (purchase, return, modification) executed properly.
- **Customer effort minimization** (0-3 points) measures whether the customer received clear guidance without frustrating dead ends or contradictory information.

A perfect interaction scores 10: all information accurate (3), transaction executed correctly (4), and customer effort minimal (3). A failed order with some correct product information but a payment processing error might score 5: partial information accuracy (2), failed transaction (0), and moderate customer effort (3). This granularity reveals improvement opportunities. If most failures score 6-7, small fixes could convert them to successes. If most failures score 1-2, fundamental capability gaps exist.

Implement the goal achievement index as a weighted sum of sub-goal scores:

```python
def compute_goal_achievement(outcome: InteractionOutcome) -> float:
    """Compute a 0-10 goal achievement score from weighted subgoals."""
    sub_goals = {
        "information_accuracy": {"max": 3, "weight": 0.3},
        "action_correctness":   {"max": 4, "weight": 0.4},
        "effort_minimization":  {"max": 3, "weight": 0.3},
    }
    
    scores = evaluate_sub_goals(outcome)  # Returns {"information_accuracy": 2, ...}
    
    total = 0.0
    for goal_name, config in sub_goals.items():
        raw = scores.get(goal_name, 0)
        normalized = raw / config["max"]  # 0.0 to 1.0
        total += normalized * config["weight"]
    
    return round(total * 10, 1)  # Scale to 0-10
```

The weighted structure lets you adjust emphasis as the platform matures—early focus might weight action correctness higher, while mature platforms shift weight toward effort minimization.

## Evaluate journey coherence

Multi-step interactions can complete individual steps correctly while producing a confusing or contradictory overall experience. Journey coherence measures whether the agent's multiple responses across a session form a logically consistent narrative.

An incoherent journey example: The customer asks about returning a damaged item. The first agent response confirms the return policy allows damaged item returns within 30 days. The second response, after asking about the order date, states that returns aren't possible because the item was a final sale. The third response, after the customer expresses confusion, offers a store credit solution—contradicting the previous "returns aren't possible" statement. Each individual response may contain factually correct information, but the sequence creates customer frustration.

Measuring journey coherence requires evaluating the interaction as a whole rather than summing individual response scores. LLM-as-judge evaluation works well for this assessment: provide the complete interaction transcript to a judge model with the prompt "Does this conversation maintain logical consistency throughout? Rate 0-10 and explain any contradictions." This holistic evaluation catches coherence failures that component-level metrics miss.

A minimal journey coherence scorer using an LLM-as-judge follows this pattern:

```python
import json
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential

def score_journey_coherence(transcript: List[Dict], client: ChatCompletionsClient) -> float:
    """Score 0-10 journey coherence using LLM-as-judge."""
    rubric = (
        "Evaluate this multi-agent conversation transcript for logical consistency.\n"
        "Score 0-10 where:\n"
        "  0-3: Major contradictions between agent responses\n"
        "  4-6: Minor inconsistencies that could confuse the customer\n"
        "  7-9: Mostly consistent with minor style differences\n"
        "  10: Fully consistent narrative throughout\n"
        "Return JSON: {\"score\": <int>, \"contradictions\": [<str>]}\n\n"
        f"Transcript:\n{json.dumps(transcript, indent=2)}"
    )
    response = client.complete(
        messages=[{"role": "user", "content": rubric}],
        response_format={"type": "json_object"},
    )
    result = json.loads(response.choices[0].message.content)
    return result["score"]
```

This scorer returns a numeric coherence rating that feeds into the system health scorecard. The contradiction list provides actionable diagnostics for identifying which agent transitions cause coherence failures.

## Track business impact metrics

AI quality metrics (accuracy, task completion rate, goal achievement scores) don't always correlate perfectly with business outcomes. An agent might achieve high task completion rates using excessive escalations to human support—technically completing tasks but failing the business goal of automation. Track business impact metrics alongside AI quality metrics to ensure optimization efforts improve outcomes, not just scores.

**Customer resolution rate** measures whether customers consider their issue resolved without needing escalation to human support. If task completion rate is 85% but customer resolution rate is only 60%, many "completed" tasks didn't actually satisfy customers—they escalate anyway, seeking different solutions.

**Session reopen rate** measures whether customers return to support for the same issue. If a customer's order modification "completes" but they open a new session 4 hours later asking why their order still shows the old configuration, the initial completion was illusory. High reopen rates indicate the multi-agent system creates outcomes that don't match customer expectations.

**Escalation rate** tracks how often automated interactions hand off to humans. Unlike resolution rate (customer satisfaction), escalation rate measures agent capability boundaries. A 15% escalation rate may be acceptable for complex product selection but indicates serious problems for routine order status queries.

For Adventure Works, the metric dashboard combines these three levels:

```
System Health Scorecard - Week of April 1-7, 2026

AI Quality Metrics:
- Task completion rate: 82% (target: 90%)
- Avg goal achievement index: 7.8/10 (target: 8.5)
- Journey coherence score: 8.2/10 (target: 9.0)

Business Impact Metrics:
- Customer resolution rate: 76% (target: 85%)
- Session reopen rate: 12% (target: <8%)
- Escalation rate: 14% (target: <10%)

By Interaction Type:
┌────────────────────┬──────────┬──────────┬────────────┐
│ Type               │ Task     │ Resolve  │ Escalate   │
│                    │ Complete │ Rate     │ Rate       │
├────────────────────┼──────────┼──────────┼────────────┤
│ Product search     │ 94%      │ 91%      │ 4%         │
│ Order placement    │ 89%      │ 85%      │ 8%         │
│ Order status       │ 96%      │ 94%      │ 2%         │
│ Returns            │ 78%      │ 70%      │ 22%        │
│ Multi-item mods    │ 67%      │ 58%      │ 28%        │
└────────────────────┴──────────┴──────────┴────────────┘
```

This hierarchy reveals that multi-item modifications need attention—low task completion, low customer resolution, and high escalation indicate this interaction type exceeds current agent capabilities.

## Design metric aggregation hierarchies

A 14-agent system doesn't have one evaluation score—it has scores for each agent plus system-level aggregations. Design a three-tier metric hierarchy:

**Tier 1: System-level dashboard** displays aggregate metrics for the entire multi-agent platform: overall task completion rate, average goal achievement index, end-to-end journey coherence, and business impact metrics. This tier answers "Is the system healthy overall?"

**Tier 2: Journey-type breakdown** segments system metrics by interaction type: product search, order placement, returns processing, shipping modifications, and account management. This tier answers "Which customer scenarios need improvement?"

**Tier 3: Per-agent component metrics** shows each agent's individual performance: accuracy on its specialized task, latency, error rate, and token consumption. This tier answers "Which specific agent needs optimization?"

Navigation flows from broad to specific: the system dashboard shows task completion dropped to 78% (below target). The journey-type breakdown reveals returns processing at 68% (dragging down the average). The per-agent view shows the returns validation agent at 88% accuracy but the refund calculation agent at 72%—identifying the specific component requiring attention.

This hierarchy prevents both premature optimization (fixing individual agents that aren't impacting system metrics) and ineffective investigation (staring at system-level numbers without drilling into root causes). Adventure Works' weekly quality review starts at Tier 1, identifies problem areas at Tier 2, and assigns fixes at Tier 3.

## Key takeaways

- **Task completion rate** measures whether customers accomplish their end-to-end goals, not just whether individual agents return correct answers.
- **Goal achievement index** provides graduated 0-10 scoring with weighted subgoals, capturing how close the system came to success beyond binary pass/fail.
- **Journey coherence** evaluates whether multi-agent response sequences form a logically consistent narrative, catching contradictions that component-level metrics miss.
- **Business impact metrics** like resolution rate, session reopen rate, and escalation rate connect AI quality scores to real customer outcomes.
- **Metric aggregation hierarchies** organize evaluation into system, journey-type, and per-agent tiers that guide investigation from broad health to specific component fixes.
