This module explains how to implement important Microsoft 365 tenant security recommendations that among the most commonly flagged by Microsoft Secure Score. These security controls protect administrative identities, standard users, application consent, Microsoft Teams meetings, privileged roles, and account recovery. You should treat each recommendation as good Microsoft 365 security hardening practice even when Secure Score doesn't currently flag it. 

After completing this module, you can:

- Interpret Microsoft Secure Score points, states, and refresh behavior.
- Prepare emergency access, pilot users, permissions, and recovery data.
- Enforce strong authentication for administrators and standard users.
- Block legacy authentication.
- Remediate risky sign-ins and risky identities.
- Prevent ungoverned delegated application consent.
- Restrict lobby bypass, presenter privileges, and anonymous meeting access.
- Replace broad standing roles with scoped, time-bound roles.
- Enable self-service password reset for every user.
- Validate effective behavior independently from score refresh.

## Interpret Microsoft Secure Score

Microsoft Secure Score measures the extent to which a tenant implements recommended security controls. It combines configuration data, user coverage, completed tasks, and accepted alternate mitigations. It's a posture indicator. It isn't a breach probability, compliance certificate, or complete threat model.

### Understand the score

Open the Microsoft Defender portal, then select **Secure Score**. The overview shows the achieved score, the available score, historical movement, comparison data, and recommended actions.

Points are awarded in three ways:

- Configure the Microsoft control named in a recommendation.
- Complete the security task named in a recommendation.
- Record an approved non-Microsoft control or alternate mitigation.

Most actions use binary scoring. The tenant receives all points only after the complete configuration is detected. Some actions use proportional scoring. If a 10-point action protects 50 of 100 applicable users, the tenant can receive 5 points.

When securing a tenant, don't optimize only for points. A low-value control can close a serious tenant-specific attack path. A high-value control can cause an outage if deployed without dependency analysis. Prioritize by exploitability, privilege, exposed population, existing incidents, implementation effort, and recovery risk.

### Commonly flagged recommendations

Secure Score evaluates many controls. The following table identifies recommendations that often appear when a tenant hasn't completed foundational identity, application, collaboration, privilege, and recovery hardening. They address common attack paths and provide broadly applicable security value.

| Recommendation | Security outcome |
| --- | --- |
| Require multifactor authentication for administrative roles | Reduces privileged account compromise from stolen passwords |
| Require multifactor authentication for all users | Reduces account compromise from phishing, password spray, and credential reuse |
| Block legacy authentication | Closes authentication paths that can't enforce modern controls |
| Configure sign-in risk protection | Challenges authentication requests with credible risk signals |
| Configure user risk protection | Remediates identities likely to be compromised |
| Prevent user consent to applications | Reduces exposure to consent phishing and ungoverned delegated access |
| Admit only invited meeting participants automatically | Places uninvited participants in the lobby |
| Restrict meeting presenters | Limits content sharing and elevated meeting controls |
| Restrict anonymous meeting access | Prevents attendance without a verifiable identity |
| Use least-privileged administrative roles | Reduces standing privilege, scope, and compromise impact |
| Enable self-service password reset for all users | Provides governed account recovery without routine help desk intervention |

> [!NOTE]
> This module doesn't rank these recommendations in order of importance as this will vary depending on the circumstances of the tenancy. Deployment order follows technical dependencies and lockout risk. If you examine security recommendations through Secure Score in your own tenant, you might encounter different wording, points, or applicability. Even if a recommendation isn't listed, you should check the status of the security control.

### Account for detection delay

Secure Score receives configuration data from several products. The dashboard can update quickly, while the recommendation state follows the source product cadence. Microsoft Entra recommendation state is refreshed after configuration changes and at least weekly. Microsoft Teams recommendation state is refreshed after changes and at least monthly.

An unchanged score immediately after implementation doesn't prove failure. Validate the control in its source product:

- Use Conditional Access policy impact, the What If tool, and sign-in logs.
- Inspect risky sign-ins and risky users in Microsoft Entra ID Protection.
- Read effective Microsoft Teams policy assignments.
- Test a representative Teams meeting.
- Inspect Microsoft Entra role assignments and activation history.
- Test password registration and password reset.

### Inspect one recommendation

To inspect a specific recommendation:

1. In **Secure Score**, select **Recommended actions**.
1. Open an action.
1. Read **Implementation** to identify the expected setting.
1. Read **User impact** before scheduling enforcement.
1. Check **Licensing**. The tenant-specific license indicator doesn't remove the security risk.
1. Review **History** for detected changes.
1. Export the recommendation list. Store the export with the date and tenant environment name.

> [!NOTE]
> Secure Score addresses the question: "How much of the recommended control baseline is implemented?". Secure score doesn't address the question: "How likely is a breach?".
