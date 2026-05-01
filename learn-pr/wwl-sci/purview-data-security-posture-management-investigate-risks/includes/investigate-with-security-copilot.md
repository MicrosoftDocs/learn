An investigation typically involves multiple questions in sequence. You identify a user, check their recent activity, look for exfiltration patterns, assess whether alerts are related, and decide whether to escalate. Each of those steps can mean switching between surfaces, adjusting filters, and interpreting raw event data.

Security Copilot in Data Security Posture Management (DSPM) compresses that sequence. You describe what you're investigating in natural language. Security Copilot then correlates activity data, alerts, and risk signals into a synthesized answer.

## Use the Copilot Prompt Gallery for investigation

The Copilot Prompt Gallery for DSPM is accessible from suggested prompts on the DSPM posture page and from the **Copilot prompts** button on data security objective cards. The gallery has two tabs: **Prompts** for individual queries and **Promptbooks** for multi-step sequences.

### Filtering for investigation

The Prompts tab includes category filters that scope results to either investigation or assessment. For investigation, you can use:

- **Potentially Risky Users**
- **Potentially Suspicious Activity**
- **Alerts and Policies**

:::image type="content" source="../media/security-copilot-prompt-gallery.png" alt-text="Screenshot of the Copilot Prompt Gallery for DSPM with the category filter dropdown expanded." lightbox="../media/security-copilot-prompt-gallery.png":::

These filters return prompts scoped to users, timeframes, and behaviors. Filters like "Sensitive Data" and "Data at Risk" are scoped to data types, locations, and policy coverage, which serves posture assessment.

### The Risky user investigation Promptbook

The Risky user investigation Promptbook takes a user principal name and a timeframe of up to 30 days. It runs six prompts in sequence that cover sensitive data activity, exfiltration patterns, alert history, and recommended risk-reduction actions.

:::image type="content" source="../media/security-copilot-risky-user-investigation-prompt-book.png" alt-text="Screenshot of the Risky user investigation Promptbook showing input fields and the six prompts." lightbox="../media/security-copilot-risky-user-investigation-prompt-book.png":::

Each step builds on the previous results, correlating activity summaries, anomalies, and alerts into a single view.

If the results indicate a risk, validate through activity explorer or the audit log where you can see the authoritative event records.

### The Sensitive data protection Promptbook

This Promptbook takes a sensitive information type, trainable classifier, or sensitivity label name and a timeframe of up to 30 days. It maps where that data is stored, who interacts with it, whether it's leaving the organization, and who's responsible for the most exfiltration.

Use this Promptbook when an alert or report finding indicates a specific data type might be at risk. It answers whether the concern is real and identifies the users and paths involved. If you're using it without a specific triggering concern, you're doing assessment work rather than investigation.

## Constraints that affect investigation results

- **30-day maximum**: Time-based queries cover at most 30 days. Investigations spanning longer periods need direct analysis through activity explorer or audit logs.
- **Input specificity matters**: Use full user principal names, the exact name of sensitivity labels, and full names of sensitive information types or trainable classifiers. Partial names produce incomplete or wrong results.
- **Iterative refinement**: If the first response is too broad, add specificity. If too narrow, widen the time window or remove constraints. Security Copilot maintains conversation context across follow-up prompts.

## When to validate with direct investigation

Security Copilot synthesizes and summarizes. That synthesis can occasionally be incomplete, miss relevant context, or present partial data. Validate through direct investigation when:

- The results seem inconsistent with what you know about the user or scenario
- You need the authoritative audit record for compliance or legal purposes
- The 30-day limit doesn't cover the period you need to investigate
- The investigation requires correlation with data outside DSPM, like endpoint signals or network logs
- You're making a high-consequence decision like escalation, disciplinary action, or policy change based on the findings

Security Copilot helps you identify what requires deeper investigation. It doesn’t replace the need for direct analysis.
