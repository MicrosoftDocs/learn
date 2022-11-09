To allow inbound network traffic for RDP Shortpath, use the Microsoft Defender Firewall with Advanced Security node in the Group Policy Management MMC snap-in to create firewall rules.

1.  Open the Group Policy Management Console to Microsoft Defender Firewall with Advanced Security.
2.  In the navigation pane, select **Inbound Rules**.
3.  Select **Action**, and then select **New rule**.
4.  On the **Rule Type** page of the New Inbound Rule Wizard, select **Custom**, and then select **Next**.
5.  On the **Program** page, select This program path, enter **%SystemRoot%\\system32\\svchost.exe**, then select **Next**.
6.  On the **Protocol and Ports** page, select the UDP protocol type. In the **Local por**t, select **Specific ports** and enter the configured UDP port. If you've left the default settings on, the port number will be **3390**.
7.  On the **Scope** page, you can specify that the rule applies only to network traffic to or from the IP addresses entered on this page. Configure as appropriate for your design, and then select **Next**.
8.  On the **Action** page, select **Allow the connection**, and then select **Next**.
9.  On the **Profile** page, select the network location types to which this rule applies, and then select **Next**.
10. On the **Name** page, enter a name and description for your rule, then select **Finish**.

When you're done, verify that the new rule matches the format as seen below.

:::image type="content" source="../media/shortpath-firewall-general-tab-0df2a5e5.png" alt-text="Sreenshot showing the General tab for Firewall configuration for RDP Shortpath Network Connections with Allow the connection option selected.":::


:::image type="content" source="../media/shortpath-firewall-service-settings-830fc8a8.png" alt-text="Screenshot showing the Programs and Services tab for Firewall configuration for RDP Shortpath Network Connections.":::


:::image type="content" source="../media/shortpath-firewall-protocol-and-ports-c2ff55a6.png" alt-text="Screenshot showing the Protocols and Ports tab for Firewall configuration for RDP Shortpath.":::


You can also use PowerShell to configure Windows Firewall:

```powershell
New-NetFirewallRule -DisplayName 'Remote Desktop - Shortpath (UDP-In)'  -Action Allow -Description 'Inbound rule for the Remote Desktop service to allow RDP traffic. [UDP 3390]' -Group '@FirewallAPI.dll,-28752' -Name 'RemoteDesktop-UserMode-In-Shortpath-UDP'  -PolicyStore PersistentStore -Profile Domain, Private -Service TermService -Protocol udp -LocalPort 3390 -Program '%SystemRoot%\system32\svchost.exe' -Enabled:True
```
