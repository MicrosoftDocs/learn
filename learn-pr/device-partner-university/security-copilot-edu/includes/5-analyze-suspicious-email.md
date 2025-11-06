Imagine you're the IT administrator at the Maple School of Fine Arts. It’s Monday morning on October 28. Hana Sykorova, a visual arts teacher, receives an email that appears to come from the school principal, Aiko Watanabe. The message urges her to verify her credentials to access a new grading system. The email includes a link that redirects to a sign in page that mimics the school’s portal. Hana notices the sender’s address is slightly off—aiko@mapleadmin.net instead of the usual aiko@fineartschool.net—and forwards the email to the IT helpdesk. As the school’s IT administrator, you're responsible for investigating the incident using Microsoft Security Copilot.

Steps:

1. Access Microsoft Security Copilot
   - Navigate to the Microsoft 365 Security portal.
   - Select Security Copilot from the left navigation pane.
   - Confirm you’re signed in with Security Reader or higher permissions.

> [!NOTE]
> For full investigation and remediation, Security Administrator or Global Administrator roles are ideal. Also, Ensure Microsoft Defender is integrated for full telemetry. [Learn more](/copilot/security/).

2. Initiate the investigation
   - In the Copilot prompt box, type:
   - *“Investigate phishing email sent to hana@fineartschool.net on October 28.”*
   - Press Enter to submit the query.

> [!TIP]
> Include as much context as possible—sender address, subject, or suspected indicators.

3. Review the AI-generated summary

- Look for the sender’s domain and IP address. Is it from a known or suspicious source?
- Inspect the email subject and body. Are there any indicators of compromise, such as unusual hyperlinks and attachments, or irregular email address names?
- Check if the email was flagged by Microsoft Defender. If not, consider why it might have been missed.
- Identify if other users received the same email. This helps determine if it’s a targeted or broad attack.

4. Ask follow-up questions to dig deeper

Use natural language prompts like:

- *“What actions were taken automatically?”*
- *“Is this part of a known phishing campaign?”*
- *“What’s the risk level of this incident?”*
- *“What are the recommended next steps?”*

To investigate further, you can ask copilot to *“Check if similar phishing emails were sent to other staff at fineartschool.net in the last seven days.”* Use this to assess whether the incident is isolated or part of a larger campaign.

>[!NOTE]
>
>**Optional practice activities**:
>- Try modifying your prompt to include a different user or date.
>- What happens if you ask Copilot to summarize the incident in plain language?
>- Use Copilot to suggest a policy update based on this incident.

5. Take recommended actions

Based on Copilot’s suggestions:

- Quarantine the email if not already done
- Block the sender’s domain and IP address
- Notify affected users with a warning and guidance
- Update anti-phishing policies in Microsoft Defender

> [!IMPORTANT]
> Validate recommendations against your organization’s incident response policy.

6. Document your findings

- Use the Export feature to save the investigation summary.
- Save it as a PDF or Word document for internal records.

Remember to document not just findings but also remediation steps as a best practice.

Congratulations! You’ve identified the phishing source, assessed its impact, and taken action—all within minutes. This rapid response helps prevent further compromise and builds trust with staff.

>[!TIP]
>
>**Reflection prompt**:
>
> - Ask yourself how your school’s response process might differ from this scenario?
> - What other steps might you need to take to notify stakeholders or comply with local regulations?