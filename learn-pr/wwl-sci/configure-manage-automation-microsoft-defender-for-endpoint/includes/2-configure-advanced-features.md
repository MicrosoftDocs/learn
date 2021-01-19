The Advanced features page in the Settings/General area provides the following automation-related settings:

The Advanced features area in the General Settings area provides many an on/off switch for features within the product. The following are settings that are automation focused.

| Feature| Description|
| :--- | :--- |
| Automated Investigation| Enables the automation capabilities for investigation and response.|
| Enable EDR in block mode| When turned on, Microsoft Defender for Endpoint uses behavioral blocking and containment capabilities by blocking malicious artifacts or behaviors observed through post-breach endpoint detection and response (EDR) capabilities. This feature doesn't change how Microsoft Defender for Endpoint performs detection, alert generation, and incident correlation.|
| Automatically resolve alerts| Resolves an alert if Automated investigation finds no threats or has successfully remediated all malicious artifacts.|
| Allow or block file| Make sure that Windows Defender Antivirus is turned on and the cloud-based protection feature is enabled in your organization to use the allow or block file feature.|

### Automated investigation

Turn on this feature to take advantage of the automated investigation and remediation features of the service.

### Autoresolve remediated alerts

For tenants created on or after Windows 10, version 1809, the automated investigation and remediation capability is configured by default to resolve alerts where the automated analysis result status is "No threats found" or "Remediated".  If you don't want to have alerts auto-resolved, you'll need to turn off the feature manually.

The result of the autoresolve action may influence the Device risk level calculation based on the active alerts found on a device.  If a security operations analyst manually sets the status of an alert to "In progress" or "Resolved," the autoresolve capability will not overwrite it.

### Allow or block file

Blocking is only available if your organization fulfills these requirements:

- Uses Microsoft Defender Antivirus as the active antimalware solution

and

- The cloud-based protection feature is enabled

This feature enables you to block potentially malicious files in your network. Blocking a file will prevent it from being read, written, or executed on devices in your organization.  After turning on this feature, you can block files via the Add Indicator tab on a file's profile page.

