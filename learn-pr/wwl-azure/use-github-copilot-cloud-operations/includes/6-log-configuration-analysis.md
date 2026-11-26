::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8ecffddd-efca-4050-a91b-ebf7e862eb9f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Modern cloud environments generate large volumes of log data. An Azure Firewall in a busy environment produces thousands of log entries per hour. Activity logs capture every management operation across all resources. NSG flow logs record every network connection, both allowed and denied.

The challenge isn't collecting the data. Azure Monitor, Log Analytics, and Microsoft Sentinel handle collection well. The challenge is turning raw log data into actionable intelligence quickly. This means finding the attack pattern in 10,000 firewall entries, identifying the root cause of a deployment failure buried in a 500-line error log, or producing a meaningful compliance report from a month of activity data.

GitHub Copilot handles pattern-recognition and summarization work well. You provide the data; Copilot provides the analysis.

## Analyzing Azure Firewall logs

Azure Firewall network rule logs record every connection the firewall evaluated: the source IP, destination IP, port, protocol, and whether the connection was allowed or denied. Analyzing these logs manually is time-consuming. Copilot can scan them in seconds.

### The basic analysis prompt

```
Analyze these Azure Firewall network rule logs and provide:
1. The top 5 source IPs generating denied traffic, with connection counts
2. The top 5 destination ports targeted by denied traffic
3. Any source IPs with rapid sequential connections to many different ports
   (port scanning behavior), including the time window
4. The one-hour period with the highest volume of denied connections
5. Any connections that were ALLOWED to unusual external destinations
   (non-standard ports, suspicious IP ranges)

Format the output as a structured report with a section for each finding.

[paste firewall-logs.json content here]
```

### What good firewall log analysis reveals

**Port scanning** is identifiable by a single source IP making connections to many different destination ports in a short time window. A legitimate client makes connections to one or two ports repeatedly. A scanner probes dozens of ports sequentially.

**Brute force attempts** appear as many denied connections from one source IP to the same destination port, typically 22 (SSH) or 3389 (RDP), in quick succession.

**Allowed traffic anomalies** are often more concerning than denied traffic. Denied connections are blocked. Allowed connections to unusual destinations, such as nonstandard ports or IP ranges associated with known threats, represent actual data movement that should be investigated.

### Turning findings into infrastructure changes

Log analysis should feed directly back into your Bicep templates. After identifying problem source IPs, ask Copilot to generate the remediation:

```
Based on the firewall log analysis, the following source IPs are confirmed
malicious: 185.220.101.45, 91.230.54.112, 194.165.16.78.

Generate:
1. A Bicep snippet for an Azure Firewall Network Rule Collection that explicitly
   denies all traffic from these IPs at the highest priority (100)
2. An Azure CLI command to apply this rule without a full template redeployment
3. A comment explaining the source of each blocked IP
```

To close the loop: analyze logs, identify threats. Generate IaC to block them. Next, deploy the remediation. The entire cycle can happen within a single Copilot Chat session.

## Troubleshooting deployment failures

Deployment failure logs can be cryptic. Azure Resource Manager returns nested JSON error objects with codes, messages, and policy evaluation details that take time to parse. Copilot helps in reducing the noice across different sources to a clear root cause and fix in seconds.

### The failure analysis prompt

```
This is an Azure resource deployment log that ended in failure.
Analyze the log and provide:
- The root cause of the failure in plain language, not error codes
- Which specific resource failed and why
- The exact change needed in the Bicep template or deployment parameters to fix the issue
- Whether there are multiple issues (sometimes one error masks another)

If there is a policy violation, explain: which policy blocked the deployment,
what the policy requires, and where in the template the requirement is not met.

[paste failed-deployment.log content here]
```

### Common deployment failure categories

**Subnet sizing errors:** Azure Firewall requires a /26 subnet minimum. Azure Bastion requires a /26. Virtual Network Gateway requires a /27. These boundaries are easy to miss and produce clear error messages that Copilot can parse and fix.

**Policy violations:** Enterprise Azure subscriptions governance relies on Azure Policy. Common policies require specific tags on all resources, restrict SKUs to approved types, or enforce minimum subnet sizes. A policy violation in the error log includes the policy name and the specific expression that evaluated to noncompliant.

**Resource conflicts:** Deploying a resource that already exists with incompatible properties. Examples include a storage account with a different SKU than the existing one, or a Key Vault name that is already taken globally.

**RBAC permission failures:** The deployment identity lacks the permissions to create a specific resource type. This example is common when deploying role assignments, where `Microsoft.Authorization/roleAssignments/write` requires Owner or User Access Administrator.

