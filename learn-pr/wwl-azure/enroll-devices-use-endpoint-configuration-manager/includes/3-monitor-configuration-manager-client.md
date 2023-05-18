

After you install the Configuration Manager client on the Windows devices and are connected to your site, you can monitor and manage the device directly inside the Configuration Manager console.

From within the Configuration Manager console, there are a number in-built features (status) that can alert you if a client is experiencing issues or could require further attention:

 -  **Client online status**: The site considers a device **online** if it's connected to its assigned management point. To indicate that the client is online, it sends ping-like messages to the management point. If the management point does not receive a message in five minutes, the site considers the client **offline**.
 -  **Client activity**: The site considers the client **active** if it has communicated with Configuration Manager in the past seven days. The site considers the client **inactive** if it hasn't done the following actions in seven days:
    
     -  Requested policy update.
     -  Sent a heartbeat message.
     -  Sent hardware inventory.
 -  **Primary User**: From the ECM console, you can see at a high-level what Configuration Manager believes to be the primary user of this device. This metric is calculated over a 60-day period of the most frequent logins.
 -  **Operating System Build**: Data exposed from the inventory performed on the machine enables you to see the OS version of a device without having to connect to or perform any remote management.
 -  **Client check**: The state of the periodic evaluation that the Configuration Manager client runs on the device. The evaluation checks the device and can remediate some of the problems it finds. You can configure remediation not to run on specific devices, for example, a business-critical server. If there are additional items that you want to evaluate, use Configuration Manager compliance settings to monitor additional configurations. Device remediation is an example of a workload that can be utilized through co-management to enable the client to be evaluated, regardless of how the device was brought into the hierarchy. Windows Intune also offers device compliance on the path to modern management, but the subset of noncompliance actions is still evolving. For this reason, co-management using Configuration Manager for remediation is often the most appropriate choice in most advanced scenarios, such as making file or configuration changes to allow remediation for compliance.
