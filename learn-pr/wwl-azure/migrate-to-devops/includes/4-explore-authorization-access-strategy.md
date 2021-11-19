Azure DevOps Services uses enterprise-grade authentication. To protect and secure your data, you can use:

 -  Microsoft account.
 -  GitHub account.
 -  Azure Active Directory (Azure AD).

Tools like Visual Studio and Azure DevOps natively support the use of Microsoft Accounts and Azure AD. Eclipse can also support this form of authentication if you install a Team Explorer Everywhere plug-in.

## Personal access tokens

Use personal access tokens (PAT) for tools that do not directly support Microsoft accounts or Azure AD for authentication. Also, if you want them to integrate with Azure DevOps.

For example, tools like:

 -  Git-based repositories.
 -  NuGet.
 -  Xcode.<br>

These tokens can be set up using Git Credential managers, or you can create them manually.

Personal access tokens are also helpful when establishing access to command-line tools, external tools, and tasks in build pipelines.

Also, when calling REST-based APIs, you do not have a UI popping out to do the authentication. When access is no longer required, you can then revoke the personal access token.

## Security groups

Azure DevOps is pre-configured with default security groups. Default permissions are assigned to the default security groups. But you can also configure access at the organization level, the collection level, and the project or object level.

In the organization settings in Azure DevOps, you can configure app access policies. Based on your security policies, you might allow alternate authentication methods, enable third-party applications to access via OAuth, or even allow anonymous access to some projects.

For even tighter control, you can set conditional access to Azure DevOps. It offers simple ways to help secure resources when using Azure Active Directory for authentication.

## Multifactor authentication

Conditional access policies such as multifactor authentication can help to minimize the risk of compromised credentials.

As part of a conditional access policy, you might require:

 -  Security group membership.
 -  A location or network identity.
 -  A specific operating system.
 -  A managed device, or other criteria.
