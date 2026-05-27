Microsoft Agent Framework provides built-in handoff orchestration for the multi-agent pipelines in this unit. You use it to define specialist agents, specify handoff conditions through agent instructions, and build workflows where agents transfer control autonomously—without routing every decision through a central hub.

## Understand when handoff protocols are necessary

In hub-and-spoke orchestration, the central hub controls all routing—agents complete their work and return results to the hub, which decides what happens next. **Handoff protocols** extend this model by allowing peer-to-peer transfers where one specialist agent decides to pass a task directly to another specialist based on its own analysis. This autonomy improves efficiency but requires strict protocol to prevent context loss.

Contoso Capital's research platform encounters handoff scenarios when a specialist agent discovers during analysis that a different specialist is better suited for the remaining work. The SEC Filing Analyzer might extract financial metrics and recognize that the company's foreign operations require currency risk analysis—a capability outside its domain. Rather than returning partial results to the hub and requiring a full rerouting decision, it hands off directly to the International Risk Assessor with complete context.

| Handoff benefit | Without protocol | With protocol |
|-----------------|------------------|---------------|
| Context preservation | Partial results returned to hub, context lost | Complete context transfers directly |
| Routing efficiency | Hub must reanalyze and reroute | Direct peer transfer reduces latency |
| Specialist autonomy | Agents are passive executors | Agents make informed routing decisions |

Handoff protocols define what **must** be included in a transfer, how receiving agents confirm receipt and capability, and how to handle failures. Without protocols, autonomous handoffs create context collapse where each transfer loses information.

## Design comprehensive handoff message schemas

A handoff message is a structured data package that transfers complete execution context from one agent to another. Design a mandatory schema that every handoff must follow. The source agent populates all required fields before initiating the handoff, and the receiving agent validates the schema before accepting.

Required fields for Contoso Capital's handoff schema include: **task description** (what needs to be done), **context summary** (relevant findings so far), **source agent ID** (who's handing off), **confidence level** (0.0-1.0, why the handoff is happening), **reason for handoff** (explicit explanation), **expected output format** (what the source agent needs back), and **timeout constraint** (when results are needed by).

Agent Framework provides a `HandoffBuilder` that handles the orchestration mechanics—validation, context broadcast, and circular routing detection—so you focus on defining agent capabilities and handoff conditions through agent instructions rather than custom protocol code.

```python
from agent_framework import Agent
from agent_framework.foundry import FoundryChatClient
from agent_framework.workflows import HandoffBuilder
from azure.identity import DefaultAzureCredential
import os

# Install: pip install agent-framework-foundry azure-identity
chat_client = FoundryChatClient(
    project_endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
    model=os.environ["FOUNDRY_MODEL"],
    credential=DefaultAzureCredential(),
)

# Create specialized agents with domain-specific instructions
# Each agent's instructions define when to hand off and to whom
sec_analyzer = Agent(
    client=chat_client,
    name="sec_filing_analyzer",
    instructions="""You are a financial document specialist for Contoso Capital.
Extract financial metrics from SEC filings and identify risk factors.
When you identify significant foreign currency exposure (>30% foreign revenue)
or complex international operations, hand off to international_risk_assessor
with: the company name, foreign revenue percentage, primary markets, and
reporting currency extracted so far.""",
)

international_risk = Agent(
    client=chat_client,
    name="international_risk_assessor",
    instructions="""You assess currency exposure risk and geopolitical factors.
Analyze foreign revenue concentration, currency denomination mismatches,
and hedging adequacy. Return a structured JSON assessment with:
currency_risk_score (0-10), hedging_recommendations (list), and
exposure_by_market (dict mapping market to revenue percentage).""",
)

credit_analyst = Agent(
    client=chat_client,
    name="credit_analyst",
    instructions="""You analyze debt structure, credit metrics, and solvency.
Review leverage ratios, interest coverage, and debt maturity profiles.
When you encounter convertible securities or equity-linked instruments,
hand off to international_risk_assessor for currency denomination assessment
if they involve foreign currency obligations.""",
)
```

The agent instructions capture what was previously a handoff message schema: the source agent describes what context it passes (company name, percentages, markets) and the target agent describes the expected output format (JSON structure with specific fields). This design embeds the protocol directly in the agents that use it, rather than in a separate validation class.

