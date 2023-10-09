
A key task of any administrator is to protect and secure an organization's resources and data. This set of tasks is called device management. Users have many devices from which they open and share personal files, visit websites, and install apps and games. These same users are also employees and they want to use their devices to access work resources, such as email and SharePoint. Device management enables organizations to protect and secure their resources and data.

Mobile device management (MDM) is an industry standard for managing mobile devices, such as smart phones, tablets, laptops and desktop computers. As a modern desktop administrator, you need to know how to manage devices in your organization by using MDM mechanism, as there are many scenarios where on-premises solutions either can't manage or might be better suited to be managed through MDM policies than traditional methods such as Group Policies.

One point of clarification – while the term "Mobile Device Manager" is used, this term is an industry term that originated from the need to manage personal phones and tablets. As modern management focuses on a unified solution for all devices, the form factor of a device, such as a desktop or kiosk that isn't necessarily mobile, shouldn't be the determining factor in whether to manage the device using an MDM.

#### Activate MDM Services

To enable the ability to support enrollment of mobile devices, the MDM Authority must be set within the Intune configuration. This is located in the Device Enrollment section of the Microsoft Intune – Overview dashboard in the portal. The default is set to None, which means the MDM isn't configured. It must be enabled by choosing the Intune MDM Authority option.

> [!NOTE]
> Hybrid MDM with Configuration Manager is retired. While this option may still be visible for legacy implementations, new connections to Configuration Manager cannot be created. This should not be confused with Co-Management, which is different from Hybrid MDM, and still uses the Intune MDM Authority option.

:::image type="content" source="../media/intune-choose-mobile-device-management-authority-1e7c6762.png" alt-text="Screenshot of the Choose MDM Authority screen.":::


#### Configure Intune for Apple Device Support

By default, Intune is configured to allow enrollment of Windows, Android and Samsung Knox Standard devices. To manage iOS and macOS devices, an Apple MDM push certificate is also required and must be set up in Intune.

This can be configured by going to the Intune portal, and choosing **Device enrollment** \- **Apple Enrollment** \- **Apple MDM Push Certificate. In this process, you will:**

 -  Download a Certificate Signing Request (CSR)
 -  Navigate to the Apple Certificate Portal (the Intune interface provides a link)
 -  Create a certificate by uploading the CSR and then downloading the generated certificate file.
 -  Returning to the Intune Portal and uploading the certificate file.

Generating a certificate file in the Apple Certificate portal requires an Apple ID that is a member of the Apple Developer program. This should be created using an account that is authorized by your organization and a personal Apple ID should never be used.
