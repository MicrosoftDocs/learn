The majority of security breaches take place when attackers gain access to an environment by stealing a user’s identity. Discovering compromised identities is no easy task. Azure Active Directory uses adaptive machine learning algorithms and heuristics to detect suspicious actions that are related to your user accounts. Each detected suspicious action is stored in a record called a **risk detection**.

There are two places where you review reported risk detections:

 -  **Azure AD reporting** \- Risk detections are part of Azure AD's security reports.
 -  **Azure AD Identity Protection** \- Risk detections are also part of the reporting capabilities of Azure Active Directory Identity Protection.

In addition, you can use the Identity Protection risk detections API to gain programmatic access to security detections using Microsoft Graph.

Currently, Azure Active Directory detects six types of risk detections:

 -  **Users with leaked credentials** \- When cybercriminals compromise valid passwords of legitimate users, they often share those credentials.
 -  **Sign-ins from anonymous IP addresses** \- This risk detection type identifies users who have successfully signed in from an IP address that has been identified as an anonymous proxy IP address.
 -  **Impossible travel to atypical locations** \- This risk detection type identifies two sign-ins originating from geographically distant locations, where at least one of the locations may also be atypical for the user, given past behavior.
 -  **Sign-ins from infected devices** \- This risk detection type identifies sign-ins from devices infected with malware, that are known to actively communicate with a bot server.
 -  **Sign-in from unfamiliar locations** \- This risk detection type considers past sign-in locations (IP, Latitude / Longitude and ASN) to determine new / unfamiliar locations.
 -  **Sign-ins from IP addresses with suspicious activity** \- This risk detection type identifies IP addresses from which a high number of failed sign-in attempts were seen, across multiple user accounts, over a short period of time.

The insight you get for a detected risk detection is tied to your Azure AD subscription.<br>

 -  With the **Azure AD Premium P2 edition**, you get the most detailed information about all underlying detections.
 -  With the **Azure AD Premium P1 edition**, advanced detections (such as unfamiliar sign-in properties) are not covered by your license, and will appear under the name Sign-in with additional risk detected. Additionally, the risk level and risk detail fields are hidden.

> [!IMPORTANT]
> While the detection of risk detections already represents an important aspect of protecting your identities, you also have the option to either manually address them or implement automated responses by configuring Conditional Access policies.
