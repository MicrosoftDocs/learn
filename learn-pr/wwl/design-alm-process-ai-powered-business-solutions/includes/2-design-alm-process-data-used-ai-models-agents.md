## Overview

This expert unit equips solution architects to design an application lifecycle management (ALM) process for **all data that powers AI models and agents**. You define data-centric stages, controls, roles, and promotion gates that keep datasets, prompts, knowledge sources, and telemetry **governed, reproducible, and compliant** from inception through retirement. The approach integrates enterprise data governance, regional data movement considerations, and operational monitoring so that AI solutions scale safely across environments.

## Learning objectives

By the end of this unit, learners are be able to:

* Map the **AI data lifecycle** to ALM stages and define artifacts, owners, and promotion gates.

* Design **environment strategies** (Dev/Test/PreProd/Prod) that isolate data and enforce guardrails.

* Specify **data residency and movement** policies for Copilot and agent features.

* Operationalize **quality, lineage, and drift** checks with go/no-go criteria and rollback plans.

* Establish a **RACI** and change workflows for datasets, knowledge sources, and evaluation telemetry.

## ALM foundations for AI data

### Scope the "data" in AI ALM

#### Treat the following as versioned, promotable ALM artifacts:

* **Training & fine-tuning datasets** (raw, curated, feature/embedding sets).

* **Evaluation/Testing datasets** and "golden" sets for regression testing.

* **Grounding knowledge** (SharePoint/OneDrive corpora, Dataverse tables, wikis, KBs).

* **Prompt assets** (system prompts, prompt actions, templates).

* **Policies & guardrails** (DLP, sensitivity labels, allowed connectors, action limits).

* **Run telemetry** (latency, token/cost, success/failure, safety events) and **feedback**.

### Environment strategy

#### Create separate data planes per environment—Dev → Test → Pre-Prod → Prod—with:

* **Least privilege access**; no crossing shared identity.

* **Red gold datasets** pattern: _red_ (mutable, experimental) vs. _gold_ (frozen, promoted).

* **Promotion gates** that require evidence: quality reports, bias checks, lineage, and security signoff.

* **Professional visual—Environment & data flow (text diagram)**<br>Dev (Red data → feature builds) → Test (Repro runs, evaluation sets) → Pre-Prod (Gold candidates) → Prod (Gold only)<br>Controls at each hop: validation → approval → immutable snapshot → catalog update

## The AI data ALM process (end-to-end)

### Phase A—Plan & Catalog

* Identify business scenarios and **data contracts** (purpose, fields, retention, owners).

* Classify sensitivity; apply **sensitivity labels** and register assets in your catalog.

* Define **KPIs** and **risk posture** (PII handling, export boundaries, audit scope).

* **Gate A → B:** Data contract approved; assets discoverable with owners and tags.

### Phase B—Ingest & Prepare

* Profile and remediate quality (missingness, outliers, imbalance).

* Generate **lineage**; stamp **schema versions** and **hashes** for each snapshot.

* Produce **curated** datasets and **feature/embedding** sets with deterministic pipelines.

* **Gate B → C:** Quality and lineage reports; signed reproducibility log.

### Phase C—Develop & Evaluate

* Train/iterate using Dev/Test data; **never** train on production knowledge.

* Run **evaluation suites** (accuracy, safety, robustness, cost) on golden sets.

* Store **model/data cards** with dataset references and context limits.

* **Gate C → D:** Evaluation thresholds met; risk & safety findings addressed.

### Phase D—Stage & Approve

* Perform **privacy, security, and compliance** reviews (DLP, RAI, export controls).

* Execute **canary runs** using masked/representative Prod-like data.

* _Canary testing is a low-risk deployment strategy.
It releases new code to a small, isolated subset of users or servers to identify issues before a full rollout._

* Freeze **gold datasets** and sign **immutability attestations**.

* **Gate D → E:** CAB approval; deployment runbooks and rollback plans ready.

### Phase E—Deploy & Serve

* Promote gold corpora and indexes; **semantic indexing** or retrieval stores refreshed.

* Enforce **region/residency** settings and connector allow/deny lists.

* Register release in **data catalog** and publish **consumer contracts**.

### Phase F—Operate & Monitor

* Track **latency, cost/token, success rate, safety violations, data access denials**.

* Detect **data drift** vs. baselines; trigger **safeguard actions** (circuit breakers, HITL).

* Run scheduled **re-evaluation** with golden sets; file backlog items with trace IDs.

