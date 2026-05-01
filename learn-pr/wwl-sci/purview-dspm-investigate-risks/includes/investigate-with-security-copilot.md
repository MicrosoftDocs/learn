Activity explorer and audit logs require you to know what to filter for. You need a user, a time window, or an event type before you can trace anything. That works when you already have a lead. It's slower when you're starting from a broad concern like "are users exfiltrating data involving this label?" and don't yet know where to look.

Security Copilot in DSPM lets you describe the investigation question in natural language and get a synthesized answer across DSPM's data. The tradeoff is control versus speed. With direct investigation, you see exactly what the filters return and you control the scope. With Security Copilot, you get a faster answer that may be incomplete or lack context you'd catch manually. Both have a place, and the decision between them depends on what you're trying to accomplish.

## What Security Copilot provides for investigation

Security Copilot in DSPM synthesizes data from activity explorer, audit logs, DLP alerts, and Insider Risk Management signals into natural-language responses. Instead of filtering across multiple surfaces and correlating results yourself, you ask a question and get a consolidated answer.

The types of investigative questions it handles well:

- **User-focused investigation**: What did a specific user do with sensitive data over a time period? What's their risk profile? Are there alerts associated with them?
- **Data-focused investigation**: Where is a specific type of sensitive data stored? Who's interacting with it? Is it leaving the organization?
- **Alert-focused investigation**: What's the context around a specific DLP or IRM alert? What's the risk profile of the user involved?
- **Pattern-focused investigation**: Are there exfiltration patterns? Which users show unusual activity?

Each of these would take multiple filter passes in activity explorer and audit logs. Security Copilot collapses that into a conversational sequence where you ask, evaluate the response, and refine.

## How to access it

You can access Security Copilot within DSPM in two ways:

- From the top of the DSPM page, where you can enter investigation prompts directly
- From **Show Users Involved** in data security objectives, which starts an interaction focused on users related to specific risk indicators

The DSPM page entry gives you open-ended investigation. The objective entry pre-focuses on users relevant to a specific risk you're already examining.

## Promptbooks and the Prompt Gallery

DSPM includes pre-built investigation sequences called Promptbooks that run multiple prompts in order. One focuses on investigating a specific user's behavior. Another focuses on investigating a specific sensitive data type across the organization. Both take an input, either a UPN or a data classifier name, and a time window of up to 30 days. They return a multi-step analysis covering activity, anomalies, alerts, and recommendations.

The Prompt Gallery provides individual pre-built prompts organized by investigation category. These are useful when you need a single data point rather than a full guided sequence.

You can also write custom prompts for anything the pre-built options don't cover. Effective prompts are specific: they name a user, a data type, a time period, or an alert. Vague questions produce vague responses.

## Constraints that affect your results

- **30-day maximum**: Time-based queries cover at most 30 days. Investigations spanning longer periods need direct analysis.
- **Input specificity matters**: Use full user principal names, the exact name of sensitivity labels, and full names of sensitive information types or trainable classifiers. Partial names produce incomplete or wrong results.
- **Iterative refinement**: If the first response is too broad, add specificity. If too narrow, widen the time window or remove constraints. Security Copilot maintains conversation context across follow-up prompts.

## When to validate with direct investigation

Security Copilot synthesizes and summarizes. That synthesis can occasionally be incomplete, miss relevant context, or present partial data. Validate through direct investigation when:

- The results seem inconsistent with what you know about the user or scenario
- You need the authoritative audit record for compliance or legal purposes
- The 30-day limit doesn't cover the period you need to investigate
- The investigation requires correlation with data outside DSPM, like endpoint telemetry or network logs
- You're making a high-consequence decision like escalation, disciplinary action, or policy change based on the findings

Security Copilot helps you identify what to investigate deeply, not replace the need for deep investigation.

## Choosing between investigation approaches

| Investigation need | Recommended approach | Reasoning |
| --- | --- | --- |
| Investigate a specific user's behavior | Risky user Promptbook | Covers activity, anomalies, alerts, and recommendations in one sequence |
| Investigate a sensitive data type across the organization | Sensitive data protection Promptbook | Maps data location, usage, exfiltration, and involved users |
| Quick data point or specific alert summary | Gallery prompt or custom prompt | Targeted retrieval without a full guided sequence |
| Pattern confirmation or trend investigation | Start with Copilot, validate in reports | Copilot identifies the pattern; reports confirm the trend over time |
| Formal compliance investigation | Direct investigation through activity explorer and audit logs | Authoritative records needed; Copilot summaries are not sufficient |
