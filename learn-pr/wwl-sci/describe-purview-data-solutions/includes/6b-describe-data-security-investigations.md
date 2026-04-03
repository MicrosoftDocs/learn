
When a data security incident occurs—a data breach, an insider leak, or an unexpected data exposure—your security team needs to understand quickly what data was affected and what risk it creates. Historically, that kind of investigation required significant time and manual effort: downloading files, searching through them one by one, and trying to piece together what was exposed. Microsoft Purview Data Security Investigations is a purpose-built solution that helps cybersecurity teams investigate data security incidents using generative AI, so they can analyze large amounts of data and find the most critical risks faster than traditional methods allow.

## What is Data Security Investigations?

Data Security Investigations is a Microsoft Purview solution that helps security analysts investigate data security incidents from start to finish. It lets you find and review impacted data, use AI to understand what risks are present, take action to reduce the damage, and collaborate with others in your organization—such as legal, IT, and executive teams—throughout the process.

Think of it like a smart investigation workspace. When an incident happens, you bring the relevant data into the investigation, let the AI analyze it, review what's most at risk, and then take steps to address the problem—all from one place. This is especially helpful for security teams that don't have dedicated forensic tools or that need to respond to a high volume of incidents without a large analyst workforce.

## AI integration

One of the key strengths of Data Security Investigations is its use of generative AI to analyze data quickly. There are three main AI capabilities.

**Vector search** goes beyond keyword matching. Instead of only finding files that contain exact words, it understands the meaning behind your search. If you're looking for files related to client contracts, it surfaces relevant content even if those exact words don't appear in the file. This is useful when you're searching through unfamiliar data or when the language used in files is indirect.

**Categorization** helps you make sense of large amounts of data before committing to a deeper analysis. AI automatically sorts impacted content into categories by subject matter and risk level—using default categories, custom ones you define, or categories that the AI suggests based on what it finds. This lets your team quickly see which items carry the most risk and focus their attention there first, rather than reviewing everything manually.

**Examination** takes the analysis a step further by scanning file content for specific security risks. It can surface things like exposed credentials, network vulnerabilities, or discussion of threat actor activity buried within files. This is the step that moves from "what data was touched" to "what danger does this data actually represent."

## Common scenarios

Data Security Investigations supports several situations that security teams regularly face.

**Investigate a data breach.** After a security incident, it's often hard to know what sensitive data was exposed. You can use Data Security Investigations to identify intellectual property, personal data, or financial information that might be compromised. For example, if a document containing unfiled patents was downloaded from a risky IP address, you can create an investigation to see who accessed it and take steps to protect or remove the file from circulation.

**Investigate a potential insider data leak.** If Insider Risk Management flags a user who has been sharing files externally, you can open a Data Security Investigations investigation directly from that case. Preliminary insights are available right away, before you commit to deeper processing. When you expand the scope, the data is automatically categorized by risk level so your team knows where to prioritize.

**Proactively assess data risk.** You don't have to wait for an incident. Data Security Investigations also lets you scan specific data sources or a sample of users to look for gaps in your security policies before a problem occurs. This kind of proactive review can reveal risks that existing policies haven't yet addressed.

## Integration with other solutions

Data Security Investigations connects with the security tools your organization might already use, so you can move from an alert to an investigation without starting from scratch. Rather than switching between separate tools and manually copying information, the integrations let signals flow directly into investigations.

- **Insider Risk Management—When an Insider Risk Management case surfaces a potential data leak, investigators can pass that case directly to Data Security Investigations for deeper content analysis. This closes the gap between detecting a risky behavior and understanding what data was exposed.
- **Microsoft Defender XDR—From the Microsoft Defender portal, you can open a Data Security Investigations investigation to get deeper insight into the data and users connected to a security alert. This helps your security operations team go beyond the alert itself to understand the data impact.
- **Data Security Posture Management—When DSPM identifies a potential exfiltration event, you can route that finding to Data Security Investigations. The investigation is automatically scoped to the recently exfiltrated data so your team can quickly assess what was exposed.
- **Unified audit log—You can query the audit log for user activities—like file downloads or sensitivity label changes—and pull that content into your investigation. Every action taken within Data Security Investigations is also recorded in the audit log, creating a clear record for compliance and legal purposes.

## Taking action

Once you understand what's at risk, Data Security Investigations gives you options to respond directly. You can soft purge items, which moves them to a recoverable deleted state in case you need to restore them later. You can also hard purge items, which permanently removes them from the data source when you're confident the content needs to be deleted entirely.

Beyond removing content, investigation findings give you the context you need to take other protective steps: tightening access controls on affected data sources, working with your IT team to apply extra encryption, or preparing documentation to meet regulatory requirements. Depending on the nature of the data and your organization's location, data protection laws might require that you notify affected individuals or authorities about a breach, and the records generated by an investigation help support that process.

## Billing

Data Security Investigations uses a pay-as-you-go billing model. The solution uses AI analysis powered by large language models and Microsoft Copilot for Security. Organizations pay only for the storage and processing they use, not a fixed per-user license. This means you're not paying for capacity you don't need. You don't need a dedicated enterprise plan to access Data Security Investigations, which makes it available to organizations of different sizes and at different points in their security maturity.
