When accessing your Microsoft Defender portal settings for Endpoints for the first time, you're able to configure many attributes. You must be a Security Administrator for the tenant. On the Set-up preferences page, you can set the:

> [!IMPORTANT]
> Microsoft recommends that you use roles with the fewest permissions. This helps improve security for your organization. Global Administrator is a highly privileged role that should be limited to emergency scenarios when you can't use an existing role.

**Data storage location** - Determine where you want to be primarily hosted: US, EU, or UK. You can't change the location after this is set up, and Microsoft won't transfer the data from the specified geolocation.

**Data retention** - The default is six months.

**Enable preview features** - The default is on, can be changed later.

To access the Microsoft Defender portal settings for Endpoints do the following action:

1. Go to ([https://security.microsoft.com](https://security.microsoft.com/?azure-portal=true))
2. Select **Settings**.
3. Select **Endpoints**.

:::image type="content" source="../media/screenshot-defender-xdr-settings-endpoints.png" alt-text="Screenshot of Microsoft Defender XDR Settings and Endpoints.":::

> [!NOTE]
> Your organization may have different settings displayed based on the tenant subscription and configuration.

## Network configuration

If the organization doesn't require the endpoints to use a Proxy to access the Internet, the following configuration isn't required.

The Microsoft Defender for Endpoint sensor requires Microsoft Windows HTTP (WinHTTP) to report sensor data and communicate with the Microsoft Defender for Endpoint service. The embedded Microsoft Defender for Endpoint sensor runs in the system context using the LocalSystem account. The sensor uses Microsoft Windows HTTP Services (WinHTTP) to enable communication with the Microsoft Defender for Endpoint cloud service. The WinHTTP configuration setting is independent of the Windows Internet (WinINet) internet browsing proxy settings and can only discover a proxy server by using the following discovery methods:

Autodiscovery methods:

- Transparent proxy

- Web Proxy Autodiscovery Protocol (WPAD)

If a Transparent proxy or WPAD has been implemented in the network topology, there's no need for special configuration settings.
