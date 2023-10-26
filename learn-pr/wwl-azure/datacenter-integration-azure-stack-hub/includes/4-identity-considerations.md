You'll need to consider which identity provider you want to use for Azure Stack Hub deployment, either Microsoft Entra ID or Active Directory Federation Services (AD FS). You can't switch identity providers after deployment without full system redeployment. If you don't own the Microsoft Entra account and are using an account provided to you by your Cloud Solution Provider, and if you decide to switch provider and use a different Microsoft Entra account, you'll have to contact your solution provider to redeploy the solution for you at your cost.

Your identity provider choice has no bearing on tenant virtual machines (virtual machines), the identity system, accounts they use, or whether they can join an Active Directory domain, and so on. These things are separate.

### Active Directory Federation Services and Graph integration

If you choose to deploy Azure Stack Hub using Active Directory Federation Services (AD FS) as the identity provider, you must integrate the AD FS instance on Azure Stack Hub with an existing AD FS instance through a federation trust. This integration allows identities in an existing Active Directory forest to authenticate with resources in Azure Stack Hub.

You can also integrate the Graph service in Azure Stack Hub with the existing Active Directory. This integration lets you manage role-based access control (RBAC) in Azure Stack Hub. When access to a resource is delegated, the Graph component looks up the user account in the existing Active Directory forest using the Lightweight Directory Access Protocol.

The following diagram shows integrated AD FS and Graph traffic flow. :::image type="content" source="../media/recommend-identity-provider-11-d34d521c.png" alt-text="Diagram shows integrated AD FS and Graph traffic flow.":::
