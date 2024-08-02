This unit describes issues you may experience with the [Remote Desktop client for Windows](/azure/virtual-desktop/users/connect-windows?toc=/azure/virtual-desktop/toc.json) when connecting to Azure Virtual Desktop and how to fix them.

### You don't see the expected resources

If you don't see the remote resources you're expecting to see in the app, check the account you're using. If you've already signed in with a different account than the one you want to use for Azure Virtual Desktop, you should first sign out, then sign in again with the correct account. If you're using the Remote Desktop Web client, you can use an InPrivate browser window to try a different account.

If you're using the correct account, make sure your application group is associated with a workspace.

### Your account is configured to prevent you from using this device

If you come across an error saying **Your account is configured to prevent you from using this device. For more information, contact your system administrator**, ensure the user account was given the [Virtual Machine User Login role](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows#azure-role-not-assigned) on the VMs.

### The user name or password is incorrect

If you can't sign in and keep receiving an error message that says your credentials are incorrect, first make sure you're using the right credentials. If you keep seeing error messages, check to make sure you've fulfilled the following requirements:

 -  Have you assigned the **Virtual Machine User Login** role-based access control (RBAC) permission to the virtual machine (VM) or resource group for each user?
 -  Does your Conditional Access policy exclude multifactor authentication requirements for the **Azure Windows VM sign-in** cloud application?

If you've answered no to either of those questions, you'll need to reconfigure your multifactor authentication. To reconfigure your multifactor authentication, follow the instructions in [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Acces](/azure/virtual-desktop/set-up-mfa#azure-ad-joined-session-host-vms)ge.

If you have [integrated Microsoft Entra logs with Azure Monitor logs](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs) to access your Microsoft Entra sign-in logs through Log Analytics, you can see if you've enabled multifactor authentication and which Conditional Access policy is triggering the event. The events shown are non-interactive user login events for the VM, which means the IP address will appear to come from the external IP address from which your VM accesses Microsoft Entra ID.

You can access your sign-in logs by running the following Kusto query:

let UPN = "useru`pn"; AADNonInteractiveUserSignInLogs | where UserPrincipalName == UPN | where AppId == "372140e0-b3b7-4226-8ef9-d57986796201" | project ['Time']=(TimeGenerated), UserPrincipalName, AuthenticationRequirement, ['MFA Result']=ResultDescription, Status, ConditionalAccessPolicies, DeviceDetail, ['Virtual Machine IP']=IPAddress, ['Cloud App']=ResourceDisplayName | order by ['Time'] d`esc

### Retrieve and open client logs

You might need the client logs when investigating a problem.

To retrieve the client logs:

1.  Ensure no sessions are active and the client process isn't running in the background by right-clicking on the **Remote Desktop** icon in the system tray and selecting **Disconnect all sessions**.
2.  Open **File Explorer**.
3.  Navigate to the **%temp%\\DiagOutputDir\\RdClientAutoTrace** folder.

The logs are in the.ETL file format. You can convert to .CSV or .XML to make them easily readable by using the tracerpt command. Find the name of the file you want to convert and make a note of it.

To convert the .ETL file to .CSV, open PowerShell and run the following, replacing the value for $filename with the name of the file you want to convert (without the extension) and $outputFolder with the directory in which to create the .CSV file.

```powershell
$filename = "<filename>"
$outputFolder = "C:\Temp"
cd $env:TEMP\DiagOutputDir\RdClientAutoTrace
tracerpt "$filename.etl" -o "$outputFolder\$filename.csv" -of csv
```

To convert the .ETL file to .XML, open Command Prompt or PowerShell and run the following, replacing &lt;filename&gt; with the name of the file you want to convert and $outputFolder with the directory in which to create the .XML file.

```powershell
$filename = "<filename>"
$outputFolder = "C:\Temp"
cd $env:TEMP\DiagOutputDir\RdClientAutoTrace
tracerpt "$filename.etl" -o "$outputFolder\$filename.xml"
```

### Client stops responding or can't be opened

If the Remote Desktop client for Windows or Azure Virtual Desktop Store app for Windows stops responding or can't be opened, you may need to reset user data. If you can open the client, you can reset user data from the **About** menu, or if you can't open the client, you can reset user data from the command line. The default settings for the client will be restored and you'll be unsubscribed from all workspaces.

To reset user data from the client:

1.  Open the **Remote Desktop** app on your device.
2.  Select the three dots at the top right-hand corner to show the menu, then select **About**.
3.  In the section **Reset user data**, select **Reset**. To confirm you want to reset your user data, select **Continue**.

To reset user data from the command line:

1.  Open PowerShell.
2.  Change the directory to where the Remote Desktop client is installed, by default is `C:\Program Files\Remote Desktop`.
3.  Run the following command to reset user data. You'll be prompted to confirm you want to reset your user data.
    
    ```powershell
    .\msrdcw.exe /reset
    ```

You can also add the /f option, where your user data will be reset without confirmation:

### Your administrator may have ended your session

You see the error message **Your administrator may have ended your session. Try connecting again. If this does not work, ask your administrator or technical support for help**, when the policy setting **Allow users to connect remotely using Remote Desktop Services** has been set to disabled.

To configure the policy to enable users to connect again depending on whether your session hosts are managed with Group Policy or Intune.

For Group Policy:

1.  Open the **Group Policy Management Console (GPMC)** for session hosts managed with Active Directory or the **Local Group Policy Editor console** and edit the policy that targets your session hosts.
2.  Browse to **Computer Configuration &gt; Administrative Templates &gt; Windows Components &gt; Remote Desktop Services &gt; Remote Desktop Session Host &gt; Connections**
3.  Set the policy setting **Allow users to connect remotely using Remote Desktop Services** to **Enabled**.

For Intune:

1.  Open the **Settings catalog**.
2.  Browse to **Computer Configuration &gt; Administrative Templates &gt; Windows Components &gt; Remote Desktop Services &gt; Remote Desktop Session Host &gt; Connections**
3.  Set the policy setting **Allow users to connect remotely using Remote Desktop Services** to **Enabled**.

## Authentication and identity

In this section you'll find troubleshooting guidance for authentication and identity issues with the Remote Desktop client.

### The logon attempt failed

If you come across an error saying **The logon attempt failed** on the Windows Security credential prompt, verify the following:

 -  You're using a device that is Microsoft Entra joined or Microsoft Entra hybrid joined to the same Microsoft Entra tenant as the session host.
 -  The [PKU2U protocol is enabled](/windows/security/threat-protection/security-policy-settings/network-security-allow-pku2u-authentication-requests-to-this-computer-to-use-online-identities) on both the local PC and the session host.
 -  [Per-user multifactor authentication is disabled](/azure/virtual-desktop/set-up-mfa#azure-ad-joined-session-host-vms) for the user account as it's not supported for Microsoft Entra joined VMs.

### The sign-in method you're trying to use isn't allowed

If you come across an error saying **The sign-in method you're trying to use isn't allowed. Try a different sign-in method or contact your system administrator**, you have Conditional Access policies restricting access. Follow the instructions in [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Access](/azure/virtual-desktop/set-up-mfa#azure-ad-joined-session-host-vms) to enforce Microsoft Entra multifactor authentication for your Microsoft Entra joined VMs.

### A specified logon session does not exist. It may already have been terminated.

If you come across an error that says, **An authentication error occurred. A specified logon session doen't exist. It may already have been terminated**, verify that you properly created and configured the Kerberos server object when [configuring single sign-on](/azure/virtual-desktop/configure-single-sign-on).

### Authentication issues while using an N SKU of Windows

Authentication issues can happen because you're using an *N* SKU of Windows on your local device without the *Media Feature Pack*. For more information and to learn how to install the Media Feature Pack, see [Media Feature Pack list for Windows N edit](https://support.microsoft.com/topic/media-feature-pack-list-for-windows-n-editions-c1c6fffa-d052-8338-7a79-a4bb980a700a) 'DWORD' -Force

## Issue isn't listed here

If your issue isn't listed here, see [Troubleshooting overview, feedback, and support for Azure Virtual Desktop](/azure/virtual-desktop/troubleshoot-set-up-overview) for information about how to open an Azure support case for Azure Virtual Desktop.
