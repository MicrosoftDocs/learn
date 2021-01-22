When accessing your Microsoft Defender Security Center ([https://securitycenter.windows.com](https://securitycenter.windows.com/?azure-portal=true)) for the first time, a wizard will guide you through some initial steps. You must be a global administrator or security administrator for the tenant. On the Set up preferences page, you can set the:

**Data storage location** - Determine where you want to be primarily hosted: US, EU, or UK. You cannot change the location after this set up and Microsoft will not transfer the data from the specified geolocation.

**Data retention** - The default is six months.

**Enable preview features** - The default is on, can be changed later.

At the end of the setup wizard, there will be a dedicated cloud instance of Defender for Endpoint created.

## Network configuration

If the organization does not require the endpoints to use a Proxy to access the Internet, the following configuration is not required.

The Microsoft Defender for Endpoint sensor requires Microsoft Windows HTTP (WinHTTP) to report sensor data and communicate with the Microsoft Defender for Endpoint service. The embedded Microsoft Defender for Endpoint sensor runs in the system context using the LocalSystem account. The sensor uses Microsoft Windows HTTP Services (WinHTTP) to enable communication with the Microsoft Defender for Endpoint cloud service. The WinHTTP configuration setting is independent of the Windows Internet (WinINet) internet browsing proxy settings and can only discover a proxy server by using the following discovery methods:

Autodiscovery methods:

- Transparent proxy

- Web Proxy Autodiscovery Protocol (WPAD)

If a Transparent proxy or WPAD has been implemented in the network topology, there is no need for special configuration settings.



