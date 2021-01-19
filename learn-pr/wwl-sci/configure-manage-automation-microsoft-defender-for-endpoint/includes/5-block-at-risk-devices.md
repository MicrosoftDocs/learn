Contain a threat by not letting risky devices access your corporate resources through Conditional Access.


>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4byD1?rel=0]

You'll need a Microsoft Intune environment, with Intune managed and Azure AD joined Windows 10 devices.

There are steps you'll need to take in Microsoft Defender Security Center, the Intune portal, and Azure AD portal.

The required roles to access these portals and implement Conditional access:

- Microsoft Defender Security Center - You'll need to sign in to the portal with a global administrator role to turn on the integration.

- Intune - You'll need to sign in to the portal with security administrator rights with management permissions.

- Azure AD portal - You'll need to sign in as a global administrator, security administrator, or Conditional Access administrator.

Take the following steps to enable Conditional Access:

1. Turn on the Microsoft Intune connection from Microsoft Defender Security Center

1. Turn on the Defender for Endpoint integration in Intune

1. Create the compliance policy in Intune

1. Assign the policy

1. Create an Azure AD Conditional Access policy

### Turn on the Microsoft Intune connection

1. In the navigation pane, select **Settings > Advanced features > Microsoft Intune connection**.

1. Toggle the Microsoft Intune setting to **On**.

1. Select **Save preferences**.

### Turn on the Defender for Endpoint integration in Intune

1. Sign in to the Azure portal.

1. Select **Device compliance > Microsoft Defender ATP**.

1. Set Connect Windows 10.0.15063+ devices to Microsoft Defender Advanced Threat Protection to **On**.

1. Select **Save**.

### Create the compliance policy in Intune

1. In the Azure portal, select **All services**, filter on **Intune**, and select **Microsoft Intune**.

1. Select **Device compliance > Policies > Create policy**.

1. Enter a Name and Description.

1. In Platform, select **Windows 10 and later**.

1. In the Device Health settings, set **Require the device to be at or under the Device Threat Level** to your preferred level:

    - Secured: This level is the most secure. The device cannot have any existing threats and still access company resources. If any threats are found, the device is evaluated as noncompliant.
    - Low: The device is compliant if only low-level threats exist. Devices with medium or high threat levels are not compliant.
    - Medium: The device is compliant if the threats found on the device are low or medium. If high-level threats are detected, the device is determined as noncompliant.
    - High: This level is the least secure and allows all threat levels. So devices with high, medium, or low threat levels are considered compliant.


1. Select **OK**, and Create to save your changes (and create the policy).

### Assign the policy

1. In the Azure portal, select **All services**, filter on **Intune**, and select **Microsoft Intune**.

1. Select **Device compliance > Policies> select your Microsoft Defender ATP compliance policy**.

1. Select **Assignments**.

1. Include or exclude your Azure AD groups to assign them the policy.

1. To deploy the policy to the groups, select **Save**. The user devices targeted by the policy are evaluated for compliance.

### Create an Azure AD Conditional Access policy

1. In the Azure portal, open Azure **Active Directory > Conditional Access > New policy**.

1. Enter a policy Name, and select **Users and groups**. Use the Include or Exclude options to add your groups for the policy, and select Done.

1. Select Cloud apps, and choose which apps to protect. For example, choose Select apps, and select Office 365 SharePoint Online and Office 365 Exchange Online. Select Done to save your changes.

1. Select **Conditions > Client apps** to apply the policy to apps and browsers. For example, select Yes, and then enable Browser and Mobile apps and desktop clients. Select Done to save your changes.

1. Select **Grant** to apply Conditional Access based on device compliance. For example, select **Grant access > Require device to be marked as compliant**. Choose **Select** to save your changes.

1. Select **Enable policy**, and then **Create** to save your changes.


