








## Initialize the Microsoft Defender for Endpoint environment


When accessing your Microsoft 365 Defender portal settings for Endpoints for the first time, you'll be able to configure many attributes. You must be a global administrator or security administrator for the tenant. On the Set-up preferences page, you can set the:

**Data storage location** - Determine where you want to be primarily hosted: US, EU, or UK. You can't change the location after this set up and Microsoft won't transfer the data from the specified geolocation.

**Data retention** - The default is six months.

**Enable preview features** - The default is on, can be changed later.

To access the Microsoft 365 Defender portal settings for Endpoints do the following action:

1. Go to ([https://security.microsoft.com](https://security.microsoft.com/?azure-portal=true))
2. Select **Settings**.
3. Select **Endpoints**.


## Network configuration

If the organization doesn't require the endpoints to use a Proxy to access the Internet, the following configuration isn't required.

The Microsoft Defender for Endpoint sensor requires Microsoft Windows HTTP (WinHTTP) to report sensor data and communicate with the Microsoft Defender for Endpoint service. The embedded Microsoft Defender for Endpoint sensor runs in the system context using the LocalSystem account. The sensor uses Microsoft Windows HTTP Services (WinHTTP) to enable communication with the Microsoft Defender for Endpoint cloud service. The WinHTTP configuration setting is independent of the Windows Internet (WinINet) internet browsing proxy settings and can only discover a proxy server by using the following discovery methods:

Autodiscovery methods:

- Transparent proxy

- Web Proxy Autodiscovery Protocol (WPAD)

If a Transparent proxy or WPAD has been implemented in the network topology, there's no need for special configuration settings.


## Onboard devices


You'll need to go to the onboarding section of the Microsoft 365 Defender portal to onboard any of the supported devices.  Depending on the device, you'll be guided with appropriate steps and provided management and deployment tool options suitable for the device.

In general, to onboard devices to the service:

- Verify that the device fulfills the minimum requirements

- Depending on the device, follow the configuration steps provided in the onboarding section of the Microsoft 365 Defender portal

- Use the appropriate management tool and deployment method for your devices

- Run a detection test to verify that the devices are properly onboarded and reporting to the service

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4bGqr?rel=0]

In Settings, Endpoints, Device management, Onboarding select operating system dropdown to see the supported options.

:::image type="content" source="../media/onboarding.png" alt-text="Screenshot of the Supported Operating Systems dropdown." lightbox="../media/onboarding.png":::

After you select the appropriate operating system option, the supported deployment options are outlined.   Here's a list of the Windows 10 supported deployment options:

- Local script (for up to 10 devices)

- Group Policy

- Microsoft Endpoint Configuration Manager current branch and later

- Mobile Device Management (including Microsoft Intune)

- VDI onboarding script for non-persistent devices

:::image type="content" source="../media/onboard-deployment.png" alt-text="Screenshot of the device onboarding Deployment methods." lightbox="../media/onboard-deployment.png":::

As you can see, there are many configuration options.  

## Offboarding devices

In Settings, Endpoints, Device Management, Offboarding, select operating system dropdown to see the direction to offboard devices.

