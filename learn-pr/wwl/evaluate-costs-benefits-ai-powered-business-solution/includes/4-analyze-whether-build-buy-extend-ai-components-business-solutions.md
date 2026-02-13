### Overview

Solution architects make pivotal decisions that determine whether AI capabilities should be **built**, **bought**, or **extended**. This choice affects **cost**, **timetovalue**, **risk**, **scalability**, and the longterm sustainability of the solution.<br>This unit provides a structured decision framework that blends **organizational strategy**, **AI component cost drivers**, and **Copilot extensibility models** to help architects select the right path for each business process.

### 1. Strategic Decision Context

Organizations accelerating AI adoption face three primary pathways:

**Build - Create AI components internally**

Best when organizations require:

Deep customization

Control over data, IP, and model behavior

Unique business processes not supported by commercial tools

Integration with proprietary systems

**Buy - Acquire prebuilt AI capabilities**

Best when:

Timetovalue is a priority

Internal engineering capacity is limited

Business processes are standardized

Reliability, support, and updates are essential

**Extend - Customize an existing platform (e.g., Microsoft Copilot, Copilot Studio, Foundry)**

Best for:

Hybrid scenarios that require both speed and customization

Leveraging mature ecosystem capabilities while tailoring agent or Copilot behaviors

Introducing domainspecific knowledge via plugins, skills, or grounding data

### 2. Key Evaluation Factors for Build vs. Buy vs. Extend

#### 2.1 Business Drivers

Solution architects must evaluate:

**Uniqueness of business process**

**Strategic importance** (competitive differentiation vs. commodity workflows)

**Time horizon** (immediate operational win vs. long-term strategic capability)

**Compliance and governance needs**

**Professional Visual (Conceptual Diagram - Decision Triangle)**

        Strategic Differentiation

              /           \

             /   Build     \

            /               \

 Standardization—Extend—Speed-to-Value

            \               /

             \     Buy     /

              \           /

### 3. Cost Structure Considerations

Using Microsoft AI agent coststructure guidance, architects must evaluate costs in **five domains**:

#### Infrastructure Costs

Compute for inference (CPU/GPU), storage, networking

Scaling and resiliency overhead

#### Development & Integration Costs

Agent design, orchestration flows, pipelines

API and system integration

Governance and compliance engineering

#### Data Quality & Preparation Costs

Data cleansing, labeling, validation

Grounding, retrievers, embeddings, indexing

Ongoing monitoring for drift

#### Expertise & Resource Costs

AI engineers, architects, MLOps, SME involvement

Training internal teams, documentation

#### Ongoing Operations

Monitoring, optimization, retraining

Licensing (if buying or extending)

Telemetry, governance, security updates

#### Professional Visual (TCO Table)

| Cost Domain        | Build | Buy | Extend |

|--------------------|:-----:|:---:|:------:|

| Infrastructure     | High  | Low | Medium |

| Development        | High  | Low | Medium |

| Data Preparation   | High  | Low | High   |

| Expertise          | High  | Low | Medium |

| Operations         | High  | Medium | Medium |

### 4. When to Build

#### Choose Build when:

The AI solution defines competitive advantage

Prebuilt solutions do not meet regulatory or compliance needs

Data sensitivity requires full internal control

The organization has strong AI/ML engineering capability

#### Risks:

Higher upfront cost

Longer implementation timeline

Requires continuous maintenance investment

### 5. When to Buy

#### Choose Buy when:

Efficiency and rapid deployment matter more than customization

Core commercial capabilities adequately meet business needs

Organizational maturity in AI is low

The vendor ecosystem provides robust support and upgrades

#### Risks:

Vendor lockin

Limited extensibility

Feature gaps for specialized processes

### 6. When to Extend

#### Choose Extend when:

The organization wants **Copilot** or another AI product to adopt internal logic

Domain knowledge can be added through grounding data, connectors, or plugins

The base model performs well but needs enterprise-specific adaptation

##### Examples:

Adding lineofbusinessspecific prompts

Incorporating internal documents or structured knowledge

Extending Microsoft Copilot with custom actions or agent behavior

Supplementing prebuilt copilots with custom skills

#### Benefits:

Balanced cost

Faster deployment than Build

More customization flexibility than Buy

### 7. Decision Framework for Build vs. Buy vs. Extend

#### Step-by-Step Architectural Flow

**Define business requirements and business processes**

**Determine strategic importance (differentiation vs. commodity)**

**Assess available vendor solutions and effort to implement**

**Evaluate feasibility of extending existing tools**

**Evaluate feasibility create a completely custom solution** 

**Estimate TCO across the five cost domains**

**Forecast ROI (time saved, cost avoided, error reduction, throughput increases)**

**Score each option on a weighted model**

**Select the approach with optimal value-to-cost ratio**

**Professional Visual (Weighted Scoring Matrix)**

| Criteria            | Build | Buy | Extend |

|---------------------|-------|-----|--------|

| Strategic fit       |  5    |  2  |   4    |

| Time-to-value       |  2    |  5  |   4    |

| TCO                 |  2    |  4  |   3    |

| Customization need  |  5    |  2  |   4    |

| Maintainability     |  3    |  4  |   4    |

### References

<https://www.microsoft.com/en-us/microsoft-cloud/blog/2024/03/06/build-buy-or-both-how-to-choose-the-right-approach-for-your-ai-transformation>

[https://learn.microsoft.com/en-us/training/modules/ai-agent-cost-structure/](/training/modules/ai-agent-cost-structure/)

[https://learn.microsoft.com/en-us/training/modules/business-value-microsoft-copilot-solutions/5-extend-copilot-organization](/training/modules/business-value-microsoft-copilot-solutions/5-extend-copilot-organization)