**API version mismatches:** A resource uses an API version that is no longer available. This scenario is more common in outdated templates.

### Asking for a fix in Bicep

After Copilot identifies the root cause, ask it to generate the fix:

```
The deployment failed because:
1. AzureFirewallSubnet is /27 but must be /26
2. The CostCenter tag is missing from the hub VNet resource

Apply both fixes to this Bicep template. Show only the changed sections,
not the entire template, and explain what you changed and why.

[paste the relevant Bicep sections]
```

## Generating KQL queries for Azure Monitor

KQL (Kusto Query Language) is the query language for Azure Monitor, Log Analytics, and Microsoft Sentinel. Writing KQL from scratch requires knowledge of table schemas, KQL functions, and the structure of Azure diagnostic logs. Copilot generates KQL queries from natural language descriptions, significantly lowering the barrier.

### Basic KQL generation

```
Generate a KQL query for the AzureDiagnostics table in Log Analytics.
The query should:
- Count denied connections grouped by SourceIP
- Filter to the last 24 hours using TimeGenerated > ago(24h)
- Include only rows where Action_s == "Deny"
- Include only rows from Azure Firewall (Category == "AzureFirewallNetworkRule")
- Sort by count descending
- Visualize as a bar chart

Add a comment at the top explaining what this query does and when to use it.
```

**Example KQL output:**

```kql
// Top blocked source IPs in the last 24 hours
// Use this query to identify source IPs generating the most denied traffic.
// Useful for firewall rule tuning and threat hunting.
AzureDiagnostics
| where TimeGenerated > ago(24h)
| where Category == "AzureFirewallNetworkRule"
| where Action_s == "Deny"
| summarize DeniedCount = count() by SourceIP = SourceIp_s
| sort by DeniedCount desc
| render barchart
```

### Generating a suite of security queries

```
Generate three KQL queries for Azure Firewall security monitoring:

Query 1: Allowed SSH/RDP connections
Find all connections to port 22 or 3389 that were allowed by the firewall.
These are potential security risks that should be reviewed.

Query 2: Hourly allowed vs. denied traffic trend
Show the count of allowed and denied connections per hour over the last 7 days,
as a time chart with two series (one for allowed, one for denied).

Query 3: New source IPs in the last 24 hours
Find source IPs that appear in today's denied traffic but did not appear
in the 7 days prior. These are new sources of malicious traffic.

For each query: add explanatory comments, use the AzureDiagnostics table,
and make them production-ready (handle null fields with isnotempty()).
```

### Generating KQL for Activity Logs

Activity Logs use the `AzureActivity` table in Log Analytics. The schema is different from diagnostic logs, and Copilot knows the column names.

```
Generate a KQL query for the AzureActivity table that finds:
- All role assignment changes (RBAC) in the last 30 days
- Only operations where OperationNameValue contains "roleAssignments"
- Include: TimeGenerated, Caller, OperationNameValue, ActivityStatusValue,
  ResourceGroup, Properties

Sort by TimeGenerated descending. Add a comment explaining how to use
this query for access control auditing.
```

## Generating compliance audit summaries

Compliance teams and auditors need structured reports, not raw log data. Copilot can read log files and generate professional audit summaries.

### The compliance summary prompt

```
Analyze these Azure Activity Log entries and generate a compliance audit summary
in markdown format for the period [date range].

Structure the report as follows:

## Executive Summary
[2-3 sentences summarizing the overall compliance posture]

## Access Control Changes
[Table: Date | Actor | Action | Resource | Risk Rating]

## Resource Deletions
[Table: Date | Actor | Resource | Resource Group | Risk Rating]

## Policy Exemptions
[Table: Date | Actor | Policy | Exemption Scope | Expiry | Risk Rating]

## After-Hours Activity
[Table: Date | Time | Actor | Action | Risk Rating]
[Note: Business hours are 09:00-18:00 in your local time zone]

## Risk Summary
[Count by risk level: High / Medium / Low]

## Recommended Actions
[Bulleted list of follow-up actions based on findings]

Apply risk ratings:
- High: role assignments, policy exemptions, resource deletions in production
- Medium: configuration changes to security resources (Key Vault, NSG, Firewall)
- Low: read operations, tag updates, scaling events

[paste activity-log.json content here]
```

The output is immediately usable as a compliance report, a security review summary, or a section in an audit response package. Review the risk ratings Copilot applies and adjust any that don't match your organization's risk classification policy.

::: zone-end
