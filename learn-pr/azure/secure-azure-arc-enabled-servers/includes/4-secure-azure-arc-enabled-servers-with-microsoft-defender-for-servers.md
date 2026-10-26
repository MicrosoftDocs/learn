Tailwind Traders wants to understand the protections available for its Arc-enabled servers. In this unit, you explore endpoint detection and response, vulnerability assessment, file integrity monitoring, and complementary application-control measures.

Reference links for this unit are in the summary's **More info** section.

## Overview of Microsoft Defender for Servers

Microsoft Defender for Servers is a paid plan in Microsoft Defender for Cloud. It protects supported Windows and Linux servers across cloud and on-premises environments. Features depend on the plan, operating system, and hosting environment.

The following table summarizes the capabilities covered in this module.

| Capability | Scope for this module |
| --- | --- |
| Microsoft Defender for Endpoint integration | Plan 1 and Plan 2, on supported Windows and Linux servers. |
| Agent-based vulnerability assessment through Microsoft Defender Vulnerability Management | Plan 1 and Plan 2 through the endpoint sensor. |
| Premium Defender Vulnerability Management capabilities | Plan 2; access these capabilities in the Microsoft Defender portal. |
| File integrity monitoring | Plan 2, with separate enablement and a Log Analytics workspace. |
| Dedicated fileless-security alerts | Plan 2 on supported Windows Arc-enabled servers; distinguish these alerts from general Defender for Endpoint detections. |

For complete coverage and exclusions, see *Defender for Servers overview and plan comparison* and the *Defender for Servers support matrix*.

Security posture capabilities also include assessments of applicable operating-system configuration and update status. Review the plan-specific guidance before relying on those assessments. Use Azure Update Manager for the supported update-management workflow and review its requirements and pricing separately.

## Integration with Microsoft Defender for Endpoint

Defender for Servers includes Defender for Endpoint capabilities for supported servers. The integration provides endpoint detection and response, vulnerability information, and software inventory. Endpoint alerts can appear in Defender for Cloud, and you can investigate the corresponding device and incident in the Microsoft Defender portal.

Confirm that endpoint integration is enabled and that each server has actually onboarded, as described in the previous unit. Enabling Defender for Servers authorizes access to relevant endpoint vulnerability, software, and alert data.

## Vulnerability assessment with Microsoft Defender Vulnerability Management

For on-premises Arc-enabled servers, use agent-based vulnerability assessment through the Defender for Endpoint sensor. This is available with Defender for Servers Plan 1 or Plan 2. Review applicable software vulnerability recommendations in Defender for Cloud and use the Microsoft Defender portal for deeper vulnerability-management investigation.

Plan 2 includes additional premium vulnerability-management capabilities. These don't make on-premises Arc machines eligible for cloud disk-snapshot scanning.

> [!NOTE]
> Agentless scanning is a separate collection method for supported Azure VMs, AWS EC2 instances, and GCP compute instances. It requires the applicable Plan 2 or Defender CSPM coverage. Registering an on-premises server with Azure Arc doesn't give Defender for Cloud access to snapshot that server's disks.

Follow *Set up integrated vulnerability assessment* and investigate current individual vulnerability recommendations rather than relying on a specific grouped recommendation title.

## File integrity monitoring

File integrity monitoring (FIM) helps identify suspicious changes to monitored files and Windows registry entities. For on-premises Arc-enabled servers, the current collection path uses Defender for Endpoint. Endpoint-collected changes are sent to the configured Log Analytics workspace in near real time.

FIM is part of Defender for Servers Plan 2 and isn't enabled by default. Before enabling it, confirm that the server is connected through Azure Arc and has Defender for Endpoint installed through the Defender for Servers extension. Check the current platform-specific minimum sensor versions and the configuration permissions in *Enable file integrity monitoring*. That guidance requires Security Admin and Owner roles on the subscription containing the selected workspace.

To configure the recommended monitoring coverage:

1. In the Azure portal, open **Microsoft Defender for Cloud** > **Environment settings** and select the subscription.
1. Open **Settings** for Defender for Servers and set **File Integrity Monitoring** to **On**.
1. Select **Edit configuration** and choose or create the Log Analytics workspace to store change events.
1. Under **Recommended to monitor**, select **Edit**. Review the recommended entities, keep the required rules enabled, and select the change types you want to monitor.
1. Select **Apply** to save the rule selection, then **Apply** and **Continue** to finish the configuration. Save the subscription settings if the portal presents a pending **Save** action.
1. Open **Workload protection** > **File Integrity Monitoring** > **Settings** and resolve any missing prerequisites.

Review change records in the FIM experience or query the chosen workspace:

```kusto
MDCFileIntegrityMonitoringEvents
| where TimeGenerated > ago(1h)
| take 20
```

Records are expected only after a matching monitored change occurs. Use a controlled change on a test server to verify the selected coverage, without changing a production system file solely to test ingestion. If you don't get any results, check FIM status, endpoint health, monitored entities, and the destination workspace.

For Linux, the current sensor reports a newly created file as a Modify event rather than distinguishing Create from Modify. Custom-path and agentless coverage have additional requirements; this on-premises walkthrough uses the recommended monitored entities rather than promising arbitrary path monitoring.

## Complementary application control on Windows

Use App Control for Business to define which applications and code are permitted on supported Windows servers. It's a Windows security control configured separately from Defender for Cloud; enabling Defender for Servers doesn't deploy an application-control policy.

App Control for Business supports Windows Server 2016 and later; individual policy capabilities vary by version. Check *App Control for Business feature availability* for the server version and policy capabilities you need. Plan an audit-mode pilot, review the observed applications, and validate your management and recovery procedures before enforcing a policy. Follow *Use audit events to create App Control policy rules*.

Defender attack surface reduction rules provide complementary Windows protection against risky behaviors. They aren't application allowlisting and aren't a Linux feature. See *Attack surface reduction overview*.

> [!IMPORTANT]
> These Windows controls aren't a one-for-one, cross-platform Defender for Cloud application-control service. An enforced policy can block legitimate business or management software. Validate it on representative test servers before rollout, and don't assume that the same policy applies to Linux.

## Fileless threats and platform scope

Fileless attacks can run malicious code in memory to reduce their exposure to disk-based detection. Defender for Servers Plan 2 provides dedicated Defender for Cloud fileless-security alerts for supported Windows Arc-enabled servers. These are additional detections, distinct from general Defender for Endpoint detection and response available through Plan 1 or Plan 2. Investigate the alerts with the associated endpoint and process context. See *Alerts for Windows machines*.

Use the *Defender for Servers support matrix* to distinguish this Windows capability from general endpoint detection and response on supported Windows and Linux servers. Don't assume identical alert families or a default periodic memory-scanning workflow across both operating systems.
