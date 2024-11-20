Priva capabilities are available through two solutions:

1.  Priva Privacy Risk Management, which provides visibility into your organization's data and policy templates for reducing risks; and
2.  Priva Subject Rights Requests, which provides automation and workflow tools for fulfilling data requests.

## Privacy Risk Management

Privacy Risk Management in Microsoft Priva gives you the capability to set up policies that identify privacy risks in your Microsoft 365 environment and enable easy remediation. Privacy Risk Management policies are meant to be internal guides and can help you:

-   Detect overexposed personal data so that users can secure it.
-   Spot and limit transfers of personal data across departments or regional borders.
-   Help users identify and reduce the amount of unused personal data that you store.

Privacy Risk Management offers built-in templates for these scenarios to help you easily create policies. You can also fine tune your approach by [creating custom policies](/privacy/priva/risk-management-policies), using any of these templates as a starting point.

When policy matches are found, admins can review alerts about the findings and make decisions about how to handle the data by creating issues for further action by your users. To learn more, see [Investigate and remediate alerts in Privacy Risk Management](/privacy/priva/risk-management-alerts). You can also configure email notifications and, for supported policy types, Teams notifications to notify your content owners directly about policy matches. They can take corrective action from these notifications and learn more about best practices for handling data with links you provide to your own training materials. For more information, see [Send user notifications in Privacy Risk Management](/privacy/priva/risk-management-notifications).

### Learn about key risk scenarios

Privacy Risk Management's policy options help you address three key areas of privacy concern. Whether you're using a default template or customizing it to meet specific needs, Privacy Risk Management can help you find issues in these areas and guide your users through recommended steps for remediation.

### Limit data overexposure

Data overexposure policies can help you detect and handle situations in which data that your organization has stored is insufficiently secure. For example, if access to an internal site is open to too many people or your permissions settings have not been maintained, personal data stored on that site may be vulnerable to a breach. Data overexposure policies can evaluate your data for these risks and alert you to potential issues.

Privacy Risk Management can alert you about data overexposure for content items that are accessible to the public or have their access restricted by your organization. Privacy Risk Management also offers remediation options that help your users resolve any issues that are found. For data overexposure, these include making content items private, notifying content owners, or tagging items for further review.

### Find and mitigate data transfers

Transferring personal data presents risks, especially when transferred outside of your organization, or sent between certain departments or across regional borders within your organization. For example, if the data is sent via unencrypted emails or to unauthorized recipients, the data may no longer be secure. Data transfer activities like these can have regulatory impact or may violate established organizational privacy practices. Using data transfer policies in Privacy Risk Management can help you spot and limit such transfers.

Data transfer policies allow you to monitor for transfers between different world regions or between departments in your organization, as well as transfers outside of your organization. When a policy match is detected, you can send users email notifications that allow them to take corrective action right in the email, such as making content items private, notifying content owners, or tagging items for further review.

Learn how to create a [data transfer policy](/privacy/priva/risk-management-policy-data-transfer).

### Minimize stored data

Over time, companies can collect large amounts of personal data from customers or employees. Sometimes this includes data that no longer needs to be stored and is being unused. This type of data should be reduced to limit privacy risks. Data minimization policies can be used to address risks of this type.

Data minimization policies allow you to look for data that your organization has been storing for at least a certain length of time. This can help you manage your ongoing storage practices. When policy matches are found, remediation options include marking items for deletion, notifying content owners, or tagging items for further review.

## Subject Rights Requests

Several privacy regulations around the world grant individuals—or _data subjects_—the right to make requests to review or manage the personal data that companies have collected about them. These subject rights requests are also referred to as data subject requests (DSRs), data subject access requests (DSARs), or consumer rights requests. For companies that store large amounts of information, finding the relevant data can be a formidable task. Fulfilling the requests, for most organizations, is a highly manual and time consuming process.

The Microsoft Priva Subject Rights Requests solution is designed to help alleviate the complexity and length of time involved in responding to data subject inquires. We provide automation, insights, and workflows to help organizations fulfill requests more confidently and efficiently.

### How Priva supports subject rights request fulfillment

Automation and robust workflow tools are woven into the entire Subject Rights Requests solution. Once you create a request in the system, we take on the work of identifying and collecting data and provide tools to facilitate collaborative analysis.

#### Immediate kickoff of data evaluation

Priva uses the foundational capabilities of Microsoft 365 to identify personal data types in your organization's data. As soon as you create a request, the solution immediately gets to work identifying the files, emails, sites, and chats that contain the data subject's personal data. We'll retrieve the content items within a few hours, depending on the amount of data. If we expect to find a high volume, we'll provide you the chance to refine your search parameters before we collect the data.

#### Help in prioritizing content to review

You may have to review a large amount of data collected for the data subject's request. We provide insights on the details screen of each request and suggest which items to prioritize for review. Priority items include files that may be confidential or items containing more than one person's personal data. These items highlight content that might need redaction or other special handling considerations.

#### Built-in Teams collaboration and editing tools to facilitate data review

As soon as you create the request, a dedicated Teams channel is automatically set up for that request. Adding relevant stakeholders as request collaborators will invite them into the chat to help analyze and make decisions about the items retrieved. Using built-in redaction tools within the request, collaborators can mark up files in a review screen next to the list of items. If certain content requires a further follow-up action, you can apply tags defined by your organization to help identify the items and take the action at a later time.

#### Automatically generated reports

After you're done reviewing the data and deciding what to include for the request, we generate reports for you. The reports include any relevant data package you'll send to the data subject, audit logs, and a summary of tagged files so you can complete any necessary follow-up actions.

#### Solutions that extend and integrate with your subject request strategy

Extend the automation capabilities by using one of the built-in Power Automate templates to set up flows for common tasks, such as setting calendar reminders or creating records of your requests in ServiceNow. You can also use the Microsoft 365 Subject Rights Request API to introduce automation to your existing subject rights strategy.