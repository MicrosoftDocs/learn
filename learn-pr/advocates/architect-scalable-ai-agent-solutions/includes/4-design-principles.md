AI workloads present unique challenges due to their data-centric nature, nondeterministic behavior, and operational complexity. To maximize cost efficiency while maintaining performance and scalability, apply the following principles and strategies:

- Cost-aware AI model selection. Choose models that balance performance and cost.
- Apply Azure Policy to enforce cost-related rules in AI governance.
- Add cost visibility and transparency with tagging strategies.
- Efficient data management by minimizing unnecessary data movement.
- Evaluate pay-per-token and provisioned throughput options.

## Cost-aware AI model selection: choose models that balance performance and cost

Selecting a model is both a technical and financial decision. Microsoft
Foundry Models provides a catalog for discovering, evaluating, and deploying
models. The catalog has two main categories:

- **Foundry Models sold by Azure:** Models that Microsoft sells and supports
  under Microsoft product terms, with deep Azure integration. Available
  deployment types and features vary by model and region.
- **Foundry Models from partners and community:** Models supplied by external
  providers and communities. Support, licensing, and deployment options such
  as serverless deployment or managed compute vary by provider and model.

Evaluate models with workload-specific quality, safety, latency, throughput,
data-boundary, availability, and cost tests. Use the model card and current
pricing documentation rather than assuming that model size alone determines
cost.

### Pricing considerations

The following table summarizes the cost drivers to evaluate when selecting a model.

| Cost driver | What to evaluate |
|---|---|
| Inference | The selected model's input, output, cached-token, request, or other applicable meters |
| Fine-tuning | Training charges, hourly hosting while a fine-tuned deployment exists even when idle, and inference charges |
| Deployment option and type | Serverless or managed compute, and standard, provisioned, batch, or other supported deployment types |
| Region and availability | Current model, feature, quota, and capacity availability in the required processing boundary |
| Complete solution | Agent runtime, tools, data stores, retrieval, networking, observability, and application hosting |

Match the model to the task, but validate smaller models rather than assuming
they meet quality requirements. Compare candidates with representative
evaluations and production-like traffic, and review the current meter for each
candidate.

### Model router

Model router is a trained language-model selector that you deploy as one model
endpoint. It selects an eligible underlying model for each request. Configure
the routing mode as **Balanced**, **Cost**, or **Quality**, and restrict the
allowed model subset when cost, capability, context-window, or compliance
requirements demand it.

> [!IMPORTANT]
> Model router supports **Global Standard** and **Data Zone Standard**
> deployments. Routing mode and model subset are custom-deployment settings:
> the subset limits which models are eligible, while the deployment type
> determines the data-processing boundary. If processing must remain in one
> Azure region, use a supported fixed-model **Standard** deployment. If the
> workload requires provisioned throughput, use an appropriate fixed-model
> provisioned deployment. To route requests to Claude models, deploy those
> models separately before adding them to the subset.

Evaluate model router against a fixed-model baseline for quality, latency, and
end-to-end cost. Model router selects models; it doesn't coordinate agents,
functions, or business workflow steps. Use explicit application workflows or
an orchestration framework such as Microsoft Agent Framework for those
responsibilities.

### AI model selection best practices

- Estimate complete solution costs with the Azure pricing calculator, and
  monitor deployed resource costs with Microsoft Cost Management. Configure
  autoscaling only for the compute or endpoint technology that hosts the
  workload. Size Foundry provisioned model deployments in PTUs, and then
  validate quota and available capacity.
- Treat retrieved grounding data as input-token overhead. Retrieve only
  concise, relevant passages; filter, rank, or summarize context; limit
  conversation history and output length; and use prompt caching when the
  selected model and deployment support it.
- Monitor usage patterns and retrain only when performance degrades.

## Applying Azure Policy to enforce cost-related rules in AI governance

As AI workloads scale across cloud environments, enforcing cost
discipline becomes essential, not just for budget control, but for
sustainable operations. Azure Policy provides a powerful mechanism to
embed cost-awareness directly into your governance boundaries.

### Azure Policy for cost governance

Azure Policy can audit, deny, modify, or remediate resource configurations.
Use it to enforce approved technical guardrails that support cost governance:

