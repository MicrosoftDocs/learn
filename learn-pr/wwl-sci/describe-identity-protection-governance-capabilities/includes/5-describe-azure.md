Microsoft Entra ID Protection helps organizations detect, investigate, and remediate identity-based risks. This includes user identities and workload identities.

These identity-based risks can be further fed into tools like Conditional Access to make access decisions or fed back to a security information and event management (SIEM) tool for further investigation and correlation.

:::image type="content" source="../media/identity-protection-overview.png" alt-text="Diagram that shows building blocks of Microsoft Entra ID Protection. The signals used to detect risk, the types of risks, and steps to investigate and remediate risks." lightbox="../media/identity-protection-overview.png":::

### Detect risks

Microsoft continually adds and updates detections in its catalog to protect organizations. These detections come from the analysis of trillions of signals each day from Microsoft Entra ID, Microsoft Accounts, and in gaming with Xbox. This broad range of signals helps ID Protection detect risky behaviors like anonymous IP address usage, password spray attacks, leaked credentials, and more.

During each sign-in, ID Protection runs all real-time sign-in detections, generating a sign-in session risk level that indicates how likely the sign-in is compromised. Based on this risk level, policies are applied to protect the user and the organization.

Microsoft Entra ID Protection risk detections can be linked to a sign-in event (sign-in risk) or an individual user (user risk).

- **Sign-in risk**. A sign-in risk represents the probability that a given authentication request isn't authorized by the identity owner. Examples include a sign-in from an anonymous IP address, atypical travel (two sign-ins originating from geographically distant locations), unfamiliar sign-in properties, and more.

- **User risk**. A user risk represents the probability that a given identity or account is compromised. Examples include leaked credentials, user reported suspicious activity, suspicious sending patterns, and more.

Identity Protection only generates risk detections when correct credentials are used in the authentication request. If a user uses incorrect credentials, it isn't flagged by Identity Protection since there isn't a risk of credential compromise unless a bad actor uses the correct credentials.

### Investigate risks

Any risks detected on an identity are tracked with reporting. Identity Protection provides three key reports for administrators to investigate risks and take action:

- **Risk detections**: Each risk detected is reported as a risk detection.
- **Risky sign-ins**: A risky sign-in is reported when there are one or more risk detections reported for that sign-in.
- **Risky users**: A Risky user is reported when either or both of the following are true:
  - The user has one or more risky sign-ins.
  - One or more risk detections are reported.

Investigation of events is key to understanding and identifying any weak points in your security strategy.

### Remediate

Automation is critical in security because the massive scale of signals and attacks makes manual response impractical. Risk-based Conditional Access policies can be enabled to require access controls such as providing a strong authentication method, performing multifactor authentication, or performing a secure password reset based on the detected risk level. If the user successfully completes the access control, the risk is automatically remediated.

When automated remediation isn't enabled, an administrator must manually review the identified risks in the reports through the portal, through the API, or in Microsoft Defender XDR. Administrators can perform manual actions to dismiss, confirm safe, or confirm compromise on the risks.

### Export

Data from Identity Protection can be exported to other tools for archive, further investigation, and correlation. The Microsoft Graph based APIs allow organizations to collect this data for further processing in tools such as a SIEM. The data can also be sent to a Log Analytics workspace, archived to a storage account, streamed to Event Hubs, or sent to other solutions.
