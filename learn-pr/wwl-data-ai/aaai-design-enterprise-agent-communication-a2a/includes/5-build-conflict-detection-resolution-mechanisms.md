Azure AI Foundry Agent Service runs the specialized agents whose outputs sometimes conflict when each agent optimizes for a different objective—returns, risk, or compliance. Azure AI Inference services power the consistency judge that detects semantic contradictions between agent outputs automatically, before conflicting recommendations reach clients.

| Conflict Type | Root Cause | Detection Method | Resolution Strategy |
|---------------|-----------|------------------|---------------------|
| Resource contention | Concurrent writes to same state | Optimistic concurrency (ETag) | Retry with merge |
| Output inconsistency | Divergent domain logic | Semantic similarity check | Priority-based weighting |
| Deadline conflict | Dependent timing constraints | Dependency graph analysis | Decoupling or approximation |

These conflicts emerge naturally in multi-agent systems where specialized agents optimize for different objectives. Production platforms need automated detection mechanisms that identify conflicts before they propagate to clients and resolution strategies that synthesize coherent final outputs from contradictory intermediate results.

## Classify agent conflict types

Agent conflicts fall into three categories based on their failure mode and appropriate resolution strategy.

**Resource contention conflicts** occur when multiple agents attempt to modify the same state resource simultaneously. Two instances of the market analysis agent both read task document version 12, both perform their analysis, and both attempt to write their results as version 13. Only one write can succeed—the other receives an ETag mismatch error. These conflicts happen at the infrastructure layer and get resolved through optimistic concurrency retry logic covered in Unit 3. The conflicting operations are equivalent—both agents produce valid market analysis—so retrying with merged results resolves the conflict safely.

**Output inconsistency conflicts** occur when agents produce semantically contradictory results about the same entity. This is the "buy vs. reduce exposure" scenario where domain logic diverges. These conflicts happen at the semantic layer and require explicit conflict detection logic that compares agent outputs for logical consistency. Resolution often depends on domain-specific priority rules or escalation to a synthesis agent that reconciles the perspectives.

**Deadline conflicts** occur when agents have interdependent tasks with incompatible timing constraints. Agent A needs Agent B's market forecast to complete risk modeling by T+5 minutes. Agent B's forecast requires Agent C's sector classification, which won't complete until T+8 minutes. This creates an unsolvable dependency chain. These conflicts happen at the orchestration layer and require either restructuring the task plan to remove dependencies or proceeding with approximations when precise inputs are unavailable.

For Contoso Capital's financial analysis workflows, output inconsistency conflicts are most prevalent and most dangerous. Surfacing contradictory recommendations to clients undermines trust in the platform. The priority shifts from preventing conflicts—impossible when agents legitimately have different analysis criteria—to detecting and resolving them automatically.

## Detect output inconsistency through semantic analysis

Identifying contradictory agent outputs requires comparing their semantic meaning, not just their data structures. Two agents might produce structurally identical JSON but with opposite recommendations in the text fields. Three detection methods provide increasing sophistication.

**Semantic similarity scoring** embeds both outputs using a text embedding model and computes their cosine similarity. Outputs that should be consistent—two market analysts evaluating the same company—but produce similarity scores below 0.6 indicate potential conflicts. This approach catches obvious contradictions like "bullish outlook" versus "bearish outlook" but can miss subtle conflicts where text structure is similar even though conclusions differ.

**LLM-based consistency judging** submits both outputs to a small language model specifically prompted to evaluate consistency. The judge model receives a prompt: "You are evaluating whether two financial analyses are consistent. Respond with: CONSISTENT if they agree on the main conclusion, INCONSISTENT if they contradict, or COMPLEMENTARY if they address different aspects." This approach understands nuanced contradictions that embedding similarity misses, like when one output recommends buying calls while another recommends selling puts on the same stock—superficially different language but contradictory strategies.

**Rule-based validation** for structured financial recommendations applies domain-specific logic. If one agent sets `recommendedAction: "increase"` and another sets `recommendedAction: "decrease"` for the same security identifier, flag as conflicting regardless of text content. If one agent calculates positive cash flow while another calculates negative for the same period, flag as contradictory data. Rule-based detection provides immediate conflict identification without inference uncertainty.

