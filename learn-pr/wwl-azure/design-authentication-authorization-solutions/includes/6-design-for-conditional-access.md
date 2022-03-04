[Conditional Access](/azure/active-directory/conditional-access/overview) is a tool that Azure Active Directory uses to allow (or deny) access to resources. During sign-in, Conditional Access examines who the user is, where the user is, and from what device the user is requesting access. Based on these signals Conditional Access can allow access, enforce multifactor authentication, or deny access.  

:::image type="content" source="../media/conditions-actions.png" alt-text="Conditions are evaluated and access is determined.":::


Here are some example conditional access situations.

- Require multifactor authentication (MFA). MFA can be used to provide a secondary authentication for accessing certain apps. MFA can be selectively applied to certain users, like administrators, or just users coming from external networks.

- Require access to services only through approved client applications. For example, only allow users to access Office 365 services from a mobile device if they use approved client apps, like the Outlook mobile app.

- Require users to access applications only from managed devices. A managed device is a device that meets your standards for security and compliance.

- Block access from untrusted sources, such as access from unknown or unexpected locations.

## Things to consider when using conditional access

- **Use for enabling multifactor authentication for more granular control**. Conditional Access provides a more granular multifactor authentication experience for users. For example, a user might not be challenged for second authentication factor if they're at a known location. However, they might be challenged for a second authentication factor if they're at an unexpected location.

- **Test by using report-only mode**. [Report-only mode](/azure/active-directory/conditional-access/concept-conditional-access-report-only) allows administrators to evaluate the impact of Conditional Access policies before enabling them in their environment. Report-only mode can help predict the number and names of users affected by common deployment initiatives. Use report-only mode to test blocking legacy authentication, requiring MFA, and implementing sign-in risk policies. 

- **Exclude geographic areas from which you never expect a sign-in**. Azure Active Directory allows you to create named locations. Create a named location that includes all the geographic areas from which you would never expect a sign-in to occur. Then create a policy for all apps that blocks sign-in from that named location. Be sure to exempt your administrators from this policy.

- **[Require managed devices](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)**.  The proliferation of supported devices to access your cloud resources helps to improve the productivity of your users. You probably don't want certain resources in your environment to be accessed by devices with an unknown protection level. For those resources, require that users can only access them using a managed device.

- **Require approved client applications.** Employees use their mobile devices for both personal and work tasks. In these scenarios, you must decide whether to manage the entire device or just the data on it. If managing only data and access, you can require only approved cloud apps. This can help to protect your corporate data.

- **Respond to potentially compromised accounts.** Three default policies can be enabled: require all users to register for MFA, require a password change for users who are high-risk, and require MFA for users with medium or high sign-in risk.

- **Block access.** Blocking access overrides all other assignments for a user and has the power to block your entire organization from signing on to your tenant. It can be used, for example, when you’re migrating an app to Azure AD, but you aren't ready for anyone to sign-in yet. You can also block certain network locations from accessing your cloud apps or block apps using legacy authentication from accessing your tenant resources.

- **Block legacy authentication protocols**. Attackers exploit weaknesses in older protocols every day, particularly for password spray attacks. Configure Conditional Access to [block legacy protocols](/azure/active-directory/conditional-access/howto-conditional-access-policy-block-legacy).

- **Use the** **What If** tool. The [What If](/azure/active-directory/conditional-access/what-if-tool) tool helps you plan and troubleshoot your Conditional Access policies. The What If tool enables you to test your proposed Conditional Access policies before you implement them.

> [!NOTE]
> To use Conditional Access, you need an Azure AD Premium P1 or P2 license. If you have a Microsoft 365 Business Premium license, you also have access to Conditional Access features. 