Power Automate and Microsoft Teams provide a low-code integration layer for delivering approval requests to human reviewers and collecting their decisions asynchronously. When an agent escalates a decision, it posts a request to a Power Automate webhook, releases the session, and polls for the reviewer's response — all without blocking agent execution or forcing customers to wait.

## Why approval workflows require durable execution

Traditional web applications maintain state in memory for the duration of a request — a user submits a form, the server processes it, and returns a response within seconds. This synchronous model doesn't work for approval workflows where hours or days might elapse between request submission and approval response. Keeping an in-memory state machine running for hours wastes resources and creates reliability problems (what happens if the server restarts before approval arrives?).

Durable workflows externalize state to persistent storage and pause execution while waiting for external events like human approvals. When the approval event arrives, the workflow loads its saved state from storage and continues from exactly where it paused. This pattern enables efficient handling of long-running processes: the workflow consumes zero compute resources while waiting for approval, it survives application restarts and infrastructure changes, and it scales to thousands of pending approvals without resource exhaustion.

Adventure Works needs durable workflows for several approval scenarios. A return exception workflow pauses after submitting the exception for manager review. The workflow might wait 2 hours for approval. When the manager approves, the workflow resumes, updates order status, triggers return label generation, sends customer notification, and completes. A bulk refund workflow pauses after calculating the refund amounts and customer list. The workflow waits for finance team approval. After approval (potentially 24 hours later), the workflow executes the refunds, logs the transactions, and generates the completion report.

## Approval workflow architecture on Azure

Adventure Works standardizes on Power Automate webhook flows paired with Teams adaptive cards for this approval architecture. This combination delivers fast low-code integration with an approval channel that reviewers already use daily, while still providing fully asynchronous human review.

In this pattern, the agent posts an approval request payload to `POWER_AUTOMATE_WEBHOOK_URL`, stores a tracking record in Redis, and returns control immediately. The workflow polls for the decision status until it receives `APPROVED` or `REJECTED` (or times out and escalates).

| Component | Responsibility | Why it is used |
| --------- | -------------- | -------------- |
| Power Automate flow | Receives approval payload and distributes card to approvers | Fast low-code integration with Teams |
| Teams adaptive card | Presents request context and approve or reject actions | Familiar reviewer experience |
| Redis pending approvals store | Tracks in-flight requests and TTL | Lightweight state tracking for asynchronous polling |
| Audit log store | Persists final decision artifacts | Compliance and incident traceability |

In a typical implementation, your application exposes two core functions against this contract: `submit_for_approval()` to post the request payload and record the pending state, and `poll_approval_status()` to check for a decision until one arrives or the timeout elapses.

## Designing approval requests for human reviewers

The approval request presented to a human reviewer must contain all context needed for an informed decision without requiring the reviewer to look up additional information. A poorly designed approval request: "Customer 12345 requested exception. Approve?" A well-designed request includes what the agent is requesting permission to do, what context led to this request, what the customer's history and tier are, what business impact the decision carries, what actions will be taken if approved, and clear approve/reject UI.

Adventure Works uses Microsoft Teams Adaptive Cards for approval requests because most managers already use Teams, the cards provide rich formatting with sections and fields, they support approve or reject buttons with optional comment fields, and they integrate cleanly with Power Automate flows. An approval card for a return exception includes:

- **Customer context**: Name (anonymized if PII-sensitive), tier (gold/standard), account tenure, order history summary
- **Request details**: Order number, product, purchase date, return reason, current policy status ("outside 30-day window")
- **Agent recommendation**: What the agent proposes and why ("Approve exception due to shipping delay")
- **Business impact**: Financial cost, precedent risk, customer lifetime value
- **Actions on approval**: Specific steps that will execute ("Issue return label, credit $249.99 to original payment method within 3-5 days")
- **Approve/Reject buttons**: Single-click decision with optional comment field

The adaptive card design balances completeness with scannability. Managers reviewing 20 approval requests per day need to absorb context quickly — structured formatting with clear sections and visual hierarchy enables efficient decision-making.

## Implementing asynchronous approvals with Power Automate webhooks

Power Automate handles card delivery and approval collection, while your application keeps asynchronous control flow in `approval_workflow.py`. The workflow follows this sequence: submit approval payload to the webhook, store a pending request record, poll for final decision, and apply timeout escalation if no decision arrives by SLA.

