Microsoft Agent Framework automatically synchronizes full conversation history across all participants in a handoff workflow. This built-in context broadcast is the foundation for the reliability patterns in this unit—you design agents that depend on shared history rather than manually compressed summaries, and structure recovery when handoffs fail.

## Preserve context through partial handoffs

Partial handoffs occur when a specialist completes part of a task and transfers the remaining work to another agent. The handoff includes both **completed work** (for context) and the **remaining task** (what still needs to be done). This pattern is common in Contoso Capital's research workflows when one specialist exhausts its capabilities mid-task.

For example, the Credit Analyst completes debt-to-equity analysis but encounters convertible securities that require equity valuation expertise. It hands off to the Equity Valuation Specialist with: completed debt analysis results, the specific convertible securities needing valuation, and how those valuations should feed back into the overall credit analysis.

Design partial handoff messages to clearly separate completed work from remaining work. The `completed_work` field contains finalized results that don't need revisiting. The `task_description` field describes only the remaining work. This separation helps receiving agents understand exactly what they're responsible for versus what's already done.

## Prevent context collapse in handoff chains

The most common failure in multi-handoff chains is **context collapse**—accumulated information loss through repeated summarization. Agent A summarizes its full analysis into a context summary for Agent B. Agent B further summarizes that summary for Agent C. By the time Agent C receives context, critical details are gone.

Agent Framework's handoff orchestration addresses this by automatically broadcasting each agent's response to all participants in the workflow. Every agent always has the full conversation history when it takes over—not a summary of a summary. The design principle that matters is: **raw data is never summarized more than once**. If your agent instructions ask agents to compress context before handing off, you're reintroducing collapse. Instead, instruct agents to pass specific structured outputs and rely on the framework to maintain full history for the receiving agent.

```python
from agent_framework import Agent
from agent_framework.foundry import FoundryChatClient
from agent_framework.workflows import HandoffBuilder
from azure.identity import DefaultAzureCredential
import os

chat_client = FoundryChatClient(
    project_endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
    model=os.environ["FOUNDRY_MODEL"],
    credential=DefaultAzureCredential(),
)

# Agent instructions focus on OUTPUT, not on compressing context for the next agent
credit_analyst = Agent(
    client=chat_client,
    name="credit_analyst",
    instructions="""You analyze debt structure and credit metrics.
Complete your analysis and return a structured JSON result with:
- debt_to_equity_ratio
- interest_coverage_ratio
- maturity_profile (list of {year, amount_millions})
- credit_assessment (string: STRONG / ADEQUATE / STRESSED)

When you encounter convertible securities, hand off to equity_valuation_specialist.
    Don't summarize prior analysis—return your findings in full structured form.""",
)

equity_specialist = Agent(
    client=chat_client,
    name="equity_valuation_specialist",
    instructions="""You value equity-linked instruments including convertible securities.
The full conversation history (including the credit analyst's findings) is available to you.
Build on the prior credit analysis—don't re-analyze what has already been done.
Return valuation results as JSON with: instrument_type, fair_value_estimate, dilution_impact.""",
)

workflow = (
    HandoffBuilder(
        name="credit_equity_handoff",
        participants=[credit_analyst, equity_specialist],
    )
    .with_start_agent(credit_analyst)
    .add_handoff(credit_analyst, equity_specialist)
    .with_autonomous_mode()
    .build()
)
```

The equity specialist's instructions explicitly acknowledge the full history: "The full conversation history is available to you." This contrasts with the pattern to avoid—instructions that say "here's a summary of what happened before"—which would require the credit analyst to manually compress findings and introduce loss. With Agent Framework broadcasting, the receiving agent's model can query any detail from the full exchange without it being prepackaged.

Apply a chain depth limit as a structural safeguard regardless of the framework's context sync. After three to four handoffs, even with full history, the accumulated context token count grows large enough to affect model performance and increase costs. Track chain depth in workflow output events and consolidate results to the hub orchestrator when the limit is reached rather than continuing the chain:

```python
MAX_HANDOFF_DEPTH = 4
chain_depth = 0
final_results = []

async for event in workflow.stream(research_query):
    if event.type == "output":
        chain_depth += 1
        final_results.append({
            "agent": event.data.agent_name,
            "content": event.data.message.content,
        })
        if chain_depth >= MAX_HANDOFF_DEPTH:
            # Stop accepting further handoffs—consolidate to hub
            print(f"Chain depth limit reached after {chain_depth} handoffs.")
            print("Consolidating results to hub orchestrator.")
            break
```

The break exits the eventstream when the depth limit is hit. Remaining work at that point should return to the hub orchestrator for a fresh execution plan rather than extending the chain further.

## Design failure recovery for broken handoffs

Handoffs fail when target agents are unavailable, reject tasks, or time out during execution. Design recovery strategies that handle these failures gracefully. When a handoff fails, the coordinator has three options: **retry with same agent** (for transient failures), **reroute to alternative agent** (for capability mismatches), or **escalate to hub** (for persistent failures).

Implement a handoff attempt counter that limits retries. After two failed handoff attempts to different agents, escalate to the hub orchestrator for human review rather than continuing autonomous routing. This escalation prevents infinite handoff loops where agents repeatedly pass tasks they can't handle.

Log all handoff attempts with rich context: source agent, target agent, handoff reason, acceptance/rejection decision, execution results, or failure reasons. This audit trail helps diagnose protocol failures and identify agents that frequently reject or time out on handoffs—signals that capability descriptions might be inaccurate.

For Contoso Capital, handoff failure logging revealed that the International Risk Assessor was rejecting 40% of currency risk handoffs because source agents weren't providing currency denomination details. The fix was updating the handoff schema to require currency information in the context_summary field—a protocol improvement discovered through failure analysis.

## Key takeaways

- **Partial handoffs** separate completed work from remaining work, letting receiving agents understand their responsibilities without reanalyzing what's already done.
- **Context collapse** is the most common failure in handoff chains—prevent it by writing agent instructions that return full structured outputs rather than summaries, and rely on Agent Framework's automatic context broadcast to give receiving agents complete history.
- **Chain depth limits** (three to four handoffs maximum) prevent context management from becoming unwieldy—consolidate results to the hub when chains reach the limit.
- **Failure recovery** follows a three-step escalation: retry same agent → reroute to alternative → escalate to hub. Limit to two attempts before escalation.
- **Handoff failure logging** provides the audit trail needed to diagnose protocol issues and improve capability descriptions over time.
