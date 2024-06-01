Many systems have a mixture of Azure and on-premises and use a hybrid identity solution. Microsoft Entra Connect is an on-premises application that synchronizes Microsoft Entra ID with on-premises Active Directory.

Determine why on-premises systems cannot connect to Microsoft Entra resources

To troubleshoot Microsoft Entra Connect, you should use the Microsoft Entra Connect Health portal at [Microsoft Entra Connect Health](https://portal.azure.com/) to view performance monitors and alerts.

:::image type="content" source="../media/3-connect-health.png" alt-text="Screen shot of the Microsoft Entra Connect Health screen.":::

You can also install the Microsoft Entra Connect Administration Agent on a Microsoft Entra Connect server. The Microsoft Entra Connect Administration Agent presents diagnostic data to Microsoft support engineers. Microsoft Entra Connect Administration Agent is not installed by default and doesn’t store any data. It is specifically intended for live troubleshooting. You can disable the reporting of data by the Microsoft Entra Connect Administration Agent if you edit the service config file. For more information on the Microsoft Entra Connect Administration Agent and how to install and disable it, see [What is the Microsoft Entra Connect Admin Agent](/azure/active-directory/hybrid/whatis-aadc-admin-agent).

To troubleshoot connectivity issues, you should install Microsoft Entra Connect Health agents. There are Microsoft Entra Connect Health agents for AD FS, Azure ADFS, and Sync. For detailed steps on installing the Microsoft Entra Connect Health agents, see [Microsoft Entra Connect Health agent installation](/azure/active-directory/hybrid/how-to-connect-health-agent-install).

To troubleshoot connectivity issues, you must first have installed AD Connect in your on-premises environment. For more information on installing Microsoft Entra Connect, see [Microsoft Entra Connect and Microsoft Entra Connect Health installation roadmap](/azure/active-directory/hybrid/how-to-connect-install-roadmap).

## Troubleshoot pass-through authentication and password hash sync issues

To troubleshoot pass-through authentication, you should first check that it is enabled and that the authentication agents are **Active**. To view the status, go to **Microsoft Entra Admin** Center and select **Microsoft Entra Connect**.

:::image type="content" source="../media/3-azure-active-directory-connect.png" alt-text="Screenshot of Microsoft Entra admin center - Microsoft Entra Connect blade.":::

You should then check if the user is getting errors, or if errors are reported in the **Microsoft Entra admin center**. For more information, see [Troubleshoot Microsoft Entra pass-through authentication](/azure/active-directory/hybrid/tshoot-connect-pass-through-authentication).

Troubleshooting password hash synchronization with Microsoft Entra Connect Sync depends on the version you use. There are different steps depending on whether one or many objects have password synchronization issues. Detailed steps for each scenario are available at [Troubleshoot password hash synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization).

<a name='review-and-resolve-object-synchronization-with-azure-ad-connect-sync'></a>

## Review and resolve object synchronization with Microsoft Entra Connect Sync

To resolve object sync issues, start by running the troubleshooting task in the wizard. You should complete the following steps:

- On your Microsoft Entra Connect server, start a Windows PowerShell with the Run as Administrator option and run Set-ExecutionPolicy RemoteSigned.

- Start the Microsoft Entra Connect wizard, select **Tasks**, select **Troubleshoot** then select **Next**.

   :::image type="content" source="../media/3-azure-active-directory-additional-tasks.png" alt-text="Screenshot of troubleshoot object synchronization.":::

- Click **Launch** and type **1** to **Troubleshoot Object Synchronization**.

   :::image type="content" source="../media/3-azure-active-directory-troubleshoot-object-synchronization.png" alt-text="Screenshot of global administrator credentials.":::

For more information, see [Troubleshoot object synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-objectsync).

<a name='troubleshoot-azure-ad-application-proxy-connectivity-issues'></a>

## Troubleshoot Microsoft Entra application proxy connectivity issues

To troubleshoot Microsoft Entra application proxy connectivity issues, do the following steps:

On your on-premises Active Directory server, open the Windows Services console and ensure that the **Microsoft AAD Application Proxy Conne**ctor service is enabled and running.

To discover events that could be causing problems, open Event Viewer and look for Application Proxy connector events in **Applications and Services** **Logs** > **Microsoft** > **AadApplicationProxy** > **Connector** > **Admin**.

For more information, see [Troubleshoot Application Proxy problems and error messages](/azure/active-directory/app-proxy/application-proxy-troubleshoot).

## Troubleshoot Active Directory Domain Service

When troubleshooting Microsoft Entra ID to Active Directory Domain Service integration, you need to troubleshoot Microsoft Entra Domain Services. Common issues for Microsoft Entra Domain Services include:

- Problems enabling Microsoft Entra Domain Services.

- Microsoft Graph is disabled—this must be enabled to synchronize your Microsoft Entra tenant.

- Users in your Microsoft Entra tenant are unable to sign into the managed domain.

- There are alerts in your managed domain.

For more information, see [Common errors and troubleshooting steps for Microsoft Entra Domain Services](/azure/active-directory-domain-services/troubleshoot).
