Microsoft Entra ID Protection helps organizations detect, investigate, and remediate identity-based risks. These identity-based risks can be further fed into tools like Conditional Access to make access decisions or fed back to a security information and event management (SIEM) tool for further investigation and correlation.

:::image type="content" source="../media/microsoft-entra-identity-protection-overview-9425c35d.png" alt-text="Diagram showing an example of Microsoft Entra ID Protection.":::


## Detect risks

Microsoft continually adds and updates detections in our catalog to protect organizations. These detections come from our learnings based on the analysis of trillions of signals each day from Active Directory, Microsoft Accounts, and in gaming with Xbox. This broad range of signals helps Identity Protection detect risky behaviors like:

 -  Anonymous IP address usage
 -  Password spray attacks
 -  Leaked credentials

During each sign-in, Identity Protection runs all real-time sign-in detections generating a sign-in session risk level, indicating how likely the sign-in has been compromised. Based on this risk level, policies are then applied to protect the user and the organization.

## Investigate

Any risks detected on an identity are tracked with reporting. Identity Protection provides three key reports for administrators to investigate risks and take action:

 -  **Risk detections**: Each risk detected is reported as a risk detection.
 -  **Risky sign-ins**: A risky sign-in is reported when there are one or more risk detections reported for that sign-in.
 -  **Risky users**: A Risky user is reported when either or both of the following are true:
     -  The user has one or more Risky sign-ins.
     -  One or more risk detections have been reported.

## Automatic remediation

Risk-based Conditional Access policies can be enabled to require access controls such as providing a strong authentication method, perform multifactor authentication, or perform a secure password reset based on the detected risk level. If the user successfully completes the access control, the risk is automatically remediated.

## Manual remediation

When user remediation isn't enabled, an administrator must manually review them in the reports in the portal, through the API, or in Microsoft 365 Defender. Administrators can perform manual actions to dismiss, confirm safe, or confirm compromise on the risks.

## Making use of the data

Data from Identity Protection can be exported to other tools for archive, further investigation, and correlation.

Organizations may store data for longer periods by changing the diagnostic settings in Microsoft Entra ID. They can choose to send data to a Log Analytics workspace, archive data to a storage account, stream data to Event Hubs, or send data to another solution.
