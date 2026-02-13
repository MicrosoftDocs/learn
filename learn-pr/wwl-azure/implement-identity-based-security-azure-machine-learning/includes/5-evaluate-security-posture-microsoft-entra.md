Implementing security controls is just the first step—you need visibility into whether those controls work as intended. A Conditional Access policy requiring MFA protects your workspace only if users successfully complete multi-factor challenges. A service principal with overly permissive RBAC assignments creates risk only if you can detect and remediate the misconfiguration. Microsoft Entra audit logs provide the forensic data you need to validate security controls, detect anomalies, and demonstrate compliance with auditors.

## Monitor authentication patterns with sign-in logs

Every authentication attempt to your Azure Machine Learning workspace generates an entry in Microsoft Entra sign-in logs. These logs capture comprehensive context: the user or service principal identity, source IP address and location, device operating system and browser, authentication method used, and whether Conditional Access policies triggered or blocked the attempt. With this data, you can answer critical security questions. Did that contractor who left last month still have active workspace access? Are data scientists bypassing MFA requirements? Do repeated failed sign-ins from unfamiliar locations suggest credential compromise?

:::image type="content" source="../media/workspace-generates-entry-logs.png" alt-text="Diagram showing how Azure Machine Learning workspace generates an entry in Microsoft Entra sign-in logs.":::

Sign-in logs become valuable when correlated with workspace activity. Suppose audit logs show a service principal successfully authenticated from an unexpected IP address in Eastern Europe at 2 AM local time. Cross-reference that authentication with Azure Machine Learning activity logs—did the same identity immediately deploy a new model or export training data? This correlation distinguishes between legitimate remote access (a developer traveling for a conference) and suspicious behavior (an attacker using stolen credentials). Many organizations configure automated alerts for these correlation patterns, notifying security teams within minutes of high-risk sign-in and activity combinations.

## Track administrative changes through audit logs

While sign-in logs focus on authentication events, audit logs record administrative actions within Microsoft Entra ID itself. When someone adds a user to your Data Scientists security group, create a new service principal, modifies a Conditional Access policy, or changes RBAC role assignments, audit logs capture the event. Each entry includes the identity who performed the action, what changed, the timestamp, and the outcome. This historical record enables compliance reporting and forensic investigation—you can reconstruct the entire sequence of permission changes leading to a security incident.

Audit logs prove especially critical for detecting insider threats and configuration drift. Consider a scenario where a disgruntled ML engineer adds themselves to the AI Administrators group, grants their personal service principal Owner permissions on production workspaces, then exports proprietary models before resigning. Without audit logs, you might never discover this privilege escalation. With proper log analysis, alerts trigger immediately when unauthorized group membership changes occur—your security team investigates the suspicious addition before damage occurs. Regular audit log reviews also catch gradual permission creep where users accumulate access over time as they move between projects without corresponding access revocations.

## Centralize logs in Azure Monitor for analysis

Microsoft Entra retains sign-in and audit logs for 30 days by default, but production environments need longer retention and more sophisticated analysis capabilities. Azure Monitor's Log Analytics workspace provides both. Configure diagnostic settings to stream Microsoft Entra logs into Log Analytics, where they persist for your required retention period (many regulated industries require one to seven years). With this approach, logs remain queryable long after the default retention expires, supporting compliance audits and long-term threat hunting.

:::image type="content" source="../media/configure-diagnostic-settings-stream.png" alt-text="Diagram showing to configure diagnostic settings to stream Microsoft Entra logs into Log Analytics.":::

Log Analytics transforms raw log data into actionable security insights through the Kusto Query Language (KQL). You can write queries that identify specific risk patterns—for example, users who successfully authenticated after multiple MFA failures (possible credential stuffing attacks), or service principals accessing workspace resources outside business hours (potential automated exfiltration). These queries power automated alerts and custom dashboards. Create an Azure Monitor workbook that visualizes authentication success rates by security group, failed MFA attempts by location, and service principal activity volume over time. Security and operations teams use these dashboards for daily monitoring, while audit teams reference them during compliance reviews.

## Implement proactive security monitoring

Reactive log analysis—reviewing entries after security incidents—provides limited value compared to proactive monitoring. Configure Azure Monitor alert rules that evaluate log queries on schedules ranging from every five minutes to daily. When query results meet your threshold criteria (for example, more than three failed MFA attempts from a single identity within an hour), Azure triggers alerts through your preferred channels: email, SMS, Microsoft Teams notifications, or IT service management system integrations.

Effective alert design balances sensitivity and noise. Alerting on every failed sign-in generates alert fatigue—users occasionally mistype passwords, and security teams start ignoring notifications. Instead, focus on patterns that reliably indicate risk. Alert when a single identity attempts sign-in from three or more distinct geographic locations within a six-hour window—impossible for legitimate human users but common in credential stuffing attacks using botnet infrastructure. Alert when a service principal with read-only permissions suddenly attempts write operations—evidence of compromised credentials or misconfigured RBAC. Configure alert severity levels based on potential impact: high severity for privilege escalation attempts, medium severity for repeated authentication failures, low severity for policy configuration changes requiring review.

## Measure security control effectiveness

Audit logs don't just detect security incidents—they validate that your controls work as designed. After deploying a Conditional Access policy requiring device compliance for production workspace access, query sign-in logs to verify enforcement. Are noncompliant devices actually getting blocked? Are there exception grants you didn't anticipate? Measure the false positive rate by comparing blocked legitimate access attempts against total blocked attempts—if 40% of blocks require administrator override, your policy may be too restrictive for operational reality. Use these metrics to iteratively refine policies, tightening security without creating excessive friction.

Quantify security improvements over time using log-derived metrics. Track the percentage of workspace sign-ins using MFA before and after Conditional Access deployment—from 45% voluntary adoption to 100% enforcement demonstrates measurable risk reduction. Calculate the average time between service principal creation and first usage—short intervals (minutes or hours) suggest healthy automation practices, while long delays (weeks or months) indicate orphaned identities that should be decommissioned. Present these metrics to leadership during security reviews, translating log analysis into business impact: "This quarter, MFA prevented 27 potential account takeovers based on detected credential stuffing attempts."

:::image type="content" source="../media/centralized-security-monitoring-learning-workspaces.png" alt-text="Diagram showing centralized security monitoring for Azure Machine Learning workspaces.":::

*Centralized security monitoring for Azure Machine Learning workspaces using Microsoft Entra audit logs*

## More resources

- [Microsoft Entra audit logs](/entra/identity/monitoring-health/concept-audit-logs) - Comprehensive guide to audit log schema and retention
- [Analyze sign-in logs](/entra/identity/monitoring-health/concept-sign-ins) - Understanding sign-in log data and analysis techniques
- [Monitor Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning) - Integrating workspace activity logs with Azure Monitor