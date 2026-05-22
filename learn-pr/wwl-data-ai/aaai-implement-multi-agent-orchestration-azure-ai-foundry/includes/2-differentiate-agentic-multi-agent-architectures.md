## Why this distinction matters before you orchestrate

Contoso Capital's leadership has a fair question for you: *do we actually need 12 agents?* The investment platform's first prototype used a single agent with strong tools and a long system prompt—it produced acceptable research reports for simple tickers. The current production design uses 12 specialized agents coordinated by an orchestrator. Before you commit to advanced orchestration patterns, you need a clean answer to leadership's question—one grounded in architecture, not in the assumption that more agents are inherently better.

The answer requires you to separate two terms that vendor marketing constantly conflates: **agentic AI** and **multi-agent AI**. They aren't synonyms. Multi-agent is a strict subset of agentic—every multi-agent system is agentic, but not every agentic system is multi-agent. The orchestration patterns you implement in the rest of this module exist to solve the problems that emerge *only* when you commit to the multi-agent dimension. If you can solve a problem without that commitment, you should—and the vocabulary in this unit gives you the discipline to recognize when you can.

## Define agentic AI

**Agentic AI** describes any AI system whose defining property is **autonomy**: the system chooses its next action rather than executing a fixed pipeline. An agentic system reasons about a goal, decides which tool to call, observes the result, and adapts its plan based on what it learned. It runs a loop—plan, act, observe, and reflect—until a termination condition is met.

The architectural ingredients of an agentic system are the same whether you build it with one agent or many:

- A reasoning loop with explicit termination logic
- Tool use with dynamic tool selection (the agent decides which tool fits the current step)
- Context that accumulates across iterations (so the agent remembers what it has tried)
- Adaptation in response to runtime evidence (failed tool calls, low-confidence intermediate results, new information from retrieval)

Critically, **agentic doesn't mean multi-agent.** A single agent with a strong reasoning loop, a well-designed tool catalog, and reflection cycles is fully agentic. Contoso Capital's original prototype was an agentic system with one agent. It wasn't a multi-agent system.

## Define multi-agent AI

**Multi-agent AI** adds a second defining property on top of agentic: **multiplicity with interaction**. Two or more agents—each with its own role, context, identity, and reasoning loop—coordinate to complete work that no single agent owns end-to-end. The agents may collaborate, hand off, debate, supervise each other, or run in parallel, but the *interaction itself* is doing essential architectural work.

The new ingredients that multi-agent introduces—and that single-agent agentic systems don't need—span multiple topic areas in advanced multi-agent training:

| New concern that multi-agent introduces | Related topic area |
|---|---|
| Pattern selection (hub-and-spoke, hierarchical, supervisor) | Unit 3 of this module |
| Inter-agent message protocols and handoff payloads | Agent collaboration and handoffs |
| Synchronization of parallel agent execution | Unit 5 of this module |
| Per-agent identity, OBO chains, agent-to-agent authentication | Secure multi-agent systems with zero trust |
| Distributed tracing across agents (correlated spans) | Distributed observability |
| Coordinated multi-agent release with version compatibility | CI/CD for multi-agent systems |
| Per-agent cost attribution and chargeback | Multi-agent performance and cost optimization |
| Multi-intervention guardrails on every agent and every handoff edge | Evaluation and responsible AI |

Notice the asymmetry: a single-agent system needs none of these. The decision to go multi-agent therefore commits you to building, operating, and certifying every column in that table.

## The relationship: multi-agent is a subset of agentic

Picture the relationship as two nested concentric circles. The outer circle is **agentic AI**—every system with autonomous reasoning and tool use. The inner circle is **multi-agent AI**—every agentic system that splits the work across two or more interacting agents. Outside both circles sit *nonagentic* AI systems: prompt-engineered chatbots that respond once and stop, embedding pipelines that classify on a fixed schema, deterministic LLM chains where the next step is hard-coded.

A few example classifications using this framework:

