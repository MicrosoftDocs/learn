Contoso Capital's single-agent investment research assistant is reaching its limits. Analysts need a production-grade multi-agent platform that coordinates specialized agents for market analysis, fundamental research, risk assessment, and compliance checking. The challenge isn't just orchestration—it's maintaining persistent context across multi-session workflows, implementing multi-step reasoning, and recovering gracefully from interruptions. And as Microsoft Foundry introduces the Agents v2 Responses API, the team needs to understand both the current architecture and the migration path forward.

Building production agents requires designing **stateful agentic loops** that manage complex lifecycle events, implement reflection cycles for quality improvement, and architect session state that persists across service boundaries. If you're familiar with Azure AI Foundry, you've likely created agents and run basic threads. This module builds on those fundamentals to cover production-grade patterns for stateful agent architectures—and introduces the Foundry Responses API (Agents v2) alongside the proven v1 patterns.

In this module, you learn to:

- Design agentic loop event handling for production run lifecycles
- Implement reflection and planning cycles for multi-step reasoning
- Architect session state persistence for long-lived workflows
- Build fork-based session patterns for workflow branching
- Describe the Agents v2 runtime model including agents, conversations, responses, and items
- Migrate stateful agentic loop code from Agents v1 to Agents v2 using the azure-ai-projects 2.x SDK

To recap: in Agents v1, a thread holds conversation history and a run executes the agent. This module covers what happens between runs—run status handling, state persistence, session forking—and introduces the Agents v2 Responses API, where conversations and responses replace threads and runs. No prior experience with Agents v2 is required.
