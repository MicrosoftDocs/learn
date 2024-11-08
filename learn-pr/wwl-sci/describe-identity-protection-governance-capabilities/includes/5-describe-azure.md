Microsoft Entra ID Protection helps organizations detect, investigate, and remediate identity-based risks. This includes user identities and workload identities.

These identity-based risks can be further fed into tools like Conditional Access to make access decisions or fed back to a security information and event management (SIEM) tool for further investigation and correlation.

:::image type="content" source="../media/identity-protection-overview.png" alt-text="Diagram that shows building blocks of Microsoft Entra ID Protection. The signals user to detect risk, the types of risks, and steps to investigate and remediate risks." lightbox="../media/identity-protection-overview.png":::

### Detect risks

Microsoft analyses trillions of signals per day to identify potential threats. These signals come from learnings Microsoft has acquired from numerous sources, including Microsoft Entra ID, the consumer space with Microsoft Accounts, and in gaming with Xbox.

Microsoft Entra ID Protection provides organizations with information of suspicious activity in their tenant and allows them to respond quickly to prevent further risk occurring. Risk detections can include any suspicious or anomalous activity related to a user account in the directory. ID Protection risk detections can be linked to a sign-in event (sign-in risk) or an individual user (user risk).

- **Sign-in risk**. A sign-in represents the probability that a given authentication request isn't authorized by the identity owner. Examples include a sign-in from an anonymous IP address, atypical travel (two sign-ins originating from geographically distant locations), unfamiliar sign-in properties, and more.

- **User risk**. A user risk represents the probability that a given identity or account is compromised. Examples include leaked credentials, user reported suspicious activity, suspicious sending patterns, and more.

For a detailed list of sign-in and user risk detections, see [Risk detections mapped to riskEventType](/entra/id-protection/concept-identity-protection-risks#risk-detections-mapped-to-riskeventtype)

Identity Protection only generates risk detections when correct credentials are used in the authentication request. If a user uses incorrect credentials, it will not be flagged by Identity Protection since there isn't a risk of credential compromise unless a bad actor uses the correct credentials.

Risk detections can trigger actions such as requiring users to provide multifactor authentication, reset their password, or block access until an administrator takes action.

### Investigate risks

Any risks detected on an identity are tracked with reporting. Identity Protection provides three key reports for administrators to investigate risks and take action:

- Risk detections: Each risk detected is reported as a risk detection.
- Risky sign-ins: A risky sign-in is reported when there are one or more risk detections reported for that sign-in.
- Risky users: A Risky user is reported when either or both of the following are true:
  - The user has one or more Risky sign-ins.
  - One or more risk detections are reported.

  For businesses that are onboarded to Microsoft Security Copilot The risky users' report, embeds the capabilities of Microsoft Security Copilot to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation.

Investigation of events is key to understanding and identifying any weak points in your security strategy.

### Remediate

After completing an investigation, admins will want to take action to remediate the risk or unblock users. Organizations can enable automated remediation using their risk policies. For example, risk-based conditional access policies can be enabled to require access controls such as providing a strong authentication method, perform multifactor authentication, or perform a secure password reset based on the detected risk level. If the user successfully completes the access control, the risk is automatically remediated.

When automated remediation isn't enabled, an administrator must manually review the identified risks in the reports through the portal, through the API, or in Microsoft Defender XDR. Administrators can perform manual actions to dismiss, confirm safe, or confirm compromise on the risks.

### Export

Data from Identity Protection can be exported to other tools for archive, further investigation, and correlation. The Microsoft Graph based APIs allow organizations to collect this data for further processing in tools such as a SIEM. The data can also be sent to a Log Analytics workspace, archived data to a storage account, streamed to Event Hubs, or solutions.
