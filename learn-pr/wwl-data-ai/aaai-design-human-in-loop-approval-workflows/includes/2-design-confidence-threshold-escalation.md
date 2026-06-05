Microsoft Foundry agents evaluate their own confidence before executing high-stakes decisions, and you can configure escalation thresholds to route low-confidence or high-impact actions to human reviewers automatically. Effective escalation combines multiple signals—model confidence, financial impact, policy exceptions, and request ambiguity—so human review activates only when it's genuinely needed.

## When agents should escalate to human review

Escalation triggers should be composable—multiple factors combine to determine whether human intervention is needed, rather than relying on any single metric. Adventure Works identifies four escalation triggers that operate independently and can be combined in priority order.

**Confidence score thresholds** represent the agent's self-assessed certainty about its proposed action. After analyzing a request and formulating a response or action, the agent generates a confidence score from 0.0 to 1.0 indicating how certain it is that the proposed action is correct. Confidence below 0.75 for any decision triggers review consideration. However, confidence scores alone are insufficient because they don't account for the stakes of the decision—a 0.70 confidence decision to send a standard shipping notification is fine, while 0.70 confidence on a fraud investigation is unacceptable.

**Business impact assessment** quantifies the financial or operational consequences of the action. The impact calculation considers monetary value (refund amounts, credit issued, discount applied), scope (number of customers affected), and irreversibility (can the action be easily undone?). High-impact actions have different confidence requirements than low-impact ones. Adventure Works defines three impact tiers: low impact (< \$50 value, single customer, reversible), moderate impact (\$50-\$200 value or affects 2-10 customers), and high impact (> \$200 value, affects > 10 customers, or irreversible actions like account closures).

**Policy exception requirements** trigger escalation regardless of confidence. Adventure Works' agents operate within defined policy boundaries—they can approve returns within the 30-day window, they can issue refunds up to order value, they can apply standard discount codes. But some customer requests require bending these rules: accepting a return after 45 days, issuing a refund exceeding order value to compensate for poor service, or applying manager-level discounts. These exception requests require human authorization even if the agent is highly confident the exception is appropriate.

**Ambiguity detection** identifies situations where multiple valid interpretations exist and choosing incorrectly would harm the customer. A customer writes "I want to return this"—the agent sees two orders in the past 60 days. Which one? The agent mustn't guess. A customer says "the product broke after two weeks"—is this a defect warranty claim or a standard return? The distinction determines which team handles the request and what compensation is appropriate. Ambiguity requires clarification, either from the customer or from a human agent who can apply judgment.

| Escalation trigger | Threshold | Example situation |
|-------------------|-----------|-------------------|
| Low confidence | < 0.60 always, < 0.75 with moderate+ impact | Agent unsure which policy applies |
| High business impact | > \$200 or > 10 customers | Bulk refund, large exception approval |
| Policy exception | Any exception request | Return outside window, above-limit credit |
| Ambiguity | Multiple valid interpretations | Unclear which order, which policy applies |

These triggers form a decision tree evaluated in priority order: first check for policy exceptions (always escalate), then evaluate business impact and confidence together, finally assess ambiguity. If any trigger fires, the request escalates to human review with context about which condition triggered escalation.

## Calibrating confidence scores for accurate thresholds

Confidence scores reported by language models are notoriously miscalibrated. A model might report 0.90 confidence on decisions where it's only correct 65% of the time, or report 0.70 confidence when it achieves 85% accuracy. Using raw confidence scores for escalation decisions creates either excessive escalation (if the model underestimates its accuracy) or insufficient oversight (if it overestimates). Confidence calibration maps reported scores to actual accuracy rates using historical data.

Adventure Works builds a calibration dataset by collecting 2,000 agent decisions with their reported confidence scores and having human experts label each decision as correct or incorrect. The calibration analysis groups decisions by reported confidence ranges—all decisions with 0.85-0.90 confidence are grouped together—and calculates actual accuracy within each group. If the 0.85-0.90 confidence group achieved only 72% accuracy, the calibration curve maps a reported 0.875 confidence to a true 0.72 accuracy.

The calibration curve transforms raw model confidence into calibrated probabilities that reflect real-world accuracy. When the agent reports 0.85 confidence, the system looks up the calibrated accuracy (0.72) and uses that for escalation decisions. This calibration is model-specific and task-specific—Adventure Works calculates each agent's confidence calibration separately because different tasks have different accuracy profiles. The return policy agent's confidence scores may be well-calibrated (reported 0.80 = actual 0.78), while the exception handler's scores may be overconfident (reported 0.80 = actual 0.63).