### Phase G—Evolve & Retire

* Rotate or retrain on updated gold sets; **retest** before promote.

* Apply **retention & deletion** policies for expired snapshots and transcripts.

* Preserve **audit trails** and lineage for compliance.

## Controls & checks (what to verify at each promotion gate)

### Text table—ALM gate checks

| **Gate** | **Control area** | **Questions to answer** | **Evidence required** |
|---|---|---|---|
| **A→B** | Catalog & ownership | Is the owner accountable? Is sensitivity labeled? | Data contract; catalog record; label policy proof |
| **B→C** | Data quality & lineage | Is data profiled, balanced, de-identified where needed? | Profiling report; lineage graph; version IDs |
| **C→D** | Evaluation & safety | Do evaluations meet thresholds? Any bias or unsafe patterns? | Metrics pack; safety report; model/data card |
| **D→E** | Compliance & residency | Do region rules and DLP policies permit use? | Residency mapping; DLP rules; approval memo |
| **E→F** | Runtime readiness | Can we monitor, roll back, and cap costs? | Dashboards; alarms; rollback plan; budget guard |

## Region, residency, and cross-border movement

Document **where** prompts/outputs may be processed for Copilot and Power Platform features, and when **cross-region capacity** is required.

In regulated scenarios, set the default to **in-region** and require explicit approval to enable **overflow processing**.

Align **mailbox region** (for activity data) and environment geo with your policy; define exceptions and purge schedules.

Professional visual—Residency decision tree (text)<br>In-region capacity available? → Yes: keep local.<br>No: Is overflow allowed for this workload tier? → If yes, enable cross-region under admin control; else block feature or defer.

## Roles and RACI

## Text RACI—data used in AI models and agents

The below RACI chart is a representative sample for an organization. It's up to the architect on the project to validate and adjust the roles and responsibilities as appropriate for the implementation.

| **Activity** | **Data Owner** | **AI Architect** | **Security/Compliance** | **Platform Admin** | **Product Owner** |
|---|---|---|---|---|---|
| **Define data contract** | **R** | **A** | C | C | C |
| **Classify & label** | **A/R** | C | **C** | C | I |
| **Quality profiling & lineage** | **R** | **A** | C | I | I |
| **Evaluation thresholds** | C | **A/R** | C | I | C |
| **Residency configuration** | C | **A** | **R** | **R** | I |
| **Deployment & rollback** | I | **A** | C | **R** | **R** |
| **Monitoring & drift response** | C | **A** | C | **R** | **R** |
| **Retention & deletion** | **A/R** | C | **C** | I | I |

**Legend:** A = Accountable, R = Responsible, C = Consulted, I = Informed

## Operational telemetry and drift

* Maintain **baseline metrics** per release: latency p95, success %, token/€ per task, safety flags/M runs.

* Compare live to baseline; if drift exceeds thresholds, **auto-open an incident**, route to data owner, and pause affected actions.

* Rerun evaluation suites nightly/weekly against **golden sets**; store time series for audit.

## Checklists you can paste into your runbooks

### Go/NoGo before production

* [ ]  Data contract approved; asset tagged and discoverable.
* [ ]  Sensitivity labels/DLP rules applied; connectors approved.
* [ ]  Lineage graph current; dataset snapshot **immutable** and versioned.
* [ ]  Evaluation thresholds met; safety risks mitigated.
* [ ]  Residency decision recorded; cross-regions toggle reviewed.
* [ ]  Dashboards, budgets, alerts, and rollback validated in Pre-Prod.

### Retirement

* [ ]  Consumers notified; cutover plans executed.
* [ ]  Snapshots archived/deleted per retention; access revoked.
* [ ]  Audit and lineage preserved; catalog updated.

## References

[https://learn.microsoft.com/microsoft-copilot-studio/manage-activity-data-m365](/microsoft-copilot-studio/manage-activity-data-m365)

[https://learn.microsoft.com/power-platform/admin/geographical-availability-copilot#turn-on-data-movement-bing-search-and-m365-for-copilots-and-generative-ai-features](/power-platform/admin/geographical-availability-copilot)

<https://dialzara.com/blog/ai-data-lifecycle-management-complete-guide-2024>

[https://learn.microsoft.com/fabric/governance/data-governance-overview](/fabric/governance/data-governance-overview)


[https://learn.microsoft.com/azure/architecture/guide/responsible-ai/data](/azure/architecture/guide/responsible-ai/data)

