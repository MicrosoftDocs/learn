Contain a threat by not letting risky devices access your corporate resources through Conditional Access.

You need a Microsoft Intune environment, with Intune managed and Entra ID joined Windows 10 or higher devices.

The required roles to access these portals and implement Conditional access:

- Microsoft Defender portal - To configure roles in the Microsoft Defender portal, you need to sign in with the Security Administrator role. To manage portal advanced settings, you need the Microsoft Defender for Endpoint Administrator role.

- Intune - You need to sign in to the portal with Security Administrator rights with management permissions.

- Entra ID portal - You need to sign in as a Security Administrator, or Conditional Access administrator.

<!--- >:::image type="content" source="../media/mde-architecture.png" alt-text="Diagram of architecture for M D E conditional access."::: --->

Take the following steps to enable Conditional Access:

1. Turn on the Microsoft Intune connection from Microsoft Defender XDR.

1. Turn on the Defender for Endpoint integration in Endpoint Manager

1. Create the compliance policy in Intune

1. Assign the policy

1. Create an Entra ID Conditional Access policy

### Turn on the Microsoft Intune connection

1. In the Microsoft Defender XDR navigation pane, select **Settings > Endpoints** and then under General section select **Advanced features**.

1. Toggle the Microsoft Intune connection setting to **On**.

1. Select **Save preferences**.

### Turn on the Defender for Endpoint integration in the Intune admin center

1. Sign in to the Microsoft Intune admin center [https://intune.microsoft.com](https://intune.microsoft.com).

1. Select **Endpoint security > Microsoft Defender for Endpoint**.

1. Set **Allow Microsoft Defender for Endpoint to enforce Endpoint Security Configurations** to **On**.

1. Select **Save**.

### Create the compliance policy in the Intune admin center

1. In the Microsoft Intune admin center, select **Devices** from the navigation menu, and then expand the **Manage Devices** section.

1. select **Compliance**.

1. Select **+ Create policy**.

1. In Platform, select **Windows 10 and later**, and select **Create**.

1. Enter a Name and Description, select **Next**.

1. On the *Compliance Settings* tab, expand **Microsoft Defender for Endpoint**, set **Require the device to be at or under the machine risk score** to your preferred level:

    - Clear: This level is the most secure. The device can't have any existing threats and still access company resources. If any threats are found, the device is evaluated as noncompliant.
    - Low: The device is compliant if only low-level threats exist. Devices with medium or high threat levels aren't compliant.
    - Medium: The device is compliant if the threats found on the device are low or medium. If high-level threats are detected, the device is determined as noncompliant.
    - High: This level is the least secure and allows all threat levels. So devices with high, medium, or low threat levels are considered compliant.

1. Select **Next** and in the **Actions for noncompliance** tab, select actions to take.

1. Select **Next** and in the **Scope tags** tab, leave the *Default* or select other scope tags.

1. Select **Next** and in the **Assignments** tab, select the groups, users, or devices to assign the policy to. Or select groups to exclude from the policy.

1. Select **Next** until you can select **Create**, and Create to save your changes (and create the policy).

    >[!NOTE:] You can also create and assign policies the *Microsoft Intune admin center*, **Endpoint security**, *Device compliance* section.

### Create an Entra ID Conditional Access policy

1. In the Azure portal, select **Entra ID Conditional Access** from the Services menu, and select the drop-down **+ New policy**, and then select **Create new policy**.

1. Enter a policy Name, and select **Users or workload entities**. Use the Include or Exclude options to add your groups for the policy.

1. In the Cloud apps or actions area, choose which apps to protect. For example, choose Select apps, and select Office 365 SharePoint Online and Office 365 Exchange Online.

1. In the Conditions area, select to apply the policy to Client apps and browsers.  When complete select **done**.

1. In the Grant area, apply Conditional Access based on device compliance. For example, select **Grant access > Require device to be marked as compliant**. Choose **Select** to save your changes.

1. Select **Enable policy** choice, and then **Create** to save your changes.

For more information, see [Use Defender for Endpoint to enforce device compliance with Microsoft Intune](/mem/intune/protect/advanced-threat-protection)