Recalibration happens quarterly as the agents improve. As prompts are refined and agents receive feedback, their accuracy at each confidence level changes. A three-month calibration dataset might show that the agent now achieves 0.81 accuracy in the 0.85-0.90 reported confidence range, updating the calibration curve. Continuous recalibration ensures escalation thresholds remain accurate as agent capabilities evolve.

## Defining escalation thresholds by risk level

With calibrated confidence scores, Adventure Works defines escalation thresholds that balance automation efficiency with risk tolerance. The thresholds are risk-stratified: higher-risk decisions require higher confidence before autonomous execution.

**Low-risk decisions** (impact < \$50, single customer, reversible) require calibrated confidence > 0.60 to proceed autonomously. If confidence falls below 0.60, escalate. These decisions include standard return label generation, order status updates to customers, and applying approved discount codes. The 0.60 threshold accepts that 40% of low-confidence low-risk decisions might be suboptimal, which is acceptable given the small impact and easy reversibility.

**Moderate-risk decisions** (impact \$50-\$200 or affects 2-10 customers) require calibrated confidence > 0.75. Examples include return approvals within policy, refunds matching order value, and loyalty points adjustments within tier limits. The 0.75 threshold means the agent must be correct at least 75% of the time based on calibrated accuracy—not a high bar, but sufficient for moderate-stakes situations.

**High-risk decisions** (impact > \$200, affects > 10 customers, or irreversible) require calibrated confidence > 0.88. These include exception approvals, bulk operations, account modifications, and actions that could trigger regulatory scrutiny. The 0.88 threshold ensures high accuracy before autonomous action.

**Policy exceptions** always escalate regardless of confidence. Even if the agent is 0.95 confident that a 45-day return exception should be approved, it lacks the authority to make that decision autonomously. Human authorization is required for out-of-bounds actions.

```python
from typing import Dict, Any
from enum import Enum

class RiskLevel(Enum):
    LOW = "low"
    MODERATE = "moderate"
    HIGH = "high"
    EXCEPTION = "exception"

class EscalationDecider:
    def __init__(self, calibration_curve: Dict[float, float]):
        """
        Initialize with calibration curve mapping raw confidence to calibrated accuracy.
        calibration_curve: {raw_confidence: calibrated_accuracy}
        """
        self.calibration_curve = calibration_curve
        self.confidence_thresholds = {
            RiskLevel.LOW: 0.60,
            RiskLevel.MODERATE: 0.75,
            RiskLevel.HIGH: 0.88,
            RiskLevel.EXCEPTION: 1.0  # Always escalate
        }
    
    def calibrate_confidence(self, raw_confidence: float) -> float:
        """Convert raw model confidence to calibrated accuracy using calibration curve."""
        # Find nearest calibration point
        calibration_points = sorted(self.calibration_curve.keys())
        nearest_point = min(calibration_points, key=lambda x: abs(x - raw_confidence))
        return self.calibration_curve[nearest_point]
```

The `EscalationDecider` class maps raw model confidence to calibrated accuracy using historical performance data. Without calibration, a model reporting 0.90 confidence might only be correct 72% of the time—the calibration curve corrects this gap so threshold comparisons use real-world accuracy rates.

```python
    def assess_risk_level(self, action: Dict[str, Any]) -> RiskLevel:
        """Determine risk level of proposed action based on impact and scope."""
        # Check for policy exceptions first
        if action.get("requires_exception", False):
            return RiskLevel.EXCEPTION
        
        # Assess financial impact and scope
        financial_impact = action.get("financial_amount", 0)
        customer_count = action.get("customers_affected", 1)
        is_reversible = action.get("reversible", True)
        
        # High risk triggers
        if financial_impact > 200 or customer_count > 10 or not is_reversible:
            return RiskLevel.HIGH
        
        # Moderate risk
        if financial_impact > 50 or customer_count > 1:
            return RiskLevel.MODERATE
        
        # Default to low risk
        return RiskLevel.LOW
```

Risk assessment evaluates each action's financial impact, customer scope, and reversibility to assign a risk tier. The `should_escalate` method below combines the calibrated confidence score with the assessed risk level to determine whether Adventure Works' agent can proceed autonomously or must route the decision to a human reviewer.

