Before you build your first automation rule, take a few minutes to map the incident patterns that your SOC handles repeatedly. For Contoso, the most obvious candidates are incidents from the trading platform analytics rules (always routed to the same team), informational incidents during the nightly batch maintenance window (always suppressed), and any incident involving a host in the cardholder data environment (always tagged for compliance). Identifying these patterns first means you build rules with clear intent rather than discovering gaps after the first deployment.

## Plan your automation rule strategy

Before opening the rule wizard, answer these questions:

1. **What is the trigger?** Most incident management rules use the **Incident created** trigger. Use **Incident updated** when you need to react to status changes, such as reassigning an incident when escalated from low to high severity.
2. **How specific should the conditions be?** A rule scoped to a single analytics rule by name is precise but requires updates when you rename that rule. A rule scoped to a severity level is broad but durable. Combine both for the right balance.
3. **What actions run, and in what order?** Actions within a single rule execute in the order you define them. Put the assign action before the tag action if you want the assignee to already be set when the notification fires.
4. **What priority number should this rule have?** Lower numbers run first. If two rules match the same incident, the lower-priority rule's actions complete before the higher one runs. Reserve the lowest numbers (1–10) for critical suppression or escalation rules.

## Create an automation rule in Microsoft Sentinel

To create an automation rule:

1. In the Microsoft Defender portal, select **Microsoft Sentinel**, then select **Automation** from the left navigation.
2. Select **Create**, then select **Automation rule**.
3. Enter a descriptive rule name. A consistent naming convention helps—for example, `ROUTE-TradingPlatform-HighSeverity` or `SUPPRESS-MaintenanceWindow-Informational`.
4. Under **Trigger**, select **Incident created**.
5. Under **Conditions**, select **Add condition**. Select **Analytics rule name**, set the operator to **Contains**, and enter the name of the trading platform analytics rule. Select **Add condition** again, set **Incident severity** to **Equals**, and select **High** and **Medium**.
6. Under **Actions**, select **Add action**. Select **Assign owner** and choose the trading security team account. Select **Add action** again, select **Add tags**, and enter `trading-platform` and `PCI-in-scope`.
7. Set **Order** to `10` to give this rule a defined priority among your automation rules.
8. Leave **Expiration** empty for a permanent rule, or set a date for time-limited suppression scenarios.
9. Verify the rule is set to **Enabled**, then select **Apply**.

:::image type="content" source="../media/create-automation-rule.png" alt-text="Screenshot of the Create automation rule page in the Microsoft Defender portal showing conditions and actions configured for trading platform incidents.":::

## Configure conditions to target specific incidents

Conditions support **AND** logic by default—all conditions must be true for the rule to fire. This is the right model for most routing and tagging rules, where you want both the right analytics rule *and* the right severity before taking action.

The condition field options give you several ways to target incidents precisely:

- **Analytics rule name**: Match by exact name or partial string using the **Contains** operator. Use this to scope a rule to a specific detection without editing every time you add a new rule to the same analytics rule.
- **Incident title**: The **Contains** operator works here for title patterns like "impossible travel" or "malware detected."
- **Severity**: Useful for escalation rules—for example, automatically assigning any critical-severity incident to a senior analyst regardless of source.
- **Tactics**: Scope a rule to all incidents tagged with a specific MITRE ATT&CK tactic, such as Initial Access or Exfiltration, to apply consistent handling to an entire category of threats.

## Monitor and manage your automation rules

The **Automation** page lists all your rules with their current status, trigger type, and a run count showing how many times each rule executed. Select any rule to view its configuration, edit conditions or actions, change the priority order, or disable the rule without deleting it.

When a rule isn't triggering as expected, check the conditions first. A common issue is an analytics rule name condition that uses an exact match rather than **Contains**, which fails silently when the rule name changes slightly. If two rules conflict—one closing an incident that another rule should be tagging—check the priority numbers and verify that the lower-priority rule isn't consuming the incident before the tag rule runs.

For audit purposes, every automation rule execution is logged in the Microsoft Sentinel audit log, available in the **Logs** page under the `SentinelAudit` table. This gives you a complete, queryable record of every automated action taken on every incident—essential for demonstrating process controls during a PCI or SOX audit review.
