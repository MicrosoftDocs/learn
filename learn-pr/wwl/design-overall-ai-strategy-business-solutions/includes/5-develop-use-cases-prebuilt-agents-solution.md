## Unit overview

This unit equips solution architects with expert-level skills to analyze, map, and design high-value business use cases for **prebuilt Microsoft 365 Copilot agents**. Prebuilt agents accelerate productivity by streamlining routine tasks, enabling fast information retrieval, and providing structured guidance across business processes. Prebuilt agents deliver value quickly because they do not require custom development, yet remain customizable through organizational knowledge and configured behaviors.

This unit synthesizes foundational principles of AI agents, core use case patterns, and applied scenario mapping techniques used by architects to translate business needs into effective agent-powered solutions.

## Understanding prebuilt agents

Prebuilt Microsoft 365 Copilot agents are ready-to-use intelligent assistants that help employees complete tasks, retrieve information, and accelerate workflows across Microsoft 365 applications.

These agents simplify common tasks such as:

- Summarizing long documents, chat threads, or emails
- Retrieving organizational knowledge quickly

- Drafting communications or reports

- Providing guidance based on company policies

- Assisting with routine operational workflows

Prebuilt agents are especially effective when:

- Business processes depend on frequently accessed information

- Tasks are repetitive and high-frequency

- Manual search or drafting consumes time

- Standardization of responses improves quality

- Employees work across Microsoft 365 (Teams, Outlook, Word, etc.)

Foundational training emphasizes that AI agents deliver value by reducing effort, improving decision accuracy, and accelerating knowledge-driven tasks.

## Identifying high-value use cases

Solution architects determine candidate use cases by analyzing:

- **Task repetitiveness**: How often the task occurs per user per week

- **Knowledge intensity**: Volume of data needed to effectively answer or complete tasks

- **Pain points**: Delays, errors, bottlenecks, or ingestion-heavy workflows

- **ROI KPIs impacted**: Hours saved, reduction in ticket volume, faster cycle time

The Microsoft Scenario Library supports identifying functional areas—such as IT, HR, Finance, Sales, or Operations—and mapping Copilot capabilities to processes. For more information, see [Microsoft Scenario Library](https://adoption.microsoft.com/scenario-library/).

### Common use case categories

#### Knowledge answering & search

Employees often struggle to find policy, HR, or procedural information scattered across documents and chats. Prebuilt agents return immediate, contextual answers.

#### Document summarization & reporting

Agents synthesize large volumes of information into digestible summaries, making them ideal for operational planning, stakeholder updates, or daily reports.

#### Travel & guidance agents

Example: The Safe Travels agent offers structured travel assistance, demonstrating how prebuilt agents deliver consistent guidance via predefined instructions and templates.

#### Research and analysis agents

Agents can research topics using defined boundaries for gathering additional  sources of information on a topic or request. Agents can also analyze large sets of data to provide additional insights and KPIs for users. 

#### Productivity workflows

Prebuilt agents simplify repetitive communication, meeting preparation, and follow-up tasks to improve employee throughput and reduce noise.

[/azure/cloud-adoption-framework/ai-agents/responsible-ai-across-organization](/azure/cloud-adoption-framework/ai-agents/responsible-ai-across-organization)

## Mapping business processes to prebuilt agent capabilities

### Process identification

Architects evaluate:

- Where employees lose time searching for information

- Steps filled with manual review or drafting

- Frequent questions routed to support teams

- Tasks that follow a predictable workflow pattern

### Task-to-agent capability matching

Use the following alignment approach:

| **Process Step** | **Agent Capability** | **Fit Indicators** |
|---|---|---|
| **Searching for documents** | Retrieval | Distributed content / slow manual navigation |
| **Drafting emails or reports** | Summarization & Generation | High writing load, standardized formats |
| **Providing policy answers** | Knowledge QA | Policies stored in Microsoft 365 |
| **Gathering daily insights** | Synthesis | Multiple info sources / operational updates |

### Feasibility evaluation

Architects confirm:

- Required data exists in Microsoft 365

- Interaction model fits conversational patterns

- No advanced multi-agent orchestration is required

- Output accuracy expectations align with retrieval-first responses

This mirrors guidance for quickly deploying prebuilt agents with minimal configuration while still enabling tailoring.

### Example use case blueprints

#### HR policy assistant

Business Need: Employees frequently ask HR policy questions.

Agent Actions: Retrieve relevant policy information; summarize answers; provide clear response.

Expected Outcome: Lower HR workload, fast self-service answers, consistent guidance.

#### Operations daily summary assistant

Business Need: Managers spend time consolidating updates across dashboards, chats, and email.

Agent Actions: Summarize daily updates; produce consolidated insights for planning.

Expected Outcome: Improved operational alignment and decision speed.

#### Travel guidance assistant

Business Need: Employees need consistent guidance for corporate travel.

Agent Actions: Provide travel rules, health/safety guidelines, documentation requirements.

Expected Outcome: Reduced confusion, faster planning, fewer support inquiries.

## References

- Introduction to developing AI agents. [/training/modules/introduction-develop-ai-agents](/training/modules/introduction-develop-ai-agents)

- Enhance productivity with prebuilt agents. [/training/paths/enhance-productivity-prebuilt-agents](/training/paths/enhance-productivity-prebuilt-agents)

- Microsoft Copilot scenarios. [https://copilotscenarios.microsoft.com](https://copilotscenarios.microsoft.com)

- Agent Academy — using prebuilt agents. [https://microsoft.github.io/agent-academy/recruit/05-using-prebuilt-agents/](https://microsoft.github.io/agent-academy/recruit/05-using-prebuilt-agents/)