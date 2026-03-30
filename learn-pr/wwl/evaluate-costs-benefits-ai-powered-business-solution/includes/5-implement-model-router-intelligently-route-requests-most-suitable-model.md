### Overview

Modern AI applications often rely on multiple models—generalpurpose LLMs, small language models (SLMs), fine tuned models, and taskspecific models. Azure AI Foundry's Model Router provides a unified endpoint that automatically selects the best model for each request based on routing rules, performance criteria, and business constraints.

This unit equips solution architects to design, configure, and operationalize a model router that optimizes cost, latency, accuracy, and reliability across AI workloads.

#### By the end of this unit, learners are able to:

- Explain the purpose and value of a model router

- Identify routing criteria (task type, cost, latency, domain specificity)

- Configure routing rules in Azure AI Foundry

- Integrate a model router into AI agents and applications

- Evaluate routing performance and optimize model selection

### Understanding the Model Router in Azure AI Foundry

Azure AI Foundry's model router provides:

#### A Single Unified Endpoint

- One endpoint for multiple models

- Simplifies application integration

- Reduces code complexity

#### Intelligent Routing

- Route requests based on:

- Task type

- Model capabilities

- Cost constraints

- Latency requirements

- Custom rules

#### Centralized Governance

- Versioning

- Monitoring

- Usage analytics

- Safety and compliance controls

### Why Model Routing Matters

Model routing enables organizations to:

#### Optimize Cost

- Use SLMs for simple tasks

- Use LLMs only when needed

- Reduce token consumption

#### Improve Performance

- Route low latency tasks to faster models

- Use specialized models for domain-specific tasks

#### Increase Reliability

- Fail over to backup models

- Automatically switch to newer model versions

#### Support Hybrid AI Strategies

- Combine foundation models, fine tuned models, and custom models

- Align with "build, buy, or both" AI transformation strategies

### Routing Criteria for Selecting the Most Suitable Model

Azure AI Foundry supports rule based and metadatabased routing. 

**Key criteria include:**

#### Task Type

- Summarization

- Classification

- Extraction

- Reasoning

- Conversation

#### Complexity

- Simple → SLM

- Moderate → fine tuned model

- Complex → LLM

### Designing Routing Rules

Solution architects should conduct a routing rule design workshop to help identify and create routing rules for a set of business tasks as the rules will likely vary greatly from organization to organization. 

In the workshop, the routing rules identified should be adjusted to reduce cost while maintaining performance. 

Azure AI Foundry supports:

#### Static Rules

Examples:

- "If task = classification → use SLM"

- "If domain = finance → use fine tuned model"

#### Weighted Routing

- Distribute traffic across models

- Useful for A/B testing and gradual rollout

#### Fallback Routing

- Automatically route to backup model if primary fails

#### VersionBased Routing

- Route to latest stable version

- Route specific traffic to experimental versions

### Implementing the Model Router

**Step 1 — Define the Routing Strategy**

- Costoptimized

- Performance optimized

- Accuracy optimized

- Hybrid

**Step 2 — Register Models**

- Foundation models

- Fine tuned models

- Custom models

**Step 3 — Configure Routing Rules**

- Rule based

- Weighted

- Fallback

**Step 4 — Integrate with Applications**

- AI agents

- Copilot extensions

- Backend services

- Multiagent systems

**Step 5 — Monitor and Optimize**

- Latency

- Cost

- Accuracy

- Model usage distribution

### References

- [https://learn.microsoft.com/en-us/azure/ai-foundry/openai/concepts/model-router?view=foundry](/azure/ai-foundry/openai/concepts/model-router)
- [https://learn.microsoft.com/en-us/azure/ai-foundry/openai/concepts/model-router?view=foundry-classic](/azure/ai-foundry/openai/concepts/model-router)
- <https://github.com/MicrosoftDocs/azure-ai-docs/blob/main/articles/ai-foundry/openai/concepts/model-router.md> 
