Planning your Conditional Access deployment is critical to achieving your organization's access strategy for apps **and** resources.

Azure Active Directory (Azure AD) Conditional Access analyses signals such as user, device, and location to automate decisions and enforce organizational access policies for resource. You can use Conditional Access policies to apply access controls like multifactor authentication (MFA). Conditional Access policies allow you to prompt users for MFA when needed for security, and stay out of users’ way when not needed.

:::image type="content" source="../media/planning-conditional-access-1-060d60dd.png" alt-text="Conditional Access overview":::


Microsoft provides standard conditional policies called security defaults that ensure a basic level of security. However, your organization may need more flexibility than security defaults offer. You can use Conditional Access to customize security defaults with more granularity and to configure new policies that meet your requirements.

### Benefits

The benefits of deploying Conditional Access are:

 -  **Increase productivity**. Only interrupt users with a sign-in condition like MFA when one or more signals warrants it. Conditional Access policies allow you to control when users are prompted for MFA, when access is blocked, and when they must use a trusted device.
 -  **Manage risk**. Automating risk assessment with policy conditions means risky sign-ins are at once identified and remediated or blocked. Coupling Conditional Access with Identity Protection, which detects anomalies and suspicious events, allows you to target when access to resources is blocked or gated.
 -  **Address compliance and governance**. Conditional Access enables you to audit access to applications, present terms of use for consent, and restrict access based on compliance policies.
 -  **Manage cost**. Moving access policies to Azure AD reduces the reliance on custom or on-premises solutions for Conditional Access, and their infrastructure costs.

### Prerequisites

 -  A working Azure AD tenant with Azure AD Premium or trial license enabled.
 -  An account with Conditional Access administrator privileges.
 -  A non-administrator user with a password you know, such as testuser.
 -  A group that the non-administrator user is a member of.