| System | Agentic? | Multi-agent? | Why |
|---|---|---|---|
| Contoso Capital's first prototype: one agent with tools for market data, news, filings | Yes | No | One reasoning loop; no second agent involved |
| A document pipeline: extract → summarize → classify, with hard-coded order | No | No | No autonomous decision about the next step |
| A reflection loop: planner agent + critic agent that iterate until quality threshold | Yes | Yes | Two agents with distinct roles interacting |
| Contoso Capital's production platform: 12 specialized agents coordinated by orchestrators | Yes | Yes | Many agents with role separation and explicit coordination |
| A single agent that subprompts itself with different system messages mid-loop | Yes | Debatable | Often called "multi-persona prompting"—same agent, same context. Treat as single-agent agentic for architectural purposes. |

The bottom row describes the trap teams fall into most often in practice. Multiple personas inside one prompt aren't multi-agent—there's one identity, one context, one set of tools. Calling it multi-agent inflates architectural cost without adding architectural benefit.

## The litmus test

When you're not sure which architecture you have—or are evaluating someone else's design—apply this test:

> *If I removed the second agent and made one agent do everything, would the system still work?*

If **yes**, you have an agentic system that *uses* multiple agents (often a stylistic choice—the architecture isn't load-bearing). Consider consolidating. The cost of multi-agent—coordination overhead, deployment complexity, observability surface area, security boundary count—is real. Pay it only when you must.

If **no**, you have a true multi-agent system. The interaction does essential work: different roles with different specializations, parallel execution that single-agent can't match, separation of duties that compliance requires, security boundaries that demand distinct identities, or organizational ownership that maps to agent ownership. Now the orchestration patterns in this module become necessary.

## When multi-agent earns its complexity

Multi-agent is the right commitment when one or more of these conditions hold:

- **Specialization quality**: a domain expert agent with a tightly scoped prompt and tool set outperforms a generalist agent on the specialized task by a margin large enough to justify the coordination cost. Contoso Capital sees this with regulatory compliance—a compliance specialist agent catches issues a generalist research agent misses.
- **Parallel execution**: the work is decomposable into independent sub-tasks where wall-clock latency matters. Running market analysis, fundamental research, and risk assessment in parallel cuts a 30-second sequential workflow to 10 seconds.
- **Separation of duties**: regulatory or organizational requirements demand that the agent making a recommendation can't be the same agent reviewing it. Maker-checker patterns and critic loops fall here.
- **Security boundaries**: different agents need different data scopes, different identities, or different network perimeters. A customer-facing agent shouldn't have direct access to internal compliance systems; the boundary forces a multi-agent split.
- **Independent evolution**: agent capabilities owned by different teams need to ship on different cadences. Splitting them into separate agents lets each team release without coordinating with every other team.

When *none* of these conditions hold, a single strong agent with good tools and reflection cycles is usually the better choice.

## Why this matters for the rest of the module

The remaining units in this module assume you have committed to multi-agent. Unit 3 explains *why flat orchestration patterns break down* once you have many interacting agents. Units 4 and 5 implement two of the three patterns that solve those breakdowns—hub-and-spoke and parallel spawning. Unit 6 surveys the frameworks that make implementation tractable.

Hold on to one thread as you work through them: every orchestration pattern, framework choice, and synchronization technique you encounter exists to manage the complexity that multi-agent introduces. If you ever find yourself implementing one of these patterns for a system that doesn't actually need multi-agent, the right answer isn't a better orchestration pattern—it's to consolidate to a single strong agent.

Now that you can distinguish agentic from multi-agent and decide deliberately when each is the right choice, you're ready to examine why flat orchestration patterns stop scaling at enterprise multi-agent scale.

## Key points

- **Agentic AI** is any system with an autonomous reasoning loop, dynamic tool use, accumulated context, and runtime adaptation—one agent or many.
- **Multi-agent AI** is the strict subset where two or more agents with distinct roles, contexts, and identities coordinate, and the interaction itself does essential architectural work.
- **The subset relationship matters**: every multi-agent system is agentic, but committing to multi-agent commits you to coordination patterns, distributed observability, per-agent identity, coordinated release, and per-agent cost attribution—none of which a single-agent system needs.
- **The litmus test**—*would removing the second agent break the architecture?*—separates real multi-agent commitments from stylistic uses of multiple agents.
- **Multi-agent earns its complexity** when specialization quality, parallel execution, separation of duties, security boundaries, or independent team evolution justify the coordination cost—otherwise consolidate.
- **The rest of this module** teaches the patterns that manage multi-agent complexity—recognize when those patterns are the answer and when consolidation is.
