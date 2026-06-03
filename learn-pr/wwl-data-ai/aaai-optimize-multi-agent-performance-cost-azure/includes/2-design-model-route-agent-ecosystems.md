Organizations deploying multi-agent systems quickly discover that using the same model for every agent is the fastest path to cost overruns. Adventure Works' shipping status agent doesn't need GPT-4o to parse a tracking number and look up delivery information — but the return policy interpreter absolutely needs advanced reasoning to handle ambiguous edge cases. The difference in per-request cost between these models can be 10x, and at millions of daily requests, choosing the right model for each task determines whether the system is financially sustainable.

## The multi-agent model routing problem

Model routing addresses a fundamental tension: powerful models deliver better quality but cost more and respond slower, while smaller models are fast and cheap but struggle with complex reasoning. In a single-agent system, you choose one model and accept the tradeoff. In a multi-agent system with 14 specialized agents handling diverse workloads, each agent's tasks have different complexity profiles, and even within a single agent, request complexity varies dramatically.

The shipping status lookup agent receives two types of requests: simple tracking number lookups that require extracting structured data, and complex "where is my order?" questions that require interpreting shipping exceptions, carrier delays, and weather-related disruptions. Routing both to the same model leaves money on the table — the simple lookups overpay for capability they don't need, while forcing the complex cases into a smaller model degrades the customer experience.

| Request characteristic | Model tier needed | Cost implication |
|------------------------|-------------------|------------------|
| Structured data extraction | GPT-4o-mini | 5-10x cheaper |
| Multi-step reasoning with ambiguity | GPT-4o | Baseline cost |
| Complex policy interpretation | GPT-4o or o-series | 2-5x more expensive |

Effective routing requires classifying each request's complexity before invoking the model, then selecting the deployment that matches the requirement. The classification itself must be cheaper than the savings it produces — using GPT-4o to decide whether to use GPT-4o-mini defeats the purpose.

## Task complexity classification for intelligent routing

Adventure Works' platform engineering team defines three complexity tiers based on the cognitive demands of each request type. This classification drives routing decisions across all 14 agents.

**Tier 1 (simple requests)** includes structured data lookups, status retrievals, factual single-turn questions, and catalog searches. These requests have deterministic answers that don't require reasoning or interpretation. The input-output mapping is essentially a lookup or simple transformation. Examples: "What's my order status for order #12345?" or "What are your store hours?" Route tier 1 requests to GPT-4o-mini or equivalent small models, achieving 5-10x cost reduction with no quality degradation.

**Tier 2 (moderate complexity)** covers multi-step reasoning, intent classification with multiple overlapping categories, short-form generation that requires tone adaptation, and comparison tasks. These requests need some reasoning but not deep policy interpretation. Examples: "I need to return this product but I lost the receipt — what are my options?" or "Which of these three products best fits my needs?" Route tier 2 requests to GPT-4o, balancing quality and cost at the platform baseline.

**Tier 3 (complex reasoning)** addresses high-stakes policy interpretation with ambiguous inputs, multi-factor recommendations that weigh conflicting criteria, sensitive customer situations requiring empathy and nuance, and cases where incorrect handling creates significant business risk. Examples: "I received a damaged product three months ago but just discovered the damage — can I still return it?" or handling a customer threatening legal action. Route tier 3 requests to GPT-4o or o-series models, accepting higher cost for quality and risk mitigation.

The classification logic uses lightweight heuristics rather than model inference: keyword matching for tier 1 (contains order number pattern, matches known status query templates), request length and structural complexity for tier 2 (multi-sentence requests, contains comparison operators), and business rule triggers for tier 3 (dollar amount exceeds threshold, contains escalation keywords, mentions policy exceptions).

## Dynamic model selection with quality floor protection

Once the system classifies request complexity, it selects the appropriate Azure AI Foundry deployment and invokes the routed model. But complexity classification isn't perfect — occasionally a request classified as tier 1 actually requires tier 2 reasoning, and the initial model fails to produce a quality response. Quality floor protection prevents these misclassifications from degrading customer experience.

After each routed model invocation, a quality validator scores the response on a 0-100 scale using a lightweight evaluation model. The score checks for: response completeness (did the model answer the question?), factual consistency (does the response align with retrieved context?), and confidence indicators (did the model express uncertainty or provide hedged responses?). If the quality score falls below the tier's minimum threshold, the system automatically retries with the next tier up.

Tier 1 has a quality floor of 75 — if a tier 1 response scores below 75, retry with tier 2. Tier 2 has a quality floor of 85 — fall below 85 and escalate to tier 3. Tier 3 has no automatic escalation; failures at tier 3 trigger human review. This retry mechanism ensures that cost optimization never compromises customer experience at the expense of a few extra model calls.

