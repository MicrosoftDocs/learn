Basic agents respond once and stop. Production agents tasked with complex reasoning — financial analysis, diagnostic support, code review — benefit from iterating on their own outputs. **Reflection cycles** implement this multi-pass reasoning pattern, where agents critique and refine their work before delivering final results.

## Understand why reflection matters

Reflection is not retry-on-error. Retry handles transient failures. Reflection implements intentional quality improvement through self-critique. Consider Contoso Capital's investment research workflow: an analyst agent generates a stock recommendation based on market data. Without reflection, that first-pass recommendation ships to clients. With reflection, the agent critiques its own reasoning ("Did I consider regulatory risks? Are my growth assumptions justified?"), identifies gaps, and produces a refined output.

The pattern mirrors human expertise. Senior analysts don't produce final reports in one draft — they write, review, revise. Reflection cycles bring that multi-pass discipline to agent workflows.

| Pattern | When to Use | Typical Iterations |
|---------|-------------|-------------------|
| Plan-then-act | Task requires explicit decomposition | 1 planning + 1 execution |
| Act-then-reflect | Quality improvement on complex outputs | 2-3 critique cycles |
| Iterative refinement | Uncertain solution space, need exploration | 3-5 refinement passes |

## Implement plan-then-act patterns

Plan-then-act separates decomposition from execution. The agent first generates a structured plan, then executes each step. This pattern works when task complexity benefits from explicit planning — multi-step data pipelines, research workflows crossing multiple data sources, or orchestration scenarios requiring dependency management.

Implement planning using structured output with `json_schema` response format. The agent produces a plan as JSON, your orchestration code validates it, then you execute each step:

```python
from azure.ai.agents.models import AgentsResponseFormat

# First run: generate the plan
planning_message = """Analyze MSFT stock. First, create a detailed plan with specific steps. 
Output as JSON: {"steps": [{"step": 1, "action": "...", "rationale": "..."}]}"""

agents_client.messages.create(thread_id=thread.id, role="user", content=planning_message)

run = agents_client.runs.create_and_process(
    thread_id=thread.id,
    agent_id=planner_agent.id,
    response_format=AgentsResponseFormat(type="json_object")
)

messages = list(agents_client.messages.list(thread_id=thread.id))
plan = json.loads(messages[0].text_messages[0].text.value)

# Second run: execute the plan
execution_message = f"Execute this plan: {json.dumps(plan)}. Provide analysis for each step."
agents_client.messages.create(thread_id=thread.id, role="user", content=execution_message)
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=analyst_agent.id)
```

The key insight: planning and execution can use different agents. A specialized planner agent with strong decomposition capabilities generates the plan. A different analyst agent with deep tool access executes it. The thread preserves the plan context, so the executor sees what was intended.

## Implement act-then-reflect patterns

Act-then-reflect produces output first, then critiques it. This pattern suits scenarios where you have clear quality criteria and want iterative improvement. After an agent completes a run, inject a follow-up message asking it to critique its own output, then run again to get the revision.

The implementation uses the thread's message history to maintain context. The agent sees its original output and your critique prompt, producing a refined version:

```python
# First run: generate initial analysis
initial_prompt = "Analyze MSFT stock and provide a buy/hold/sell recommendation with supporting rationale."
agents_client.messages.create(thread_id=thread.id, role="user", content=initial_prompt)
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=analyst_agent.id)

# Extract the initial response
messages = list(agents_client.messages.list(thread_id=thread.id))
initial_response = messages[0].text_messages[0].text.value

# Second run: reflect and refine
critique_prompt = """Review your analysis. Check for:
1. Unsupported assumptions
2. Missing risk factors
3. Incomplete competitive analysis

Provide a revised recommendation addressing any gaps."""

agents_client.messages.create(thread_id=thread.id, role="user", content=critique_prompt)
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=analyst_agent.id)

# The refined output is now in the message history
messages = list(agents_client.messages.list(thread_id=thread.id))
refined_response = messages[0].text_messages[0].text.value
```

The critique prompt controls what aspects get reviewed. Tailor it to your domain — financial analysis checks for risk factors and assumption justification, code review checks for security vulnerabilities and performance concerns, diagnostic support checks for alternative diagnoses.

