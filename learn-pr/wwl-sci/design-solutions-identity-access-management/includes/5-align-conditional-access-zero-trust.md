Microsoft Entra Conditional Access is the basis of Microsoft's Zero Trust security policy engine. It brings signals together from multiple sources to automate access decisions and enforce organizational security policies. As a security architect, you must validate that Conditional Access policies collectively enforce all three Zero Trust principles across users, devices, applications, and increasingly, agent identities.

## Zero Trust principles and Conditional Access

Zero Trust is built on three core principles. Each principle maps directly to specific Conditional Access capabilities:

| Zero Trust principle | How Conditional Access enforces it |
|---|---|
| **Verify explicitly** | Evaluates all available signals—user or group membership, IP location, device state, application, real-time risk detection, and Microsoft Defender for Cloud Apps—before granting access |
| **Use least privilege access** | Limits user access through session controls, time-limited permissions, risk-based adaptive policies, and scope-based targeting |
| **Assume breach** | Minimizes blast radius through access segmentation, continuous verification with Continuous Access Evaluation (CAE), and real-time analytics |

When Conditional Access policies are evaluated, they function as if-then statements: *if* a user wants to access a resource, *then* they must complete the required action. Conditional Access processes six categories of signals to reach grant, block, or session-control decisions.

## Validate explicit verification alignment

Explicit verification requires that every access request is fully authenticated and authorized using all available data points. Validate your Conditional Access policies address these signal categories:

### Identity and authentication strength

- MFA is required for all users across all cloud applications.
- Phishing-resistant authentication methods (passkeys, FIDO2 security keys, certificate-based authentication) are enforced for privileged roles.
- Legacy authentication protocols are blocked. Research shows that 97% of credential-stuffing attacks and 99% of password-spray attacks exploit legacy authentication.
- Microsoft-managed Conditional Access policies are reviewed and enabled where appropriate. These policies automatically block legacy authentication, require MFA for Azure management portal access, require MFA for admin accounts, and require MFA for all users.


### Device compliance

- Require Microsoft Entra hybrid joined or Intune-compliant devices for accessing corporate resources.
- Use device filters to target or exclude specific device platforms.
- Require managed devices and token protection for privileged access to bind tokens to the intended device.

### Location and application signals

- Define named locations for corporate networks and trusted IP ranges.
- Block access from countries or regions where the organization doesn't operate.
- Apply Conditional Access App Control through Microsoft Defender for Cloud Apps for session-level visibility into high-risk applications.
- Integrate sign-in risk and user risk levels from Microsoft Entra ID Protection so that policies respond dynamically to detected threats.

### Agent identity coverage

Conditional Access for Agent ID (preview) extends Zero Trust controls to AI agents. This capability treats agents as first-class identities and evaluates their access requests using agent-specific logic. Validate that agent identities and agent users are covered by your Conditional Access policies so that nonhuman identities don't create coverage gaps.

## Validate least privilege access alignment

Least privilege access ensures users receive only the permissions necessary for their current task. Validate your Conditional Access configuration enforces least privilege through these mechanisms:

### Tiered protection levels

Microsoft recommends three tiers of Zero Trust identity and device access policies, each adding progressively stricter controls:

| Tier | Key controls |
|---|---|
| **Starting point** | MFA for all users, block legacy authentication, app protection policies for mobile |
| **Enterprise** | Require compliant or Microsoft Entra hybrid joined devices, enforce MFA for guests |
| **Specialized security** | Require MFA every sign-in for specific high-value users or sensitive data, restrict sessions |


### Session and scope controls

- Configure sign-in frequency controls to limit session duration for sensitive applications.
- Use Conditional Access App Control to prevent data download on unmanaged devices.
- Create targeted policies per user group, application, and sensitivity level rather than applying a single broad policy.
- Integrate Privileged Identity Management (PIM) for just-in-time activation of administrative roles, enforcing time-limited access aligned with least privilege.

## Validate assume breach alignment

The assume breach principle designs controls under the assumption that compromise has already occurred or will occur. Validate your policies address ongoing verification and blast-radius reduction:

### Continuous verification and real-time response

- Enable Continuous Access Evaluation (CAE) for supported applications so that policy changes and risk events take effect in near real time, without waiting for token expiration.
- Configure risk-based Conditional Access policies that automatically block access or require password change when Identity Protection detects elevated user risk or sign-in risk.
- Deploy automated remediation paths so users can self-remediate through MFA registration or secure password reset.

### Blast-radius reduction and segmentation

- Segment access by resource sensitivity: separate policies for general corporate apps versus financial systems, HR data, or administrative portals.
- Require privileged access workstations for administrative operations.
- Implement protected actions for sensitive operations such as modifying Conditional Access policies themselves.
- Restrict device code flow and block authentication transfer to prevent attackers from abusing these flows.

## Zero Trust pillars and Conditional Access coverage

Beyond the three principles, Zero Trust defines six technology pillars. Conditional Access plays a different role in each pillar, and complementary controls are required where coverage is limited:

