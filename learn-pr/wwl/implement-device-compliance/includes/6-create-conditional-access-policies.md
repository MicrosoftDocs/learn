

You use conditions and controls to create conditional access policies.

### Conditions

A condition is a rule that Intune checks when performing conditional access. For example, a condition might be “when a device meets the password requirements.” Conditions can be based on the:

 -  Device platform that is accessing the data.
 -  Location from where the data is being accessed.
 -  Client applications that are used to access the data.

### Controls

Controls are the actions that are allowed or disallowed when a condition is met. For example, with the previous condition, a control might be “allow access.” Controls include:

 -  Blocking access.
 -  Granting access if one or more requirements are met.

### Configure conditional access

You can configure conditional access from the Intune console in the Microsoft Intune admin center. by opening the **Conditional Access** > **Policies** page. When creating the policy, you assign it to users or groups and can specify any cloud services that are affected by the policy.

You can also configure conditional access for Exchange ActiveSync in the Tenant administration section of Microsoft Intune admin center.

:::image type="content" source="../media/create-conditional-access-72f94dcd.png" alt-text="Screenshot showing the steps to create a conditional access policy.":::


#### Conditional Access and Exchange ActiveSync

Exchange ActiveSync (EAS) is an Exchange synchronization protocol that's optimized to work together with high-latency and low-bandwidth networks. The protocol, based on HTTP and XML, lets mobile phones access an organization's information on a server that's running Microsoft Exchange. Not only does EAS allow mobile phone users to access their email, calendar, contacts, and tasks, it also allows them to continue accessing this information when they're working offline. By default, Exchange ActiveSync is enabled. All users who have an Exchange mailbox can synchronize their mobile device with the Microsoft Exchange server.

> [!NOTE]
> Exchange ActiveSync doesn't support shared mailboxes or delegate access.

Standard encryption services add security to mobile communication with the server. You can configure Exchange ActiveSync to use Secure Sockets Layer (SSL) encryption for communications between the Exchange server and the mobile device.

One of the most common scenarios for conditional access is managing access to Exchange server or Exchange Online. Conditional access can be used to allow or block access to Exchange on-premises based on the device compliance policies and enrollment state. When conditional access is used in combination with a device compliance policy, only compliant devices are allowed access to Exchange on-premises.

You can configure advanced settings in conditional access for more granular control such as:

 -  Allow or block certain platforms.
 -  Immediately block devices that aren't managed by Intune.

Any device used to access Exchange on-premises is checked for compliance when device compliance and conditional access policies are applied. When devices don't meet the conditions set, the end user is guided through the process of enrolling the device via the Azure AD Device Registration Server (DRS) to fix the issue that is making the device noncompliant.

The Intune Exchange connector pulls in all the Exchange ActiveSync records that exist at the Exchange server so Intune can take these EAS records and map them to Intune device records. These records are devices enrolled and recognized by Intune. This process allows or blocks e-mail access.

If the EAS record is brand new, and Intune isn't aware of it, Intune issues a command that blocks access to e-mail. The following diagram shows more details on how this process works.

:::image type="content" source="../media/conditional-access-intune-common-ways-1.png" alt-text="Diagram showing how the EAS process works.":::