## Implement iterative refinement with quality thresholds

Iterative refinement runs N cycles of act → reflect → refine until output quality meets a threshold. This pattern handles uncertain solution spaces where the optimal answer emerges through exploration.

Quality thresholds prevent infinite loops. Options include:

- **Confidence scoring**: The agent rates its own confidence 1-10, stop at 8+
- **External validation**: A separate validator agent evaluates output quality, stop when passing
- **Semantic convergence**: Compare output between iterations, stop when changes drop below a threshold

Here's confidence-based termination:

```python
MAX_REFLECTION_CYCLES = 3
confidence_threshold = 8

for cycle in range(MAX_REFLECTION_CYCLES):
    # Run the agent
    run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=analyst_agent.id)
    
    # Ask for confidence rating
    confidence_prompt = "Rate your confidence in this analysis from 1-10. Provide just the number."
    agents_client.messages.create(thread_id=thread.id, role="user", content=confidence_prompt)
    run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=analyst_agent.id)
    
    messages = list(agents_client.messages.list(thread_id=thread.id))
    confidence = int(messages[0].text_messages[0].text.value.strip())
    
    if confidence >= confidence_threshold:
        break
    
    # Inject reflection prompt for next cycle
    reflection_prompt = "Identify the weakest part of your analysis and strengthen it."
    agents_client.messages.create(thread_id=thread.id, role="user", content=reflection_prompt)
```

This approach balances quality with cost. A low threshold (6) terminates early but risks shipping mediocre outputs. A high threshold (9) drives quality up but compounds costs. Empirically, 7-8 works for most production scenarios — agents produce meaningfully better outputs without excessive iteration.

## Balance reflection depth with reasoning budgets

Reflection has real costs. Each cycle runs the model again, consuming tokens and adding latency. The relationship is non-linear — the first reflection cycle typically yields significant quality improvement (15-25% by human evaluation), the second adds incremental value (5-10%), and subsequent cycles plateau.

**Reasoning budget** constraints guide reflection depth:

- **Latency-sensitive workflows** (customer-facing chat): Max 1 reflection cycle, 2-3 total runs
- **Accuracy-critical workflows** (medical diagnostic support): 2-3 reflection cycles, validated by external checks
- **Cost-constrained workflows** (high-volume batch processing): No reflection, optimize prompts for single-pass accuracy

Track cumulative token usage across cycles. If a single-pass analysis consumes 5K tokens, and each reflection cycle adds 4K tokens (re-processing context + new generation), three reflection cycles consume 17K tokens total — a 3.4x multiplier. Factor this into your cost modeling.

## Capture structured reasoning traces

Reflection produces intermediate reasoning that has value beyond the final output. Capture it using structured output formats. Instead of plain text responses, use `json_schema` to extract reasoning steps, confidence levels, and revision rationale:

```python
from azure.ai.agents.models import AgentsResponseFormat, ResponseFormatJsonSchemaType, ResponseFormatJsonSchema

reasoning_schema = {
    "type": "object",
    "properties": {
        "recommendation": {"type": "string"},
        "reasoning_steps": {
            "type": "array",
            "items": {"type": "string"}
        },
        "confidence": {"type": "number"},
        "revision_notes": {"type": "string"}
    }
}

run = agents_client.runs.create_and_process(
    thread_id=thread.id,
    agent_id=analyst_agent.id,
    response_format=ResponseFormatJsonSchemaType(
        json_schema=ResponseFormatJsonSchema(
            name="reasoning_output",
            schema=reasoning_schema
        )
    )
)
```

These traces serve two purposes: they document the agent's decision path for audit and compliance, and they provide training data for future model improvements. Contoso Capital's compliance team reviews reasoning traces for regulatory reporting. The structured format makes automated auditing feasible.

> [!NOTE]
> **Pause and reflect:** Your team is building a clinical report generator that needs high accuracy but also serves hundreds of requests per hour. How would you decide which reflection pattern (plan-then-act, act-then-reflect, or iterative refinement) to use, and what confidence threshold would balance quality with your cost and latency constraints?

