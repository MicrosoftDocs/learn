Microsoft Sentinel originally connected the Microsoft Defender XDR solutions with individual connectors:
- Microsoft Defender for Endpoint
- Microsoft Defender for Office 365
- Microsoft Defender for Cloud Apps
- Microsoft Defender for Identity


These connectors had a limitation of only sending Alerts to Microsoft Sentinel.  You would then have the option to generate an Incident from the Alert.  Setting this option created the following limitations:
- Raw data wouldn't be ingested.
- A new Incident would be created that caused Incidents in both the Microsoft Defender portal and Microsoft Sentinel that would need to be managed independently.

The newer **Microsoft Defender XDR** connector removes the limitations and should be used instead of the legacy connectors.  


