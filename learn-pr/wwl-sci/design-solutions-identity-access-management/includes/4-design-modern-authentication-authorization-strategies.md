This unit will address a few specific strategies for modern authentication:

- Conditional access
- Continuous access authentication
- Threat intelligence integration
- Risk scoring

## Conditional Access

Users can access your organization's resources by using a variety of devices and apps from anywhere. As an IT admin, you want to make sure that these devices meet your standards for security and compliance. Just focusing on who can access a resource is not sufficient anymore.

To balance security and productivity, you need to think about how a resource is accessed before you can make a decision about access control. With Azure AD Conditional Access, you can address this requirement. With Conditional Access, you can make automated access control decisions based on conditions for accessing your cloud apps.

**Best practice**: Manage and control access to corporate resources.  
**Detail**: Configure common Azure AD Conditional Access policies based on a group, location, and application sensitivity for SaaS apps and Azure AD–connected apps.

**Best practice**: Block legacy authentication protocols.
**Detail**: Attackers exploit weaknesses in older protocols every day, particularly for password spray attacks. Configure Conditional Access to block legacy protocols.

## Continuous access evaluation
<!--
BEGIN(https://learn.microsoft.com/azure/active-directory/conditional-access/concept-continuous-access-evaluation)
-->
Token expiration and refresh are a standard mechanism in the industry. When a client application like Outlook connects to a service like Exchange Online, the API requests are authorized using OAuth 2.0 access tokens. By default, access tokens are valid for one hour, when they expire the client is redirected to Azure AD to refresh them. That refresh period provides an opportunity to reevaluate policies for user access. For example: we might choose not to refresh the token because of a Conditional Access policy, or because the user has been disabled in the directory. 

Customers have expressed concerns about the lag between when conditions change for a user, and when policy changes are enforced. Azure AD has experimented with the "blunt object" approach of reduced token lifetimes but found they can degrade user experiences and reliability without eliminating risks.

Timely response to policy violations or security issues really requires a "conversation" between the token issuer (Azure AD), and the relying party (enlightened app). This two-way conversation gives us two important capabilities. The relying party can see when properties change, like network location, and tell the token issuer. It also gives the token issuer a way to tell the relying party to stop respecting tokens for a given user because of account compromise, disablement, or other concerns. The mechanism for this conversation is continuous access evaluation (CAE). The goal for critical event evaluation is for response to be near real time, but latency of up to 15 minutes may be observed because of event propagation time; however, IP locations policy enforcement is instant.

The initial implementation of continuous access evaluation focuses on Exchange, Teams, and SharePoint Online.

To prepare your applications to use CAE, see How to use Continuous Access Evaluation enabled APIs in your applications.

Continuous access evaluation is available in Azure Government tenants (GCC High and DOD) for Exchange Online.

### Key benefits

- User termination or password change/reset: User session revocation will be enforced in near real time.
- Network location change: Conditional Access location policies will be enforced in near real time.
- Token export to a machine outside of a trusted network can be prevented with Conditional Access location policies.

## Scenarios 

There are two scenarios that make up continuous access evaluation, critical event evaluation and Conditional Access policy evaluation.

### Critical event evaluation

Continuous access evaluation is implemented by enabling services, like Exchange Online, SharePoint Online, and Teams, to subscribe to critical Azure AD events. Those events can then be evaluated and enforced near real time. Critical event evaluation doesn't rely on Conditional Access policies so it's available in any tenant. The following events are currently evaluated:

- User Account is deleted or disabled
- Password for a user is changed or reset
- Multifactor Authentication is enabled for the user
- Administrator explicitly revokes all refresh tokens for a user
- High user risk detected by Azure AD Identity Protection

This process enables the scenario where users lose access to organizational SharePoint Online files, email, calendar, or tasks, and Teams from Microsoft 365 client apps within minutes after a critical event. 

> [!NOTE] 
> SharePoint Online doesn't support user risk events.

### Conditional Access policy evaluation

Exchange Online, SharePoint Online, Teams, and MS Graph can synchronize key Conditional Access policies for evaluation within the service itself.

This process enables the scenario where users lose access to organizational files, email, calendar, or tasks from Microsoft 365 client apps or SharePoint Online immediately after network location changes.

| | Outlook Web | Outlook Win32 | Outlook iOS | Outlook Android | Outlook Mac |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **SharePoint Online** | Supported | Supported | Supported | Supported | Supported |
| **Exchange Online** | Supported | Supported | Supported | Supported | Supported |

| | Office web apps | Office Win32 apps | Office for iOS | Office for Android | Office for Mac |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **SharePoint Online** | Not Supported \* | Supported | Supported | Supported | Supported |
| **Exchange Online** | Not Supported | Supported | Supported | Supported | Supported |

| | OneDrive web | OneDrive Win32 | OneDrive iOS | OneDrive Android | OneDrive Mac |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **SharePoint Online** | Supported | Not Supported | Supported | Supported | Not Supported |

| | Teams web | Teams Win32 | Teams iOS | Teams Android | Teams Mac |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Teams Service** | Partially supported | Partially supported | Partially supported | Partially supported | Partially supported |
| **SharePoint Online** | Partially supported | Partially supported | Partially supported | Partially supported | Partially supported |
| **Exchange Online** | Partially supported | Partially supported | Partially supported | Partially supported | Partially supported |

> \* Token lifetimes for Office web apps are reduced to 1 hour when a Conditional Access policy is set.
<!--
END()
-->
## Threat intelligence

<!--
BEGIN(https://learn.microsoft.com/azure/sentinel/understand-threat-intelligence)
-->

Cyber threat intelligence (CTI) is information describing existing or potential threats to systems and users. This intelligence takes many forms, from written reports detailing a particular threat actor's motivations, infrastructure, and techniques, to specific observations of IP addresses, domains, file hashes, and other artifacts associated with known cyber threats. CTI is used by organizations to provide essential context to unusual activity, so security personnel can quickly take action to protect their people, information, and assets. CTI can be sourced from many places, such as open-source data feeds, threat intelligence-sharing communities, commercial intelligence feeds, and local intelligence gathered in the course of security investigations within an organization.

For SIEM solutions like Microsoft Sentinel, the most common forms of CTI are threat indicators, also known as Indicators of Compromise (IoC) or Indicators of Attack (IoA). Threat indicators are data that associate observed artifacts such as URLs, file hashes, or IP addresses with known threat activity such as phishing, botnets, or malware. This form of threat intelligence is often called tactical threat intelligence because it can be applied to security products and automation in large scale to detect potential threats to an organization and protect against them. In Microsoft Sentinel, you can use threat indicators to help detect malicious activity observed in your environment and provide context to security investigators to help inform response decisions.

Integrate threat intelligence (TI) into Microsoft Sentinel through the following activities:

- Import threat intelligence into Microsoft Sentinel by enabling data connectors to various TI platforms and feeds.
- View and manage the imported threat intelligence in Logs and in the Threat Intelligence blade of Microsoft Sentinel.
- Detect threats and generate security alerts and incidents using the built-in Analytics rule templates based on your imported threat intelligence.
- Visualize key information about your imported threat intelligence in Microsoft Sentinel with the Threat Intelligence workbook.

Microsoft enriches all imported threat intelligence indicators with GeoLocation and WhoIs data, which is displayed together with other indicator details.

Threat Intelligence also provides useful context within other Microsoft Sentinel experiences such as Hunting and Notebooks. For more information, see Jupyter Notebooks in Microsoft Sentinel and Tutorial: Get started with Jupyter notebooks and MSTICPy in Microsoft Sentinel.
<!--
END()
-->

## Risk-based access policies

Access control policies can be applied to protect organizations when a sign-in or user is detected to be at risk. Such policies are called **risk-based policies**. 

Azure AD Conditional Access offers two risk conditions: **Sign-in risk** and **User risk**. Organizations can create risk-based Conditional Access policies by configuring these two risk conditions and choosing an access control method. During each sign-in, Identity Protection sends the detected risk levels to Conditional Access, and the risk-based policies will apply if the policy conditions are satisfied.

![Diagram that shows a conceptual risk-based Conditional Access policy.](https://learn.microsoft.com/azure/active-directory/identity-protection/media/concept-identity-protection-policies/risk-based-conditional-access-diagram.png)

For example, as shown in the diagram below, if organizations have a sign-in risk policy that requires multifactor authentication when the sign-in risk level is medium or high, their users must complete multifactor authentication when their sign-in risk is medium or high.
  
![Diagram that shows a conceptual risk-based Conditional Access policy with self-remediation.](https://learn.microsoft.com/azure/active-directory/identity-protection/media/concept-identity-protection-policies/risk-based-conditional-access-policy-example.png)

The example above also demonstrates a main benefit of a risk-based policy: **automatic risk remediation**. When a user successfully completes the required access control, like a secure password change, their risk is remediated. That sign-in session and user account won't be at risk, and no action is needed from the administrator. 

Allowing users to self-remediate using this process will significantly reduce the risk investigation and remediation burden on the administrators while protecting your organizations from security compromises. More information about risk remediation can be found in the article, Remediate risks and unblock users.

### Sign-in risk-based Conditional Access policy

During each sign-in, Identity Protection analyzes hundreds of signals in real-time and calculates a sign-in risk level that represents the probability that the given authentication request isn't authorized. This risk level then gets sent to Conditional Access, where the organization's configured policies are evaluated. Administrators can configure sign-in risk-based Conditional Access policies to enforce access controls based on sign-in risk, including requirements such as:

- Block access
- Allow access
- Require multifactor authentication

If risks are detected on a sign-in, users can perform the required access control such as multifactor authentication to self-remediate and close the risky sign-in event to prevent unnecessary noise for administrators.

### User risk-based Conditional Access policy

Identity Protection analyzes signals about user accounts and calculates a risk score based on the probability that the user has been compromised. If a user has risky sign-in behavior, or their credentials have been leaked, Identity Protection will use these signals to calculate the user risk level. Administrators can configure user risk-based Conditional Access policies to enforce access controls based on user risk, including requirements such as: 

- Block access
- Allow access but require a secure password change.

A secure password change will remediate the user risk and close the risky user event to prevent unnecessary noise for administrators.
