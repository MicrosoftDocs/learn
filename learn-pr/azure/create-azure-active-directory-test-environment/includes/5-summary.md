<!-- 1. Restate the scenario problem --------------------------------------------------------------------------------

    Goal: Summarize the challenge(s) posed in the introduction scenario; be brief (1-2 sentences)

    Heading: none

    Example: "You are writing the instruction manual for a new model fire extinguisher. The instructions must be quickly read and understood by a wide variety of people."

    [Summary unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-module-summary-unit?branch=main)
-->
Great work!  You've successfully:

- Learned how to evaluate whether you should use an existing production tenant in Azure Active Directory (Azure AD) for your application test environment, or whether you should create a separate test tenant
- Set up a dedicated test tenant in Azure AD
- Created a test user in the test tenant
- Created an app registration to use as a test client for your web app

Having completed this module, you can use this test environment in Azure AD as a starting point for testing your applications.  You can also use this Azure AD test environment as a resource in a CI/CD pipeline that moves a web app through the development, test, and production lifecycle.
<!-- 2. Show how you solved the scenario problem(s)---------------------------------------------------

    Goal: Describe how you used the product to solve the problem(s) posed in the introduction scenario

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Recommended: format this as lead-in sentence(s) followed by a list

    Example: "You did some research and found that Plain English is a good writing style for safety-critical communications. You applied several Plain English techniques to your instructions:
        * Removed unnecessary words, which made your sentences easier to read even in a stressful situation like a fire.
        * Made sure all sentences used the active voice, which made your content more direct.
        * Replaced fire-industry jargon with everyday words, which made the instructions accessible to a wider audience.
        * Replaced a comma-delimited list with a bulleted list, which made the steps to activate the fire extinguisher easier to follow."
 -->
<!--TODO: add your lead-in sentence(s)
TODO: add your list of techniques used to solve the scenario problem -->

<!-- 3. Describe the experience without the product ---------------------------------------------------

    Goal: Describe what would be required to solve the problem without using the product; be brief (1-2 sentences)

    Heading: none; typically this will be a new paragraph

    Example: "Fire extinguishers are critical safety equipment for both homes and businesses. Despite their importance, many customers don't read the instructions ahead of time. Confusing instructions could mean customers don't use the extinguisher correctly when they're needed. This can result in loss of property or life."

 -->
<!--TODO: describe the experience without the product-->

<!-- 4. Describe the business impact ----------------------------------------------------

    Goal: explain the business impact of using the product to solve the problem

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "The test for effective instructions is whether customers can use your extinguishers correctly during an emergency. Users that fail might blame the instructions or the product. In either case, it's not good for business. On the other hand, successful customers are likely to share their stories and become advocates for your product."
 -->
<!--TODO: describe the business impact -->

<!-- 5. References (optional) ----------------------------------------------------

    Goal: Provide a few recommendations for further study via a bulleted list of links. This is optional and intended to be used sparingly.        - use the target page title as the text for your link
        - do not include other text such as a description
        - prefer other first-party sites like Docs reference pages
        - link to third-party sites only when they are trusted and authoritative
        - do not link to other Learn content ("next steps" recommendations are generated automatically)
        - avoid linking to opinion sites such as blog posts

    Heading: "## References"

    Example:
        "## References
          * [Administrator role permissions in Azure Active Directory](https://learn.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
          * [What is Azure role-based access control (Azure RBAC)?](https://learn.microsoft.com/azure/role-based-access-control/overview)
          * [Manage access to billing information for Azure](https://learn.microsoft.com/azure/billing/billing-manage-access)"
 -->

<!-- Do not include any other content -->
## Clean up

In this module, you created resources using your Azure subscription. You'll want to clean up these resources so that they won't count against your quotas and/or you won't continue to be charged for them. If you don’t need the resources you created to complete other training modules, delete the resources by completing the following steps.

### Delete a user

To delete a user in Azure CLI, run the az ad user delete command as a Global Administrator or a User Administrator.

```azurecli-interactive
az ad user delete --id "<NewUser@contoso.onmicrosoft.com>"
```

### Delete an app registration

To delete an app registration in Azure CLI, run the az ad app delete command as a Global Administrator or Application Administrator.

```azurecli-interactive
az ad app delete --id $TESTUPN
```

### Delete an Azure AD tenant

When a tenant is deleted in Azure AD, all resources in the organization are also deleted. Prepare your organization by minimizing its associated resources before you delete. Only a global administrator in Azure AD can delete an Azure AD organization from the Azure portal.

#### Prepare the tenant

You can't delete an organization in Azure AD until it passes several checks.

- You've paid all outstanding invoices and amounts due or overdue.
- No users are in the Azure AD tenant, except one global administrator who will delete the organization. You must delete any other users before you can delete the organization.
- If users are synchronized from on-premises, turn off the sync first. You must delete the users in the cloud organization by using the Azure portal or Azure PowerShell cmdlets.
- No applications are in the organization. You must remove any applications before you can delete the organization.
- No multi-factor authentication providers are linked to the organization.
- No subscriptions for any Microsoft Online Services offerings (such as Azure, Microsoft 365, or Azure AD Premium) are associated with the organization.
- For example, if a default Azure AD tenant was created for you in Azure, you can't delete this organization if your Azure subscription still relies on it for authentication. You also can't delete a tenant if another user has associated an Azure subscription with it.

#### Delete the tenant

1. Sign in to the [Azure AD admin center](https://aad.portal.azure.com) with an account that is the global administrator for your organization.
1. Select **Azure Active Directory**.
1. On a tenant's **Overview** page, select **Manage tenants**.
   :::image type="content" source="../media/manage-tenants-command.png" alt-text="Screenshot that shows the button for managing tenants.":::

1. Select the checkbox for the tenant that you want to delete, and then select **Delete**.

   :::image type="content" source="../media/manage-tenants-delete-command.png" alt-text="Screenshot that shows the button for deleting an organization.":::
1. If your organization doesn't pass one or more checks, you'll get a link to more information on how to pass. After you pass all checks, select **Delete** to complete the process.