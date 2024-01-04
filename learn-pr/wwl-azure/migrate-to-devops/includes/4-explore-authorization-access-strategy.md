Azure DevOps Services uses enterprise-grade authentication. To protect and secure your data, you can use:

 -  Microsoft account.
 -  GitHub account.
 -  Microsoft Entra ID.

Tools like Visual Studio and Azure DevOps natively support the use of Microsoft Accounts and Microsoft Entra ID. Eclipse can also support this form of authentication if you install a Team Explorer Everywhere plug-in.

## Personal access tokens

Use personal access tokens (PAT) for tools that don't directly support Microsoft accounts or Microsoft Entra ID for authentication. You can use it if you want them to integrate with Azure DevOps.

For example, tools like:

 -  Git-based repositories.
 -  NuGet.
 -  Xcode.<br>

These tokens can be set up using Git Credential managers, or you can create them manually.

Personal access tokens are also helpful when establishing access to command-line tools, external tools, and tasks in build pipelines.

Also, when calling REST-based APIs, you don't have a UI popping out to do the authentication. When access is no longer required, you can revoke the personal access token.

## Security groups

Azure DevOps is pre-configured with default security groups.

Default permissions are assigned to the default security groups. You can also configure access at the organization, collection, and project or object levels.

In the organization settings in Azure DevOps, you can configure app access policies. Based on your security policies, you might allow alternate authentication methods, enable third-party applications to access via OAuth, or even allow anonymous access to some projects.

For even tighter control, you can use Conditional Access policies. These offer simple ways to help secure resources such as Azure DevOps when using Microsoft Entra ID for authentication.

## Multifactor authentication

Conditional Access policies such as multifactor authentication can help to minimize the risk of compromised credentials.

As part of a Conditional Access policy, you might require:

 -  Security group membership.
 -  A location or network identity.
 -  A specific operating system.
 -  A managed device or other criteria.
