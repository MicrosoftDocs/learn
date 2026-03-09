Security groups control who can access your Azure Machine Learning workspace, but they don't address how users connect or from where. A compromised password gives attackers the same access as legitimate users—security groups can't distinguish between the two. Conditional Access policies fill this gap by evaluating the context of each sign-in attempt and enforcing additional requirements based on risk factors like location, device state, and authentication method.

## Evaluate sign-in context with Conditional Access

Conditional Access acts as a policy enforcement checkpoint between users and your Azure Machine Learning workspace. When a data scientist attempts to sign in, the policy engine evaluates multiple signals simultaneously. It checks whether the user is connecting from a trusted network or an unfamiliar location. It verifies whether their device meets your organization's security standards—is antivirus software up to date, is the disk encrypted, are operating system patches current? It examines authentication strength—did the user provide just a password, or did they complete multifactor authentication? Based on these signals, the policy grants access, requires additional verification, or blocks the connection entirely.

:::image type="content" source="../media/conditional-access-policy-enforcement-checkpoint.png" alt-text="Diagram showing how Conditional Access acts as a policy enforcement checkpoint between users and an Azure Machine Learning workspace.":::

Unlike static security groups, Conditional Access adapts to changing conditions. A data scientist signing in from your corporate office on a managed laptop requires minimal verification. The same user connecting from a coffee shop on a personal device triggers stricter controls. This dynamic approach maintains security without creating friction for legitimate users in low-risk scenarios. At the same time, it raises barriers when risk indicators suggest potential compromise—for example, simultaneous sign-in attempts from geographically distant locations within minutes.

## Enforce Multifactor authentication for workspace access

Password-based authentication provides weak protection for AI infrastructure containing sensitive training data and proprietary models. Multifactor authentication (MFA) adds a second verification factor that attackers can't easily steal or replicate. Even if a phishing attack captures a user's password, the attacker still can't access your workspace without the victim's phone or security key. Conditional Access policies let you require MFA selectively based on risk—enforce it for all workspace access, or limit the requirement to high-risk scenarios like connections from unfamiliar locations.

Implementing MFA through Conditional Access requires creating a policy that targets your Azure Machine Learning workspace. Start by selecting the Azure Machine Learning application as the target resource. Choose which users or security groups the policy applies to—you might enforce MFA for the ML Engineers group while exempting read-only analysts in low-risk scenarios. Under access controls, select "Require multifactor authentication" as a grant condition. This configuration prompts users for a second factor during sign-in, with the verification persisting for a configurable session duration. Most organizations set this to eight hours, balancing security with usability—users authenticate once per workday rather than with every experiment submission.

## Require compliant devices for data protection

Multifactor authentication protects credentials, but it doesn't prevent data exfiltration from compromised devices. A data scientist's laptop infected with malware can steal training data or model weights even after successful MFA. Device compliance requirements address this gap by verifying that endpoints meet your security baseline before granting workspace access. Microsoft Intune policies define compliance criteria: devices must run supported operating systems, have encryption enabled, maintain current patches, and run approved endpoint protection software.

:::image type="content" source="../media/multi-factor-authentication-protects-credentials.png" alt-text="Diagram showing how Microsoft Intune policies define compliance criteria.":::

Conditional Access integrates with Intune to enforce device compliance at sign-in time. When you add "Require device to be marked as compliant" to your policy's grant controls, Azure evaluates the device's Intune compliance status before allowing access. Non-compliant devices receive a block message with remediation instructions—for example, "Your device requires security updates. Install pending patches and try again." This approach prevents shadow IT scenarios where data scientists use unmanaged personal devices for convenience, unknowingly exposing your AI infrastructure to security risks.

## Control access from trusted locations

Your data scientists work from multiple environments—corporate offices, home offices, co-working spaces, and client sites. Traditional security models either block remote access entirely or trust all internet connections equally. Conditional Access named locations provide granular control based on network context. Define your corporate offices and VPN endpoints as trusted locations using IP address ranges. Create policies that require additional authentication when users connect from outside these trusted networks. This approach maintains security for remote work while reducing friction for on-premises access.

Location-based policies become particularly valuable for protecting production AI environments. You might allow data scientists unrestricted access to development workspaces from any location after MFA, while limiting production workspace access to corporate networks and approved VPN connections. This segregation reduces the attack surface for your most sensitive AI assets—an attacker who compromises a developer's credentials can't immediately access production models and training data. However, be cautious with location-only policies. VPNs and proxy services let attackers appear to connect from trusted locations, so combine location checks with other signals like device compliance and MFA for defense in depth.

## Balance security with productivity

Overly restrictive Conditional Access policies can halt AI development by blocking legitimate workflows. Data scientists running long-training jobs need persistent sessions that survive network changes as they move between locations. Forcing re-authentication every hour disrupts workflows and reduces model iteration speed—a cost that compounds across dozens of team members. Session controls in Conditional Access let you balance security with usability by customizing authentication frequency and session persistence.

Configure session controls based on risk and resource sensitivity. For high-risk scenarios like accessing production endpoints, set aggressive sign-in frequency—require re-authentication every four hours and block persistent browser sessions. For development workspaces accessed from compliant devices on trusted networks, extend session duration to 24 hours and enable persistent sessions. This tiered approach provides strong protection where it matters most while avoiding unnecessary friction in lower-risk contexts. Monitor user feedback and authentication logs after policy deployment—if data scientists repeatedly request exceptions or find workarounds, your policies may be too restrictive for operational realities.


:::image type="content" source="../media/conditional-access-policy-evaluation-flow.png" alt-text="Diagram showing Conditional Access policy evaluation flow for Azure Machine Learning workspace access.":::

*Conditional Access policy evaluation flow for Azure Machine Learning workspace access*


## Additional resources

- [What is Conditional Access?](/entra/identity/conditional-access/overview) - Overview of Conditional Access capabilities and architecture
- [Conditional Access for Azure Machine Learning](/azure/machine-learning/how-to-setup-authentication#conditional-access) - Service-specific implementation guidance
- [Plan a Conditional Access deployment](/entra/identity/conditional-access/plan-conditional-access) - Best practices for policy design and rollout