- **Restrict compute SKUs:** Use the built-in **Allowed virtual machine size
  SKUs** policy for virtual machine sizes. For other services, use a
  service-specific built-in policy or a custom policy that evaluates the
  relevant SKU property. A resource-type policy can't distinguish individual
  VM sizes.
- **Require cost-allocation tags:** Audit, deny, or add required tags such as
  cost center, environment, owner, and workload, according to the
  organization's tagging standard.
- **Restrict locations:** Limit deployments to approved regions for
  governance, data residency, service availability, or operational
  standardization. Evaluate current pricing as one input, not as the only
  selection criterion.
- **Restrict services, models, or deployment types:** Use available built-in
  policies or tested custom definitions to allow only approved AI resources
  and deployment configurations.
- **Inherit landing-zone guardrails:** Start with the Azure landing-zone
  policy baseline, then add workload-specific controls at the appropriate
  management-group or subscription scope.

> [!IMPORTANT]
> A location policy doesn't reserve model capacity or remove quota
> requirements. Azure Reservations provide a billing discount and don't
> guarantee capacity. Validate model and feature availability, quota, and
> deployable capacity separately before enforcing a regional design.

### AI-specific policy examples

Consider the following policy types to ensure cost effective AI agent solutions:

| Policy type             | Purpose                            | Example enforcement scope        |
|-------------------------|------------------------------------|----------------------------------|
| VM SKU restriction      | Prevent use of expensive compute   | Internal-only workloads          |
| Tag enforcement         | Ensure cost attribution            | All AI resources                 |
| Region restriction      | Enforce approved regions for governance, data residency, and service availability | Workloads with location requirements |
| Service access control  | Limit use of high-cost AI services | Dev/test environments            |

### Azure Policy best practices

- Start with baseline policies from Azure landing zones, then layer AI-specific cost controls.
- Monitor policy compliance using **Azure Policy Insights**.
- Review policy impact regularly to balance cost control with innovation flexibility.

## Adding cost visibility and transparency with tagging strategies

As AI workloads scale across Azure environments, maintaining cost
visibility becomes essential for financial accountability and
operational efficiency. Tagging strategies offer a simple yet powerful
way to attribute cloud costs to specific projects, teams, or workloads,
enabling granular tracking, budget monitoring, and informed
decision-making.

Tagging enables organizations to identify high-cost workloads and
optimize resource usage, allocate AI expenses to business units for
chargeback, detect cost anomalies tied to specific environments or teams
and support financial forecasting and strategic planning for AI
investments.

### Why tagging matters for AI cost governance

Tagging is a foundational governance practice that supports:

- **Cost attribution**: Assigning expenses to the correct business unit,
  project, or owner.
- **Budget accountability**: Enabling teams to monitor and manage their
  own consumption.
- **Operational clarity**: Simplifying reporting, forecasting, and
  anomaly detection.

Azure supports tagging across infrastructure (IaaS), platform services
(PaaS), and AI-specific resources, making it a versatile tool for cost
governance.

### Key tagging strategies for cost transparency

#### Enforce mandatory cost tags

Use Azure Policy to require tags such as:

- ProjectName
- CostCenter
- Environment (for example, dev, test, prod)
- Owner or Team

> [!NOTE]
> Not all resource types support tags or include tags in cost reports. Verify
> both capabilities in the tag-support matrix. Required tags improve
> attribution for supported resources, but they don't guarantee complete
> resource or billing traceability. Cost Management tag inheritance applies to
> usage records and excludes purchases and resources that don't emit usage at
> subscription scope.

#### Apply tags to resources and cost records

Use Azure Policy when tags must be required, added to, or corrected on Azure
resources. Separately, enable tag inheritance in Microsoft Cost Management
when subscription, resource-group, or supported billing-scope tags should be
added to child-resource usage records for cost reporting. Cost Management tag
inheritance enriches usage records; it doesn't write tags to the resources.

#### Standardize tag formats

Define and enforce naming conventions for tag values so reports and
automation can group costs consistently. For example:

```text
CostCenter: FIN-001
Environment: Production
Owner: ai-team@company.com
```

### Tagging best practices

- Use Azure Policy definitions to audit, require, add, or remediate resource
  tags at the appropriate scopes.
