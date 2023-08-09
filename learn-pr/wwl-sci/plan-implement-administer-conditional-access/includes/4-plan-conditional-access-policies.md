Planning your Conditional Access deployment is critical to achieving your organization's access strategy for apps and resources.

In a mobile-first, cloud-first world, your users access your organization's resources from anywhere using various devices and apps. As a result, focusing on who can access a resource is no longer enough. You also need to consider where the user is, the device being used, the resource being accessed, and more.

Azure AD Conditional Access (CA) analyzes signals, such as user, device, and location, to automate decisions and enforce organizational access policies for resource. You can use CA policies to apply access controls like multifactor authentication (MFA). CA policies allow you to prompt users for MFA when needed for security and to stay out of users’ way when not needed.

:::image type="content" source="../media/conditional-access-overview-how-it-works-b5356a16.png" alt-text="Diagram of how Conditional Access works. Centralize identity provider verifies rules before access is granted.":::


Although security defaults ensure a basic level of security, your organization may need more flexibility than security defaults offer. You can use CA to customize security defaults with more granularity and to configure new policies that meet your requirements.

### Benefits

The benefits of deploying CA are:

 -  Increase productivity. Only interrupt users with a sign-in condition like MFA when one or more signals warrants it. CA policies allow you to control when users are prompted for MFA, when access is blocked, and when they must use a trusted device.
 -  Manage risk. Automating risk assessment with policy conditions means risky sign-ins are at once identified and remediated or blocked. Coupling Conditional Access with Identity Protection, which detects anomalies and suspicious events, allows you to target when access to resources is blocked or gated.
 -  Address compliance and governance. CA enables you to audit access to applications, present terms of use for consent, and restrict access based on compliance policies.
 -  Manage cost. Moving access policies to Azure AD reduces the reliance on custom or on-premises solutions for CA and their infrastructure costs.
 -  Zero trust. Conditional Access helps you move toward a zero-trust environment.

## Understand Conditional Access policy components

CA policies are if-then statements: If an assignment is met, then apply these access controls. When the admin configures CA policies, conditions are called *assignments*. CA policies allow you to enforce access controls on your organization’s apps based on certain assignments.

:::image type="content" source="../media/create-policy-3ac1e413.png" alt-text="Screenshot of the conditional access dialog with the create policy screen open for configuration.":::


Assignments define the users and groups to be affected by the policy, the cloud apps or actions to which the policy will apply, and the conditions under which the policy will apply. Access control settings grant or block access to different cloud apps and can enable limited experiences within specific cloud apps.

Some common questions about assignments, access controls, and session controls:

 -  Users and Groups: Which users and groups will be included in or excluded from the policy? Does this policy include all users, specific group of users, directory roles, or external users?
 -  Cloud apps or actions: What application(s) will the policy apply to? What user actions will be subject to this policy?
 -  Conditions: Which device platforms will be included in or excluded from the policy? What are the organization’s trusted locations?
 -  Access controls: Do you want to grant access to resources by implementing requirements such as MFA, devices marked as compliant, or hybrid Azure AD joined devices?
 -  Session controls: Do you want to control access to cloud apps by implementing requirements such as app enforced permissions or Conditional Access App Control?

### Access token issuance

Access tokens enable clients to securely call protected web APIs, and they're used by web APIs to perform authentication and authorization. Per the OAuth specification, access tokens are opaque strings without a set format. Some identity providers (IDPs) use GUIDs; others use encrypted blobs. The Microsoft identity platform uses a variety of access token formats depending on the configuration of the API that accepts the token.

It’s important to understand how access tokens are issued.

:::image type="content" source="../media/access-policy-token-issuance-516d80f1.png" alt-text="Diagram of the flow of issues an access token for conditional access, and how it is used.":::


> [!NOTE]
> If no assignment is required, and no CA policy is in effect, the default behavior is to issue an access token.

For example, consider a policy where:

IF user is in Group 1, THEN force MFA to access App 1.

IF a user not in Group 1 attempts to access the app, THEN the **“if"** condition is met, and a token is issued. Excluding users outside of Group 1 requires a separate policy to block all other users.

## Follow best practices

The Conditional Access framework provides you with great configuration flexibility. However, great flexibility also means you should carefully review each configuration policy before releasing it to avoid undesirable results.

### Set up emergency access accounts

If you misconfigure a policy, it can lock the organizations out of the Azure portal. Mitigate the accidental administrator lockout by creating two or more emergency access accounts in your organization. You will learn more about emergency access accounts later in this course.