Reflection transforms single-pass generation into multi-pass reasoning. The implementation is straightforward — add a critique message and run again. The impact on output quality is measurable. The cost is predictable. Use reflection when output quality justifies the added iteration.

## Apply reflection patterns using the Responses API (v2)

The v1 reflection patterns above use thread message injection: add a critique message to the thread, start a new run, read the result. In Agents v2, the same patterns map to the `previous_response_id` chain — no thread messages to inject, no runs to poll.

### Plan-then-act in v2

In v2, plan-then-act splits across two `responses.create()` calls chained by `previous_response_id`. The first call generates the plan; the second call executes it with full plan context.

```python
import json

# Step 1: Generate structured plan (same instructions, v2 client)
plan_response = openai.responses.create(
    input=(
        "Decompose this task into specific research steps in JSON format: "
        "{\"steps\": [{\"id\": 1, \"action\": \"...\", \"tool\": \"...\"}]}\n\n"
        "Task: Evaluate MSFT as a long-term investment"
    ),
    extra_body={
        "agent_reference": {"name": "investment-analyst", "type": "agent_reference"},
        "text": {"format": {"type": "json_object"}},
    },
)

plan = json.loads(plan_response.output[0].content[0].text)

# Step 2: Execute the plan — chain via previous_response_id
execute_response = openai.responses.create(
    input=f"Execute this investment analysis plan: {json.dumps(plan)}",
    previous_response_id=plan_response.id,
    extra_body={
        "agent_reference": {"name": "investment-analyst", "type": "agent_reference"}
    },
)
```

### Act-then-reflect in v2

Act-then-reflect uses the same `previous_response_id` chain. The critique "message" becomes the input to the next response — no thread injection needed.

```python
def reflect_with_responses(agent_name, initial_input, critique_template, max_cycles=3):
    """Run act-then-reflect cycles using the v2 Responses API."""
    # Initial response
    response = openai.responses.create(
        input=initial_input,
        extra_body={"agent_reference": {"name": agent_name, "type": "agent_reference"}},
    )

    for cycle in range(max_cycles):
        # Extract current output text
        output_text = ""
        for item in response.output:
            if item.type == "message":
                for part in item.content:
                    if hasattr(part, "text"):
                        output_text += part.text

        # Check confidence (same logic as v1)
        confidence = extract_confidence(output_text)
        if confidence >= 0.85:
            break

        # Inject critique as input to next response — chain via previous_response_id
        critique_input = critique_template.format(
            output=output_text,
            cycle=cycle + 1,
        )
        response = openai.responses.create(
            input=critique_input,
            previous_response_id=response.id,
            extra_body={"agent_reference": {"name": agent_name, "type": "agent_reference"}},
        )

    return response
```

The key differences from v1: `previous_response_id` replaces thread message injection; there's no `runs.create_and_process()` or status polling; and you extract output by iterating `response.output` items rather than reading `messages.list()`.

> [!NOTE]
> The `previous_response_id` chain works without a conversation object, making it ideal for stateless reflection flows. For long reflection chains where you need server-managed history, use `conversation.id` instead — see Unit 5 for context management strategy guidance.

## Summary

- **Plan-then-act** separates decomposition from execution using structured JSON output, enabling different specialized agents for planning and execution within the same thread context.
- **Act-then-reflect** injects critique prompts into thread history to drive iterative quality improvement — tailor the critique criteria to your domain (risk factors for finance, vulnerabilities for security).
- **Quality thresholds** (confidence scoring, external validation, semantic convergence) prevent infinite reflection loops while ensuring output meets minimum standards before delivery.
- **Reasoning budgets** should guide reflection depth — the first cycle yields 15-25% improvement but subsequent cycles plateau, creating a 3-4x token cost multiplier that must be factored into cost models.
- **Structured reasoning traces** captured via `json_schema` response format serve dual purposes: audit trail for compliance and training data for future model improvements.
- **Reflection in Agents v2** uses `previous_response_id` chaining in place of thread message injection — chain plan-then-act or act-then-reflect responses by reference, with no run polling required.
