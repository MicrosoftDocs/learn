Direct investigation through activity explorer and audit logs gives you the ability to trace individual events. Security Copilot adds a different paradigm: you describe what you're looking for in natural language, and AI synthesizes results across DSPM's data. This doesn't replace direct investigation. It accelerates pattern identification, surfaces connections you might miss through manual filtering, and provides focused investigation sequences for common scenarios.

The shift in your cognitive mode is important. With activity explorer, you're the primary analyst filtering and examining data. With Security Copilot, you're directing an AI partner and then evaluating whether its synthesized results are complete and accurate. Both skills are needed because Copilot's analysis is only as useful as your ability to validate it.

## Accessing Security Copilot in DSPM

You can access Security Copilot within DSPM in two ways:

- From the top of the DSPM page, where you can enter investigation prompts directly
- From **Show Users Involved** in data security objectives, which starts an interaction focused on users related to specific risk indicators

Both entry points use the same underlying capabilities. The difference is context: the DSPM page provides open investigation, while the objective entry pre-focuses on users relevant to the objective you're viewing.

## The risky user investigation Promptbook

The risky user investigation Promptbook is a six-prompt guided sequence for investigating a specific user's data activities. You provide a user principal name (UPN) and a duration (maximum 30 days), and the Promptbook runs the following prompts in sequence:

1. Show all sensitive data activities performed by the user in the specified period
2. Identify potential sensitive data exfiltration activities (email forwarding, external sharing, USB transfers, cloud uploads)
3. Summarize the user's sensitive data interactions, highlighting the most accessed classifiers, labels, SharePoint sites, common upload domains, and primary email recipient domains
4. Identify unusual behavior or uncommon actions like excessive access or downloads
5. Check for alerts associated with the user and their current risk level
6. Recommend actions to prevent the user from leaking sensitive data, including policies, DLP controls, and access restriction strategies

This Promptbook is appropriate when you already know which user to investigate. It synthesizes activity data, IRM risk signals, and alert history into a coherent narrative about that user's behavior.

## The sensitive data protection Promptbook

The sensitive data protection Promptbook is a six-prompt sequence focused on a specific type of sensitive data rather than a specific user. You provide the full name of a trainable classifier, sensitivity label, or sensitive information type (SIT) and a duration. The Promptbook runs:

1. Where is the specified data stored?
2. Provide an overview of activities involving this data in the specified period
3. Identify instances where this data was transferred outside of the organization
4. Who are the top five users with the most exfiltration of this data?
5. Are there any alerts for users who interacted with this data?
6. How can unauthorized transfers of this data be prevented?

Use this Promptbook when you're investigating a data type rather than a user. For example, if reports show a spike in exfiltration events involving a specific sensitivity label, this Promptbook helps you understand who's involved and what happened.

## The Copilot Prompt Gallery

The Prompt Gallery provides sample prompts organized across five investigation categories:

- **Alerts and policies**: Prompts to retrieve and summarize DLP and IRM alerts
- **Data at risk**: Prompts to identify unprotected sensitive data and risk patterns
- **Potentially risky users**: Prompts to investigate user risk profiles and activity
- **Potentially suspicious activity**: Prompts to identify unusual data access or movement
- **Sensitive data**: Prompts to discover where specific data types exist and how they're used

Gallery prompts serve as starting points. You can run them as-is or customize them to your specific investigation context. They're useful when you need a specific data point rather than a full guided investigation sequence.

## Custom prompts for targeted investigation

Beyond Promptbooks and the Gallery, you can construct custom prompts for targeted data hunting. Effective custom prompts in DSPM include:

- "Show me the five most recent high-severity DLP alerts"
- "What's the risk profile of the user associated with DLP alert [ID]?"
- "What items did user [UPN] exfiltrate in the past 30 days?"
- "Provide a list of events where sensitive files were shared externally"
- "List all the sensitive files that were uploaded to cloud in the last week"
- "Show me the data activities for user [UPN] in the last 30 days"

Custom prompts work best when they're specific about what you're looking for. Vague prompts produce vague results.

## Tips for effective prompts

Several constraints and practices affect prompt quality:

- **Maximum timeframe**: Security Copilot in DSPM supports a maximum of 30 days for time-based queries. Requests for longer periods may produce incomplete results.
- **Input specificity**: Provide user principal names (UPN) for user-focused queries. Use the full name of sensitivity labels, sensitive information types, or trainable classifiers for data-focused queries.
- **Iterative refinement**: If initial results are too broad, narrow with additional context. If too narrow, expand the timeframe or remove specificity constraints.
- **Follow-up prompts**: After an initial response, use follow-up prompts to drill deeper into specific findings. Security Copilot maintains conversation context.

## When to validate with direct investigation

Security Copilot synthesizes and summarizes. That synthesis can occasionally be incomplete, miss relevant context, or present partial data. Validate through direct investigation when:

- The results seem inconsistent with what you know about the user or scenario
- You need the authoritative audit record for compliance or legal purposes
- Copilot's timeframe limitation (30 days) doesn't cover the period you need to investigate
- The investigation requires correlation with data outside DSPM (endpoint telemetry, network logs)
- You're making a high-consequence decision (escalation, disciplinary action, policy change) based on the findings

Security Copilot is an investigation accelerant. It helps you identify what to investigate deeply, not replace the need for deep investigation.

## Choosing between investigation approaches

| Investigation need | Recommended approach | Reasoning |
|---|---|---|
| Investigate a specific user's behavior | Risky user investigation Promptbook | Structured six-prompt sequence covers activities, anomalies, alerts, and recommendations |
| Investigate a sensitive data type across the organization | Sensitive data protection Promptbook | Focused on data location, usage, exfiltration, and protective measures |
| Quick data point or specific alert summary | Gallery prompts or custom prompt | Targeted retrieval without the full Promptbook sequence |
| Pattern confirmation or trend investigation | Start with Copilot, validate in reports | Copilot identifies the pattern; reports confirm the trend |
| Formal compliance investigation | Direct investigation (activity explorer + audit logs) | Authoritative records needed; Copilot summaries are not sufficient |

The judgment of when to use each approach is as important as knowing how to use them. As you gain experience, you'll develop intuition about which approach matches your current investigation need.