| Pillar | Conditional Access role | Complementary controls needed |
|---|---|---|
| **Identity** | Primary policy engine—enforces MFA, authentication strength, risk-based policies, and CAE | Microsoft Entra ID Protection, PIM |
| **Devices** | Enforces device compliance, hybrid join requirements, device filters, and token protection | Microsoft Intune, Defender for Endpoint |
| **Applications** | Controls application access, applies session restrictions, integrates Conditional Access App Control | Defender for Cloud Apps, app governance |
| **Data** | Indirect—session controls block downloads on unmanaged devices but don't classify or encrypt data | Microsoft Purview Information Protection, DLP, sensitivity labels |
| **Network** | Evaluates named locations and IP-based conditions as access signals | Azure Firewall, NSGs, Azure Front Door, microsegmentation |
| **Infrastructure** | Requires MFA for Azure management portal; limited to control-plane entry points | Defender for Cloud, Azure Policy, just-in-time VM access |

This mapping helps identify where Conditional Access alone satisfies pillar requirements and where architects must layer additional controls.

## Phased deployment for Zero Trust alignment

Microsoft recommends a three-phase Conditional Access deployment approach to achieve Zero Trust alignment:

| Phase | Focus | Key policies |
|---|---|---|
| **Phase 1: Foundation** (weeks 1–2) | Block legacy authentication, secure MFA registration, require phishing-resistant MFA for privileged roles | Block legacy auth, protect security info registration, admin MFA strength |
| **Phase 2: Core authentication** (weeks 2–3) | MFA for all users, guest MFA, app protection policies, device-join MFA | Universal MFA, guest access controls, mobile app protection |
| **Phase 3: Advanced protection** (weeks 3–4) | Risk-based sign-in and user policies, token protection, restrict device code flow, block authentication transfer | Risk-based CA, token binding, PAW-based policies |

Deploy each policy in report-only mode first. Review sign-in logs to understand impact before switching to enabled.

## Policy templates for Zero Trust

Microsoft provides Conditional Access policy templates organized into two categories aligned with Zero Trust:

- **Secure foundation** — Eight policies covering core protections: MFA for all users, MFA for admins, MFA for Azure management, block legacy authentication, require compliant devices, phishing-resistant MFA for admins, and others.
- **Zero Trust** — Thirteen policies covering advanced protections: risk-based policies for users and sign-ins, phishing-resistant MFA for all users, block device code flow, require compliant devices for all platforms, enforce persistent browser restrictions, and more.

These templates accelerate Zero Trust alignment but must be customized to exclude emergency access accounts, service accounts, and other identities that require dedicated handling.

## Tools for validating policy alignment

Validating Zero Trust alignment requires continuous assessment. Use these tools to identify coverage gaps:

| Tool | Purpose |
|---|---|
| **[What If tool](/entra/identity/conditional-access/what-if-tool)** | Simulates a sign-in for a user, agent identity, or service principal to determine which policies apply under specific conditions. Useful for testing complex scenarios before deployment. |
| **[Report-only mode](/entra/identity/conditional-access/concept-conditional-access-report-only)** | Evaluates policies without enforcing them, logging what *would have* happened. Essential for impact analysis before enabling new policies. |
| **[Conditional Access gap analyzer workbook](/entra/identity/monitoring-health/workbook-conditional-access-gap-analyzer)** | Identifies four categories of gaps: sign-ins using legacy authentication, applications without Conditional Access, high-risk sign-ins bypassing policies, and sign-ins from locations without policies. |
| **[Conditional Access insights and reporting workbook](/entra/identity/conditional-access/howto-conditional-access-insights-reporting)** | Provides a consolidated view of policy impact over time, including report-only results. Requires a Log Analytics workspace. |
| **[Conditional Access optimization agent](/entra/security-copilot/conditional-access-agent-optimization)** | Uses Security Copilot to analyze policies, recommend new policies based on Zero Trust best practices, propose policy consolidation, and generate policy review reports that highlight spikes or dips indicating misconfiguration. |

## Common misalignments

Watch for these frequent gaps between Conditional Access configuration and Zero Trust requirements:

| Misalignment | Zero Trust impact |
|---|---|
| Emergency access accounts without monitoring | Violates assume breach: compromise of break-glass accounts goes undetected |
| MFA required only for admins | Violates verify explicitly: regular user accounts remain vulnerable |
| No device compliance requirements | Incomplete explicit verification: unmanaged devices create entry points |
| Single blanket policy for all applications | Violates least privilege: same controls regardless of sensitivity level |
| No risk-based policies | Missing continuous verification: elevated risk doesn't trigger additional controls |
| Legacy authentication still permitted | Bypasses MFA and other controls; enables credential-stuffing and password-spray attacks |
| Agent and workload identities unprotected | Coverage gap: nonhuman identities access resources without Zero Trust controls |

## Design considerations

When validating Zero Trust alignment of Conditional Access policies:

- **Assess current state** — Use the gap analyzer workbook and What If tool to document all policies and identify coverage gaps against Zero Trust requirements.
- **Establish emergency access** — Maintain at least two emergency access accounts excluded from Conditional Access policies but monitored through alerts on any sign-in activity.
- **Respect the 195-policy limit** — Each tenant supports a maximum of 195 Conditional Access policies. Use policy consolidation recommendations from the optimization agent to stay within this limit.
- **Prioritize by risk** — Address the highest-risk gaps first: MFA for all users, block legacy authentication, and risk-based policies.
- **Apply naming standards** — Use a consistent naming convention that includes a sequence number, target applications, response, target users, and conditions for easier management.
- **Iterate continuously** — Track policy coverage and effectiveness through the insights and reporting workbook and schedule regular reviews to adapt to new signals, applications, and identity types.
