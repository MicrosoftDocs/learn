The Microsoft Defender portal​ is a unified, natively integrated, pre- and post-breach enterprise defense suite. It protects endpoint, identity, email, and cloud app threats. You can detect, prevent, investigate, and automatically respond to sophisticated threats in a central place. It includes the following services:

- Microsoft Defender for Office 365

- Microsoft Defender for Endpoint

- Microsoft Defender for Identity

- Microsoft Defender for Cloud Apps

The Microsoft Defender XDR integration with Microsoft Sentinel currently provides these data connectors for those services:

- Microsoft Defender XDR (Preview)

- Microsoft Defender for Cloud Apps

- Microsoft Defender for Endpoint

- Microsoft Defender for Identity

- Microsoft Defender for Office 365 (Preview)

Other relevant Microsoft Defender data connectors include:

- Microsoft Defender for IoT

- Microsoft 365 Insider Risk Management (Preview)

It's important to understand how data is ingested by each connector.  Does the connector support bi-directional syncing of Incidents?  Should you ingest the raw log data for hunting and entity analysis? Once you've decided the required data from each log source, then enable the connectors.

> [!NOTE]
> These connectors are now considered *Legacy* connectors:
> 
> Microsoft Defender for Cloud Apps, Microsoft Defender for Endpoint, Microsoft Defender for Identity and Microsoft Defender for Office 365.
