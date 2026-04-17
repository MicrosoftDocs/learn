## Telemetry collection for AI governance

Traditional application monitoring focuses on performance metrics like response time and error rates. AI workloads introduce extra dimensions that governance teams must track—token consumption, model invocation patterns, and data residency compliance. Microsoft Foundry captures this telemetry automatically from every AI resource, forwarding structured logs to Azure Monitor without requiring custom instrumentation code in your applications.

This automated collection becomes essential when investigating security incidents or compliance violations. Consider a scenario where your quarterly audit reveals unexpected Azure OpenAI usage spikes. Rather than manually reviewing deployment logs across dozens of resource groups, you query centralized telemetry through Log Analytics to identify which projects consumed excess tokens, which users initiated those requests, and whether the activity violated any established quotas. With this visibility, your operations team resolves the investigation in hours instead of days, reducing the administrative burden of compliance activities by 50%.

## Alert rules and automated responses

Now that you understand how telemetry flows into Azure Monitor, let's explore how to act on that data in real time. Microsoft Foundry lets you define alert rules that continuously evaluate monitoring signals against thresholds you specify. When CPU usage on an AI inference endpoint exceeds 85% for more than 10 minutes, an alert fires automatically. Unlike static notifications that inform administrators of problems, Foundry alerts trigger automated response workflows that can scale resources, block suspicious identities, or initiate incident response procedures.

:::image type="content" source="../media/global-telemetry-flows-azure-monitor.png" alt-text="Diagram that illustrates how workflows follow an evaluate-decide-act pattern that reduces mean time to resolution.":::

These workflows follow an evaluate-decide-act pattern that reduces mean time to resolution by 60% compared to manual interventions. First, the alert evaluates whether the condition persists beyond normal variance—preventing false positives from temporary spikes. Second, the workflow decides which response is appropriate based on the violation type: policy noncompliance triggers remediation tasks, while security violations escalate to the security operations center. Third, automated actions execute the chosen response, such as applying a deny assignment that immediately blocks further access until human review occurs. At the same time, the system logs every automated action for audit purposes, ensuring your compliance team can reconstruct the complete incident timeline during regulatory reviews.

## Compliance dashboards and reporting

Building on these monitoring foundations, compliance dashboards aggregate telemetry into executive-ready views that answer critical governance questions. Your compliance officer needs to demonstrate data residency adherence for regional audits—the dashboard shows that 100% of EU customer data remained within EU Azure regions over the past 12 months. Finance teams want to understand AI spending trends—cost analytics reveal which business units exceeded their Azure OpenAI budgets and by what percentage.

Microsoft Foundry generates these insights by correlating multiple telemetry streams. Policy evaluation results combine with access logs and resource consumption metrics to paint a comprehensive picture of your governance posture. This becomes especially important when supporting industry-specific regulations like HIPAA for healthcare or PCI DSS for payment processing. Rather than manually collecting evidence from disparate systems, you export preformatted compliance reports directly from Foundry dashboards. These reports include attestation data that auditors require, such as proof that all AI resources enforce encryption at rest and that access reviews occur quarterly as policy mandates.

## Audit log retention and forensic analysis

For security teams, raw telemetry serves another critical purpose: forensic investigation after suspected breaches. Azure Monitor retains audit logs for 90 days by default, but Microsoft Foundry extends this retention to seven years for compliance-critical events like authentication failures, policy violations, and administrative actions. This extended retention satisfies regulatory requirements in industries like financial services, where you must preserve audit evidence for the full lifecycle of customer relationships.

When conducting forensic analysis, investigators query these retained logs to reconstruct attack sequences. Suppose an unauthorized party briefly accessed an Azure OpenAI endpoint before your security team blocked the connection. Log queries reveal the exact timestamp of the breach, the IP address, and user agent of the attacker, which models they queried, and whether they exfiltrated any response data. With this evidence, you file accurate breach notifications with regulators within required timeframes, demonstrating that your monitoring capabilities detected and responded to the incident promptly. Organizations using this approach report 40% faster regulatory response times compared to environments without centralized audit logging.

:::image type="content" source="../media/monitor-compliance-workflow-microsoft-foundry.png" alt-text="Diagram showing how AI workload telemetry flows through Azure Monitor to Log Analytics feeds compliance dashboards.":::

*Monitoring and compliance workflow in Microsoft Foundry, showing telemetry collection, analysis, alerting, automated responses, and regulatory reporting with audit log retention*