- Deploy standardized Bicep or ARM templates through deployment stacks. Use
  Template Specs when centrally stored and versioned templates are useful.
- Integrate tags into CI/CD pipelines so resources are tagged at creation.
- Monitor resource-tag compliance with Azure Policy and analyze inherited
  usage-record tags in Microsoft Cost Management.

## Efficient data management: Minimize unnecessary data movement

Data-transfer charges depend on the source, destination, direction, and Azure
service. Data transfer between Azure services in the same region is generally
not charged as bandwidth, but service-specific processing, storage, retrieval,
or networking meters can still apply. Inter-region transfers and outbound
internet traffic can incur charges. Placing data near users can reduce latency,
but it doesn't by itself eliminate internet egress.

### Design from actual data flows

- **Map each transfer path:** Document movement among users, applications,
  models, indexes, storage, tools, backup targets, and external systems.
- **Select the model processing boundary:** Global deployment types can
  process inference data in any Azure region. Data Zone deployment types keep
  processing within the selected Microsoft-defined data zone. **Standard**
  and **Regional Provisioned** deployment types process in the deployment
  region.
- **Co-locate dependent services where appropriate:** Place the application,
  retrieval index, and storage close to the selected model processing
  boundary when latency, compliance, reliability, and service availability
  allow it.
- **Cache deliberately:** Use application caches or a content delivery
  network for suitable content, with explicit freshness, privacy, and
  invalidation rules.
- **Review replication and recovery traffic:** Choose zone or regional
  replication from reliability and compliance requirements, and include its
  data-transfer and storage effects in the estimate.
- **Measure current meters:** Use service logs and Microsoft Cost Management
  to identify high-volume paths, then validate the applicable service and
  bandwidth pricing.

> [!IMPORTANT]
> The region of the Foundry resource, application, and storage account alone
> doesn't guarantee single-region inference processing. If processing must
> remain in one region, use **Standard** or **Regional Provisioned** where the
> required model is supported, and verify current availability before
> deployment.

### Trade-offs and risks

- Regional consolidation can conflict with availability, disaster recovery,
  data residency, or model availability requirements.
- Caching reduces repeated transfers but introduces freshness and data-handling
  responsibilities.
- Cross-region replication can be necessary for recovery objectives even when
  it adds cost.

## Evaluate pay-per-token and provisioned throughput options

Microsoft Foundry Models deployment types differ in billing, throughput, and
data-processing boundary. Select the processing boundary and performance
characteristics first, then compare the applicable billing options.

The following table compares deployment choices, billing, and capacity behavior for common workload patterns.

| Workload pattern | Deployment choice | Billing and capacity behavior |
|---|---|---|
| Variable or bursty online traffic | **Global Standard**, **Data Zone Standard**, or **Standard** | Pay per token according to the selected model and deployment meter |
| Short benchmark or temporary event that needs provisioned throughput | The matching **Global Provisioned**, **Data Zone Provisioned**, or **Regional Provisioned** deployment with hourly billing | Pay for every deployed PTU-hour, whether used or idle |
| Predictable, sustained, high-volume production traffic | A provisioned deployment covered by an Azure Reservation | Pay for deployed PTU capacity, with a term-based discount applied to matching usage |

Use a standard pay-per-token deployment type for variable or bursty demand.
Use hourly Provisioned Throughput for short benchmarking or temporary events,
not as an elastic production-scaling strategy. Provisioned deployments are
billed for their deployed PTUs, can't be paused, and stop accruing hourly
deployment charges only when deleted. Scaling down releases capacity, and the
same capacity might not be available if you later scale up.

### Provisioned throughput reservations

Azure Reservations provide a billing discount compared with hourly PTU
billing for matching provisioned deployments. PTUs are model-independent, so
model family isn't a reservation-matching dimension. Select the matching
**Global**, **Data Zone**, or **Regional** reservation, choose a one-month or
one-year term and an appropriate assignment scope, and verify the current
portal quote rather than publishing a fixed savings percentage.

Create and validate the provisioned deployment before purchasing its
reservation. A reservation is a billing construct and doesn't guarantee that
model capacity is available.

Reservation matching has three independent dimensions:

- **Deployment type:** Global, Data Zone, and Regional reservations are
   separate and aren't interchangeable.
