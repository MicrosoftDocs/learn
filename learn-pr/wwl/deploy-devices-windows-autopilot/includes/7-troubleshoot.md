When troubleshooting Windows Autopilot, it's important to verify the following key factors:

 -  **Configuration:** Has Entra ID and Microsoft Intune (or an equivalent MDM service) been configured as specified in Windows Autopilot configuration requirements?
 -  **Network connectivity:** Can the device access the services described in Windows Autopilot networking requirements?
 -  **Autopilot OOBE behavior:** Where only the expected out-of-box experience screens displayed? Was the Entra ID credentials page customized with organization-specific details as expected?
 -  **Entra ID join issues:** Was the device able to join Entra ID?
 -  **MDM enrollment issues:** Was the device able to enroll in Microsoft Intune (or an equivalent MDM service)?

### Troubleshoot Autopilot OOBE issues

If the expected Autopilot behavior doesn't occur during the out-of-box experience (OOBE), it's useful to see whether the device received an Autopilot profile and what settings that profile contained. Depending on the Windows release, there are different mechanisms available to do that.

You can use the Event Tracing for Windows (ETW) can be used to capture detailed information from Autopilot and related components. The resulting ETW trace files can then be viewed using the Windows Performance Analyzer or similar tools.

Information about the Autopilot profile settings is stored in the registry on the device after they're received from the Autopilot deployment service. These settings can be found at HKLM\\SOFTWARE\\Microsoft\\Provisioning\\Diagnostics\\Autopilot.

To see details related to the Autopilot profile settings and OOBE flow, Windows adds event log entries. These logs can be viewed using Event Viewer, navigating to the log at Application and Services Logs –> Microsoft –> Windows –> Provisioning-Diagnostics-Provider –> Autopilot. The following events might be recorded, depending on the scenario and profile configuration.

| Event ID | Type   | Description                                                                                                        |
|----------|--------|--------------------------------------------------------------------------------------------------------------------|
| 100      | Warning | "Autopilot policy \[name\] not found." This event is typically a temporary problem, while the device is waiting for an Autopilot profile to be downloaded. |
| 171      | Error  | "AutopilotManager failed to set TPM identity confirmed. HRESULT=\[error code\]." This event indicates an issue performing TPM attestation, needed to complete the self-deploying mode process. |
| 172      | Error  | "AutopilotManager failed to set Autopilot profile as available. HRESULT=\[error code\]." This event is typically related to event ID 171. |

### Windows Autopilot Diagnostics

Windows Autopilot can now aggregate many of the troubleshooting techniques listed into a more easily readable format to isolate issues that occur. This function can be executed from a PowerShell command directly on the device.

Open PowerShell command and enter the following (Accept download prompts):

```powershell
Set-ExecutionPolicy ByPass
Install-Script Get-AutoPilotDiagnostics -force
Get-AutoPilotDiagnostics -Online
```

Once connected to the tenant with an account that has appropriate credentials, through the GraphAPI extensions for Intune, a list of policies, apps, and status is displayed.

### Troubleshoot Entra ID join issues

The most common issue joining a device to Entra ID is related to Entra ID permissions. Ensure the correct configuration is in place to allow users to join devices to Entra ID. Errors can also happen if the user has exceeded the number of devices that they're allowed to join, as configured in Entra ID.

Typically displayed on a "Something went wrong" error page, the error code 801C0003 signifies that the attempt to join Entra ID was unsuccessful.

### Troubleshoot Intune enrollment issues

[See this article](/troubleshoot/mem/intune/device-enrollment/troubleshoot-device-enrollment-in-intune) for assistance with Intune enrollment issues. Common issues include incorrect or missing licenses assigned to the user or too many devices enrolled for the user.

When encountering the error code 80180018, it's accompanied by an error page titled "Something went wrong." This specific error indicates a failed MDM enrollment process.

### Troubleshoot Device Import

If you experience a scenario where importing a device CSV file results in no action and a *'400' error appears in network trace with error body "Cannot convert the literal '\[DEVICEHASH\]' to the expected type 'Edm.Binary'* error appears, the device hash within the file is either corrupted or the hash might not be properly padded in the file. To resolve this issue, a minor edit to the file might be necessary to ensure the device hash is in the correct format.

For more information, see [Troubleshooting Windows Autopilot (level100/200)](https://aka.ms/AA6d57a) and [Troubleshooting Windows Autopilot](https://aka.ms/AA80h34).

