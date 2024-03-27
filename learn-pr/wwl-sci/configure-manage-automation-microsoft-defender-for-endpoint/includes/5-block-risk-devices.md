Contain a threat by not letting risky devices access your corporate resources through Conditional Access.


>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4byD1?rel=0]

You'll need a Microsoft Endpoint Manager environment, with Intune managed and Azure AD joined Windows 10 or higher devices.

The required roles to access these portals and implement Conditional access:

- Microsoft Defender portal - You'll need to sign in to the portal with a global administrator role to turn on the integration.

- Intune - You'll need to sign in to the portal with security administrator rights with management permissions.

- Azure AD portal - You'll need to sign in as a global administrator, security administrator, or Conditional Access administrator.

:::image type="content" source="../media/mde-architecture.png" alt-text="Diagram of architecture for M D E conditional access.":::

Take the following steps to enable Conditional Access:

1. Turn on the Microsoft Intune connection from Microsoft Defender XDR.

1. Turn on the Defender for Endpoint integration in Endpoint Manager

1. Create the compliance policy in Intune

1. Assign the policy

1. Create an Azure AD Conditional Access policy

### Turn on the Microsoft Intune connection

1. In the Microsoft Defender XDR navigation pane, select **Settings > Endpoints** and then under General section select **Advanced features**.

1. Toggle the Microsoft Intune connection setting to **On**.

1. Select **Save preferences**.

### Turn on the Defender for Endpoint integration in Endpoint Manager

1. Sign in to the Microsoft Endpoint Manager admin center [https://endpoint.microsoft.com](https://endpoint.microsoft.com).

1. Select **Endpoint security > Microsoft Defender for Endpoint**.

1. Set **Allow Microsoft Defender for Endpoint to enforce Endpoint Security Configurations** to **On**.

1. Select **Save**.

### Create the compliance policy in Endpoint Manager

1. In the Microsoft Endpoint Manager admin center, select **Devices**, and select **Compliance policies**.

1. Select **+ Create policy**.

1. In Platform, select **Windows 10 and later**, and select **Create**.

1. Enter a Name and Description, select **Next**.

1. In the Device Health settings, set **Require the device to be at or under the Device Threat Level** to your preferred level:

    - Secured: This level is the most secure. The device can't have any existing threats and still access company resources. If any threats are found, the device is evaluated as noncompliant.
    - Low: The device is compliant if only low-level threats exist. Devices with medium or high threat levels aren't compliant.
    - Medium: The device is compliant if the threats found on the device are low or medium. If high-level threats are detected, the device is determined as noncompliant.
    - High: This level is the least secure and allows all threat levels. So devices with high, medium, or low threat levels are considered compliant.


1. Select **Next** until you can select **Create**, and Create to save your changes (and create the policy).

### Assign the policy in Endpoint Manager

1. In Microsoft Endpoint Manager admin center, open the policy you created in the previous step, select **Properties**.

1. Under the Assignments section, select **Edit**.

1. Select **Assignments**.

1. Include or exclude your Azure AD groups to assign them the policy.

1. To deploy the policy to the groups, select **Review + Save** and then select **Save**. The user devices targeted by the policy are evaluated for compliance.

### Create an Azure AD Conditional Access policy

1. In the Azure portal, select **Azure AD Conditional Access** from the Services menu, and select the drop-down **+ New policy**, and then select **Create new policy**.

1. Enter a policy Name, and select **Users or workload entities**. Use the Include or Exclude options to add your groups for the policy.

1. In the **Cloud apps or actions** area choose which apps to protect. For example, choose Select apps, and select Office 365 SharePoint Online and Office 365 Exchange Online.

1. In the Conditions area, select to apply the policy to Client apps and browsers.  When complete select **done**.

1. In the Grant area, apply Conditional Access based on device compliance. For example, select **Grant access > Require device to be marked as compliant**. Choose **Select** to save your changes.

1. Select **Enable policy** choice, and then **Create** to save your changes.

