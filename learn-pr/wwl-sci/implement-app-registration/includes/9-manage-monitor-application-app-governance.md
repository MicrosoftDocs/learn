Cyberattacks have become increasingly sophisticated in the ways they exploit the apps you have deployed in your on-premises and cloud infrastructures. Cyberattacks establish a starting point for privilege escalation, lateral movement, and exfiltration of your data. To understand the potential risks and stop these types of attacks, you need to gain clear visibility into your organization’s app compliance posture. Then you need to look for when an app exhibits anomalous behaviors and to respond when these behaviors present risks to your environment, data, and users.

The app governance add-on feature to Defender for Cloud Apps is a security and policy management capability designed for OAuth-enabled apps that access Microsoft 365 data through Microsoft Graph APIs. App governance delivers full visibility, remediation, and governance into how these apps and their users access, use, and share your sensitive data stored in Microsoft 365 through actionable insights and automated policy alerts and actions.

App governance provides you with comprehensive:

 -  **Insights**: See a view of all the third-party apps for the Microsoft 365 platform in your tenant on a single dashboard. You can see all the apps’ status and alert activities and react or respond to them.
 -  **Governance**: Create proactive or reactive policies for app and user patterns and behaviors and protect your users from using non-compliant or malicious apps and limiting the access of risky apps to your data.
 -  **Detection**: Be alerted and notified when there are anomalies in app activity and when non-compliant, malicious, or risky apps are used.
 -  **Remediation**: Along with automatic remediation capabilities, use remediation controls in a timely manner to respond to anomalous app activity detections.

## Enable Defender for Cloud Apps sync

To enable app governance sync with Defender for Cloud Apps, follow these steps:

1.  Ensure Office 365 is connected in Defender for Cloud Apps.
2.  Ensure Office 365 Microsoft Entra ID apps are enabled.
3.  Go to your Defender for Cloud Apps portal – `https://portal.cloudappsecurity.com`
4.  Select the gear icon (top-right corner) and select Settings.
5.  Under Threat Protection, select App Governance.
6.  Select Enable App Governance integration, and then select Save. To verify the integration with Defender for Cloud Apps is active, look for the app governance policies listed below to appear in Defender for Cloud Apps. The new policies might take few minutes to appear once integration is enabled.
    
    
     -  Microsoft 365 OAuth app Reputation
     -  Microsoft 365 OAuth Phishing Detection
     -  Microsoft 365 OAuth App Governance