```python
import json
import time
import uuid
import requests
import redis

class ApprovalWorkflow:
    def __init__(self, webhook_url: str, redis_client: redis.Redis):
        self.webhook_url = webhook_url
        self.redis = redis_client

    def submit_for_approval(self, refund_decision: dict, reviewer_email: str) -> dict:
        tracking_id = str(uuid.uuid4())

        payload = {
            "tracking_id": tracking_id,
            "reviewer_email": reviewer_email,
            "decision": refund_decision,
        }

        # Send approval request to Power Automate flow.
        response = requests.post(self.webhook_url, json=payload, timeout=10)
        response.raise_for_status()

        # Track pending status for up to 24 hours.
        self.redis.setex(
            f"pending-approvals:{tracking_id}",
            24 * 60 * 60,
            json.dumps({"status": "PENDING"}),
        )

        return {"tracking_id": tracking_id, "status": "PENDING"}

    def poll_approval_status(self, tracking_id: str, timeout_seconds: int = 240) -> str:
        deadline = time.time() + timeout_seconds

        while time.time() < deadline:
            decision = self.redis.get(f"approval:{tracking_id}")
            if decision:
                return json.loads(decision).get("status", "PENDING")
            time.sleep(2)

        return "TIMEOUT"
```

## Timeout handling and escalation paths

Approval workflows need timeout policies to prevent requests from waiting indefinitely. Adventure Works defines timeout tiers: standard approvals have 4-hour SLA, urgent approvals have 1-hour SLA, and escalated approvals have 24-hour SLA. If a reviewer doesn't respond within the timeout window, the workflow automatically escalates to the next approver tier or defaults to a conservative fallback action.

For a return exception request, the timeout handling works like this: the initial manager approval waits for the configured polling window, then escalates to a senior reviewer path if no decision record appears. If escalation also times out, the workflow defaults to rejection with a notification explaining that review exceeded SLA and suggesting a follow-up path. The default-to-rejection policy ensures timeouts don't create uncontrolled approvals.

For lower-stakes approvals, the timeout might default to auto-approval rather than rejection. A loyalty points adjustment under $25 might auto-approve after 2 hours if the manager hasn't responded — the business risk is minimal, and auto-approval serves the customer better than indefinite waiting.

## Audit trail for all approval decisions

Every approval or rejection must be logged in an immutable audit trail that records who made the decision, when they decided, what context they reviewed, whether they approved or rejected, any comments they provided, and what actions resulted from the decision. This audit trail serves three purposes: compliance with automated decision oversight requirements, post-incident analysis when something goes wrong, and agent improvement through analyzing which proposals get approved vs. rejected.

Adventure Works stores approval audit records in Azure Cosmos DB with append-only semantics — the system never modifies or deletes records; it only appends new ones. Each record includes the approval request JSON, the decision outcome, the approver identity (hashed for privacy), timestamp, and a link to the OpenTelemetry trace from the agent's original decision. Role-based access control protects the audit database from tampering while keeping it queryable for compliance reporting and analytics.

Monthly audit reports analyze approval patterns: approval rate by agent, by request type, by approver, and by impact level. Low approval rates for a specific agent or request type suggest the agent is making poor recommendations and needs prompt improvement. High approval rates across all categories with no rejections might indicate rubber-stamping — reviewers approving without genuine assessment — requiring reviewer training or spot-check audits.

Asynchronous approval workflows and immutable audit trails make human oversight practical at scale — reviewers see the right context, decisions survive infrastructure events, and every approval leaves a traceable record.

## Human review as a Microsoft Foundry capability

The human review capability you've implemented here—durable workflows that pause for human input, approval cards that surface context for reviewers, and audit trails that record every decision—maps to a named capability in Microsoft Foundry. Microsoft Foundry's human review process provides the runtime integration point where agents pause execution and request human evaluation of a decision before proceeding.

Power Automate and Teams adaptive cards are the underlying implementation pattern: Foundry surfaces the human review request through its approval workflow integration, which Power Automate routes to a Teams channel where reviewers see adaptive cards with full decision context. When reviewers approve or reject in Teams, the response flows back through Power Automate to the durable workflow state, and Foundry resumes agent execution.

Foundry provides the capability surface; durable workflows + Power Automate + Teams adaptive cards are the implementation components. Neither is complete without the other — Foundry defines when and why to pause; the implementation components define how.

## Key takeaways

- **Durable workflows** externalize state to persistent storage and pause execution while awaiting human approval, consuming zero compute resources during the wait and surviving application restarts.
- **Power Automate webhooks** paired with Teams adaptive cards provide a low-code integration for submitting approval requests and collecting human decisions asynchronously.
- **Well-designed approval cards** include customer context, request details, agent recommendation, business impact, and clear approve/reject buttons so reviewers can make informed decisions quickly.
- **Timeout handling** defines SLA-based escalation tiers and configurable default actions (reject for high-stakes, auto-approve for low-stakes) to prevent indefinite waiting.
- **Immutable audit trails** in Cosmos DB log every approval decision with full context, supporting compliance reporting, post-incident analysis, and agent improvement analytics.
