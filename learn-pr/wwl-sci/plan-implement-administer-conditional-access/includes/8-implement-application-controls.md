Conditional Access App Control enables user app access and sessions to be monitored and controlled in real time based on access and session policies. Access and session policies are used within the Microsoft Defender for Cloud Apps portal to further refine filters and set actions to be taken on a user.

## Conditional Access App Control

:::image type="content" source="../media/conditional-access-app-control-21108d98.png" alt-text="Screenshot of Microsoft Entra Conditional Access policy wizard with the Use Conditional Access App Control highlighted.":::


Conditional Access App Control uses a reverse proxy architecture and is uniquely integrated with Microsoft Entra Conditional Access. Microsoft Entra Conditional Access allows you to enforce access controls on your organization’s apps based on certain conditions. The conditions define who (user or group of users) and what (which cloud apps) and where (which locations and networks) a Conditional Access policy is applied to. After you’ve determined the conditions, you can route users to Microsoft Defender for Cloud Apps where you can protect data with Conditional Access App Control by applying access and session controls.

With the access and session policies, you can:

 -  **Prevent data exfiltration:** You can block the download, cut, copy, and print of sensitive documents on, for example, unmanaged devices.
 -  **Protect on download:** Instead of blocking the download of sensitive documents, you can require documents to be labeled and protected with Azure Information Protection. This action ensures the document is protected and user access is restricted in a potentially risky session.
 -  **Prevent upload of unlabeled files:** Before a sensitive file is uploaded, distributed, and used by others, it’s important to make sure that the file has the right label and protection. You can ensure that unlabeled files with sensitive content are blocked from being uploaded until the user classifies the content.
 -  **Monitor user sessions for compliance:** Risky users are monitored when they sign into apps and their actions are logged from within the session. You can investigate and analyze user behavior to understand where, and under what conditions, session policies should be applied in the future.
 -  **Block access:** You can granularly block access for specific apps and users depending on several risk factors. For example, you can block them if they are using client certificates as a form of device management.
 -  **Block custom activities:** Some apps have unique scenarios that carry risk, for example, sending messages with sensitive content in apps like Microsoft Teams or Slack. In these kinds of scenarios, you can scan messages for sensitive content and block them in real time.

## How to: Require app protection policy and an approved client app for cloud app access with Conditional Access

People regularly use their mobile devices for both personal and work tasks. While making sure staff can be productive, organizations also want to prevent data loss from potentially unsecure applications. With Conditional Access, organizations can restrict access to approved (modern authentication-capable) client apps.

This section presents two scenarios to configure Conditional Access policies for resources like Microsoft 365, Exchange Online, and SharePoint Online.

> [!NOTE]
> In order to require approved client apps for iOS and Android devices, these devices must first register in Microsoft Entra ID.

### Scenario 1: Microsoft 365 apps require an approved client app

In this scenario, Contoso has decided that users using mobile devices can access all Microsoft 365 services as long as they use approved client apps, like Outlook mobile, OneDrive, and Microsoft Teams. All of their users already sign in with Microsoft Entra credentials and have licenses assigned to them that include Microsoft Entra ID Premium P1 or P2 and Microsoft Intune.

Organizations must complete the following three steps in order to require the use of an approved client app on mobile devices.

**Step 1: Policy for Android and iOS based modern authentication clients requiring the use of an approved client application when accessing Exchange Online.**

1.  Sign in to the **Microsoft Entra admin center** as a Global Administrator, Security Administrator, or Conditional Access Administrator.
2.  Browse to **Identity**, then **Protection**, and then **Conditional Access**.
3.  Select **+Create new policy**.
4.  Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
5.  Under **Assignments**, select **Users and groups.**
    
    
    1.  Under **Include**, select **All users** or the specific **Users and groups** you wish to apply this policy to.
    2.  Select **Done**.
6.  Under **Cloud apps or actions**, then **Include**, select **Office 365**.
7.  Under **Conditions**, select **Device platforms**.
    
    
    1.  Set **Configure** to **Yes**.
    2.  Include **Android** and **iOS**.
