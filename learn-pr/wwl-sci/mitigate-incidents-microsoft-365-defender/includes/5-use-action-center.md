Use the Action center to see the results of current and past investigations across your organization's devices and mailboxes. Depending on the type of threat and resulting verdict, remediation actions can occur automatically or upon approval by your organization's security operations team. All remediation actions, whether they are pending approval or already approved, are consolidated in the Action center.

The Action center provides a "single pane of glass" experience for tasks, such as:

- Approving pending remediation actions;

- Viewing an audit log of already approved remediation actions; and

- Reviewing completed remediation actions.

Your security operations team can operate more effectively and efficiently because the Action center provides a comprehensive view of Microsoft 365 Defender at work.

In the Action center, you'll see two tabs: Pending and History.

- The **Pending** tab lists investigations that require review and approval by someone in your security operations team to continue. Make sure to review and take action on pending items you see here.

- The **History** tab lists past investigations and remediation actions that were taken automatically. You can view data for the past day, week, month, or six months.

Select an item in the list to view more details about an investigation. The investigation details view opens.

- If the investigation pertains to email content (such as, the entity is a mailbox), investigation details open in the Security & Compliance Center [https://protection.office.com/threatinvestigation](https://protection.office.com/threatinvestigation?azure-portal=tru).

- If the investigation involves a device, investigation details open in the security center [https://security.microsoft.com](https://security.microsoft.com?azure-portal=tru).

## Available actions

As remediation actions are taken, they're listed on the History tab in the Action center. Such actions include the following:

- Collect investigation package

- Isolate device (this action can be undone)

- Offboard machine

- Release code execution

- Release from quarantine

- Request sample

- Restrict code execution (this action can be undone)

- Run antivirus scan

- Stop and quarantine

## Action source

The following table describes possible Action source values:

| Action source value| Description|
| :--- | :--- |
| Manual device action| A manual action taken on a device. Examples include device isolation or file quarantine.|
| Manual email action| A manual action taken on email. An example includes soft-deleting email messages or remediating an email message.|
| Automated device action| An automated action taken on an entity, such as a file or process. Examples of automated actions include sending a file to quarantine, stopping a process, and removing a registry key. (See Remediation actions in Microsoft Defender for Endpoint.)|
| Automated email action| An automated action taken on email content, such as an email message, attachment, or URL. Examples of automated actions include soft-deleting email messages, blocking URLs, and turning off external mail forwarding. (See Remediation actions in Microsoft Defender for Office 365.)|
| Advanced hunting action| Actions taken on devices or email with advanced hunting.|
| Explorer action| Actions taken on email content with Explorer.|
| Manual live response action| Actions taken on a device with live response. Examples include deleting a file, stopping a process, and removing a scheduled task.|
| Live response action| Actions taken on a device with Microsoft Defender for Endpoint APIs. Examples of actions include isolating a device, running an antivirus scan, and getting information about a file.|