```python
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import numpy as np
import os

class AgentConflictDetector:
    """Detect contradictory outputs from collaborative agents."""
    
    def __init__(self):
        credential = DefaultAzureCredential()
        self.llm_client = ChatCompletionsClient(
            endpoint=os.environ["AZURE_INFERENCE_ENDPOINT"],
            credential=credential
        )
    
    def detect_output_conflict(
        self,
        agent_a_id: str,
        agent_a_output: dict,
        agent_b_id: str,
        agent_b_output: dict
    ) -> dict:
        """Detect conflicts between two agent outputs using LLM judge."""
        
        # Check for obvious rule-based conflicts first
        rule_conflict = self._check_rule_based_conflicts(
            agent_a_output,
            agent_b_output
        )
        
        if rule_conflict:
            return {
                "conflictDetected": True,
                "conflictType": "rule-based",
                "details": rule_conflict,
                "agentA": agent_a_id,
                "agentB": agent_b_id
            }
        
        # Use LLM judge for semantic consistency check
        consistency_result = self._llm_consistency_check(
            agent_a_output,
            agent_b_output
        )
        
        return {
            "conflictDetected": consistency_result["status"] == "INCONSISTENT",
            "conflictType": "semantic",
            "consistency": consistency_result["status"],
            "explanation": consistency_result["reasoning"],
            "agentA": agent_a_id,
            "agentB": agent_b_id,
            "confidenceScore": consistency_result["confidence"]
        }
```

The `_check_rule_based_conflicts` method applies domain-specific rules to catch obvious contradictions without LLM inference. It compares structured fields like recommended actions and financial metrics—if one agent says "buy" while another says "sell" for the same security, that's flagged as a conflict immediately.

```python
    def _check_rule_based_conflicts(
        self,
        output_a: dict,
        output_b: dict
    ) -> dict | None:
        """Apply domain-specific rules to detect obvious conflicts."""
        
        # Check for contradictory recommendations
        recommendation_a = output_a.get("recommendation", {})
        recommendation_b = output_b.get("recommendation", {})
        
        action_a = recommendation_a.get("action")
        action_b = recommendation_b.get("action")
        symbol = recommendation_a.get("symbol")
        
        if action_a and action_b and symbol:
            if action_a in ["increase", "buy"] and action_b in ["decrease", "sell"]:
                return {
                    "reason": "contradictory-actions",
                    "symbol": symbol,
                    "actionA": action_a,
                    "actionB": action_b
                }
            if action_a in ["decrease", "sell"] and action_b in ["increase", "buy"]:
                return {
                    "reason": "contradictory-actions",
                    "symbol": symbol,
                    "actionA": action_a,
                    "actionB": action_b
                }
        
        # Check for contradictory metrics
        metrics_a = output_a.get("metrics", {})
        metrics_b = output_b.get("metrics", {})
        
        cash_flow_a = metrics_a.get("cashFlow")
        cash_flow_b = metrics_b.get("cashFlow")
        
        if cash_flow_a is not None and cash_flow_b is not None:
            # Same metric but opposite signs indicates data conflict
            if (cash_flow_a > 0 and cash_flow_b < 0) or (cash_flow_a < 0 and cash_flow_b > 0):
                return {
                    "reason": "contradictory-metrics",
                    "metric": "cashFlow",
                    "valueA": cash_flow_a,
                    "valueB": cash_flow_b
                }
        
        return None
```

The `_llm_consistency_check` method handles subtle contradictions that rule-based checks miss. It prompts a language model to evaluate whether two agent outputs are consistent, inconsistent, or complementary, returning a structured judgment with a confidence score.

```python
    def _llm_consistency_check(self, output_a: dict, output_b: dict) -> dict:
        """Use LLM to evaluate semantic consistency of outputs."""
        
        system_prompt = """You are evaluating whether two financial agent analyses are consistent.
        
Respond with a JSON object containing:
- status: "CONSISTENT" if they agree on main conclusions, "INCONSISTENT" if they contradict, "COMPLEMENTARY" if they address different aspects
- reasoning: Brief explanation of your assessment
- confidence: Score from 0.0 to 1.0 indicating confidence in your judgment

Focus on investment recommendations and key metrics, not superficial text differences."""
        
        user_message = f"""Agent A output:
{output_a.get('analysis', '')}
Recommendation: {output_a.get('recommendation', {})}

Agent B output:
{output_b.get('analysis', '')}
Recommendation: {output_b.get('recommendation', {})}

Are these outputs consistent?"""
        
        response = self.llm_client.complete(
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_message}
            ],
            model="gpt-4o-mini",
            temperature=0.0,
            response_format={"type": "json_object"}
        )
        
        import json
        return json.loads(response.choices[0].message.content)
```

This detector combines fast rule-based checks for obvious conflicts with sophisticated LLM judging for subtle contradictions. When two agents produce recommendations on the same security, the system automatically validates their consistency before proceeding. Detecting the conflict is half the challenge—resolving it requires choosing or synthesizing a unified conclusion.

## Key takeaways

- **Agent conflict types** fall into three categories: resource contention conflicts (concurrent writes to shared state), output inconsistency conflicts (divergent domain logic), and deadline conflicts (incompatible timing dependencies)—each requiring a different detection and resolution approach.
- **Semantic analysis** combines three escalating methods—rule-based validation, semantic similarity scoring, and LLM consistency judging—to detect conflicts ranging from obvious field-level mismatches to subtle strategic contradictions.
- **LLM judge confidence scores** indicate how certain the system is that a conflict exists, enabling automatic resolution of high-confidence conflicts and escalation to human review for ambiguous cases.
