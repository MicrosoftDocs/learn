As a part of general information protection strategy within company or organization, you should not consider only data classification and data protection technologies, but also how to provide efficient data loss prevention. Data loss prevention is not the same thing as data protection, although these two terms are often confused.  With data protection, you actually protect data from being access from unauthorized persons, but data loss prevention ensures that your sensitive data is not improperly used or shared. To comply with business standards and industry regulations, organizations must protect sensitive information and prevent its inadvertent disclosure. Sensitive information can include financial data or personally identifiable information (PII) such as credit card numbers, social security numbers, or health records.

## What is data loss prevention?

Data loss prevention (DLP) helps you prevent the unintentional or accidental sharing of sensitive information. For example, DLP examines email messages and files for sensitive information, like a credit card number. DLP can also prevent users from sending sensitive information outside the company. Using DLP technologies, you can detect sensitive information, and take action such as:

- Log the event for auditing purposes
- Display a warning to the end user who is sending the email or sharing the file
- Actively block the email or file sharing from taking place

Data loss prevention (DLP) may also be defined as set of technologies or a product that perform content inspection and contextual analysis of data and, based on that, performs appropriate action. 

Data treated by DLP can be: 

- sent via messaging applications such as email and instant messaging
- in transit over the network
- in use on a managed device such as laptop or mobile phone
- at rest in on-premises file servers or in cloud storage service

DLP technologies and products execute responses based on policy and rules defined on DLP platform. These responses addresses the risk of inadvertent or accidental leaks or exposure of sensitive data outside authorized framework.

## How DLP works?

DLP finds sensitive information by regular expression (RegEx) pattern matching, in combination with other indicators such as the proximity of certain keywords to the matching patterns. For example, a VISA credit card number has 16 digits. But, those digits can be written in different ways, such as 1111-1111-1111-1111, 1111 1111 1111 1111, or 1111111111111111.

Any 16-digit string is not necessarily a credit card number, it could be a ticket number from a help desk system, or a serial number of a piece of hardware. To tell the difference between a credit card number and a harmless 16-digit string, a calculation is performed (checksum) to confirm that the numbers match a known pattern from the various credit card brands.

If DLP finds keywords such as "VISA" or "AMEX", near date values that might be the credit card expiry date, DLP also uses that data to help it decide whether the string is a credit card number or not.

In other words, DLP is smart enough to recognize the difference between these two strings of text in an email:

- "Can you order me a new laptop. Use my VISA number 1111-1111-1111-1111, expiry 11/22, and send me the estimated delivery date when you have it."
- "My laptop serial number is 2222-2222-2222-2222 and it was purchased on 11/2010. By the way, is my travel visa approved yet?"

## How to achieve data loss prevention with Microsoft tools?

There are several Microsoft products that provide data loss prevention. In today's world, most commonly used is the Compliance Center in Microsoft 365 platform or the Security & Compliance Center on some Office 365 tenants. With a data loss prevention (DLP) policy in the Compliance Center, you can identify, monitor, and automatically protect sensitive information across Microsoft 365 services and applications.

With a DLP policy, you can:

- Identify sensitive information across many locations, such as Exchange Online, SharePoint Online, OneDrive for Business, and Microsoft Teams. For example, you can identify any document containing a credit card number that's stored in any OneDrive for Business storage, or you can monitor just the OneDrive storage of specific people.


- Prevent the accidental sharing of sensitive information. For example, you can identify any document or email containing a health record that's shared with people outside your organization, and then automatically block access to that document or block the email from being sent.


- Monitor and protect sensitive information in the desktop versions of Excel, PowerPoint, and Word. Just like in Exchange Online, SharePoint Online, and OneDrive for Business, these Office desktop programs include the same capabilities to identify sensitive information and apply DLP policies. DLP provides continuous monitoring when people share content in these Office programs.


- Help users learn how to stay compliant without interrupting their workflow. You can educate your users about DLP policies and help them remain compliant without blocking their work. For example, if a user tries to share a document containing sensitive information, a DLP policy can both send them an email notification and show them a policy tip in the context of the document library that allows them to override the policy if they have a business justification. The same policy tips also appear in Outlook on the web, Outlook, Excel, PowerPoint, and Word.


- View DLP alerts and reports showing content that matches your organization’s DLP policies. To view alerts and metadata related to your DLP policies you can use the DLP Alerts Management Dashboard. You can also view policy match reports to assess how your organization is complying with a DLP policy. If a DLP policy allows users to override a policy tip and report a false positive, you can also view what users have reported


:::image type="content" source="../media/5-DLP.png" alt-text="Image shows DLP Policy components.":::

A DLP policy contains a few basic things:

- Where to protect the content: locations such as Exchange Online, SharePoint Online, and OneDrive for Business sites, as well as Microsoft Teams chat and channel messages.


- When and how to protect the content by enforcing rules comprised of:
  - **Conditions** the content must match before the rule is enforced. For example, a rule might be configured to look only for content containing Social Security numbers that's been shared with people outside your organization.
  - **Actions** that you want the rule to take automatically when content matching the conditions is found. For example, a rule might be configured to block access to a document and send both the user and compliance officer an email notification.

You can use a rule to meet a specific protection requirement, and then use a DLP policy to group together common protection requirements, such as all of the rules needed to comply with a specific regulation.

For example, you might have a DLP policy that helps you detect the presence of information subject to the Health Insurance Portability and Accountability Act (HIPAA). This DLP policy could help protect HIPAA data (the what) across all SharePoint Online sites and all OneDrive for Business sites (the where) by finding any document containing this sensitive information that's shared with people outside your organization (the conditions) and then blocking access to the document and sending a notification (the actions). These requirements are stored as individual rules and grouped together as a DLP policy to simplify management and reporting.
