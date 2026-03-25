### Overview

Creating a rigorous ROI analysis is essential for evaluating whether an AI solution will deliver measurable business value. 

### This unit equips solution architects to build a complete ROI analysis using:

- Productivity and efficiency metrics

- Costsavings calculations

- Total cost of ownership (TCO)

- Forecasting models

- Copilot Studio analytics

**Learners will apply a structured methodology to evaluate the ROI of a proposed AI solution for a real business process.**

### By the end of this unit, solution architects will be able to:

- **Define a defensible ROI scope** for an AI solution mapped to a single business process, with clear baselines and guardrails.

- **Quantify time and cost savings** using an agentlevel savings model (perrun and pertool) and translate those savings into financial benefits that align to enterprise KPIs. 

- **Build a complete ROI model** that balances benefits against **total cost of ownership (TCO)** across infrastructure, development/integration, data quality, expertise, and ongoing operations. 

- **Add evidence and ranges** using a simple sensitivity analysis informed by recent field research on knowledgeworker productivity with Copilotstyle tools. 

- **Package the analysis for executive review** with a oneslide summary and a clear pilottoscale recommendation.

### 1. Frame the ROI scope (what, where, who)

- **Goal:** Keep the analysis crisp, measurable, and attributable to a single process.

- **Name the process:** e.g., "Tier1 HR case triage," "Invoice exception handling," "Customer email response."

- **Define boundaries:** inscope steps (A→B→C), handoffs, systems touched, and _what will not change_.

- **Baseline period:** typical month or quarter representing steadystate operations.

- **Baseline metrics:** task volume, average handle time (AHT), rework/error rate, backlog/aging, customer or employee satisfaction proxy.

**_Tip:_** Establish a "noAI" baseline first; you'll compare all benefits back to it.

### 2. Map AI value to measurable levers

Most process gains fall into three buckets:

- **Time saved** per transaction or step (cycletime compression).

- **Quality lift** (error reduction, firstcontact resolution, fewer escalations).

- **Capacity/throughput** (more work per FTE without adding headcount).

Support each lever with _observations you can measure_ (e.g., the step the agent automates, the decision it accelerates, or the draft it prepares).

### 3. Quantify savings with the Savings Calculator (perrun and pertool)

Use the agent **Savings** capability to estimate and then track time or money saved. You can configure:

- **Savings per run** (quick estimate when the run path is predictable).

- **Savings per tool** (granular estimate when an agent uses multiple tools with different impacts).

Admins can disable moneybased savings; if so, keep tracking _time_ and convert to currency in your ROI workbook. Add or edit the Savings panel on the agent's **Analytics** page to keep the model current. 

#### Inputs you'll need

- _Time saved per run_ (minutes).

- _Successful runs_ in period (only resolved runs count).

- _Fully loaded labor rate_ (currency/hour) for the role(s) impacted.

- _(Optional)_ Toolspecific time/cost deltas when using the pertool model.

**Text chart — Savings model (example)**

| **Parameter** | **Value** |
|---|---|
| **Minutes saved per run** | 6 |
| **Successful runs / month** | 20,000 |
| **Labor rate ($/hour)** | 60 |
| **Monthly savings ($)** | **$120,000** |

The calculator stores these estimates and shows trends over time so you can adjust assumptions as adoption changes. 

### 4. Convert time into financial benefits

#### Core formula

- Plain Text

- Annual_Benefit ($) = (Minutes_Saved_per_Run / 60) × Runs_per_Year × Labor_Rate

- Error_Cost_Avoided

- Backlog/Working_Capital Effects (if material)

- Show more lines

**Evidence to calibrate your ranges.** Early field studies on Copilotstyle tools show measurable time reductions in common knowledgework (e.g., faster document creation and reduced time spent reading email). Use these as _directional_ anchors when setting optimistic/expected/conservative ranges—always validated against your baseline. 

### 5. Model TCO (the five cost drivers)

Build a transparent TCO view so your ROI is durable beyond the pilot:

- **Infrastructure** — compute (CPU/GPU) for inference, storage, network/egress, resiliency/HA.

- **Development and integration** — agent design, orchestration, connectors/APIs, auth, compliance, testing.

- **Data quality and preparation** — cleansing/labeling, grounding/indexing, refresh schedules, drift monitoring.

- **Expertise and staffing** — architects, AI/ML engineers, MLOps, SMEs, change management/training.

- **Operations and licensing** — monitoring/telemetry, evaluation/retuning, incident response, consumption or subscription fees. 

- **Text visual — TCO matrix**

Infrastructure   | Compute, storage, network, HA

Dev and Integration| Orchestration, connectors, security testing

Data Quality     | Clean/label, ground/index, refresh, drift

Expertise        | Arch, Eng, MLOps, SME, change mgmt

Operations       | Monitoring, evaluation, retraining, licensing

### 6. Build the ROI, payback, and sensitivity view

#### Simple ROI and payback

- Plain Text

- Net_Benefit = Annual_Benefit - Annual_TCO

- ROI % = Net_Benefit / Annual_TCO × 100

- Payback (months) = Initial_OneTime_Cost / Net_Monthly_Benefit

- Show more lines

_Sensitivity bands_<br>Create **optimistic / expected / conservative** cases by varying:

- Adoption rate (runs per period).

- Minutes saved per run (use measured ranges from Analytics). 

- Labor rates or mix of roles impacted.

- Quality/rework effects (use errorrate deltas).

**Why add ranges?** Stakeholders can see upside and risk. Use the researchanchored directional effects on knowledgework time as justification for your bands while keeping your _own telemetry_ in the driver's seat. 

### 7. Package the executive oneslide

Use a concise summary that decisionmakers can act on:

- **Problem and scope** — where the waste is today.

- **AI intervention** — what the agent automates/augments.

- **Measured impact** — minutes saved, resolved runs, quality lift (from Analytics). 

- **Financials** — annual benefit, TCO, ROI %, payback.

- **Confidence and risks** — sensitivity band and key assumptions.

- **Decision** — "Pilot for 8 weeks with success criteria X; scale to Y units on pass."

#### Worked example (illustrative)

- **Use case:** Customer email triage in shared inboxes

- Minutes saved per message: **1.8** (draft + categorization)

- Monthly volume: **50,000** messages

- Adoption (routed to agent): **60%**

- Labor rate: **$45/hour**

- Annual savings: (1.8/60) × (50,000 × 12 × 0.6) × 45 ≈ $486,000

- Year1 TCO: **$300,000** (onetime + runrate)

- **ROI:** ~62% | **Payback:** ~7.4 months

Replace assumptions with your actual _Savings_ telemetry as it accrues to firm up the case. 

**Professional visuals (text diagrams you can paste into slides)**

**ROI + TCO decision flow**

Business Goal → Pick Process → Baseline → Map AI Levers

            → Configure Savings (per-run | per-tool)

            → Quantify Benefits → Model TCO

            → ROI and Payback → Sensitivity Bands → Pilot → Scale

**Benefits waterfall (text layout)**

Time Savings ($) 

 + Error Avoidance ($)

 + Throughput/Capacity ($)

 = Gross Benefit

 - TCO (Infra + Dev/Int + Data + Expertise + Ops)

 = Net Benefit (ROI%)

### References

- <https://arxiv.org/html/2504.11443v1>

- [https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-cost-savings](/microsoft-copilot-studio/analytics-cost-savings)