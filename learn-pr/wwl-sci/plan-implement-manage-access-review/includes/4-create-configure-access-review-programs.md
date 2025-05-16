Microsoft Entra access reviews are a feature of Microsoft Entra ID Governance. Access reviews help to ensure that the right identities have the right access to the right resources in the organization. Access reviews can be implemented programmatically using the access reviews API in Microsoft Graph.

To create an access review using Graph, call the Graph API to create an access review schedule definition. The caller must either be a user in an appropriate role with an application that has the delegated `AccessReview.ReadWrite.All` permission, or an application with the `AccessReview.ReadWrite.All` application permission.

You can also create an access review in PowerShell with the `New-MgIdentityGovernanceAccessReviewDefinition` cmdlet from the Microsoft Graph PowerShell cmdlets for Identity Governance module.

The access reviews API in Microsoft Graph enables organizations to audit and attest to the access that identities are assigned to resources in the organization. For example, access to a SharePoint site that contains customer contact information. And by using the access reviews API, organizations can check and attest to access to such groups and by extension, resources.

## Access Review API for a security groups

This learning module doesn't recreate the step by step method to use the API, to get that information see the article - [Review access to security groups using access reviews APIs.](/graph/tutorial-accessreviews-securitygroup)  Here are the high level steps that need to be performed.

1. Create an access review for the security group
2. List instances of the access review
3. Verify who was contacted for the review
4. Get decisions
5. Self-attest to a pending access decision
6. Confirm the decisions and the status of the access review
7. Clean up resources

During each step you can use the API to create the access review, assign it, check the results, and act on that information.
