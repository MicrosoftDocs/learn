Contoso Capital's investment research platform started with basic orchestration patterns—concurrent agents analyzing market data, sequential handoffs between analysis and reporting. These patterns worked well for proof-of-concept scenarios with three or four agents. Now the platform scales to production: 12 specialized agents handle equities, fixed income, derivatives, geopolitical risk, regulatory compliance, and ESG analysis. When one agent times out, the entire workflow crashes. When market conditions change mid-execution, there's no mechanism to re-route the workflow. The flat orchestration patterns from AI-103 can't handle enterprise-grade requirements for fault tolerance, dynamic coordination, and hierarchical decision-making.

You're the senior AI engineer responsible for evolving Contoso Capital's orchestration architecture. You need patterns that coordinate specialized agents at scale, manage partial failures gracefully, and handle complex dependencies between agent outputs. This module teaches you how to implement advanced multi-agent orchestration patterns in Azure AI Foundry.

In this module, you learn to:

- Differentiate agentic AI from multi-agent AI and decide when multi-agent architectures earn their coordination cost
- Select orchestration architectures (hub-and-spoke, hierarchical, supervisor) based on workflow requirements and failure tolerance
- Implement hub-and-spoke orchestration with spoke agents registered as tools on a central coordinator
- Design parallel agent workflows with synchronization barriers and partial failure policies
- Evaluate orchestration frameworks (Semantic Kernel, LangGraph, AutoGen, CrewAI) for Azure AI Foundry integration

You start by clarifying what "multi-agent" means as an architectural commitment—and when a single-agent solution remains the right choice—before exploring the orchestration patterns that make multi-agent systems work at enterprise scale.
