You can choose to have access removal automated by setting the **Auto apply results to resource option** to **Enable**. Once the review is completed and has ended, users who were not approved by the reviewer will automatically be removed from the resource—or kept with continued access. This could mean removing their group membership, their application assignment, or revoking their right to elevate to a privileged role.

## Take recommendations

The recommendations are displayed to reviewers as part of the reviewer experience and indicate a person’s last sign-in to the tenant or last access to an application. This information helps reviewers make the right access decision. Selecting "Take recommendations" will follow Access Review’s recommendations. At the end of an Access Review, the system will apply these recommendations automatically for users who reviewers have not responded for.

Recommendations are based on the criteria in the access review. For example, if you configure the review to remove access with no interactive sign-in for 90 days, it will recommend that all users who fit that criteria be removed. Microsoft is continually working on enhancing recommendations.

## Review guest user access

Use Access Reviews to review and clean up collaboration partners’ identities from external organizations. Configuration of a per-partner review may satisfy compliance requirements.

External identities can be granted access to company resources through one of the following actions:

- Added to a group.

- Invited to Teams.

- Assigned to an enterprise application or access package.

- Assigned a privileged role in Azure AD or in an Azure subscription.

This [sample script](https://github.com/microsoft/access-reviews-samples/tree/master/ExternalIdentityUse) shows where external identities invited into the tenant are used. You can see external users' group membership, role assignments, and application assignments in Azure AD. The script won't show any assignments outside of Azure AD, such as direct rights assignment to SharePoint resources, without the use of groups.

When creating an Access Review for groups or applications, you can choose to let the reviewer focus on **Everyone with access**, or **Guest users only**. By selecting Guest users only, reviewers are given a focused list of external identities from Azure AD B2B that have access to the resource.
