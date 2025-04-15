**Microsoft Defender Extended Detection and Response (XDR)** helps expand investigation capabilities for insider risk by integrating alerts from Microsoft Purview Insider Risk Management with other Microsoft security data. This combined view gives security operations center (SOC) analysts the context they need to assess user behavior, correlate risk signals, and take action across Microsoft 365 workloads.

Use this view to correlate insider risk alerts with data from other services like Microsoft Defender for Endpoint, Microsoft Entra ID, and Microsoft Purview Data Loss Prevention.

## Access insider risk alerts in Defender XDR

To review alerts in the [Microsoft Defender portal](https://security.microsoft.com/):

1. Go to **Investigation & response** > **Incidents & alerts** > **Incidents**.
1. Use the **Service source** filter to select **Microsoft Purview Insider Risk Management**

   :::image type="content" source="../media/defender-insider-risk-incidents.png" alt-text="Screenshot showing the Incidents page being filtered to show Microsoft Purview Insider Risk Management incidents." lightbox="../media/defender-insider-risk-incidents.png":::

This filter shows alerts from Insider Risk Management and highlights when those alerts are grouped into incidents with alerts from other Microsoft tools.

## Understand the investigation view

When insider risk alerts appear in the Defender portal, they might be:

- Part of a unified **incident** that includes multiple alert types
- Listed individually in the **alert queue** for review
- Linked to other activity such as endpoint behavior or identity signals

Selecting an alert or incident provides details such as severity, classification, and alert mappings. You can also view the user entity page for a risk summary and associated activity.

## Review alert status and classification sync

Alert status and classification automatically sync between Microsoft Purview and Microsoft Defender:

| Microsoft Defender status | Insider Risk Management status |
|-----|-----|
| New, In progress | Needs review |
| Resolved | Dismissed or Confirmed (based on classification) |

How classification types align:

| Microsoft Defender classification | Insider Risk Management classification |
|-----|-----|
| True positive | Confirmed |
| Information, expected activity   | Dismissed |
| False positive | Dismissed |

Updates to status, classification, and alert details reflect across both portals within about 30 minutes.

## Investigate insider risk activity with advanced hunting

Defender's **Advanced hunting** feature allows deeper investigation of insider risk activity using Kusto Query Language (KQL). Insider risk alerts and behavior logs are available in the following tables:

- `AlertInfo`: Alert metadata from multiple sources
- `AlertEvidence`: Linked entities such as files or users
- `DataSecurityBehaviors`: Policy-triggering behavioral patterns
- `DataSecurityEvents`: Detailed events from policy violations

These tables support cross-tool investigation. For example, you might query:

```kusto
DataSecurityEvents
| where FileName endswith ".zip"
| where ActionType == "FileUploaded"
```

You must be assigned the **Insider Risk Management Analyst** or **Investigator** role in Microsoft Purview to access this data.

## Requirements and setup

Before alerts appear in the Microsoft Defender portal:

The setting **Share user risk details with other security solutions** must be enabled in the Microsoft Purview portal. To enable this setting:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/).
1. Select **Settings** > **Insider Risk Management** > **Data sharing**.
1. Enable **Share user risk details with other security solutions**.

   :::image type="content" source="../media/enable-data-sharing-insider-risk-settings.png" alt-text="Screenshot showing where to enable data sharing in Microsoft Purview Insider Risk Management." lightbox=" ../media/enable-data-sharing-insider-risk-settings.png":::

Users must have roles in both Microsoft Purview and Microsoft Defender:

- **Defender**: _Security Operator_ or _Security Reader_
- **Purview**: _Insider Risk Management_, _Analyst_, or _Investigator_

Licensing for both solutions is also required. See Microsoft documentation for details.

## Limitations

Not all insider risk data is available in Defender:

- Alerts created from custom detections
- Risky AI usage events
- Non-Microsoft app events
- Exfiltration via email
- Events that occurred before an alert was generated
- Excluded events based on policy settings

Viewing insider risk alerts in Microsoft Defender XDR helps bring together security signals across Microsoft 365. This integration supports broader investigations, faster triage, and more comprehensive incident response.
