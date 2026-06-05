Microsoft Foundry's evaluation pipeline turns human approval decisions into structured test cases that continuously improve agent quality. Every rejected proposal becomes a labeled example that validates prompt updates before deployment and tracks whether the improvement actually reduces future escalation rates.

## Two complementary types of human feedback

Human feedback in multi-agent systems comes from two distinct sources with different characteristics and use cases.

**Approval and rejection feedback** is implicit—the decision to approve or reject an agent's proposal signals which decisions the agent handles well and which it doesn't. When an agent proposes a return exception and the manager approves it, that proposal was correct. When the manager rejects it with a comment "customer is outside warranty period, not just return window," the agent misunderstood which policy applied. Approval feedback is high-quality because it comes from expert reviewers making consequential decisions, but it's sparse—Adventure Works collects approval feedback only for the 8-12% of interactions that escalate to human review.

**Explicit correction feedback** includes customer ratings, thumbs up/down on agent responses, flagged responses marked as incorrect or unhelpful, and free-text comments from both customers and human agents. This feedback is more abundant than approval feedback (potentially every interaction can be rated) but noisier—some customers give low ratings due to the outcome rather than agent quality, and some rate responses highly even when factually incorrect. Explicit feedback requires filtering and interpretation to extract genuine quality signals.

Both feedback types complement each other. Approval feedback provides high-confidence negative examples (rejected proposals were wrong) with expert-annotated corrections. Explicit feedback provides volume and diversity, capturing issues that don't trigger escalation but still degrade customer experience.

## Systematically collecting feedback with minimal friction

Feedback collection must balance completeness with user burden. Asking reviewers to fill out detailed forms for every approval decision creates friction that reduces compliance. Adventure Works designs feedback collection for one-click simplicity wherever possible.

For approval decisions, the feedback is the decision itself—approve or reject—plus an optional comment field. The adaptive card includes a "Reason for rejection" dropdown with common categories (wrong policy interpretation, outside agent authority, insufficient context, customer tier mismatch) plus free-text "other." Requiring the reviewer to categorize rejections takes 3 seconds and provides structured data for systematic analysis. Approvals default to no additional input required, though reviewers can add optional comments explaining why they approved edge cases.

For customer-facing responses, Adventure Works adds a simple rating prompt at the end of resolved conversations: "Was this helpful? 👍 👎" with an optional "Tell us more" expansion for customers who want to provide detail. The thumbs-up/down requires zero typing and imposes minimal burden. Completion rate for this simple rating: 42%. A previous iteration that asked customers to rate 1-5 stars and explain their rating achieved only 8% completion.

For internal agent reviews, customer service managers use a flagging system. While monitoring agent conversations, managers can flag problematic responses with a single click and select from predefined issue categories (factually incorrect, wrong tone, policy violation, missed opportunity). Each flagged response links to the OpenTelemetry trace, making it easy to identify which agent and which prompt produced the response.

## Integrating feedback into the evaluation pipeline

Feedback collection alone doesn't improve agents—the feedback must flow into an evaluation and testing pipeline that validates prompt improvements against structured test cases before deployment. Adventure Works connects approval rejections directly to their regression test suite, ensuring that rejected proposals become test cases that validate future improvements.

The feedback integration workflow operates monthly:

1. Query all approval rejections from the audit database.
2. Filter for high-confidence rejections where the approver provided clear rationale.
3. Sample 100 rejections covering diverse request types and agents.
4. For each rejection, extract the agent's input (customer request), the proposed action (what was rejected), and the correct action (from the approver comment or subsequent manual handling).
5. Format each as an evaluation test case: input → expected output → label (correct/incorrect).
6. Add the test cases to the regression suite in Microsoft Foundry.

Before deploying any agent prompt update, the updated prompt runs against the expanded regression suite including all feedback-derived test cases. If the new prompt fails on test cases derived from recent rejections, the update would reintroduce recently fixed bugs—don't deploy. This feedback loop ensures continuous quality improvement and prevents regression.