Build the handoff workflow with `HandoffBuilder`. The framework automatically injects handoff tools into each agent, broadcasts conversation history to all participants after each turn (so every agent has full context when it takes over), and detects circular routing:

```python
# Build the handoff workflow—Agent Framework handles:
# - Context synchronization: all agents receive full conversation history
# - Circular routing detection: prevents infinite handoff loops
# - Capability acknowledgment: agents accept or decline based on instructions
workflow = (
    HandoffBuilder(
        name="financial_analysis_handoff",
        participants=[sec_analyzer, international_risk, credit_analyst],
    )
    .with_start_agent(sec_analyzer)
    .with_autonomous_mode()  # pipeline runs without waiting for human input each turn
    .build()
)

# Run the analysis—context flows automatically through handoffs
async for event in workflow.stream(
    "Analyze ACME Corp's 10-K filing for investment risks, "
    "including 60% foreign revenue across Brazil, India, and Turkey"
):
    if event.type == "output":
        print(f"[{event.data.agent_name}] {event.data.message.content}")
```

When `sec_analyzer` detects significant foreign exposure, it calls a framework-injected handoff tool to transfer control to `international_risk_assessor`. The framework broadcasts the full conversation history to the receiving agent—no manual context packaging required.

The schema enforces completeness through agent instructions rather than a validation class. The source agent describes exactly what to pass. The target agent describes exactly what it returns. This approach is more maintainable than a separate `HandoffMessage` dataclass because the protocol lives where engineers look first: in the agent instructions.

## Implement acknowledgment and confirmation patterns

In Agent Framework's handoff orchestration, the acknowledgment step is implicit in agent instructions. When the framework's injected handoff tool transfers control to a target agent, that agent responds based on its instructions—if the task falls outside its described domain, it immediately hands off again rather than attempting work it can't perform well.

To make this explicit and traceable, write target agent instructions that include a brief domain statement followed by behavior for out-of-scope requests:

```python
international_risk = Agent(
    client=chat_client,
    name="international_risk_assessor",
    instructions="""You specialize in currency exposure and geopolitical risk for Contoso Capital.
Your domain: foreign revenue concentration, currency denomination risk, hedging analysis,
country-specific regulatory exposure.

Out of scope: equity valuation, credit metrics, SEC filing parsing.
If a task falls outside your domain, explain why and hand off back to sec_filing_analyzer.""",
)
```

This instruction pattern replaces the capability match confidence score from a custom protocol. The agent's model reasons about whether the task matches its described domain and responds accordingly. For high-stakes analyses where a confidence measure is critical, add an explicit confidence field to the expected output format in the source agent's instructions: `"Return JSON with: risk_score, confidence (0.0-1.0), recommendations"`.

To configure specific handoff routing rules—for example, allowing `sec_analyzer` to hand off to `international_risk` but preventing the reverse—use `HandoffBuilder`'s `.add_handoff()` method:

```python
workflow = (
    HandoffBuilder(
        name="financial_analysis_handoff",
        participants=[sec_analyzer, international_risk, credit_analyst],
    )
    .with_start_agent(sec_analyzer)
    .add_handoff(sec_analyzer, international_risk)   # sec_analyzer can hand off to international_risk
    .add_handoff(credit_analyst, international_risk) # credit_analyst can also hand off there
    .with_autonomous_mode()
    .build()
)
```

Explicit routing rules prevent unexpected handoff paths and help the framework detect circular patterns. Even with custom rules, all participants still receive broadcast context after each turn—the topology remains a mesh for context sharing, but the rules control which agent takes over next.

## Key takeaways

- **Handoff protocols** enable peer-to-peer agent transfers when one specialist discovers a task better suited for another, improving routing efficiency over always returning to a central hub.
- **Handoff schemas are defined through agent instructions**—the source agent describes what context it passes, the target agent describes its domain and expected output format. Agent Framework enforces context completeness by broadcasting full conversation history to all participants automatically.
- **Acknowledgment** is implicit in agent instructions: target agents respond based on their described domain. Explicit routing rules via `.add_handoff()` constrain which transfers are permitted and give the framework enough information to catch circular routing before it executes.
