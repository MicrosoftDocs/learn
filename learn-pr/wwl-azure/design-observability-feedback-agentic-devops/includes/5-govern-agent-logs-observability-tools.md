Observability must cover the assistant's contribution and the workload it investigates. Otherwise, a useful recommendation, a failed tool call, and an unauthorized assumption can all disappear behind the final response.

## Observe agent activity without assuming universal collection

For a governed workflow, retain the task/attempt identity, agent-definition and instruction/skill revisions, available model identifier, tool name and target, start/end time, outcome, evidence references, and approval/execution state. Capture supported usage information where available; label cost estimates and unavailable fields explicitly.

GitHub Copilot editor sessions, hosted PR review, CLI automation, and a custom instrumented application don't expose identical records. Check the host's supported logs and enterprise controls. Don't promise that Application Insights or OpenTelemetry automatically captures every Copilot prompt, tool call, or token.

If you own an automation wrapper or agent-enabled application, instrument approved task/tool boundaries and propagate correlation identifiers. Prefer metadata and evidence references over full prompt/response capture. Establish redaction, retention, restricted access, and export-failure reporting; logs shouldn't become a second repository of secrets or customer payloads.

Monitor operationally useful failures: repeated tool retries, missing evidence, rejected proposals, stale grounding, unexpected target changes, and tasks that stop without a valid output. A successful API call isn't the same as a successful engineering task.

## Position Azure Copilot Observability Agent

**Azure Copilot Observability Agent** is an Azure Monitor companion for natural-language exploration, investigation, and operational follow-up. It complements GitHub Copilot: use Copilot for reviewed source/query proposals and the Azure agent for supported, scoped telemetry exploration. They're separate products with different identity, access, persistence, and usage models.

Current Microsoft documentation distinguishes:

| Operating model | Engineering boundary |
| --- | --- |
| On-demand chat and deep investigation | Runs under the signed-in user's access; doesn't require a separately provisioned Observability Agent resource |
| Observability Agent resource and autonomous operations **(preview)** | A provisioned resource supplies durable scope, managed identity, and custom instructions for enabled background operations |
| Remediation | The Observability Agent doesn't independently restart resources, change configuration, or resolve issues; humans retain decisions and actions |

On-demand investigations can help correlate supported application, infrastructure, and Azure platform signals. Autonomous operations currently correlate alerts and create Azure Monitor issues, with automatic investigation capabilities subject to configuration and billing. 

Keep Azure SRE Agent separate: the next module covers that product's architecture and incident-response workflow. Don't transfer one agent's supported tools or approval semantics to another.

## Make an adoption decision before provisioning

For the first use, confirm Azure Copilot access, supported resources/regions, data access, and usage policy. Start with a scoped on-demand question and inspect the evidence behind the response.

If background correlation is justified, the preview resource follows a different setup boundary:

1. Choose a supported region and approved Application Insights scope. The portal currently scopes a resource to one Application Insights resource; consult current documentation for API limits.
2. Choose a system-assigned or user-assigned managed identity and grant the required data-source and issue-creation permissions. Resource-management permissions and telemetry access are separate.
3. Provision through the supported Azure portal or ARM/Bicep path. Don't invent an Azure CLI or Terraform walk through where the preview doesn't support one.
4. Review workload-specific instructions, enable only the intended operations, and check investigation billing/opt-out settings before activation.
5. Verify the actual scope and resulting issues. Keep a way to disable background operations and hand findings back to the owning team.

Interpret this as an adoption overview, not as an exercise, or a supplied deployment template. Preview limits and pricing can change; recheck the linked documentation before implementation.

## Preserve evidence and the human decision

Ask an observability agent to show the affected scope, time window, supporting signals, confidence limits, and unresolved checks. Compare the report with original telemetry before accepting its recommendation.

Resource configuration changes are recorded through Azure's management plane. **Preview autonomous correlation and investigation runs aren't emitted to the Azure activity log as data-plane events.** Retain available issue/investigation references and the team's decision record; don't claim a complete per-tool audit simply because the resource has activity logs.

Keep operational actions outside the analysis boundary unless separately authorized through the appropriate recovery workflow. An issue, explanation, or instruction doesn't grant permission to change production.

Learn more about [Azure Copilot Observability Agent](/azure/azure-monitor/aiops/observability-agent-overview), its [preview resource and access model](/azure/azure-monitor/aiops/observability-agent-resource), and [autonomous operations](/azure/azure-monitor/aiops/observability-agent-autonomous-operations).
