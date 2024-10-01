### Microsoft Tunnel for Mobile Application Management (MAM) in the Microsoft Intune Suite

The **Microsoft Tunnel** is a powerful VPN gateway solution integrated within the **Microsoft Intune Suite**, designed to provide secure access to on-premises resources from mobile devices. By using **Microsoft Tunnel**, IT administrators can create a secure connection for mobile users, enabling them to access corporate apps and resources without requiring full device enrollment, making it useful for **BYOD** (Bring Your Own Device) scenarios.

As organizations shift towards remote and hybrid work, employees increasingly access corporate resources from various locations and devices. **Microsoft Tunnel** enables IT administrators to provide secure remote access to internal company resources while maintaining a high level of security and management control. This is especially beneficial in environments where employees are using personal devices, as it allows them to securely connect to internal applications without requiring full device control.

## Platform requirements and feature overview

Before you begin, you must already have deployed the Microsoft Tunnel gateway. To learn more about Microsoft Tunnel gateway and how to install and configure it,  see:

- [Learn about the Microsoft Tunnel VPN solution for Microsoft Intune](/mem/intune/protect/microsoft-tunnel-overview)
- [Identify the prerequisites to install and use the Microsoft Tunnel VPN solution for Microsoft Intune](/mem/intune/protect/microsoft-tunnel-prerequisites)
- [Install and configure Microsoft Tunnel VPN solution for Microsoft Intune](/mem/intune/protect/microsoft-tunnel-configure)

Microsoft Tunnel for MAM supports the following platforms:

- Android Enterprise version 10.0 or higher
- iOS version 14.0 or higher

### Key features of Microsoft Tunnel for MAM

- **Per-App VPN**:  
   Instead of routing all device traffic through the VPN, Microsoft Tunnel allows organizations to configure a **per-app VPN**. This means only specific apps can access corporate resources over the VPN, reducing security risks while optimizing network traffic. This is important in BYOD scenarios, where users may not want all their personal device traffic routed through the corporate network.

- **Device Flexibility**:  
   Microsoft Tunnel supports various platforms, including **iOS** and **Android**. This cross-platform support ensures that employees can access corporate resources securely, regardless of the type of mobile device they use.

- **Secure Access to On-Premises Resources**:  
   Users can securely access internal corporate applications, such as SharePoint, ERP systems, or custom apps, directly from their mobile devices. By utilizing the Tunnel, IT administrators can ensure that only authorized users and applications can reach sensitive corporate data.

- **No Full Device Enrollment Needed**:  
   Microsoft Tunnel allows companies to provide secure access to internal resources without enrolling the entire device into **Intune MDM (Mobile Device Management)**. This feature is valuable for employees using personal devices who may be hesitant to enroll their device but still need secure access to work apps.

- **Conditional Access Integration**:  
   Microsoft Tunnel integrates seamlessly with **Microsoft Entra ID** (formerly Azure Active Directory) and **Conditional Access** policies. This ensures that users and devices are verified before being granted access to the corporate network, helping maintain a **Zero Trust** security framework.

### How Microsoft Tunnel enhances IT operations

- **Enhanced Security**:  
   By using per-app VPN, Microsoft Tunnel reduces the attack surface by limiting VPN access to only specific apps that need it, thereby reducing the risk of data leakage or misuse. This improves security without compromising user experience.

- **Improved User Flexibility**:  
   Employees can work from any device and location while maintaining secure access to critical corporate resources. This is especially useful in hybrid work environments, where users may switch between personal and work devices.

A company with a global remote workforce can deploy Microsoft Tunnel to allow employees to access internal corporate applications (such as CRM systems or financial apps) securely from their personal mobile devices. With **Conditional Access** policies in place, the IT department can ensure that only compliant and authorized devices connect to the corporate network, while limiting access to specific apps, ensuring corporate data is protected even on personal devices.

## Try the interactive demos

Try the following interactive demos to discover how Tunnel for MAM extends Microsoft Tunnel VPN Gateway to support Android and iOS devices that aren't enrolled with Intune.

- [Microsoft Tunnel for Mobile Application Management for Android]( https://regale.cloud/Microsoft/viewer/1896/microsoft-tunnel-for-mobile-application-management-for-android/index.html#/0/0)
- [Microsoft Tunnel for Mobile Application Management for iOS/iPadOS]( https://regale.cloud/Microsoft/viewer/1976/microsoft-tunnel-for-mobile-application-management-for-ios-ipados/index.html#/0/0)

