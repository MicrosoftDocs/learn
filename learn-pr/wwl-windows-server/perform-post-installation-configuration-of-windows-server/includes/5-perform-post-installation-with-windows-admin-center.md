In the past, managing and administrating the IT environment at Contoso involved using different tools across multiple consoles. Windows Admin Center combines those tools into a single console that you can easily deploy and access through a web interface.  

## Overview

You can also use Windows Admin Center to perform post-installation configuration. The process begins when you add the newly deployed server to the Windows Admin Center console.

:::image type="content" source="../media/m3-windows-admin-center-1.png" alt-text="A screenshot of Windows Admin Center. The administrator has added and selected a newly deployed server. The Overview page is displayed.":::

### Authenticate to the target server

When you connect to a remote computer, you must authenticate to that computer. If the computer you want to manage with Windows Admin Center is part of the same AD DS forest, Kerberos authentication is used.

Where this isn't the case, you must configure the target computers as trusted hosts. For example, you use a workgroup computer installed with Windows Admin Center to administer your domain computers.

> [!IMPORTANT]
> When you install Windows Admin Center on a workgroup computer, you are prompted to allow Windows Admin Center to manage the local computer's TrustedHosts setting.  If you bypass this automated setting, you must configure TrustedHosts manually.

You can configure trusted hosts settings by using the following Windows PowerShell command in an elevated Windows PowerShell window. You can specify the remote hosts by IP, FQDN, or NetBIOS name.

```PowerShell
Set-Item WSMan:localhost\Client\TrustedHosts -Value 'SEA-DC1.Contoso.com'
```

### Connect to the target server

To connect to a server in Windows Admin Center, you must first add it. To do this, use the following procedure:

1. Open **Microsoft Edge** and navigate to the **Windows Admin Center** site.
2. Authenticate to the Windows Admin Center site, if needed.
3. On the **All connections** page, select **Add**.
4. On the **Add resources** blade, in the **Windows Server** section, select **Add**.
5. In the **Server name** box, enter the name of the target server and select **Add**.
6. In the **Credentials needed** section, select **Use another account for this connection**, and then enter the credentials to connect to the server.

    > [!TIP]
    > It's likely the user account name will be **.\Administrator**, using whatever password you assigned during installation.

7. Select **Add with credentials**. Your server is added to the All connections list.
8. Select the new server in the **All connections** list.

## Perform post-installation configuration

After you've added and connected to your newly deployed server, you can use Windows Admin Center to make the required configuration changes. Start by updating the computer's name and domain membership.

1. From the **Overview** tab, select the **Edit computer ID** button in the **Overview** pane.
2. On the **Edit computer ID** blade, enter the new computer name and then select **Domain**.
3. Enter the domain name, and then select **Next**.

:::image type="content" source="../media/m3-windows-admin-center-2.png" alt-text="A screenshot of Windows Admin Center. The Overview page is displayed, along with the Edit computer ID blade. The administrator has updated the computer name and domain name.":::

4. On the **Update computer name and domain** blade, enter the credentials of an account in the domain that has rights to add computers to the domain.
5. Select the **Restart immediately** check box, and select **Save**. The computer restarts.

> [!TIP]
> You might need to add the computer to Windows Admin Center using its new name. You'll also need to specify new credentials appropriate to the computer's domain membership.

After you have added the computer to the domain, you can perform additional administrative tasks in your usual way using Server Manager, Windows PowerShell, or RSAT. You can, of course, continue with Windows Admin Center.

For example, to use Windows Admin Center to add roles or features:

1. Select the **Roles & features** link in the navigation pane.
2. In the **Roles and features** pane, select the required role. For example, select **DHCP Server**, and then select **Install**.
3. On the **Install Roles and Features** blade, select **Yes**.

If you want to use Windows PowerShell remoting, in the navigation pane, select **PowerShell**. After a moment, a remote session is established to the selected server. You'll need to authenticate the connection. Then you can use the appropriate PowerShell commands to complete post-installation configuration.

> [!TIP]
> Of course, you can use Windows PowerShell remoting without opening the Windows Admin Center, first.
