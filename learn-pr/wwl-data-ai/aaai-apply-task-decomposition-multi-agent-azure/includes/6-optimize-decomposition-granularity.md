Microsoft Foundry Agent Service supports everything from single-agent execution to complex multi-agent pipelines, so decisions about how many agents to use and where to draw task boundaries directly affect cost, latency, and output quality. This unit walks through how to measure those trade-offs and make decomposition decisions based on data rather than intuition.

## Understand the granularity tension

Task decomposition granularity determines how finely you break work into sub-tasks. Too coarse—one agent handles many concerns, reducing specialization quality and potentially overwhelming a single agent's capabilities. Too fine—many small tasks create high coordination overhead, context fragmentation, and increased latency without proportional quality gains.

For Contoso Capital's research platform, granularity tension appears when deciding whether to split "Analyze company financial health" into one comprehensive task or decompose it into separate tasks for liquidity analysis, profitability assessment, solvency evaluation, and efficiency metrics. The comprehensive approach reduces coordination but demands broad expertise from a single agent. The decomposed approach leverages specialists but introduces four handoffs and requires careful result aggregation.

| Granularity level | Characteristics | When it works | When it fails |
|-------------------|-----------------|---------------|---------------|
| Coarse (1-2 agents) | Minimal coordination, broad agent scope | Simple tasks, tight latency requirements | Complex tasks requiring deep specialization |
| Medium (3-5 agents) | Balanced specialization and coordination | Most analytical workflows | Highly uniform or highly unique tasks |
| Fine (6+ agents) | Maximum specialization, high overhead | Tasks with distinct specialized components | Tasks with shared context throughout |

The optimal granularity depends on task characteristics, available agent capabilities, and quality requirements. Empirical testing across representative workloads provides better calibration than theoretical analysis alone.

## Measure coordination overhead empirically

Coordination overhead is the cost imposed by decomposition itself—API calls to route between agents, token usage for handoff messages, latency added by sequential dependencies, and error propagation risk. Quantify this overhead by comparing decomposed execution against single-agent execution for the same task.

Run controlled experiments using Contoso Capital's equity analysis workflow. Execute identical research queries three ways: no decomposition (one comprehensive agent), medium decomposition (three specialized agents), and fine decomposition (six specialized agents). Measure total latency, API call count, token consumption, and quality scores rated by human analysts.

The data reveals decomposition's actual cost. For Contoso Capital, medium decomposition (three agents) added 8 seconds of latency and consumed 2,400 additional tokens compared to single-agent execution, but quality scores improved by 23%. Fine decomposition (six agents) added 19 seconds and 6,100 tokens while quality improved only 28%—diminishing returns past the medium level.

| Metric | Single agent | Medium (3 agents) | Fine (6 agents) |
|--------|--------------|-------------------|-----------------|
| Total latency | 42s | 50s (+19%) | 61s (+45%) |
| Token consumption | 8,200 | 10,600 (+29%) | 14,300 (+74%) |
| Quality score (0-100) | 72 | 89 (+24%) | 92 (+28%) |
| Cost per query | $0.16 | $0.21 (+31%) | $0.29 (+81%) |

The quality gain from medium to fine decomposition is 3 points (89 to 92) while cost increases by 38% ($0.21 to $0.29). For most use cases, medium decomposition provides better quality-to-cost ratio. Reserve fine decomposition for high-stakes analyses where maximum quality justifies the cost.

## Draw task boundaries at capability interfaces

Effective decomposition divides work at natural capability boundaries—points where one agent's output is a complete, discrete artifact that another agent can consume without needing the source agent's internal context. Poor decomposition splits work at arbitrary points that force receiving agents to reconstruct context or ask follow-up questions.

For Contoso Capital, a natural boundary exists between "Extract financial metrics from SEC filing" and "Benchmark metrics against industry peers." The extraction task produces a complete JSON document with all metrics—the benchmark task consumes this JSON without needing to understand how parsing happened. This is a clean interface.

A poor boundary would split extraction into "Parse first 50 pages" and "Parse remaining pages"—the second agent needs to understand document structure established by the first agent, and final results require merging partially overlapping outputs. This artificial split adds complexity without specialization benefit.

Identify capability interfaces by asking: "Could a different specialist complete the next step using only the output from this step, or do they need to understand how this step worked internally?" If they need internal understanding, the boundary is wrong. Task boundaries should encapsulate implementation details and expose only final deliverables.

## Avoid over-decomposition anti-patterns

Over-decomposition creates tasks so small they contain no useful reasoning—just formatting transformations or simple retrieval operations. These **nano-tasks** should be handled by tools or utility functions, not agents. Routing trivial operations through the agent coordination framework wastes resources.

**Nano-tasking anti-pattern**: Breaking equity analysis into separate agents for "retrieve current stock price," "retrieve 52-week price range," "calculate price change percentage," and "format results as JSON." Each task is trivial—none requires reasoning or domain expertise. The coordination overhead far exceeds the work itself.

