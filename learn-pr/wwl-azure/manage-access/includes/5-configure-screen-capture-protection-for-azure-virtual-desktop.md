The screen capture protection feature prevents sensitive information from being captured on the client endpoints. When you enable this feature, remote content will be automatically blocked or hidden in screenshots and screen shares. Also, the Remote Desktop client will hide content from malicious software that may be capturing the screen.

Screen capture protection is configured on the session host level and enforced on the client. Only clients that support this feature can connect to the remote session. Following clients currently support screen capture protection:

 -  Windows Desktop client supports screen capture protection for full desktops only.
 -  macOS client version 10.7.0 or later supports screen capture protection for both RemoteApp and full desktops.

## Configure screen capture protection

1.  To configure screen capture protection, you need to install administrative templates that add rules and settings for Azure Virtual Desktop.
2.  Download the [Azure Virtual Desktop policy templates file](https://aka.ms/avdgpo) (AVDGPTemplate.cab) and extract the contents of the cab file and zip archive.
3.  Copy the *terminalserver-avd.admx* file to *%windir%\\PolicyDefinitions* folder.
4.  Copy the *en-us\\terminalserver-avd.adml* file to *%windir%\\PolicyDefinitions\\en-us* folder.
5.  To confirm the files copied correctly, open the Group Policy Editor and navigate to **Computer Configuration** \-&gt; **Administrative Templates** \-&gt; **Windows Components** \-&gt; **Remote Desktop Services** \-&gt; **Remote Desktop Session Host** \-&gt; **Azure Virtual Desktop.**
6.  You should see one or more Azure Virtual Desktop policies, as shown below.:::image type="content" source="../media/see-azure-virtual-desktop-group-policy-c6c252cf.png" alt-text="View of the Azure Virtual Desktop group policies.":::
    

7.  Open the **"Enable screen capture protection"** policy and set it to **"Enabled"**.

## Considerations

 -  Screen capture protection protects the Remote Desktop window from being captured through a specific set of public operating system features and APIs. However, there's no guarantee that this feature will strictly protect content, for example, where someone takes photography of the screen.
 -  Customers should use the feature together with disabling clipboard, drive, and printer redirection. Disabling redirection will help to prevent the user from copying the captured screen content from the remote session.
 -  Users can't share the Remote Desktop window using local collaboration software, such as Microsoft Teams, when the feature is enabled. If Microsoft Teams is used, both the local Teams app and Teams running with media optimizations can't share the protected content.