### Set up report-only mode

It can be difficult to predict the number and names of users affected by common deployment initiatives such as:

 -  Blocking legacy authentication.
 -  Requiring MFA.
 -  Implementing sign-in risk policies.

Report-only mode allows administrators to evaluate the CA policies before enabling them in their environment.

### Exclude countries/regions from which you never expect a sign-in

Azure active directory allows you to create named locations. Create a named location that includes all of the countries/regions from which you would never expect a sign-in to occur. Then create a policy for all apps that blocks sign in from that named location. **Be sure to exempt your administrators from this policy**.

## Common policies

When planning your CA policy solution, assess whether you need to create policies to achieve the following outcomes.

 -  **Require MFA.** Common use cases include requiring MFA by admins, to specific apps, for all users, or from network locations you don't trust.
 -  **Respond to potentially compromised accounts.** Three default policies can be enabled: require all users to register for MFA, require a password change for users who are high-risk, and require MFA for users with medium or high sign-in risk.
 -  **Require managed devices.** The proliferation of supported devices to access your cloud resources helps to improve the productivity of your users. You probably don't want certain resources in your environment to be accessed by devices with an unknown protection level. For those resources, require that users can only access them using a managed device.
 -  **Require approved client applications.** Employees use their mobile devices for both personal and work tasks. For BYOD scenarios, you must decide whether to manage the entire device or just the data on it. If managing only data and access, you can require approved cloud apps that can protect your corporate data.
 -  **Block access.** Blocking access overrides all other assignments for a user and has the power to block your entire organization from signing on to your tenant. It can be used, for example, when you are migrating an app to Azure AD, but you aren't ready for anyone to sign in to it yet. You can also block certain network locations from accessing your cloud apps or block apps using legacy authentication from accessing your tenant resources.
    
    > [!IMPORTANT]
    > If you create a policy to block access for all users, be sure to exclude emergency access accounts and consider excluding all administrators from the policy.

## Build and test policies

At each stage of your deployment, ensure that you're evaluating that results are as expected.

When new policies are ready, deploy them in phases in the production environment:

 -  Provide internal change communication to end users.
 -  Start with a small set of users, and verify that the policy behaves as expected.
 -  When you expand a policy to include more users, continue to exclude all administrators. Excluding administrators ensures that someone still has access to a policy if a change is required.
 -  Apply a policy to all users only after it's thoroughly tested. Ensure you have at least one administrator account to which a policy doesn't apply.

### Create test users

Create a set of test users that reflect the users in your production environment. Creating test users enables you to verify policies work as expected before you apply to real users and potentially disrupt their access to apps and resources.

Some organizations have test tenants for this purpose. However, it can be difficult to recreate all conditions and apps in a test tenant to fully test the outcome of a policy.

### Create a test plan

The test plan is important to have a comparison between the expected results and the actual results. You should always have an expectation before testing something. The following table outlines example test cases. Adjust the scenarios and expected results based on how your CA policies are configured.

| **Name of policy**              | **Scenario**                                                                         | **Expected result**                                                                                                                                   |
| ------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Require MFA when working        | Authorized user signs into app while on a trusted location / work                    | User is not prompted to MFA. User is authorized for access. User is connecting from a trusted location. You could choose to require MFA in this case. |
| Require MFA when working        | Authorized user signs into app while not on a trusted location / work                | User is prompted to MFA and can sign in successfully                                                                                                  |
| Require MFA (for admin)         | Global Admin signs into app                                                          | Admin is prompted to MFA                                                                                                                              |
| Risky sign-ins                  | User signs into app using an unapproved browser                                      | User is prompted to MFA                                                                                                                               |
| Device management               | Authorized user attempts to sign in from an authorized device                        | Access granted                                                                                                                                        |
| Device management               | Authorized user attempts to sign in from an unauthorized device                      | Access blocked                                                                                                                                        |
| Password change for risky users | Authorized user attempts to sign in with compromised credentials (high risk sign-in) | User is prompted to change password or access is blocked based on your policy                                                                         |

## License requirements

 -  Free Azure AD - No Conditional Access
 -  Free Office 365 subscription - No Conditional Access
 -  Azure AD Premium 1 (or Microsoft 365 E3 and up) - Conditional access work based on standard rules
 -  Azure AD Premium 2 - Conditional Access, and you get the ability to use Risky sign-in, Risky Users, and risk-based sign-in options as well (from Identity Protection)
