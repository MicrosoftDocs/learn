Microsoft Defender for Office 365 (formerly named Office 365 Advanced Threat Protection) safeguards your organization against malicious threats posed by email messages, links (URLs), and collaboration tools. By ingesting Microsoft Defender for Office 365 alerts into Azure Sentinel, you can incorporate information about email-based and URL-based threats into your broader risk analysis and build response scenarios accordingly.

The following types of alerts are ingested:

- A potentially malicious URL click was detected

- Email messages containing malware removed after delivery

- Email messages containing phish URLs removed after delivery

- Email reported by the user as malware or phish

- Suspicious email sending patterns detected

- User restricted from sending email

:::image type="content" source="../media/office-365-advanced-threat-protection.png" alt-text="Microsoft Defender for Office 365 connector page." lightbox="../media/office-365-advanced-threat-protection.png":::

To view the connector page do the following steps:

1. Select Data connectors page.

1. Select **Microsoft Defender for Office 365** (may still be called Office 365 Advanced Threat Protection).

1. Select the Open connector page on the preview pane.

1. Select **Connect** to start streaming the alerts.

1. Select whether alerts from Microsoft Defender for Office 365 automatically generate incidents by selecting **Enable**.