```python
from azure.ai.inference import ChatCompletionsClient
from azure.core.credentials import AzureKeyCredential

class ModelRouter:
    def __init__(self, config):
        self.tier_deployments = {
            1: config["gpt_4o_mini_endpoint"],
            2: config["gpt_4o_endpoint"],
            3: config["gpt_4o_reasoning_endpoint"]
        }
        self.quality_floors = {1: 75, 2: 85, 3: 60}
        self.clients = {
            tier: ChatCompletionsClient(endpoint, AzureKeyCredential(config["api_key"]))
            for tier, endpoint in self.tier_deployments.items()
        }
    
    def classify_complexity(self, request_text, context):
        """Classify request complexity using lightweight heuristics."""
        # Tier 3 triggers: high-value amounts, policy exceptions, escalation keywords
        if any(keyword in request_text.lower() for keyword in ["exception", "legal", "complaint"]):
            return 3
        if context.get("transaction_amount", 0) > 500:
            return 3
        
        # Tier 1 triggers: structured patterns, known templates
        if len(request_text.split()) < 10 and any(char.isdigit() for char in request_text):
            return 1
        
        # Default to tier 2 for moderate complexity
        return 2
    
    def evaluate_quality(self, response, tier):
        """Lightweight quality scoring (0-100)."""
        score = 100
        
        # Deduct points for uncertainty indicators
        if any(phrase in response.lower() for phrase in ["i'm not sure", "i don't know", "unclear"]):
            score -= 20
        
        # Deduct for incomplete responses (very short)
        if len(response.split()) < 15:
            score -= 15
        
        # Tier-specific expectations
        if tier == 1 and len(response.split()) > 100:
            score -= 10  # Tier 1 should be concise
        
        return max(score, 0)
    
    def route_with_quality_floor(self, request_text, context, max_tier=3):
        """Route request to appropriate model with quality floor retry."""
        tier = self.classify_complexity(request_text, context)
        
        while tier <= max_tier:
            client = self.clients[tier]
            response = client.complete(messages=[{"role": "user", "content": request_text}])
            response_text = response.choices[0].message.content
            
            quality_score = self.evaluate_quality(response_text, tier)
            
            # Check quality floor
            if quality_score >= self.quality_floors[tier]:
                return {
                    "response": response_text,
                    "tier_used": tier,
                    "quality_score": quality_score,
                    "retry_count": tier - self.classify_complexity(request_text, context)
                }
            
            # Quality floor breach — escalate to next tier
            tier += 1
        
        # All tiers exhausted — flag for human review
        return {
            "response": response_text,
            "tier_used": max_tier,
            "quality_score": quality_score,
            "needs_human_review": True
        }
```

## Routing metrics and continuous optimization

Effective model routing requires continuous measurement and refinement. Adventure Works logs every routing decision with rich metadata: the tier assigned by classification, the tier actually used after quality floor retries, the final quality score, response latency, and estimated cost. This data feeds a monthly routing analysis that identifies optimization opportunities.

Over-routing occurs when the system consistently classifies requests as tier 2 or tier 3, but those requests achieve high quality scores with the more expensive models despite being handleable by cheaper tiers. The pattern suggests the classification heuristics are too conservative. Under-routing appears as frequent quality floor retries — requests initially routed to tier 1 that consistently fail and escalate to tier 2. The classification logic is too aggressive and needs recalibration.

The optimization loop works as follows: each month, query the routing logs for requests with quality scores above 90 at tier 2 or tier 3. Sample 200 of these high-confidence successes and test whether tier 1 could have handled them. If tier 1 achieves similar quality on 70% or more of the sample, adjust the classification heuristics to route more requests to tier 1. Simultaneously, identify tier 1 requests with retry rates above 15% and analyze the common characteristics — then refine the classification rules to route those patterns directly to tier 2.

This data-driven optimization converges on the ideal routing policy for Adventure Works' specific workload distribution. The first month might show 40% tier 1, 50% tier 2, and 10% tier 3. After three months of optimization, the distribution shifts to 60% tier 1, 35% tier 2, and 5% tier 3 — reducing average per-request cost by 30% while maintaining quality metrics.

Model routing transforms multi-agent cost optimization from a blunt "use cheaper models everywhere" approach into a sophisticated matching system that delivers the right quality at the right price for each unique request. The next challenge: reducing the number of requests that need model inference at all through intelligent caching strategies.

> [!NOTE]
> **Open-source model alternatives:** Azure-hosted GPT-4o-mini and GPT-4o cover most routing scenarios, but cost-optimized open-source models from Hugging Face \u2014 such as Phi-4-mini, Mistral-7B, or Llama-3.1-8B \u2014 are valid routing targets for the "simple" and "moderate" tiers when deployed on Azure Machine Learning managed endpoints or serverless inference. Open-source models reduce per-token cost further but require you to manage model quality benchmarking, version pinning, and serving infrastructure. Incorporate them into the routing tier where quality floors are demonstrably met.

## Unit summary

- **Task complexity classification** categorizes requests into three tiers (simple, moderate, complex) using lightweight heuristics rather than model inference to keep classification costs below routing savings.
- **Model tier matching** routes simple lookups to GPT-4o-mini (5-10x cheaper), moderate reasoning to GPT-4o, and complex policy interpretation to GPT-4o or o-series models.
- **Quality floor protection** validates each response with a lightweight scorer and automatically retries with the next tier up if quality falls below the tier's minimum threshold.
- **Routing metrics** track over-routing (requests that could use cheaper models) and under-routing (frequent quality floor retries) to guide monthly classification refinement.
- **Data-driven optimization** converges on the ideal routing distribution over time, reducing average per-request cost by 30% while maintaining quality metrics.

## Check your understanding

**1. A complexity classifier routes "simple" customer queries to GPT-4o-mini and "complex" queries to GPT-4o. A quality check reveals that 15% of GPT-4o-mini responses fail the quality floor. What should you do?**

- A. Switch all requests to GPT-4o to ensure quality
- B. Adjust the complexity classifier's thresholds to route borderline queries to GPT-4o, reducing the misclassification rate while keeping truly simple queries on the cheaper model
- C. Remove the quality floor check since some quality loss is expected with cheaper models

***Correct answer: B.*** The goal is to find the classification boundary that minimizes cost while meeting quality standards. Adjusting thresholds to route ambiguous cases to the more capable model reduces misclassification without abandoning cost savings on clearly simple requests.