```python
import json
from datetime import datetime, timedelta
from typing import List, Dict, Any

class FeedbackCollector:
    def __init__(self, cosmos_client, max_rejections_per_category=20):
        self.cosmos_client = cosmos_client
        self.max_rejections_per_category = max_rejections_per_category
        self.issue_categories = [
            "wrong_policy_interpretation",
            "outside_authority",
            "insufficient_context",
            "customer_tier_mismatch",
            "incorrect_calculation",
            "other"
        ]
    
    def collect_approval_rejections(self, start_date: datetime, end_date: datetime) -> List[Dict[str, Any]]:
        """Query all approval rejections within date range."""
        query = """
        SELECT * FROM approvals a
        WHERE a.decision = 'rejected'
        AND a.timestamp >= @start_date
        AND a.timestamp <= @end_date
        """
        
        parameters = [
            {"name": "@start_date", "value": start_date.isoformat()},
            {"name": "@end_date", "value": end_date.isoformat()}
        ]
        
        rejections = list(self.cosmos_client.query_items(
            query=query,
            parameters=parameters,
            enable_cross_partition_query=True
        ))
        
        return rejections
    
    def filter_high_confidence_rejections(self, rejections: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Filter for rejections with clear rationale and diverse coverage."""
        high_confidence = []
        
        for rejection in rejections:
            # Must have category or detailed comment
            has_rationale = (
                rejection.get("rejection_category") != "other" or
                (rejection.get("comment", "").strip() and len(rejection.get("comment", "")) > 20)
            )
            
            if has_rationale:
                high_confidence.append(rejection)
        
        return high_confidence
```

The collector queries approval rejections and filters for high-confidence cases with clear rationale—rejections with specific categories or detailed reviewer comments. These filtered rejections are then sampled across categories to ensure the test suite covers diverse failure modes:

```python
    def stratified_sample(self, rejections: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Sample rejections across different categories for diversity."""
        sampled = []
        
        # Group by category
        by_category = {category: [] for category in self.issue_categories}
        
        for rejection in rejections:
            category = rejection.get("rejection_category", "other")
            if category in by_category:
                by_category[category].append(rejection)
        
        # Sample from each category
        for category, items in by_category.items():
            sample_size = min(len(items), self.max_rejections_per_category)
            sampled.extend(items[:sample_size])
        
        return sampled
    
    def format_as_test_case(self, rejection: Dict[str, Any]) -> Dict[str, Any]:
        """Convert rejection to evaluation test case format."""
        original_request = rejection.get("original_request", {})
        agent_proposal = rejection.get("agent_proposal", {})
        correct_action = rejection.get("correct_action") or rejection.get("comment", "")
        
        test_case = {
            "input": {
                "customer_message": original_request.get("customer_message"),
                "context": original_request.get("context", {})
            },
            "agent_output": {
                "proposed_action": agent_proposal.get("action"),
                "confidence": agent_proposal.get("confidence"),
                "reasoning": agent_proposal.get("reasoning")
            },
            "expected_output": {
                "correct_action": correct_action,
                "issue_category": rejection.get("rejection_category")
            },
            "label": "incorrect",  # Rejected = incorrect
            "metadata": {
                "rejection_date": rejection.get("timestamp"),
                "approver": rejection.get("approver_id"),
                "agent_id": rejection.get("agent_id"),
                "trace_id": rejection.get("trace_id")
            }
        }
        
        return test_case
```

Stratified sampling ensures no single rejection category dominates the test suite. The `format_as_test_case` method converts each rejection into a structured test case with the original input, the agent's incorrect output, and the expected correct action from the human reviewer. The pipeline methods below orchestrate the full monthly collection and regression suite update:

```python
    def generate_monthly_test_cases(self) -> List[Dict[str, Any]]:
        """Generate test cases from previous month's rejection feedback."""
        # Query last month's rejections
        end_date = datetime.now()
        start_date = end_date - timedelta(days=30)
        
        rejections = self.collect_approval_rejections(start_date, end_date)
        
        # Filter for high-confidence rejections with clear rationale
        high_confidence = self.filter_high_confidence_rejections(rejections)
        
        # Stratified sampling across categories
        sampled = self.stratified_sample(high_confidence)
        
        # Format as test cases
        test_cases = [self.format_as_test_case(rejection) for rejection in sampled]
        
        return test_cases
    
    def append_to_regression_suite(self, test_cases: List[Dict[str, Any]], suite_path: str):
        """Append new test cases to existing regression test suite."""
        # Load existing suite
        try:
            with open(suite_path, 'r') as f:
                existing_suite = json.load(f)
        except FileNotFoundError:
            existing_suite = {"test_cases": []}
        
        # Append new cases
        existing_suite["test_cases"].extend(test_cases)
        existing_suite["last_updated"] = datetime.now().isoformat()
        existing_suite["total_cases"] = len(existing_suite["test_cases"])
        
        # Save updated suite
        with open(suite_path, 'w') as f:
            json.dump(existing_suite, f, indent=2)
        
        return len(test_cases)
```

