As part of the investigation or response process, you can remotely initiate an antivirus scan to help identify and remediate malware that might be present on a compromised device.

> [!IMPORTANT]
> This action is available for devices on Windows 10, version 1709 or later.
> A Microsoft Defender Antivirus (Microsoft Defender AV) scan can run alongside other antivirus solutions, whether Microsoft Defender AV is the active antivirus solution or not. Microsoft Defender AV can be in Passive mode. For more information, see Microsoft Defender Antivirus compatibility.

One you have selected Run antivirus scan, select the scan type that you'd like to run (quick or full) and add a comment before confirming the scan.

The Action center will show the scan information, and the device timeline will include a new event, reflecting that a scan action was submitted on the device. Microsoft Defender AV alerts will reflect any detections that surfaced during the scan.

> [!NOTE]
> When triggering a scan using Defender for Endpoint response action, Microsoft Defender antivirus 'ScanAvgCPULoadFactor' value still applies and limits the CPU impact of the scan.
> If ScanAvgCPULoadFactor is not configured, the default value is a limit of 50% maximum CPU load during a scan.

### Initiate automated investigations

You can start a new general purpose automated investigation on the device if needed. While an investigation is running, any other alert generated from the device will be added to an ongoing Automated investigation until that investigation is completed. In addition, if the same threat is seen on other devices, those devices are added to the investigation.

