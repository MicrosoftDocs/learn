## Unit overview

This unit equips solution architects with the expert-level skills needed to determine when organizations should invest in building **custom AI models**, instead of relying on prebuilt or catalog models available through platforms such as **Microsoft 365 Copilot**, **Microsoft Foundry**, or **Azure OpenAI model catalog**.

You'll evaluate business, technical, operational, and cost-efficiency drivers required to justify custom model development.

## Understanding the decision landscape

Choosing whether to build a custom model is a strategic decision with major implications for **cost, time-to-market, maintainability, security, and talent requirements**.

In general, organizations should create custom AI models only when:

- The business problem cannot be solved accurately with existing pre-trained or fine-tuned model

- **Domain specificity**, **sensitive workflows**, or **high-impact decisioning** demands deeper customization

- **Model behavior must be highly predictable or governed**, and prebuilt models cannot meet compliance thresholds

- **ROI modeling** confirms long-term efficiency gains that outweigh higher upfront engineering cost

A solution architect must balance:

- **Business Fit + Model Fit + Data Fit + Cost Fit + Operational Fit.**

## When prebuilt or catalog models are sufficient

Before considering custom models, confirm whether existing models from Microsoft Foundry's model catalog or Azure OpenAI already meet requirements.

Prebuilt or catalog models fit well when:

- The use case is **general-purpose** (summarization, classification, rewriting, translation, extraction)

- **Moderate accuracy** is acceptable

- The agent interacts primarily with **enterprise knowledge sources**, not highly specialized reasoning tasks

- The domain data is **not complex** or does not require deep contextual understanding

- **Time-to-value** is a priority

- Teams want **low-cost**, low-risk deployment

### Examples

- Drafting customer emails

- Policy Q&A

- Document summarization

- Meeting recap

- Basic conversation automation

- Knowledge retrieval agents

## When custom AI models should be created

A custom model is recommended in the following situations.

### Domain-specific intelligence is required

If the system must understand organization-specific language, terminology, processes, or industry technical vocabulary, a pre-trained model may lack the accuracy needed.

#### Indicators

- Highly specialized workflows

- Industry-specific compliance

- Proprietary knowledge dominating task performance

- Unique linguistic structures or business rules

### Off-the-shelf accuracy is insufficient

Custom modeling is justified when evaluation metrics show significant accuracy gaps despite:

- Prompt engineering

- Retrieval tuning

- Fine-tuning

- Using advanced catalog models

#### Metric-based indicators

- Persistent low precision/recall

- High hallucination risk

- High business cost of wrong answers

- Need for deterministic or near-deterministic output

### Governance or compliance requirements demand full control

Some organizations require:

- Full control over model behavior

- Transparent evaluation lifecycle

- Strict explainability

- Custom guardrails and moderation

- Predictable reasoning paths

- Data residency or sovereignty assurances

Custom models allow deeper control across the pipeline:

- Data curation

- Training procedures

- Evaluation frameworks

- Bias/misuse mitigation

- Model deployment patterns

### High-scale or high-ROI scenarios

Custom models are cost-effective when:

- Model usage will be extremely high

- Small cost-per-query improvements create large savings

- Custom optimization significantly reduces operational cost

- Performance gains will directly translate to revenue lift or efficiency gain

This aligns with Azure training on **cost-efficiency decision-making**.

### Multi-agent systems requiring custom reasoning

If the architecture includes multiple agents with distinct roles requiring:

- Specialized reasoning behaviors

- Multi-step planning

- Long-horizon tasks

- Workflow orchestration

- Explicit internal memory structures

The foundation models may require customization to support complex agent-agent collaboration.

## Data requirements for custom models

Custom model development requires:

- Large volumes of high-quality labeled domain data

- Strong data governance and cleaning processes

- A repeatable pipeline for training, evaluation, and deployment

- Defined taxonomy and annotation guidelines

- Continuous retraining and monitoring strategy

- Access to skilled data scientists and MLOps engineers

If these requirements are not yet met, extending Microsoft 365 Copilot is often the better starting point.

## Architecture decision framework (text-based visual)

### Decision chart: Build vs. extend

| **Decision Factor** | **Extend Copilot or Use Catalog Models** | **Build Custom Model** |
|---|---|---|
| **Domain complexity** | Low-medium | High / industry-specific |
| **Required accuracy** | Moderate | High / mission-critical |
| **Data availability** | Limited | Large curated dataset |
| **Compliance** | Standard | Custom strict requirements |
| **Reasoning depth** | Shallow-moderate | Deep / multi-step |
| **Cost tolerance** | Low | Medium-high |
| **Talent maturity** | Low | High (AI/ML engineering) |
| **Time to market** | Fast | Medium-slow |

## References

- Maximize cost efficiency in AI agent development. [/training/modules/maximize-cost-efficiency-ai-agent-development/](/training/modules/maximize-cost-efficiency-ai-agent-development/)

- Explore models in Azure AI Studio. [/training/modules/explore-models-azure-ai-studio/](/training/modules/explore-models-azure-ai-studio/)