## Active learning prioritization for maximum impact

Not all feedback examples contribute equally to agent improvement. Training on a rejected proposal where the agent was highly confident but wrong (confidence 0.92, rejection) provides more learning signal than training on a low-confidence rejection (confidence 0.45, rejection)—the low-confidence case already triggered escalation correctly, while the high-confidence failure represents a genuine model blind spot.

Adventure Works prioritizes feedback examples using three criteria:

**Confidence-outcome mismatch**: High-confidence rejections (agent was confident but wrong) and low-confidence approvals (agent was uncertain but correct) are most valuable. These examples identify where the agent's calibration is off and where the escalation thresholds might be misconfigured.

**Novel scenarios**: Feedback from request types the agent hasn't encountered frequently provides more learning signal than the hundredth example of a common scenario the agent already handles well. Novelty detection compares the feedback example's embedding to the existing training data distribution—examples far from known clusters are prioritized.

**High-frequency patterns**: Failures on common request types have highest overall impact. If 15% of rejections involve a specific product category or a specific policy edge case, fixing that pattern reduces rejection rate more than fixing a one-off unusual request. Group feedback by request similarity and prioritize clusters with many examples.

The prioritization scoring combines all three: `priority_score = 0.4 × confidence_mismatch + 0.3 × novelty + 0.3 × frequency`. The top 20% of feedback examples by priority score become the focus for prompt optimization efforts.

## Prompt optimization from feedback patterns

When feedback analysis reveals a consistent pattern of rejections, the root cause is usually one of three prompt issues: incorrect policy interpretation in the system prompt, missing context about edge cases that aren't explicitly documented, or ambiguous intent handling where the agent chooses the wrong interpretation.

For example, Adventure Works discovered that 18% of rejections involved returns for products purchased on sale or with discount codes. The agent was correctly checking the 30-day return window but incorrectly calculating refund amounts—it refunded the full price instead of the discounted price paid by the customer. The rejection feedback included approver comments: "Refund should be \$79.99 (customer's actual payment), not \$129.99 (list price)."

The fix: update the return processing agent's system prompt to explicitly instruct it to calculate refunds based on actual amount paid, not list price, and add a test case to the regression suite with a discounted purchase return. After the prompt update, run evaluation on the expanded regression suite to verify the fix resolves the issue without introducing new failures. Deploy the updated prompt and monitor rejection rates for the next month—if successful, the specific rejection pattern should disappear from feedback.

This feedback-driven optimization loop continuously improves agent quality. Each month, analyze feedback for patterns, identify top 3-5 issues by priority score, update prompts to address each issue, validate fixes with regression tests including the feedback examples, deploy updated prompts, and monitor for issue resolution. Over six months, Adventure Works reduced their overall approval rejection rate from 28% to 12% through systematic feedback-driven improvement.

> [!TIP]
> **Pause and reflect:** Your monthly feedback analysis shows that 18% of rejections involve discounted product returns where the agent refunds list price instead of the amount paid. How would you prioritize this feedback example using confidence-outcome mismatch, novelty, and frequency criteria, and what specific prompt change would you propose?

Active learning from human feedback transforms agents from static models into continuously improving systems. Each rejection tightens the gap between what the agent knows and what reviewers actually expect—and combined with confidence-based escalation and durable approval workflows, this feedback loop is what makes human oversight genuinely valuable rather than just a compliance checkbox.

## Key takeaways

- **Two feedback types** complement each other: sparse but high-quality approval/rejection signals from expert reviewers, and abundant but noisier explicit correction feedback from customer ratings and agent flags.
- **Low-friction collection** maximizes feedback volume through one-click approval decisions, simple thumbs up/down ratings (42% completion rate), and single-click flagging for internal reviews.
- **Feedback-to-test-case pipeline** converts monthly approval rejections into structured evaluation test cases that validate prompt improvements and prevent regressions.
- **Active learning prioritization** scores feedback examples by confidence-outcome mismatch, novelty, and frequency to focus improvement efforts on the highest-impact patterns.
- **Prompt optimization loop** analyzes rejection patterns monthly, updates system prompts to address top issues, validates fixes against expanded regression suites, and monitors rejection rates post-deployment.