8.  Under **Conditions**, select **Client apps (preview)**.
    
    
    1.  Set **Configure** to **Yes**.
    2.  Select **Mobile apps and desktop clients** and **Modern authentication clients**.
9.  Under **Access controls**, then **Grant**, select **Grant access**, **Require approved client app**, and select **Select**.
10. Confirm your settings and set **Enable policy** to **On**.
11. Select **Create** to create and enable your policy.

**Step 2: Configure an Microsoft Entra Conditional Access policy for Exchange Online with ActiveSync (EAS).**

1.  Browse to **Identity**, then **Protection**, and then **Conditional Access**.
2.  Select **+Create new policy**.
3.  Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
4.  Under **Assignments**, select **Users and groups.**
    
    
    1.  Under **Include**, select **All users** or the specific **Users and groups** you wish to apply this policy to.
    2.  Select **Done**.
5.  Under **Cloud apps or actions**, then **Include**, select **Office 365 Exchange Online**.
6.  Under **Conditions**:
    
    
    1.  **Client apps (preview)**:
        
        
        1.  Set **Configure** to **Yes**.
        2.  Select **Mobile apps and desktop clients** and **Exchange ActiveSync clients**.
7.  Under **Access controls**, then **Grant**, select **Grant access**, **Require approved client app**, and select **Select**.
8.  Confirm your settings and set **Enable policy** to **On**.
9.  Select **Create** to create and enable your policy.

**Step 3: Configure Intune app protection policy for iOS and Android client applications.**

Review the article [How to create and assign app protection policies](/intune/apps/app-protection-policies) for steps to create app protection policies for Android and iOS.

### Scenario 2: Exchange Online and SharePoint Online require an approved client app

In this scenario, Contoso has decided that users can only access email and SharePoint data on mobile devices as long as they use an approved client app like Outlook mobile. All of their users already sign in with Microsoft Entra credentials and have licenses assigned to them that include Microsoft Entra ID Premium P1 or P2 and Microsoft Intune.

Organizations must complete the following three steps in order to require the use of an approved client app on mobile devices and Exchange ActiveSync clients.

**Step 1: Policy for Android and iOS based modern authentication clients requiring the use of an approved client application when accessing Exchange Online and SharePoint Online.**

1.  Sign in to the **Microsoft Entra admin center** as a Global Administrator, Security Administrator, or Conditional Access Administrator.
2.  Browse to **Identity**, then **Protection**, and then **Conditional Access**.
3.  Select **New policy**.
4.  Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
5.  Under **Assignments**, select **Users and groups.**
    
    
    1.  Under **Include**, select **All users** or the specific **Users and groups** you wish to apply this policy to.
    2.  Select **Done**.
6.  Under **Cloud apps or actions**, then **Include**, select **Office 365 Exchange Online** and **Office 365 SharePoint Online**.
7.  Under **Conditions**, select **Device platforms**.
    
    
    1.  Set **Configure** to **Yes**.
    2.  Include **Android** and **iOS**.
8.  Under **Conditions**, select **Client apps (preview)**.
    
    
    1.  Set **Configure** to **Yes**.
    2.  Select **Mobile apps and desktop clients** and **Modern authentication clients**.
9.  Under **Access controls**, then **Grant**, select **Grant access**, **Require approved client app**, and select **Select**.
10. Confirm your settings and set **Enable policy** to **On**.
11. Select **Create** to create and enable your policy.

**Step 2: Policy for Exchange ActiveSync clients requiring the use of an approved client app.**

1.  Browse to **Identity**, then **Protection**, and then **Conditional Access**.
2.  Select **New policy**.
3.  Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
4.  Under **Assignments**, select **Users and groups.**
    
    
    1.  Under **Include**, select **All users** or the specific **Users and groups** you wish to apply this policy to.
    2.  Select **Done**.
5.  Under **Cloud apps or actions**, then **Include**, select **Office 365 Exchange Online**.
6.  Under **Conditions**:
    
    
    1.  **Client apps (preview)**:
        
        
        1.  Set **Configure** to **Yes**.
        2.  Select **Mobile apps and desktop clients** and **Exchange ActiveSync clients**.
