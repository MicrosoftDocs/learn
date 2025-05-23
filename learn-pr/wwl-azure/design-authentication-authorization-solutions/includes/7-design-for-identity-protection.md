[Identity Protection](/azure/active-directory/identity-protection/overview-identity-protection) is a tool that allows organizations to accomplish three key tasks:

- [Automate the detection and remediation of identity-based risks](/azure/active-directory/identity-protection/howto-identity-protection-configure-risk-policies).

- [Investigate risks](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk) by using data in the Azure portal.

- [Export risk detection data](/azure/sentinel/connect-azure-ad-identity-protection) to other tools.

The signals that are generated and fed into Identity Protection can be exported to other tools. You learned how the Conditional Access tool can make decisions based on your organization's policies. By using Identity Protection, you can pass this information to a security information and event management (SIEM) tool for more investigation. 

In the following workflow, the administrator first configures the risk policies that then monitor for identity risks. When a risk is detected, the policies enforce measures to remediate it. A policy might, for example, prompt a user to reset their password in response to a risk detected. The user then resets their password, and the risk is remediated.

:::image type="content" source="../media/user-risk-level-evaluation.png" alt-text="Diagram that shows automated remediation." border="false":::

### Things to know about Identity Protection

As the CTO of Tailwind Traders, you'd like to know how Identity Protection can be included in your authentication strategy. Consider the following characteristics of this tool.

- Identity Protection provides **risk policy** detection that includes any identified suspicious actions related to user accounts in the directory.

- Two risk policies are evaluated: user risk and sign-in risk:

   :::image type="content" source="../media/risk-detections.png" alt-text="Diagram that shows risky users, risky sign-ins, and risk detections." border="false":::

- [**User risk**](/azure/active-directory/identity-protection/concept-identity-protection-risks) represents the probability that a given identity or account is compromised. An example is when a user's valid credentials are leaked. User risks are calculated offline by using Microsoft's internal and external threat intelligence sources. Here are some user risks that can be identified:

   - **Leaked credentials**: Microsoft checks for leaked credentials from the dark web, paste sites, or other sources. These leaked credentials are checked against Microsoft Entra users' current valid credentials for valid matches.

   - **Microsoft Entra threat intelligence**: This risk detection type indicates user activity that's unusual for the given user or is consistent with known attack patterns.

- [**Sign-in risk**](/azure/active-directory/identity-protection/concept-identity-protection-risks) represents the probability that a given sign-in (authentication request) isn't authorized by the identity owner. Sign-in risk can be calculated in real time or offline. Here are some sign-in risks that can be identified:

   - **Anonymous IP address**: A sign-in attempt from an anonymous IP address like a Tor browser or an anonymized VPN.

   - **Atypical travel**: Two sign-ins from the same user that originate from a geographically distant location. Given past behavior, at least one of the locations might also be atypical for the user.

   - **Malware-linked IP address**: An infected IP address sign-in known to actively communicate with a bot server.

   - **Password spray**: A password spray attack where a bad actor tries to defeat lockout and detection by attempting sign-in with different user names and the same password.

### Things to consider when using Identity Protection

Tailwind Traders decides to implement Identity Protection into their security solution. Review these options that can enhance your strategy.

- **Consider "High" threshold for user risk policy**. (Microsoft recommended) Set the risk policy level for your Tailwind Traders users to "High." A high setting can detect for leaked credentials and unusual activity for a user, and check for known attack patterns. By setting the policy threshold to "high," you can spread a wide net to prevent attacks that target user credentials.

- **Consider "Medium and above" threshold for sign-in risk policy**. (Microsoft recommended) Configure the risk policy level for sign-in attempts to Tailwind Traders apps to "Medium and above." This setting supports the Identity Protection self-remediation options. Self-remediation, like password changes and MFA, have less impact than blocking users.

- **Consider investigating risks in the Azure portal**. Investigate Tailwind Traders risk events in the Azure portal and identify any weak areas in your security implementation. Download the risk events in .CSV format and view the output in the Security section of Microsoft Entra ID. Use the Microsoft Graph API integrations to aggregate your data with other sources.

- **Consider exporting your risk detection data**. Export the risk detection data for Tailwind Traders by using the Microsoft Sentinel data connector for Identity Protection.
