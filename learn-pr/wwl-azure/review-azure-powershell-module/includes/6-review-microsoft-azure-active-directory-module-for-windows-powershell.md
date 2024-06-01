# Review Microsoft Graph PowerShell module

The Microsoft Graph module for Windows PowerShell provides cmdlets that you can use for Microsoft Entra administrative tasks. These tasks include user management, domain management, and configuring single sign-on. This topic includes information about how to install these cmdlets for use with your directory.

The following list summarizes the key advantages of using the Microsoft Graph PowerShell SDK.

- **Access to all Microsoft Graph APIs**: Microsoft Graph PowerShell is based on Microsoft Graph API. The Microsoft Graph API includes, in addition to Microsoft Entra ID, APIs from other Microsoft services like SharePoint, Exchange, and Outlook, all accessed through a single endpoint with a single access token.
- **Supports PowerShell 7**: Microsoft Graph PowerShell module works with PowerShell 7 and later. It's also compatible with Windows PowerShell 5.1.
- **Cross-platform support**: Microsoft Graph PowerShell module works on all platforms including Windows, macOS, and Linux.
- **Supports modern authentication**: Microsoft Graph PowerShell supports the Microsoft Authentication Library (MSAL) which offers more security. For example, you can use Passwordless sign-in experiences.
- **Supports external identities**: Users from other Microsoft Entra tenants can authenticate to services in your tenant with Microsoft Graph PowerShell.
- **Uses least privilege**: Microsoft Graph PowerShell permissions are NOT pre-authorized and users must perform one-time request for app permissions depending on their needs.
- **Advanced queries**: Microsoft Graph PowerShell supports rich, advanced queries via eventual consistency. For example, you can get a near-instant count of all users using advanced queries.
- **Open source**: Feature teams and the community can create great PowerShell experiences and share them with everyone.
- **Receives regular updates**: Microsoft Graph PowerShell commands are updated regularly to support the latest Graph API updates.

The easiest way to install the module is from the PowerShell Gallery. You can install the module with the **Install-Module** cmdlet by running the following command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module Microsoft.Graph
```
You can also add beta features for Microsoft Graph SDK by running (not required):

```powershell
Install-Module Microsoft.Graph.Beta
```
## Connecting to Microsoft Entra ID with PowerShell

If you want to connect to the Microsoft Entra service with the Microsoft Graph module for Windows PowerShell, run the following command:

```powershell
Connect-MgGraph -Scopes 'User.Read.All'
```

After running the previous command, you'll be prompted for your Microsoft Entra credentials. You should use the credentials that you use to sign in to Microsoft 365 or your Azure services. After you authenticate, you'll be able to use the cmdlets available for Microsoft Entra management.

> **Additional reading:** For more information about the cmdlets related to Microsoft Entra ID in the PowerShell for Graph, refer to [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview?view=graph-powershell-1.0).