7.  Under **Access controls**, then **Grant**, select **Grant access**, **Require approved client app**, and select **Select**.
8.  Confirm your settings and set **Enable policy** to **On**.
9.  Select **Create** to create and enable your policy.

**Step 3: Configure Intune app protection policy for iOS and Android client applications.**

Review the article [How to create and assign app protection policies](/intune/apps/app-protection-policies) for steps to create app protection policies for Android and iOS.

## App protection policies overview

App protection policies (APP) are rules that ensure an organization's data remains safe or contained in a managed app. A policy can be a rule that is enforced when the user attempts to access or move "corporate" data, or a set of actions that are prohibited or monitored when the user is inside the app. A managed app has app protection policies applied to it, and it can be managed by Intune.

Mobile Application Management (MAM) app protection policies allow you to manage and protect your organization's data within an application. With **MAM without enrollment** (MAM-WE), a work or school-related app that contains sensitive data can be managed on almost any device, including personal devices in **bring-your-own-device** (BYOD) scenarios. Many productivity apps, such as the Microsoft Office apps, can be managed by Intune MAM.

### How you can protect app data

Your employees use mobile devices for both personal and work tasks. While making sure your employees can be productive, you want to prevent data loss—intentional and unintentional. You'll also want to protect company data that is accessed from devices that you do not manage.

You can use Intune app protection policies **independent of any mobile-device management (MDM) solution**. This independence helps you protect your company's data with or without enrolling devices in a device management solution. By implementing **app-level policies**, you can restrict access to company resources and keep data within the purview of your IT department.

### App protection policies on devices

App protection policies can be configured for apps that run on devices that are:

 -  **Enrolled in Microsoft Intune:** These devices are typically corporate owned.
 -  **Enrolled in a third-party MDM solution:** These devices are typically corporate owned.
    
    > [!NOTE]
    > Mobile app management policies should not be used with third-party mobile app management or secure container solutions.
 -  **Not enrolled in any mobile device management solution:** These devices are typically employee-owned devices that aren't managed or enrolled in Intune or other MDM solutions.
    
    > [!IMPORTANT]
    > You can create mobile app management policies for Office mobile apps that connect to Microsoft 365 services. You can also protect access to Exchange on-premises mailboxes by creating Intune app protection policies for Outlook for iOS/iPadOS and Android enabled with hybrid Modern Authentication. Before using this feature, make sure you meet the Outlook for iOS/iPadOS and Android requirements. App protection policies are not supported for other apps that connect to on-premises Exchange or SharePoint services.

### Benefits of using app protection policies

The important benefits of using app protection policies are the following:

 -  **Protecting your company data at the app level.** Because mobile app management doesn't require device management, you can protect company data on both managed and unmanaged devices. The management is centered on the user identity, which removes the requirement for device management.
 -  **End-user productivity isn't affected and policies don't apply when using the app in a personal context.** The policies are applied only in a work context, which gives you the ability to protect company data without touching personal data.
 -  **App protection policies ensure that the app-layer protections are in place.** For example, you can:
    
    
     -  Require a PIN to open an app in a work context.
     -  Control the sharing of data between apps.
     -  Prevent the saving of company app data to a personal storage location.
 -  **MDM, in addition to MAM, ensures that the device is protected**. For example, you can require a PIN to access the device, or you can deploy managed apps to the device. You can also deploy apps to devices through your MDM solution to give you more control over app management.

There are additional benefits to using MDM with app protection policies, and companies can use app protection policies with and without MDM at the same time. For example, consider an employee who uses a phone issued by the company, as well as their personal tablet. The company phone is enrolled in MDM and protected by app protection policies, while the personal device is protected by app protection policies only.

If you apply a MAM policy to the user without setting the device state, the user will get the MAM policy on both the BYOD device and the Intune-managed device. You can also apply a MAM policy based on the managed state. So when you create an app protection policy, next to **Target to all app types**, you'd select **No**. Then do any of the following:

 -  Apply a less strict MAM policy to Intune managed devices, and apply a more restrictive MAM policy to non MDM-enrolled devices.
 -  Apply a MAM policy to unenrolled devices only.
