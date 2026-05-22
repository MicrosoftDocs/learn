## Apply resolution strategies by conflict type

Once a conflict is detected, the resolution strategy depends on the conflict's nature and severity. Four patterns handle the majority of agent conflicts in production systems.

**Priority-based resolution** establishes a domain authority hierarchy where certain agent types override others. For Contoso Capital, regulatory compliance agents have ultimate authority—if the compliance agent says a trade violates position concentration limits, that overrides any market analysis agent's buy recommendation. The conflict resolver checks agent types against the priority table and selects the output from the highest-priority agent.

This strategy works when conflicts represent legitimate differences in objectives rather than errors. Market agents optimize for returns. Risk agents optimize for downside protection. Compliance agents enforce regulatory boundaries. These perspectives naturally conflict, and resolution comes from explicit policy about which perspective wins in specific scenarios.

**Consensus-based resolution** aggregates opinions from multiple agents of the same type. If Contoso Capital runs three independent market analysis agents on the same report and two conclude "buy" while one concludes "hold," proceed with the majority view. The threshold determines required agreement—requiring 3-of-3 consensus versus accepting 2-of-3 majority trades false negatives for false positives.

Consensus resolution assumes individual agents can make errors but collective judgment is reliable. This works well for analysis tasks where agents use different methodologies or data sources. It fails when all agents share the same upstream data error, producing consistent but incorrect conclusions.

**Escalation to orchestrator synthesis** handles conflicts that neither priority nor consensus can resolve. The conflict detector sends both agents' outputs to the hub orchestrator along with a conflict report. The orchestrator invokes a specialized synthesis agent that reads both analyses, understands their different priorities, and produces a unified recommendation that acknowledges the trade-offs.

The synthesis agent generates outputs like: "Market analysis identifies growth opportunity warranting position increase. Risk assessment flags elevated concentration risk. Recommendation: increase position by 50% of originally proposed amount, maintaining concentration within acceptable bounds." This resolution preserves both agents' insights while producing actionable guidance.

**Deadline conflict decoupling** addresses timing dependencies by restructuring the task plan. When Agent A requires Agent B's output but B cannot meet A's deadline, two patterns apply. First, proceed with approximation—Agent A uses historical data or cached results from B's previous analysis instead of waiting for current output. Second, decouple the dependency—modify the task so A's analysis doesn't require B's input, producing a less comprehensive but achievable result within constraints.

```python
class ConflictResolver:
    """Resolve detected conflicts using domain-appropriate patterns."""
    
    def __init__(self, agent_priority_map: dict):
        self.priority_map = agent_priority_map
    
    def resolve_conflict(
        self,
        conflict_report: dict,
        agent_a_output: dict,
        agent_b_output: dict
    ) -> dict:
        """Select resolution strategy and produce unified output."""
        
        conflict_type = conflict_report.get("conflictType")
        agent_a_id = conflict_report["agentA"]
        agent_b_id = conflict_report["agentB"]
        
        # Determine agent types from IDs
        agent_a_type = self._extract_agent_type(agent_a_id)
        agent_b_type = self._extract_agent_type(agent_b_id)
        
        # Priority-based resolution
        if agent_a_type in self.priority_map and agent_b_type in self.priority_map:
            priority_a = self.priority_map[agent_a_type]
            priority_b = self.priority_map[agent_b_type]
            
            if priority_a > priority_b:
                chosen_output = agent_a_output
                chosen_agent = agent_a_id
                resolution_method = "priority-based"
            elif priority_b > priority_a:
                chosen_output = agent_b_output
                chosen_agent = agent_b_id
                resolution_method = "priority-based"
            else:
                # Equal priority - escalate
                return self._escalate_for_synthesis(
                    conflict_report,
                    agent_a_output,
                    agent_b_output
                )
        else:
            # No priority mapping - escalate
            return self._escalate_for_synthesis(
                conflict_report,
                agent_a_output,
                agent_b_output
            )
        
        return {
            "resolution": "resolved",
            "method": resolution_method,
            "chosenAgent": chosen_agent,
            "output": chosen_output,
            "conflictDetails": conflict_report
        }
    
    def _extract_agent_type(self, agent_id: str) -> str:
        """Extract agent type from agent identifier."""
        # Example: "market-analysis-v2-eastus" -> "market-analysis"
        return agent_id.split("-v")[0]
    
    def _escalate_for_synthesis(
        self,
        conflict_report: dict,
        output_a: dict,
        output_b: dict
    ) -> dict:
        """Escalate to orchestrator for synthesis when automatic resolution fails."""
        
        return {
            "resolution": "escalated",
            "method": "orchestrator-synthesis-required",
            "conflictReport": conflict_report,
            "outputA": output_a,
            "outputB": output_b,
            "requiresHumanReview": conflict_report.get("confidenceScore", 1.0) < 0.5
        }

# Example priority configuration
CONTOSO_AGENT_PRIORITY = {
    "compliance": 100,  # Compliance always wins
    "risk": 75,         # Risk trumps market analysis
    "market-analysis": 50,  # Analysis is important but constrained
    "reporting": 25     # Reporting agents synthesize, never override
}
```

The resolver applies these strategies automatically, producing either a unified output or an escalation ticket when conflicts exceed automatic resolution capabilities. Every resolution gets logged to the conflict audit trail.

## Maintain conflict resolution audit trails

Financial regulatory frameworks require comprehensive evidence that investment recommendations follow documented decision processes. When conflicts occur and get resolved automatically, that resolution becomes part of the regulatory record. The audit trail must capture what conflicted, why it conflicted, how it was resolved, and who approved the resolution logic.

The conflict audit schema records:

- Conflict detection timestamp and detector version
- Conflicting agent identifiers and their outputs (full state snapshot)
- Conflict classification (resource contention, output inconsistency, deadline)
- Resolution method applied and which agent's output was selected
- Confidence scores from LLM judges if used
- Orchestrator approvals for escalated conflicts

This audit data serves multiple purposes. Compliance teams use it to demonstrate appropriate controls to regulators. Engineering teams analyze conflict patterns to identify agents that frequently produce inconsistent outputs—these agents may need recalibration. Product teams track conflict resolution success rates to validate that automated resolution produces acceptable outcomes.

When conflicts escalate to human review, the audit trail links the automated detection, attempted resolution strategies, and eventual human decision. If a compliance officer overrides the automated resolver's priority-based decision, that override gets logged with justification. Future similar conflicts can reference the precedent.

The complete conflict lifecycle—detection, classification, resolution, and audit—transforms multi-agent coordination from a source of unreliable outputs into a robust production capability where specialized agents contribute their expertise and conflicts get resolved systematically rather than creating runtime failures.

With enterprise-scale discovery, distributed state management, context isolation, and conflict resolution in place, you have the architectural patterns to operate agent ecosystems serving hundreds of clients across dozens of specialized agents. These patterns scale Contoso Capital's platform from prototype experimentation to production financial services infrastructure. Now you implement these patterns hands-on in the exercise.

## Unit summary

- **Resolution strategies vary by conflict type**: factual contradictions use authoritative source arbitration, assessment differences use weighted aggregation, and stale-data conflicts trigger data refresh.
- **Confidence-weighted resolution** selects the higher-confidence output when analytical perspectives conflict, with explicit justification logging for transparency.
- **Audit trails** log every conflict detection, resolution strategy applied, winning/losing outputs, and justification — creating a complete accountability record for regulatory review and system improvement.
