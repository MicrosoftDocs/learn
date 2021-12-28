The Advanced Features area in the General Settings area provides many on/off switches for features within the product.  Some of these features you will learn about in later modules.  The following are settings that are environment focused.

| Feature| Description|
| :--- | :--- |
| Show user details| Enables displaying user details: picture, name, title, department, stored in Azure Active Directory.|
| Skype for business integration| Enables one-click communication with users.|
| Microsoft Defender for Identity integration| Retrieves enriched user and device data from Microsoft Defender for Identity and forwards Microsoft Defender for Endpoint signals, resulting in better visibility, another detections, and efficient investigations across both services. Forwarded data is stored and processed in the same location as your MDI data.|
| Office 365 Threat Intelligence connection| Connects to Office 365 Threat Intelligence to enable security investigations across Office 365 mailboxes and Windows devices.|
| Microsoft Defender for Cloud Apps | Forwards Microsoft Defender for Endpoint signals to Defender for Cloud Apps, giving administrators deeper visibility into both sanctioned cloud apps and shadow IT. It also gives them the ability to block unauthorized applications when the custom network indicators setting is turned on. Forwarded data is stored and processed in the same location as your Defender for Cloud Apps data.|
| Enable EDR in block mode| When turned on, Microsoft Defender for Endpoint leverages behavioral blocking and containment capabilities by blocking malicious artifacts or behaviors observed through post-breach endpoint detection and response (EDR) capabilities. This feature does not change how Microsoft Defender for Endpoint performs detection, alert generation, and incident correlation. |
| Microsoft Secure Score| Forwards Microsoft Defender for Endpoint signals, giving Microsoft Secure Score visibility into the device security posture. Forwarded data is stored and processed in the same location as your Microsoft Secure Score data.|
| Microsoft Intune connection| Connects to Microsoft Intune to enable sharing of device information and enhanced policy enforcement.  Intune provides additional information about managed devices for secure score. It can use risk information to enforce Conditional Access and other security policies.|
| Preview features| Allow access to preview features. Turn on to be among the first to try upcoming features.|
| Device discovery | Allows onboarded devices to discover unmanaged devices in your network and assess vulnerabilities and risks.|

### Show user details

Turn on this feature to see user details stored in Azure Active Directory. Details include a user's picture, name, title, and department information when investigating user account entities. You can find user account information in the following views:

- Security operations dashboard

- Alert queue

- Device details page

### Skype for Business integration

Enabling the Skype for Business integration gives you the ability to communicate with users using Skype for Business, email, or phone. This can be helpful when you need to communicate with the user and mitigate risks.

### Microsoft Defender for Identity integration

The integration with Microsoft Defender for Identity allows you to pivot directly into another Microsoft Identity security product. Microsoft Defender for Identity augments an investigation with more insights about a suspected compromised account and related resources. By enabling this feature, you'll enrich the device-based investigation capability by pivoting across the network from an identify point of view.

### Microsoft Secure Score

Forwards Defender for Endpoint signals to Microsoft Secure Score in the Microsoft 365 security center. Turning on this feature gives Microsoft Secure Score visibility into the devices security posture. Forwarded data is stored and processed in the same location as the Microsoft Secure Score data.

### Office 365 Threat Intelligence connection

When you turn on this feature, you can incorporate data from Office 365 Advanced Threat Protection into Microsoft Defender Security Center to conduct a comprehensive security investigation across Office 365 mailboxes and Windows devices. To receive contextual device integration in Office 365 Threat Intelligence, you'll need to enable the Defender for Endpoint settings in the Security & Compliance dashboard.

### Microsoft Defender for Cloud Apps

Enabling this setting forwards Defender for Endpoint signals to Microsoft Defender for Cloud Apps to provide deeper visibility into cloud application usage. Forwarded data is stored and processed in the same location as your Defender for Cloud Apps data.

### Microsoft Intune connection

Defender for Endpoint can be integrated with Microsoft Intune to enable device risk-based Conditional Access. When you turn on this feature, you can share Defender for Endpoint device information with Intune, enhancing policy enforcement.  You'll need to enable the integration on both Intune and Defender for Endpoint to use this feature.

### Conditional Access policy

When you enable Intune integration, Intune will automatically create a classic Conditional Access policy. This classic Conditional Access policy is a prerequisite for setting up status reports to Intune. It should not be deleted.

### Preview features

Learn about new features in the Defender for Endpoint preview release and be among the first to try upcoming features by turning on the preview experience.  You'll have access to upcoming features, which you can provide feedback on to help improve the overall experience before features are generally available.
