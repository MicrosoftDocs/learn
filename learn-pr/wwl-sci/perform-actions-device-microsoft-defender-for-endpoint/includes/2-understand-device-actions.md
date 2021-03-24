When investigating a device, you can perform actions, collect data, or remotely access the machine.  Defender for Endpoint provides the device control required.

You can perform the following containment actions:

- Isolate Device

- Restrict app execution

- Run antivirus scan

You can perform the following investigation actions:

- Initiate Automated Investigation

- Collect investigation package

- Initiate Live Response Session

The Action center provides information on actions that were taken on a device or file.

### Isolate devices from networks

Depending on the severity of the attack and the sensitivity of the device, you might want to isolate the device from the network. This action can help prevent the attacker from controlling the compromised device and performing further activities such as data exfiltration and lateral movement.

This device isolation feature disconnects the compromised device from the network while retaining connectivity to the Defender for Endpoint service, which continues to monitor the device.

On Windows 10, version 1709 or later, you'll have another control over the network isolation level. You can also choose to enable Outlook, Microsoft Teams, and Skype for Business connectivity (a.k.a 'Selective Isolation').

Once you have selected Isolate device on the device page, type a comment and select Confirm. The Action center will show the scan information and the device timeline will include a new event.

When a device is being isolated, a notification is displayed to inform the user that the device is being isolated from the network.

### Restrict app execution

In addition to containing an attack by stopping malicious processes, you can also lock down a device and prevent subsequent attempts of potentially malicious programs from running.

> [!IMPORTANT]
> This action is available for devices on Windows 10, version 1709 or later.
> This feature is available if your organization uses Microsoft Defender Antivirus.
> This action needs to meet the Windows Defender Application Control code integrity policy formats and signing requirements. 
To restrict an application from running, a code integrity policy is applied that only allows files to run if they are signed by a Microsoft issued certificate. This method of restriction can help prevent an attacker from controlling compromised devices and performing further malicious activities.

You’ll be able to reverse the restriction of applications from running at any time. The button on the device page will change to say Remove app restrictions, and then you take the same steps as restricting app execution.

Once you have selected Restrict app execution on the device page, type a comment and select Confirm. The Action center will show the scan information, and the device timeline will include a new event.

When an app is restricted, a notification is displayed to inform the user that an app is being restricted from running.



