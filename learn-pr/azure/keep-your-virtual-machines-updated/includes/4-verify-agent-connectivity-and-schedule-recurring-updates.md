In addition to a public-facing web site, the department uses web sites for in-house content such as dispatch and patient care records. These sites must be as secure as possible.

Here, you'll learn how to assess agent connectivity, and schedule a recurring update.

## Components used by Update Management

The following configurations are used to perform assessment and update deployments:

- Microsoft Monitoring Agent (MMA) for Windows or Linux
- PowerShell Desired State Configuration (DSC) for Linux
- Automation Hybrid Runbook Worker
- Microsoft Update or Windows Server Update Services (WSUS) for Windows computers

## Compliance scan

Update Management performs a scan for update compliance. A compliance scan is by default performed every 12 hours on a Windows computer and every 3 hours on a Linux computer. In addition to the scan schedule, a compliance scan is initiated within 15 minutes if the MMA is restarted, before update installation, and after update installation. After a computer performs a scan for update compliance, the agent forwards the information in bulk to Azure Log Analytics.

It can take between 30 minutes and 6 hours for the dashboard to display updated data from managed computers.

## Recurring Updates

You can create a scheduled and recurring deployment of updates. With scheduled deployment, you can define what target computers receive the updates, either by explicitly specifying computers or by selecting a computer group that's based on log searches of a specific set of computers. You also specify a schedule to approve and designate a period of time during which updates can be installed.

Updates are installed by runbooks in Azure Automation. You can't view these runbooks, and the runbooks don’t require any configuration. When an update deployment is created, the update deployment creates a schedule that starts a master update runbook at the specified time for the included computers. The master runbook starts a child runbook on each agent to perform installation of required updates.
