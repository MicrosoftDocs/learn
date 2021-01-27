As a Security Operations Analyst, you need to understand Compliance-related terminology and alerts.  The Data loss prevention (DLP) alerts will help you in your investigation to find the full scope of the incident.  DLP alerts can be generated from Microsoft 365 Compliance or Microsoft Cloud App Security.  You might not be the person creating the DLP Policies, but it is important for you to understand them so you can recommend changes.

To comply with business standards and industry regulations, organizations must protect sensitive information and prevent its inadvertent disclosure. Sensitive information can include financial data or personal information such as credit card numbers, social security numbers, or health records.

With a DLP policy, you can:

- Identify sensitive information across many locations, such as Exchange Online, SharePoint Online, OneDrive for Business, and Microsoft Teams.

- For example, you can identify any document containing a credit card number that's stored in any OneDrive for Business site, or you can monitor just the OneDrive sites of specific people.

- Prevent the accidental sharing of sensitive information.

- For example, you can identify any document or email containing a health record that's shared with people outside your organization, and then automatically block access to that document or block the email from being sent.

- Monitor and protect sensitive information in the desktop versions of Excel, PowerPoint, and Word.

- Just like in Exchange Online, SharePoint Online, and OneDrive for Business, these Office desktop programs include the same capabilities to identify sensitive information and apply DLP policies. DLP provides continuous monitoring when people share content in these Office programs.

- Help users learn how to stay compliant without interrupting their workflow.

- You can educate your users about DLP policies and help them remain compliant without blocking their work. For example, if a user tries to share a document containing sensitive information, a DLP policy can send them an email notification and show them a policy tip in the context of the document library that allows them to override the policy if they have a business justification. The same policy tips also appear in Outlook on the web, Outlook, Excel, PowerPoint, and Word.

- View DLP alerts and reports showing content that matches your organization’s DLP policies.

## Data loss prevention Components

If you have not worked with DLP, it is important to understand the underlying components.

### Sensitive information types

A sensitive information type is defined by a pattern that can be identified by a regular expression or a function. In addition, corroborative evidence such as keywords and checksums can be used to identify a sensitive information type. Confidence level and proximity are also used in the evaluation process.

Microsoft 365 compliance comes with built-in Sensitive information types like Credit Card Numbers, Bank Accounts, and more.  You can also create a custom sensitive info type matched on regular expressions, keywords, or an uploaded dictionary.

### Sensitivity labels

Sensitivity labels specify the classification of a document.  These could be terms like public, private, or classified.  With these labels, more functionality can be applied to the document, like encryption.  Labels are applied to documents either manually by the user or automatically based on sensitive info types.

### Data loss prevention policy

A DLP policy contains a few basic things:

- Where to protect the content: locations such as Exchange Online, SharePoint Online, and OneDrive for Business sites, as well as Microsoft Teams chat and channel messages.

- When and how to protect the content by enforcing rules comprised of:

  - Conditions the content must match before the rule is enforced. For example, a rule might be configured to look only for content containing Social Security numbers that have been shared with people outside your organization.

  - Actions that you want the rule to take automatically when content matching the conditions is found. For example, a rule might be configured to block access to a document and send both the user and compliance officer an email notification.

### Cloud App Security file policy

File policies can be set to provide continuous compliance scans, legal eDiscovery tasks, DLP for sensitive content shared publicly, and many more use cases. Cloud App Security can monitor any file type based on more than 20 metadata filters.

