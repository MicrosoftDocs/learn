
The Windows Assessment and Deployment Kit (Windows ADK) includes a tool called Windows Configuration Designer, which you can use to create provisioning packages.

:::image type="content" source="../media/windows-configuration-designer-interface-f5f579a4.png" alt-text="Screenshot of the Windows Configuration Designer. Shows Project1 open with the Computer Account option in the left view.":::


You can use the Windows Configuration Designer wizards to configure the following settings:

| Step                              | Description                                                                                                                                                                | Desktop wizard | Mobile wizard | Kiosk wizard |
|:-----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------:|:---------------:|:--------------:|
| Set up device                     | Assign a device name, enter the product key to upgrade Windows, configure shared use, and remove preinstalled software                                                     | Yes            | Only device name and upgrade key | Yes          |
| Set up network                    | Connect to a wireless network                                                                                                                                              | Yes            | Yes           | Yes          |
| Account management                | Enroll the device in Active Directory Domain Services (AD DS), enroll the device in Microsoft Entra ID, or create a local administrator account                                     | Yes            | \-            | Yes          |
| Bulk enrollment in Microsoft Entra ID       | Enroll the device in Microsoft Entra ID before you use a Windows Configuration Designer wizard                                                                                     | \-             | Yes           | \-           |
| Add applications                  | Install applications by using the provisioning package                                                                                                                   | Yes            | \-            | Yes          |
| Add certificates                  | Include a certificate file in the provisioning package                                                                                                                   | Yes            | \-            | Yes          |
| Configure kiosk account and app   | Create a local account to run the kiosk mode app, and specify the app to run in kiosk mode                                                                               | \-             | \-            | Yes          |
| Configure kiosk common settings   | Set tablet mode, configure welcome and shutdown screens, and turn off timeout settings                                                                                    | \-             | \-            | Yes          |



You can apply a provisioning package during Windows 11 deployment or after the OS installation.

<a name='azure-ad-join-with-automatic-mdm-enrollment'></a>

### Microsoft Entra join with automatic MDM enrollment

The Azure AD/MDM dynamic provisioning method is also cloud-driven and is also based on Microsoft Entra ID P1 or P2 and Microsoft Intune. After you enroll a device in Intune MDM, the MDM enforces compliance with your corporate policies, adds or removes apps, and much more. In addition, the MDM can report a device’s compliance with Microsoft Entra ID; this enables Microsoft Entra ID to allow access to corporate resources or applications secured by Microsoft Entra-only to devices that comply with policies.

Using Azure AD/MDM, you can:

 -  Join devices to Microsoft Entra ID automatically
 -  Auto-enroll your users’ devices into MDM services
 -  Configure the joined devices by using MDM policies

The requirements for implementing the Azure AD/MDM deployment model are:

 -  Windows 10/11 Pro or Enterprise edition
 -  An instance of Microsoft Entra ID for identity management
 -  An appropriate MDM, such as Microsoft Intune
