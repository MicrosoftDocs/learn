### Overview

Solution architects make pivotal decisions that determine whether AI capabilities should be **built**, **bought**, or **extended**. This choice affects **cost**, **timetovalue**, **risk**, **scalability**, and the long-term sustainability of the solution.<br>This unit provides a structured decision framework that blends **organizational strategy**, **AI component cost drivers**, and **Copilot extensibility models** to help architects select the right path for each business process.

### Strategic Decision Context

Organizations accelerating AI adoption face three primary pathways:

**Build - Create AI components internally**

#### Best when organizations require:

- Deep customization

- Control over data, IP, and model behavior

- Unique business processes not supported by commercial tools

- Integration with proprietary systems

**Buy - Acquire prebuilt AI capabilities**

#### Best when:

- Timetovalue is a priority

- Internal engineering capacity is limited

- Business processes are standardized

- Reliability, support, and updates are essential

**Extend - Customize an existing platform (e.g., Microsoft Copilot, Copilot Studio, Foundry)**

#### Best for:

- Hybrid scenarios that require both speed and customization

- Leveraging mature ecosystem capabilities while tailoring agent or Copilot behaviors

- Introducing domain-specific knowledge via plugins, skills, or grounding data

### Key Evaluation Factors for Build vs. Buy vs. Extend

#### 2.1 Business Drivers

##### Solution architects must evaluate:

- **Uniqueness of business process**

- **Strategic importance** (competitive differentiation vs. commodity workflows)

- **Time horizon** (immediate operational win vs. long-term strategic capability)

- **Compliance and governance needs**

### Cost Structure Considerations

Using Microsoft AI agent cost-structure guidance, architects must evaluate costs in **five domains**:

#### Infrastructure Costs

- Compute for inference (CPU/GPU), storage, networking

- Scaling and resiliency overhead

#### Development and Integration Costs

- Agent design, orchestration flows, pipelines

- API and system integration

- Governance and compliance engineering

#### Data Quality and Preparation Costs

- Data cleansing, labeling, validation

- Grounding, retrievers, embeddings, indexing

- Ongoing monitoring for drift

#### Expertise and Resource Costs

- AI engineers, architects, MLOps, SME involvement

- Training internal teams, documentation

#### Ongoing Operations

- Monitoring, optimization, retraining

- Licensing (if buying or extending)

- Telemetry, governance, security updates

#### TCO Table

| Cost Domain        | Build | Buy | Extend |
|--------------------|-------|-----|--------|
| Infrastructure     | High  | Low | Medium |
| Development        | High  | Low | Medium |
| Data Preparation   | High  | Low | High   |
| Expertise          | High  | Low | Medium |
| Operations         | High  | Medium | Medium |

### When to Build

#### Choose Build when:

- The AI solution defines competitive advantage

- Prebuilt solutions do not meet regulatory or compliance needs

- Data sensitivity requires full internal control

- The organization has strong AI/ML engineering capability

#### Risks:

- Higher upfront cost

- Longer implementation timeline

- Requires continuous maintenance investment

### When to Buy

#### Choose Buy when:

- Efficiency and rapid deployment matter more than customization

- Core commercial capabilities adequately meet business needs

- Organizational maturity in AI is low

- The vendor ecosystem provides robust support and upgrades

#### Risks:

- Vendor lockin

- Limited extensibility

- Feature gaps for specialized processes

### When to Extend

#### Choose Extend when:

- The organization wants **Copilot** or another AI product to adopt internal logic

- Domain knowledge can be added through grounding data, connectors, or plugins

- The base model performs well but needs enterprise-specific adaptation

##### Examples:

- Adding lineofbusinessspecific prompts

- Incorporating internal documents or structured knowledge

- Extending Microsoft Copilot with custom actions or agent behavior

- Supplementing prebuilt copilots with custom skills

#### Benefits:

- Balanced cost

- Faster deployment than Build

- More customization flexibility than Buy

### Decision Framework for Build vs. Buy vs. Extend

#### Step-by-Step Architectural Flow

1. **Define business requirements and business processes**

2. **Determine strategic importance (differentiation vs. commodity)**

3. **Assess available vendor solutions and effort to implement**

4. **Evaluate feasibility of extending existing tools**

5. **Evaluate feasibility create a completely custom solution** 

6. **Estimate TCO across the five cost domains**

7. **Forecast ROI (time saved, cost avoided, error reduction, throughput increases)**

8. **Score each option on a weighted model**

9. **Select the approach with optimal value-to-cost ratio**

### References

- <https://www.microsoft.com/en-us/microsoft-cloud/blog/2024/03/06/build-buy-or-both-how-to-choose-the-right-approach-for-your-ai-transformation>

- [https://learn.microsoft.com/en-us/training/modules/ai-agent-cost-structure/](/training/modules/ai-agent-cost-structure/)

- [https://learn.microsoft.com/en-us/training/modules/business-value-microsoft-copilot-solutions/5-extend-copilot-organization](/training/modules/business-value-microsoft-copilot-solutions/5-extend-copilot-organization)