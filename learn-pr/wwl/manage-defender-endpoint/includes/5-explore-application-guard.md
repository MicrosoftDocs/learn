
Microsoft Defender Application Guard (Application Guard) is designed to help prevent old and newly emerging attacks to help keep employees productive. Using Microsoft's unique hardware isolation approach, the goal of Application Guard is to destroy the playbook that attackers use by rendering current attack methods obsolete.

Designed for Windows and Microsoft Edge, Application Guard helps to isolate enterprise-defined untrusted sites, protecting your company while your employees browse the internet. As an enterprise administrator, you define what is among trusted websites, cloud resources, and internal networks. Everything not on your list is considered untrusted.

If an employee goes to an untrusted site through either Microsoft Edge or Internet Explorer, Microsoft Edge opens the site in an isolated Hyper-V-enabled container, which is separate from the host operating system. This container isolation means that if the untrusted site turns out to be malicious, the host PC is protected, and the attacker can't get to your enterprise data. For example, this approach makes the isolated container anonymous, so an attacker can't get to your employee's enterprise credentials.

:::image type="content" source="../media/application-guard-hardware-isolation-1684b878.png" alt-text="Hardware isolation diagram":::


### Types of devices that should use Application Guard

Application Guard has been created to target several types of systems:

 -  **Enterprise desktops:** These desktops are domain-joined and managed by your organization. Configuration management is primarily done through Endpoint Configuration Manager or Microsoft Intune. Employees typically have Standard User privileges and use a high-bandwidth, wired, corporate network.
 -  **Enterprise mobile laptops:** These laptops are domain-joined and managed by your organization. Configuration management is primarily done through Configuration Manager or Microsoft Intune. Employees typically have Standard User privileges and use a high-bandwidth, wireless, corporate network.
 -  **Bring your own device (BYOD) mobile laptops:** These personally owned laptops aren't domain-joined but are managed by your organization through tools like Microsoft Intune. The employee is typically an admin on the device and uses a high-bandwidth wireless corporate network while at work and a comparable personal network while at home.
 -  **Personal devices:** These personally owned desktops or mobile laptops aren't domain-joined or managed by an organization. The user is an admin on the device and uses a high-bandwidth wireless personal network while at home or a comparable public network while outside.

### Configuring Application Guard

To enable Application Guard in Microsoft Edge, use the following steps:

1.  Open Control Panel.
2.  Select on **Programs**.
3.  Select the **Turn Windows features on or off** link.
4.  Check the **Microsoft Defender Application Guard** option. If that option isn't available to select, it's probably because your hardware doesn't support this feature.
5.  Select **OK**.
6.  Select **Restart now**.

After the computer restarts, you can start a Microsoft Edge session using Microsoft Defender Application Guard by selecting the menu button on the top-right and then selecting the New Application Guard window option.

If you want to configure Application Guard features by using Microsoft Intune platform, you can do it by creating device configuration profile. This applies only to Windows 10 and later operating systems. When you select to create new configuration profile, you should choose Endpoint protection as the profile type, and then select to configure Microsoft Defender Application Guard settings. This admin interface allows you to create more options than in Group Policy, and to configure Application Guard not just for Microsoft Edge but also for Office apps, as shown in the picture below:

:::image type="content" source="../media/intune-windows-defender-application-guard-41431013.png" alt-text="Windows Defender Application Guard screen":::