```python
    def should_escalate(self, raw_confidence: float, action: Dict[str, Any], 
                       ambiguity_detected: bool = False) -> Dict[str, Any]:
        """Determine whether action should escalate to human review."""
        # Calibrate confidence score
        calibrated_confidence = self.calibrate_confidence(raw_confidence)
        
        # Assess risk level
        risk_level = self.assess_risk_level(action)
        
        # Always escalate policy exceptions
        if risk_level == RiskLevel.EXCEPTION:
            return {
                "should_escalate": True,
                "reason": "policy_exception",
                "risk_level": risk_level.value,
                "calibrated_confidence": calibrated_confidence,
                "raw_confidence": raw_confidence
            }
        
        # Always escalate ambiguous situations
        if ambiguity_detected:
            return {
                "should_escalate": True,
                "reason": "ambiguity_detected",
                "risk_level": risk_level.value,
                "calibrated_confidence": calibrated_confidence,
                "raw_confidence": raw_confidence
            }
        
        # Check confidence against risk-appropriate threshold
        required_confidence = self.confidence_thresholds[risk_level]
        
        if calibrated_confidence < required_confidence:
            return {
                "should_escalate": True,
                "reason": "insufficient_confidence",
                "risk_level": risk_level.value,
                "calibrated_confidence": calibrated_confidence,
                "required_confidence": required_confidence,
                "raw_confidence": raw_confidence
            }
        
        # Confidence sufficient for autonomous execution
        return {
            "should_escalate": False,
            "risk_level": risk_level.value,
            "calibrated_confidence": calibrated_confidence,
            "raw_confidence": raw_confidence
        }
```

## Graceful escalation user experience

When an agent determines that escalation is necessary, how it communicates that escalation to the customer makes a significant difference in customer experience. A poor escalation response: "I can't help with this." A better response: "This request requires manager approval. I've submitted it for review, and you'll receive a response within 4 hours. In the meantime, I can help you with anything else related to your account."

Adventure Works trains agents to provide escalation responses that explain what's being escalated and why, give the customer a time expectation for resolution, offer to continue helping with other aspects of their request, and provide a tracking reference so the customer can follow up. This approach maintains customer trust and demonstrates that escalation is part of the designed service, not a system failure.

The escalated request enters a durable approval workflow that allows human reviewers to process it asynchronously. The customer doesn't need to wait on hold; they can disconnect and check back later or wait for email notification when the review completes.

## Tracking escalation patterns for continuous improvement

Adventure Works monitors escalation metrics to identify opportunities for reducing unnecessary escalations and improving agent capability. The escalation dashboard tracks escalation rate by agent, by request category, and by escalation trigger. High escalation rates indicate either overly conservative thresholds or agent capability gaps.

If the shipping exception agent escalates 35% of requests due to insufficient confidence, the pattern suggests either the confidence threshold is too strict for that agent's task, or the agent's prompt needs improvement to handle common exception scenarios more confidently. Investigation might reveal that 80% of escalated shipping exceptions are for a specific scenario—delayed international shipments—that the agent hasn't been trained to handle. Adding explicit guidance for that scenario to the system prompt reduces escalation rate to 15% while maintaining quality.

Escalation pattern analysis also identifies calibration drift. If escalations due to "insufficient confidence" are consistently approved by human reviewers with no modifications, the confidence threshold may be too conservative—the agent is more accurate than the calibration curve suggests. Conversely, if human reviewers frequently reject or modify escalated proposals, the agent is less accurate than calibrated scores indicate, and recalibration is needed.

When confidence calibration, risk stratification, and clear escalation messaging work together, human review activates at the right moment—protecting the business from costly errors without turning every uncertain request into a bottleneck.

## Key takeaways

- **Composable escalation triggers** combine confidence scores, business impact assessment, policy exception detection, and ambiguity identification rather than relying on any single metric.
- **Confidence calibration** maps raw model scores to actual accuracy rates using historical data, correcting for systematic overconfidence or underconfidence in model self-assessment.
- **Risk-stratified thresholds** require higher calibrated confidence for higher-stakes decisions: 0.60 for low-risk, 0.75 for moderate, and 0.88 for high-risk actions.
- **Graceful escalation UX** communicates what's being escalated, sets time expectations, offers continued help with other aspects, and provides a tracking reference for follow-up.
- **Escalation pattern tracking** identifies optimization opportunities by monitoring which agents, categories, and triggers generate the most escalations over time.
