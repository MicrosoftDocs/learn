It's important to understand that you need to enable Windows PowerShell remoting only on computers that will receive incoming connections. No configuration is necessary to enable outgoing communications, except for making sure that any local firewall will allow the outgoing traffic.

## Manually enabling PowerShell remoting

PowerShell remoting is enabled by default on Windows Server platforms. You can enable PowerShell remoting on other supported Windows versions, and you can also re-enable remoting if it becomes disabled. To manually enable Windows PowerShell remoting on a computer, run the Windows PowerShell **Enable-PSRemoting** cmdlet. This is a persistent change that you can disable later by running **Disable-PSRemoting**. Note that this task requires the privileges granted to local Administrators group.

The **Enable-PSRemoting** cmdlet performs the following operations:

1. Runs the **Set-WSManQuickConfig** cmdlet, which in turn performs the following tasks:

    - Starts the WinRM service.
    - Sets the startup type on the WinRM service to Automatic.
    - Creates a listener to accept requests on any IP address.
    - Enables a firewall exception for WS-Management communications.
    - Creates the simple-name and long-name session endpoint configurations, if needed.
    - Enables all session configurations.
    - Changes the security descriptor of all session configurations to allow remote access.

2. Restarts the WinRM service to make the preceding changes effective.

This command will fail on client computers where one or more network connections are set to Public instead of Work or Home. You can override this failure by adding the *–SkipNetworkProfileCheck* parameter. However, be aware that Windows Firewall won't allow exceptions when you're connected to a Public network.

> [!NOTE]
> The **Set-WSManQuickConfig** cmdlet doesn't affect remote endpoint configurations created by Windows PowerShell. It only affects endpoints created with PowerShell version 6 and newer. To enable and disable PowerShell remoting endpoints that are hosted by Windows PowerShell, run the **Enable-PSRemoting** cmdlet from within a Windows PowerShell session.

## Enabling remoting by using a GPO

Many organizations will prefer to centrally control Windows PowerShell remoting enablement and settings through GPOs. Microsoft supports this capability. You must set up various settings in a GPO to duplicate the steps taken by **Enable-PSRemoting**. To enable remoting by using Group Policy, you should configure the **Allow Remote Server Management Through WinRM** policy setting in the appropriate GPO. This setting also allows you to filter IP addresses from which remote connections can be initiated. In addition to configuring this policy, you should also configure appropriate firewall exceptions, as described earlier.
