When developing your organization's general information-protection strategy, it's key to consider data classification and data-protection technologies, and  how to help provide efficient DLP. DLP isn't the same as data protection. Data protection helps prevent unauthorized users from accessing data. DLP, meanwhile, helps prevent improper use or sharing of sensitive data. Business standards and industry regulations mandate that organizations must try to protect sensitive information from inadvertent disclosure. Sensitive information can include financial data or personal information such as credit-card and social-security numbers, and health records.

DLP enables you to help prevent unintentional or accidental sharing of sensitive information. It can examine email messages and files for sensitive information, such as a credit-card number. You also can configure DLP to help prevent users from sending sensitive information outside your organization. DLP technologies help you to detect sensitive information and take action, including:

- Logging events for auditing purposes.
- Displaying a warning to a user who's sending an email that contains sensitive data or sharing a file.
- Actively blocking file sharing or sending of emails with sensitive content.

DLP technologies and products inspect content and contextually analyze data. That analysis then triggers DLP to take appropriate action on that data. DLP can analyze data that's:

- Sent through messaging applications such as email and instant messaging.
- In transit over a network.
- In use on a managed device such as a laptop or mobile phone.
- At rest in on-premises file servers or in a cloud storage service.

You define policies and rules on the DLP platform. DLP technologies and products then implement responses based on those definitions. These responses help address inadvertent or accidental data leaks or exposure of sensitive data outside an authorized framework.

## How does DLP work?

DLP identifies sensitive information by performing regular expression (regex) pattern matching. It conducts the pattern matching in combination with other indicators, including proximity of keywords to matching patterns. Suppose a credit-card number has 16 digits. However, those digits can be written in different ways, such as 1111-1111-1111-1111, 1111 1111 1111 1111, or 1111111111111111.

Any 16-digit string isn't necessarily a credit-card number. It might be a help-desk system's ticket number or a serial number for hardware. DLP differentiates between a credit-card number and a 16-digit string by using regex to perform a calculation (checksum). The checksum confirms numbers match a known pattern from various credit-card companies. DLP looks for keywords that match a specific credit-card company’s name, or date values that might be the credit-card expiry date. Then, it uses the data to decide whether the string is a credit-card number.

In other words, DLP is smart enough to recognize the difference between the following text strings in an email:

- "Can you order me a new laptop? Use my credit card number 1111-1111-1111-1111, expiry 11/22, and send me the estimated delivery date when you have it."
- "My laptop serial number is 2222-2222-2222-2222 and it was purchased on 11/2010. By the way, is my travel visa approved yet?"

## Achieve DLP with Microsoft tools

Several Microsoft products help provide DLP. Some of the most common are the Microsoft 365 platform's Microsoft Purview compliance portal and the Microsoft 365 Defender portal. You can use a DLP policy in the compliance portal to help identify, monitor, and automatically protect sensitive information across Microsoft 365 services and applications.

With a DLP policy, you can:

- Help identify sensitive information across several locations. Locations can include Microsoft Exchange Online, Microsoft SharePoint Online, Microsoft OneDrive for Business, and Microsoft Teams. Perhaps you want to identify any document containing a credit-card number someone is storing in OneDrive for Business. Conversely, you might monitor only specific users' OneDrive storage locations.
- Help prevent accidental sharing of sensitive information. DLP helps you identify documents or emails containing a health record and being shared with people outside your organization. It then automatically blocks access to that document or blocks the email from being sent.
- Monitor and help protect sensitive information in Microsoft Excel, Microsoft PowerPoint, and Microsoft Word desktop versions. These Office desktop apps also include the same capabilities to identify sensitive information and apply DLP policies. DLP provides continuous monitoring when people share content through these Office apps.
- Help users learn how to stay compliant without interrupting their workflow. You can help educate your users about DLP policies. Perhaps a user tries to share a document containing sensitive information. A DLP policy can send them an email notification and provide a policy tip. The DLP policy tip, in the context of the document library, enables them to override the policy with a valid business justification. The same policy tips also appear in Microsoft Outlook on the web, Outlook, Excel, PowerPoint, and Word.
- Review DLP alerts and reports containing content matching your organization’s DLP policies. Use the DLP Alerts Management Dashboard to review alerts and metadata pertaining to your DLP policies, and review policy-match reports. These reports assess how your organization is complying with a DLP policy. Perhaps a user overrides a DLP policy tip and reports a false positive. Use the dashboard to review what users report.

## Components of a DLP policy

A DLP policy contains information about:

- Where to protect the content. Examples include locations such as Exchange Online, SharePoint Online, and OneDrive for Business sites, and Microsoft Teams chat and channel messages.
- When and how to protect content. This information is related to enforcing rules, which contain:
  - Conditions the content must match before a DLP enforces a rule. You might configure a rule that searches for content containing social-security numbers shared with people outside your organization.
  - Actions you want the rule to take automatically when DLP finds content matching the conditions. Perhaps you want to configure a rule to block access to a document. The rule also can send a message to the user and your compliance officer an email notification.

The following image depicts the main components of a DLP policy:

:::image type="content" source="../media/5-data-loss-prevention.png" alt-text="Components of a DLP policy, which include the locations in which to apply the policy, and different rules, each of which contains conditions and actions." border="false":::

Use a rule to meet a specific protection requirement. You then use a DLP policy to group together common protection requirements, such as all rules needed to comply with a specific regulation. For example, you might have a DLP policy to help you detect information that is subject to the Health Insurance Portability and Accountability Act (HIPAA). Your DLP policy could:

- Help protect HIPAA data (the "what") across all SharePoint Online sites.
- Help protect all OneDrive for Business sites (the "where"), by finding any document containing sensitive information and being shared with people outside your organization (the "conditions").
- Block access to the document and send a notification (the "actions").

These requirements are stored as individual rules but grouped together as a DLP policy that simplifies management and reporting.
