<!-- 1. Restate the scenario problem --------------------------------------------------------------------------------

    Goal: Summarize the challenge(s) posed in the introduction scenario; be brief (1-2 sentences)

    Heading: none

    Example: "You are writing the instruction manual for a new model fire extinguisher. The instructions must be quickly read and understood by a wide variety of people."

    [Summary unit guidance](https://review.learn.microsoft.com/learn-docs/docs/id-guidance-module-summary-unit?branch=main)
-->
Your organization was launching an online grocery store. Your organization needed customers to be authenticated in a web app before they could make an order. Instead of managing customer identities from within the web app, which is a challenge, and wouldn't scale well, your organization needed to use an identity management solution.

Azure AD B2C helped your organization to authenticate users into your web app. We used Azure AD B2C's user flows to manage a users sign up and sign in journeys. Your Node web app redirected the user to Azure AD B2C where user authentication occurred and only received a response from Azure AD B2C as an ID token and token claims for user identification.

If your organization didn't use Azure AD B2C, you'd have to build a whole authentication module from scratch, model a user's data schema, and store the data yourself. Because users can also use social identities, you'd perform the integration yourself. Besides, you'd have to deal with scaling and safety of the authentication platform.

By using Azure AD B2C and with the help of msal-node library, you added an authentication module to your web app quickly with few lines of code. Also, Azure AD B2C handles scaling and safety out of the box.

<!-- TODO: restate the scenario problem-->

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
<!--TODO: add your lead-in sentence(s)-->
<!--TODO: add your list of techniques used to solve the scenario problem-->

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
<!--TODO: describe the business impact-->

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
          * [Administrator role permissions in Azure Active Directory](/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
          * [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
          * [Manage access to billing information for Azure](/azure/billing/billing-manage-access)"
 -->

<!-- Do not include any other content -->
