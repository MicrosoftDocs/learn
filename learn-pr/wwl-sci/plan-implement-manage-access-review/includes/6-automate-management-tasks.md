You can choose to have access removal automated by setting the **Auto apply results to resource** to **Enable**. Once the review is completed and ends, users not approved by the reviewer are automatically removed from the resource—or kept with continued access. Access removal could mean removing their group membership, their application assignment, or revoking their right to elevate to a privileged role.

## Take recommendations

The recommendations are displayed to reviewers as part of the reviewer experience and indicate a person's last sign-in to the tenant or last access to an application. This information helps reviewers make the right access decision. Selecting "Take recommendations" follows the access review recommendations. At the end of an access review, the system applies these recommendations automatically for users that reviewers failed to respond to.

Recommendations are based on the criteria in the access review. For example, if you configure the review to remove access with no sign-in for 30 days, it recommends that all users who fit that criterion be removed—applies to both interactive and non-interactive sign-ins. Recommendations can also be based on **peer outlier** analysis—if a user doesn't have the same access as others in their reporting structure, the system recommends denial. Microsoft is continually working on enhancing recommendations.

## Review guest user access

Use Access Reviews to review and clean up collaboration partners’ identities from external organizations. Configuration of a per-partner review can satisfy compliance requirements.

External identities can be granted access to company resources through one of the following actions:

- Added to a group.
- Invited to Teams.
- Assigned to an enterprise application or access package.
- Assigned a privileged role in Microsoft Entra ID or in an Azure subscription.

This [sample script](https://github.com/microsoft/access-reviews-samples/tree/master/ExternalIdentityUse) shows where external identities invited into the tenant are used. You can see external users' group membership, role assignments, and application assignments in Microsoft Entra ID. The script won't show any assignments outside of Microsoft Entra ID, such as direct rights assignment to SharePoint resources, without the use of groups.

When creating an Access Review for groups or applications, you can choose to let the reviewer focus on **Everyone with access**, or **Guest users only**. By selecting Guest users only, reviewers are provided a focused list of external identities from Microsoft Entra B2B that have access to the resource.
