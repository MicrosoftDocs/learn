Now that you understand the benefits of integrating Microsoft Defender XDR with Microsoft Sentinel, and know the capability differences, you can onboard Microsoft Sentinel to Microsoft Defender XDR.

But, before you begin, make sure you have completed the following steps and have the resources and access required.

## Prerequisites

The Microsoft Defender portal supports a single Microsoft Entra tenant and the connection to a primary workspace and multiple secondary workspaces. In the context of this article, a workspace is a Log Analytics workspace with Microsoft Sentinel enabled.

To onboard and use Microsoft Sentinel in the Microsoft Defender portal, you must have the following resources and access:

- A Log Analytics workspace that has Microsoft Sentinel enabled
- The data connector for Microsoft Defender XDR (formerly named Microsoft 365 Defender) enabled in Microsoft Sentinel for incidents and alerts. For more information, see [Connect data from Microsoft Defender XDR to Microsoft Sentinel](/azure/sentinel/connect-microsoft-365-defender).
- Access to Microsoft Defender XDR in the Defender portal
- Microsoft Defender XDR onboarded to the Microsoft Entra tenant
- An Azure account with the appropriate roles to onboard, use, and create support requests for Microsoft Sentinel in the Defender portal. The following table highlights some of the key roles needed.

|Task |Azure built-in role required |Scope  |
  |---------|---------|---------|
  |Connect or disconnect a workspace with Microsoft Sentinel enabled|[Owner](/azure/role-based-access-control/built-in-roles#owner) or </br>[User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) and [Microsoft Sentinel Contributor](/azure/role-based-access-control/built-in-roles#microsoft-sentinel-contributor) |- Subscription for Owner or User Access Administrator roles </br></br>- Subscription, resource group, or workspace resource for Microsoft Sentinel Contributor |
  |View Microsoft Sentinel in the Defender portal|[Microsoft Sentinel Reader](/azure/role-based-access-control/built-in-roles#microsoft-sentinel-reader) |Subscription, resource group, or workspace resource  |
  |Query Sentinel data tables or view incidents  |[Microsoft Sentinel Reader](/azure/role-based-access-control/built-in-roles#microsoft-sentinel-reader) or a role with the following actions:</br>- Microsoft.OperationalInsights/workspaces/read</br>- Microsoft.OperationalInsights/workspaces/query/read</br>- Microsoft.SecurityInsights/Incidents/read</br>- Microsoft.SecurityInsights/incidents/comments/read</br>- Microsoft.SecurityInsights/incidents/relations/read</br>- Microsoft.SecurityInsights/incidents/tasks/read|Subscription, resource group, or workspace resource       |
  |Take investigative actions on incidents |[Microsoft Sentinel Contributor](/azure/role-based-access-control/built-in-roles#microsoft-sentinel-contributor) or a role with the following actions:</br>- Microsoft.OperationalInsights/workspaces/read</br>- Microsoft.OperationalInsights/workspaces/query/read</br>- Microsoft.SecurityInsights/incidents/read</br>- Microsoft.SecurityInsights/incidents/write</br>- Microsoft.SecurityInsights/incidents/comments/read</br>- Microsoft.SecurityInsights/incidents/comments/write</br>- Microsoft.SecurityInsights/incidents/relations/read</br>- Microsoft.SecurityInsights/incidents/relations/write</br>- Microsoft.SecurityInsights/incidents/tasks/read</br>- Microsoft.SecurityInsights/incidents/tasks/write    |Subscription, resource group, or workspace resource  |
  |Create a support request |[Owner](/azure/role-based-access-control/built-in-roles#owner) or </br> [Contributor](/azure/role-based-access-control/built-in-roles#contributor) or </br> [Support request contributor](/azure/role-based-access-control/built-in-roles#support-request-contributor) or  a custom role with Microsoft.Support/*|Subscription  |

  After you connect Microsoft Sentinel to the Defender portal, your existing Azure role-based access control (RBAC) permissions allow you to work with the Microsoft Sentinel features that you have access to. Continue to manage roles and permissions for your Microsoft Sentinel users from the Azure portal. Any Azure RBAC changes are reflected in the Defender portal. For more information about Microsoft Sentinel permissions, see [Roles and permissions in Microsoft Sentinel | Microsoft Learn](/azure/sentinel/roles) and [Manage access to Microsoft Sentinel data by resource | Microsoft Learn](/azure/sentinel/resource-context-rbac).

## Onboard Microsoft Sentinel

To connect a workspace that has Microsoft Sentinel enabled to Defender XDR, complete the following steps:

> [!IMPORTANT]
> Before you connect your workspace, make sure you've installed the **Microsoft Defender XDR** solution for Microsoft Sentinel from the **Content hub**. And then, enabled the **Microsoft Defender XDR** data connector to collect incidents and alerts.

:::image type="content" source="../media/defender-xdr-connect-sentinel-workspace.png" alt-text="Screen shot of the Get your SIEM and XDR in one place banner message." lightbox="../media/defender-xdr-connect-sentinel-workspace.png":::

1. Go to the [Microsoft Defender portal](https://security.microsoft.com/) and sign in.
1. In Microsoft Defender XDR, select **Home** (Overview).
1. Select **Connect a workspace** in the *Get your SIEM and XDR in one place* banner.
1. Choose the workspace you want to connect and select **Next**.
1. Read and understand the product changes associated with connecting your workspace. These changes include:

   - Log tables, queries, and functions in the Microsoft Sentinel workspace are also available in advanced hunting within Defender XDR.
   - The Microsoft Sentinel Contributor role is assigned to the Microsoft Threat Protection and WindowsDefenderATP apps within the subscription.
   - Active [Microsoft security incident creation rules](/azure/sentinel/threat-detection#microsoft-security-rules) are deactivated to avoid duplicate incidents. This change only applies to incident creation rules for Microsoft alerts and not to other analytics rules.
   - All alerts related to Defender XDR products are streamed directly from the main Defender XDR data connector to ensure consistency. Make sure you have incidents and alerts from this connector turned on in the workspace.

1. Select **Connect**.

After your workspace is connected, the banner on the **Home** (Overview) page shows that your unified security information and event management (SIEM) and extended detection and response (XDR) is ready. The **Home** page is updated with new sections that include metrics from Microsoft Sentinel like the number of data connectors and automation rules.

:::image type="content" source="../media/onboarded-defender-portal.png" alt-text="Screen shot of Microsoft Sentinel onboarded to Defender XDR." lightbox="../media/onboarded-defender-portal.png":::

## Offboard Microsoft Sentinel

You can only have one workspace connected to the Defender portal at a time. If you want to connect to a different workspace that has Microsoft Sentinel enabled, disconnect the current workspace and connect the other workspace.

1. Go to the [Microsoft Defender portal](https://security.microsoft.com/) and sign in.
1. In the Defender portal, under **System**, select **Settings** > **Microsoft Sentinel**.
1. On the **Workspaces** page, select the connected workspace and **Disconnect workspace**.
1. Provide a reason why you're disconnecting the workspace. 
1. Confirm your selection.

   When your workspace is disconnected, the **Microsoft Sentinel** section is removed from the left-hand side navigation of the Defender portal. Data from Microsoft Sentinel is no longer included on the Overview page.

If you want to connect to a different workspace, from the **Workspaces** page, select the workspace and **Connect a workspace**.