**Better approach**: One Data Retrieval Agent handles all market data collection using tool calls to APIs. It returns comprehensive JSON with all market data. The next agent (Equity Analyst) performs actual analytical reasoning on this complete dataset.

**Redundant coordination anti-pattern**: Creating separate tasks that share the same context. For example, routing a company's balance sheet to three agents that each analyze one financial statement section (assets, liabilities, equity) and then aggregating results. These analyses aren't truly independent—understanding equity requires understanding liabilities for debt-to-equity calculations.

**Better approach**: One Financial Analysis Agent reviews the complete balance sheet because all sections inform each other. Decomposition fits when tasks have genuinely different contexts, not when they're artificially splitting unified context.

**Decomposition for its own sake**: Adding agents to demonstrate architectural sophistication rather than solve actual quality problems. If a task rarely fails with a single agent and stakeholders report satisfaction with results, don't decompose it just to use multi-agent patterns. More agents mean more moving parts to debug—only add them when there's a quality problem that actually requires it.

## Recognize when not to decompose

Single-agent solutions with strong system prompts and good tools often outperform multi-agent solutions for tasks where the main challenge is reasoning depth, not parallelism or specialization diversity. Contoso Capital discovered this with macroeconomic analysis requests.

Initial architecture decomposed economic analysis into separate agents for GDP trends, interest rate assessment, inflation analysis, and sector performance. Testing revealed that decomposition hurt quality—economic factors are deeply interrelated, and splitting them prevented agents from recognizing connections between interest rates and sector performance or inflation and GDP growth.

The solution was consolidation: one Economic Analysis Agent with comprehensive economic tool access and a system prompt emphasizing interconnections. Quality scores improved by 15% and latency dropped by 40% compared to the decomposed version. This success came from recognizing that economic reasoning requires integrative thinking, not parallel specialization.

Indicators that single-agent execution is preferable include:

- **High context sharing**: Sub-tasks reference the same data repeatedly
- **Sequential dependencies**: Each task strictly depends on all previous tasks (no parallelism)
- **Integrative reasoning required**: Understanding emerges from considering all factors simultaneously
- **Simple task structure**: The coordination overhead exceeds task complexity
- **Existing agent capability**: One agent already handles the full workflow successfully

## Tune granularity with evaluation metrics

Make granularity decisions data-driven rather than intuitive. Establish evaluation metrics that matter for your use case: quality accuracy, user satisfaction ratings, latency percentiles, cost per query, error rates. Run controlled experiments comparing different decomposition strategies and select based on which best optimizes your priority metrics.

For Contoso Capital, experimentation revealed that different query types have different optimal granularities. Public company analysis benefited from 3-agent decomposition. Private company analysis worked better with 2-agent decomposition because data availability is limited—the coordination overhead of a third agent rarely added value. Macroeconomic queries needed single-agent execution for integrative reasoning.

Implement adaptive granularity where the meta-agent planner selects decomposition depth based on query characteristics:

- **Public company query** → three-agent decomposition
- **Private company query** → two-agent decomposition
- **Macroeconomic query** → one-agent execution
- **Quick lookup query** → Direct tool call, no agent needed

This adaptive approach optimizes for each category rather than forcing uniform architecture across diverse workloads. Track metrics continuously and update routing rules when patterns shift. If private company data availability improves through new data partnerships, retesting might reveal that 3-agent decomposition now provides value.

## Balance quality improvement against cost increase

Every decomposition decision trades cost for quality. Quantify this trade-off explicitly. If adding a third agent improves quality by 8% but increases cost by 45%, is that worthwhile? The answer depends on use case value—for regulatory compliance analysis where errors are expensive, the quality gain justifies cost. For exploratory research where users iterate through many queries, cost efficiency matters more.

Create a quality-to-cost ratio metric: divide quality score improvement by cost increase percentage. For Contoso Capital's experiments:

- **Medium decomposition (3 agents)**: Quality +24% / Cost +31% = 0.77 ratio
- **Fine decomposition (6 agents)**: Quality +28% / Cost +81% = 0.35 ratio

Medium decomposition has a better quality-to-cost ratio—each percentage point of cost increase buys more quality improvement. This metric guides default architecture selection while allowing override for specific high-value analyses.

Present these trade-offs transparently to stakeholders. Product managers need to understand that maximizing quality requires accepting higher costs, while cost optimization means accepting quality plateaus. Data-driven trade-off discussions replace subjective architectural debates with empirical decision-making.

## Key takeaways

- **Granularity tension** exists between fine-grained decomposition (higher specialization quality) and coarse-grained decomposition (lower coordination overhead).
- **Measure coordination overhead empirically**—don't guess. Compare single-agent vs. multi-agent execution time, cost, and quality on the same task set.
- **Draw task boundaries at capability interfaces** where one agent's expertise ends and another's begins, not at arbitrary step divisions.
- **Avoid over-decomposition**—when multiple subtasks share the same context window and capability requirements, they should remain in one agent.
- **Cost-quality trade-off analysis** with empirical data replaces subjective architecture debates with evidence-based decisions.
