Before you begin setting up Microsoft Intune, you can review the device platforms and operating systems that are supported by Intune. Additionally, you can learn which web browsers are supported when accessing Intune using Microsoft Endpoint Manager admin center. Also, you should be familiar with the network bandwidth requirements to perform installations and updates using Intune.

## Intune supported operating systems

You can manage devices running operating systems on the following platforms:
- Apple iOS/iPadOS
- macOS
- Android
- Android Enterprise
- Surface Hub
- Windows operating systems

For more information about Intune supported devices, platforms, and operating systems, see [Intune supported operating systems](/mem/intune/fundamentals/supported-devices-browsers?azure-portal=true#intune-supported-operating-systems).

## Intune supported web browsers

Different administrative tasks require that you use one of the following administrative websites when working with Intune:

- [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431)
- [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?LinkId=698854)
- [Azure Active Directory admin center](https://aad.portal.azure.com)

The following browsers are supported for these portals:

- Microsoft Edge (latest version)
- Microsoft Internet Explorer 11
- Safari (latest version, Mac only)
- Chrome (latest version)
- Firefox (latest version)

## Intune network configuration requirements

It is important to understand that there are different bandwidth requirements for your Intune deployments. To ensure devices receive the updates and content from Intune, they must periodically connect to the Internet. The time required to receive updates or content can vary, but they should remain continuously connected to the Internet for at least one hour each day.

**Content requiring a single installation:**

- Intune client installation
- Client enrollment package
- Endpoint Protection agent
- Operations Manager agent
- Policy agent
- Remote Assistance via Microsoft Easy Assist agent

**Content requiring daily updates:**
- Daily client operations
- Endpoint Protection malware definition updates

**Content requiring monthly updates:**
- Endpoint Protection engine update
- Software updates

Other content updates vary. For instance, content related to service packs and software distribution will vary depending on when you deploy service packs and software. For more information, see Intune's [average network traffic](/mem/intune/fundamentals/network-bandwidth-use?azure-portal=true#average-network-traffic).

## Intune bandwidth considerations

If bandwidth is a concern, you do have ways to reduce bandwidth that your tenant uses. For instances, you can do any of the following to reduce bandwidth:

- **Use a proxy server to cache content requests:**<br>
    A proxy server can cache content to reduce duplicate downloads and reduce network bandwidth from content from the Internet. For related information, see [Use a proxy server to cache content requests](/mem/intune/fundamentals/network-bandwidth-use?azure-portal=true#use-a-proxy-server-to-cache-content-requests).
 
- **Delivery Optimization:**<br>
    Delivery Optimization lets you use Intune to reduce bandwidth consumption when your Windows 10/11 devices download applications and updates. For related information, see [Delivery Optimization](/mem/intune/fundamentals/network-bandwidth-use?azure-portal=true#delivery-optimization).

- **Background Intelligent Transfer Service (BITS) and BranchCache:**<br>
    You can use Microsoft Intune to manage Windows PCs either as [mobile devices with mobile device management (MDM)](/mem/intune/enrollment/windows-enroll?azure-portal=true) or as computers with the Intune software client. Microsoft recommends that you use the MDM management solution whenever possible. For more information, see [Background Intelligent Transfer Service (BITS) and BranchCache](/mem/intune/fundamentals/network-bandwidth-use?azure-portal=true#background-intelligent-transfer-service-bits-and-branchcache).
   
## Learn more

For more information, see [Intune network configuration requirements and bandwidth](/mem/intune/fundamentals/network-bandwidth-use?azure-portal=true#ways-to-reduce-network-bandwidth-use).