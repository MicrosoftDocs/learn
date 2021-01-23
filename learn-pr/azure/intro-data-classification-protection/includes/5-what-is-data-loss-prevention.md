As a part of the general information protection strategy within a company or organization, you should consider not only data classification and data protection technologies, but also how to provide efficient DLP. DLP is not the same thing as data protection, although these two terms are often confused. With data protection, you protect data from being accessed by unauthorized persons, while with DLP, you can help prevent the improper use or sharing of your sensitive data. To comply with business standards and industry regulations, organizations must protect sensitive information and prevent its inadvertent disclosure. Sensitive information can include financial data or personally identifiable information such as credit card numbers, social security numbers, or health records.

## What is DLP?

DLP helps you prevent the unintentional or accidental sharing of sensitive information. For example, DLP examines email messages and files for sensitive information, such as a credit card number. DLP can also prevent users from sending sensitive information outside the company. By using DLP technologies, you can detect sensitive information, and take actions such as:

- Logging the event for auditing purposes.
- Displaying a warning to the end user who is sending the email or sharing the file.
- Actively blocking the email or file sharing from taking place.

Another definition of DLP is that it's a set of technologies or products that performs content inspection and contextual analysis of data, and based on that analysis, performs appropriate actions.

Data treated by DLP can be:

- Sent through messaging applications such as email and instant messaging.
- In transit over the network.
- In use on a managed device such as a laptop or mobile phone.
- At rest in on-premises file servers or in a cloud storage service.

DLP technologies and products implement responses based on policy and rules that you define on the DLP platform. These responses address the risk of inadvertent or accidental leaks, or the exposure of sensitive data outside an authorized framework.

## How does DLP work?

DLP finds sensitive information by regular expression (regex) pattern matching, in combination with other indicators such as the proximity of certain keywords to the matching patterns. For example, suppose a credit card number has 16 digits. However, those digits can be written in different ways, such as 1111-1111-1111-1111, 1111 1111 1111 1111, or 1111111111111111.

Any 16-digit string is not necessarily a credit card number. It could be a ticket number from a helpdesk system or the serial number of a piece of hardware. To discern the difference between a credit card number and a regular 16-digit string, DLP uses regex to perform a calculation (checksum) to confirm that the numbers match a known pattern from the various credit card brands.

If DLP finds keywords that match a credit card company’s name or date values that might be the credit card expiry date, DLP uses that data to decide whether the string is a credit card number or not.

In other words, DLP is smart enough to recognize the difference between these two strings of text in an email:

- "Can you order me a new laptop. Use my credit card number 1111-1111-1111-1111, expiry 11/22, and send me the estimated delivery date when you have it."
- "My laptop serial number is 2222-2222-2222-2222 and it was purchased on 11/2010. By the way, is my travel visa approved yet?"

## Achieve DLP with Microsoft tools

There are several Microsoft products that provide DLP. In today's world, the most commonly used product is the Compliance Center in Microsoft 365 platform or the Security & Compliance Center on some Office 365 tenants. With a DLP policy in the Compliance Center, you can identify, monitor, and automatically protect sensitive information across Microsoft 365 services and applications.

With a DLP policy, you can:

- **Identify sensitive information across many locations**. These can be locations such as Microsoft Exchange Online, Microsoft SharePoint Online, Microsoft OneDrive for Business, and Microsoft Teams. For example, you can identify any document containing a credit card number that's stored in any OneDrive for Business storage, or you can monitor just the OneDrive storage of specific people.
- **Prevent the accidental sharing of sensitive information**. For example, you can identify any document or email containing a health record that's shared with people outside your organization and then automatically block access to that document or block the email from being sent.
- **Monitor and help protect sensitive information in the desktop versions of Microsoft Excel, Microsoft PowerPoint, and Microsoft Word**. Just like in Exchange Online, SharePoint Online, and OneDrive for Business, these Office desktop apps include the same capabilities to identify sensitive information and apply DLP policies. DLP provides continuous monitoring when people share content in these Office apps.
- **Help users learn how to stay compliant without interrupting their workflow**. You can educate your users about DLP policies and help them remain compliant without impeding their work. For example, if a user tries to share a document containing sensitive information, a DLP policy can send them an email notification. The DLP policy can also present them with a policy tip in the context of the document library that allows them to override the policy if they have a business justification. The same policy tips also appear in Microsoft Outlook on the web, Outlook, Excel, PowerPoint, and Word.
- **Review DLP alerts and reports containing content that matches your organization’s DLP policies**. To review alerts and metadata related to your DLP policies, you can use the DLP Alerts Management Dashboard. You can also review policy match reports to assess how your organization is complying with a DLP policy. If a DLP policy allows users to override a policy tip and report a false positive, you can also review what users have reported.

## Components of a DLP policy

A DLP policy contains information about:

- Where to protect the content. Examples include locations such as Exchange Online, SharePoint Online, and OneDrive for Business sites, and Microsoft Teams chat and channel messages.
- When and how to protect the content. This information is related to enforcing rules, which contain:
  - Conditions the content must match before the rule is enforced. For example, a rule might be configured to search only for content containing social security numbers that have been shared with people outside your organization.
  - Actions that you want the rule to take automatically when content matching the conditions is found. For example, a rule might be configured to block access to a document and send both the user and compliance officer an email notification.

The following image depicts the main components of a DLP policy.

:::image type="content" source="../media/5-data-loss-prevention.png" alt-text="Components of a DLP policy components, which include the locations to apply the policy in, and different rules, each of which contains conditions and actions." border="false":::

You can use a rule to meet a specific protection requirement, and then use a DLP policy to group together common protection requirements, such as all the rules needed to comply with a specific regulation. For example, you might have a DLP policy that helps you detect the presence of information subject to the Health Insurance Portability and Accountability Act (HIPAA). This DLP policy could:

- Help protect HIPAA data (the what) across all SharePoint Online sites.
- Help protect all OneDrive for Business sites (the where) by finding any document containing this sensitive information that's shared with people outside your organization (the conditions).
- Block access to the document and send a notification (the actions).

These requirements are stored as individual rules and grouped together as a DLP policy to simplify management and reporting.
