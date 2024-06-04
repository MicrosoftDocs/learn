

Intune Mobile Application Management (MAM) refers to the suite of Intune management features you can use to publish, push, configure, secure, monitor, and update mobile apps for your users. MAM protects an organization's data within an application by using Microsoft Intune app protection policies that help protect your company data and prevent data loss.

If you use MAM without enrollment (MAM-WE), a work or school-related app that contains sensitive data can be managed on almost any device, including personal devices in bring-your-own-device (BYOD) scenarios. Many productivity apps, such as the Microsoft Office apps, can be managed by Intune MAM.

Your employees use mobile devices for both personal and work tasks. While making sure your employees can be productive, you want to prevent data loss, intentional and unintentional. You'll also want to protect company data that is accessed from devices that aren't managed by you. You can use Intune app protection policies independent of any mobile-device management (MDM) solution. This independence helps you protect your company's data with or without enrolling devices in a device management solution. By implementing app-level policies, you can restrict access to company resources and keep data within the purview of your IT department.

Intune MAM supports two configurations:

 -  **Intune MDM + MAM:** IT administrators can only manage apps using MAM and app protection policies on devices that are enrolled with Intune MDM.
 -  **MAM without device enrollment:** MAM without device enrollment (MAM-WE) allows IT administrators to manage apps using MAM and app protection policies on devices not enrolled with Intune MDM. This means apps can be managed by Intune on devices enrolled with third-party Enterprise Mobility Management (EMM) providers. Also, apps can be managed by Intune on devices enrolled with third-party EMM providers or not enrolled with an MDM at all.

You can create mobile app management policies for Office mobile apps that connect to Microsoft 365 services. You can also protect access to Exchange on-premises mailboxes by creating Intune app protection policies for devices with Outlook for iOS and Android-enabled devices with hybrid Modern Authentication. Before using this feature, make sure you meet the Outlook for iOS and Android requirements. App protection policies aren't supported for other apps that connect to on-premises Exchange or SharePoint services.

The important benefits of using app protection policies are:

 -  **Protecting your company data at the app level**. Because mobile app management doesn't require device management, you can protect company data on both managed and unmanaged devices. The management is centered on the user identity, which removes the requirement for device management.
 -  **End-user productivity isn't affected, and policies don't apply when using the app in a personal context**. The policies are applied only in a work context, which gives you the ability to protect company data without touching personal data.

There are additional benefits to using MDM with app protection policies, and companies can use app protection policies with and without MDM at the same time. For example, consider an employee that uses both a phone issued by the company, and their own personal tablet. The company phone is enrolled in MDM and protected by app protection policies while the personal device is protected by app protection policies only. MDM makes sure that the device is protected. Some examples:

 -  You can require a PIN to access the device, or you can deploy managed apps to the device. You can also deploy apps to devices through your MDM solution, to give you more control over app management.
 -  App protection policies make sure that the app-layer protections are in place. For example, you can:
    
     -  Require a PIN to open an app in a work context
     -  Control the sharing of data between apps
     -  Prevent the saving of company app data to a personal storage location

#### Supported platforms for app protection policies

App protection policies are only supported by Android and iOS. When you enroll Windows devices with Intune, you can use Windows Information Protection, which offers similar functionality.