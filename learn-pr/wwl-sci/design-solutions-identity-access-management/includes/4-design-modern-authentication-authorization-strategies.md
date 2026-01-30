Modern authentication moves beyond traditional username and password to provide adaptive, context-aware access control. As a security architect, you design authentication and authorization strategies that balance security requirements with user productivity while supporting Zero Trust principles.

## Core components of modern authentication

Modern authentication in Microsoft Entra ID builds on several foundational capabilities:

| Component | Function |
|-----------|----------|
| **Conditional Access** | Policy engine that evaluates signals and enforces access decisions |
| **Continuous Access Evaluation** | Near real-time enforcement of policy changes and critical events |
| **Microsoft Entra Identity Protection** | Risk detection and automated response to suspicious sign-ins |
| **Protected actions** | Additional verification for sensitive operations |

These components work together to create a layered authentication strategy that adapts to changing risk conditions.

## Designing Conditional Access policies

Conditional Access is the Zero Trust policy engine that evaluates every access request against defined conditions and enforces appropriate controls before granting access to apps and data.

:::image type="content" source="../media/risk-based-conditional-access-diagram.png" alt-text="Diagram that shows a conceptual risk-based Conditional Access policy.":::

### Signal evaluation

Conditional Access policies evaluate multiple signals to determine the risk level of each access attempt:

- **User and group membership** - Who is requesting access
- **Application being accessed** - What resource is the target
- **Device state** - Is the device compliant, hybrid joined, or managed
- **Location** - Where is the request originating (IP ranges, countries/regions, named locations)
- **Client application** - Modern authentication or legacy protocols
- **Sign-in risk** - Real-time risk assessment from Identity Protection
- **User risk** - Aggregate risk level based on past behavior

### Access controls

Based on signal evaluation, policies can enforce controls:

- **Block access** - Deny the request entirely
- **Grant access with conditions** - Require MFA, compliant device, approved app, or password change
- **Session controls** - Limit session duration, enforce app-enforced restrictions, or use Conditional Access App Control

### Policy design patterns

Design your Conditional Access policies using these patterns:

- **Baseline policies** - Apply to all users and applications (require MFA for all users, block legacy authentication)
- **Application-specific policies** - Enhanced protection for sensitive applications
- **Risk-based policies** - Respond dynamically to elevated sign-in or user risk
- **Location-based policies** - Different requirements for trusted versus untrusted networks
- **Device-based policies** - Require managed or compliant devices for accessing corporate data

## Continuous Access Evaluation (CAE)

Traditional token-based authentication grants access for the token lifetime, even if conditions change. CAE enables near real-time enforcement when:

- User account is disabled or deleted
- Password is changed or reset
- MFA is enabled for the user
- Administrator explicitly revokes tokens
- User risk level becomes elevated

### CAE design considerations

- **Critical event evaluation** - Microsoft Entra ID notifies resource providers when critical events occur
- **Conditional Access policy evaluation** - Resource providers can request policy re-evaluation for long-lived sessions
- **Token lifetime** - CAE-enabled tokens can have extended lifetimes (up to 28 hours) while maintaining security through continuous evaluation
- **Application support** - Ensure applications support CAE for full benefit

CAE provides stronger security guarantees than short token lifetimes alone and improves user experience by reducing unnecessary reauthentication.

## Risk-based access with Identity Protection

Microsoft Entra Identity Protection analyzes signals to detect suspicious sign-ins and compromised accounts.

[![Diagram showing how Identity Protection conceptually works.](../media/identity-protection-overview.png)](../media/identity-protection-overview.png#lightbox)

### Risk types

| Risk Type | Description | Examples |
|-----------|-------------|----------|
| **Sign-in risk** | Probability that the sign-in isn't authorized | Atypical travel, anonymous IP, malware-linked IP |
| **User risk** | Probability that the user's identity is compromised | Leaked credentials, threat intelligence indicators |

### Risk-based policy design

Configure Conditional Access policies to respond to risk levels:

- **Low risk** - Allow access with standard controls
- **Medium risk** - Require MFA or additional verification
- **High risk** - Block access or require password change and MFA

Enable automated remediation to allow users to self-service when triggered by risk-based policies, such as registering for MFA or performing password reset.

### Investigation and remediation

Security architects should also plan for:

- Risk detection review and investigation workflows
- Integration with security operations through the risky users and sign-ins reports
- Custom detections using Identity Protection APIs

## Protected actions

Some operations are sensitive enough to require additional verification even for authenticated users. Protected actions add a layer of authentication step-up for specific administrative or sensitive operations.

### Use cases for protected actions

- Modifying Conditional Access policies
- Changing tenant settings
- Accessing highly privileged resources
- Performing sensitive data operations

Configure protected actions through authentication context in Conditional Access to require reauthentication or specific authentication methods before allowing sensitive operations.

## Authentication method design

Select authentication methods based on security and usability requirements:

| Method | Security Level | User Experience |
|--------|---------------|-----------------|
| **Passkeys (FIDO2)** | Highest | Passwordless, phishing-resistant |
| **Windows Hello for Business** | Highest | Passwordless, device-bound |
| **Microsoft Authenticator (passwordless)** | High | Passwordless, phone-based |
| **Microsoft Authenticator (push notification)** | Medium-High | MFA, phone-based |
| **SMS/Voice** | Medium | Legacy, fallback only |
| **Password** | Low | Should be combined with MFA |

Plan to move toward phishing-resistant authentication methods and phase out less secure options where possible.

## Microsoft Entra solutions for modern authentication

The following capabilities support your authentication strategy:

- **Microsoft Entra Conditional Access** - Policy-based adaptive access control
- **Microsoft Entra Identity Protection** - Risk detection and automated response
- **Continuous Access Evaluation** - Near real-time policy enforcement
- **Authentication methods policy** - Control available authentication methods
- **Authentication strengths** - Define which authentication methods satisfy policy requirements
- **Named locations** - Define trusted and untrusted network locations

## Design considerations for security architects

When designing modern authentication strategies:

- **Start with secure defaults** - Use security defaults for basic protection; move to Conditional Access for customization
- **Implement policy as code** - Manage Conditional Access policies through templates and version control
- **Plan for break-glass** - Create emergency access accounts excluded from Conditional Access policies
- **Test before deployment** - Use report-only mode to evaluate policy impact
- **Monitor and iterate** - Review sign-in logs and Conditional Access insights to refine policies
- **Consider user experience** - Balance security requirements with productivity to drive adoption