- **Region:** Data Zone and Regional deployments must match the reservation
   region. Global reservations aren't region-specific and can cover matching
   Global deployments across multiple regions.
- **Assignment scope:** The reservation scope determines which matching
   resource groups, subscriptions, management groups, or eligible shared
   billing scope can receive the discount.

Monitor reservation utilization and deployed PTUs in Microsoft Cost
Management. If deployed PTUs exceed the reservation quantity, the excess is
billed at the hourly rate; unused reserved quantity doesn't carry forward.

> [!IMPORTANT]
> When a reservation expires, the provisioned deployment continues to run and
> is billed at the hourly rate. Automatic renewal maintains discount coverage
> and budget predictability; it isn't an availability or capacity mechanism.

## Strategic alignment

As AI adoption accelerates, strategic alignment helps organizations avoid technology-first investments and connect AI capabilities to measurable business outcomes and return on investment (ROI).

ROI isn't limited to cost savings. It can also include employee satisfaction, operational efficiency, and time saved on tasks.

Microsoft's Responsible AI principles of fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability guide how teams govern, map, measure, and manage risk throughout the AI lifecycle. These principles don't automatically implement compliance, access control, or threat detection. Teams must design, configure, monitor, and continuously improve the security, privacy, compliance, safety, and oversight controls for each workload.

## Match solution paths to business outcomes

Start with the business problem and measurable outcome. Classify the use case as individual work or business automation, decide whether generative or nongenerative AI is appropriate, and then choose among the Cloud Adoption Framework adoption models: ready-to-use Copilots, low-code SaaS development, managed PaaS development, or Azure infrastructure.

| Business need | Solution path | Selection guidance |
|---|---|---|
| Improve individual productivity in existing applications | Ready-to-use Microsoft Copilots or in-product Copilots | Use when a supported product already provides the required capability and data access |
| Extend Microsoft 365 Copilot with organizational knowledge or actions | Low-code SaaS development or a Microsoft 365 Copilot agent | Use a declarative agent when Copilot's models and orchestrator are sufficient; use a custom engine agent when custom models or orchestration are required |
| Automate and integrate a business process | Copilot Studio or managed PaaS development with Microsoft Foundry | Choose single-agent, multi-agent, workflow, or conventional code from boundaries, determinism, integration, quality, and operating requirements |
| Build a differentiated solution or run a custom model/runtime | Managed PaaS development with Microsoft Foundry or AI on Azure infrastructure | Accept greater engineering and operational ownership only when the required control or customization justifies it |

Complexity alone doesn't justify autonomous action. Assess the consequence and reversibility of each action, permissions, data sensitivity, ambiguity, and required oversight. Apply least privilege, audit logging, bounded execution, circuit breakers, and human approval for high-risk or irreversible actions.

> [!IMPORTANT]
> Don't grant an agent unsupervised authority over a material business, security, financial, or customer-impacting action solely because the workflow has multiple steps.

Use **prompt engineering** to refine instructions, examples, and context at inference time. Use **fine-tuning** only when evaluation shows a need to train model weights with a curated dataset and the additional training, hosting, and operational costs are justified.

For example, Fujitsu increased sales-proposal productivity by 67% using Azure AI Agent Service (now Microsoft Foundry Agent Service). Carvana reduced inbound calls per sale by more than 45% over two years by combining its Sebastian agent with the CARE conversation-analysis platform.

## Design and operate for sustained value

Modularity, security, and scalability are useful design qualities, but they aren't sufficient measures of production readiness or long-term ROI. Review and operate each workload across all five Azure Well-Architected Framework pillars:

- **Reliability:** Meet availability, recovery, and resilience targets.
- **Security:** Protect identities, data, models, tools, and communication paths.
- **Cost Optimization:** Measure complete solution cost and continuously align consumption with business value.
- **Operational Excellence:** Use automated delivery, observability, evaluation, incident response, and safe change practices.
- **Performance Efficiency:** Test latency, throughput, scaling, and capacity against expected demand.

Treat **Govern**, **Secure**, and **Manage** as continuous Cloud Adoption Framework practices. Revisit strategy, planning, and environment readiness as business goals, risks, models, data, usage, and service capabilities change.
