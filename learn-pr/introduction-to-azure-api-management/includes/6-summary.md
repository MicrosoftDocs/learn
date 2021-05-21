<!-- 1. Goal and criteria-----------------------------------------------------------------------------

    Goal: Recap that this module's goal is 'evaluate' using the provided decision criteria.

    Format: Short text followed by a bulleted list of the decision criteria developed in the "When to use <product>" unit.

    Heading: none

    Example: "Our goal was to help you evaluate whether Logic Apps would be a good choice for your business process. We developed some criteria you can use to guide your decision:
    * Integration
    * Performance
    * Conditionals
    * Connectors"

-->
Our goal in this module was to help you evaluate whether Azure API Management is appropriate for managing and exposing<!-- Same comment about changing the word "exposing." --> your organization's APIs. To help you make that decision, we presented some criteria you can use:

- Number of APIs
- Rate of API changes
- API administration load

<!-- 2. Show how you solved the scenario problem(s)---------------------------------------------------

    Goal: Briefly summarize how you applied the decision criteria to the scenario problem(s). Ideally, discuss two scenarios, one where the product was appropriate and one where it wasn't.

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "We applied these criteria to our fictional shoe company. The analysis helped us see how difficult it would be to use Logic Apps for each process. Both the social-media monitor and the video archive utility used only the built-in connectors. This characteristic made them perfect for Logic Apps. The online sales portal required more work because it had complex conditionals and needed custom connectors."
 -->

We applied these criteria in the context of our fictional food delivery organization. You learned that in most scenarios, Azure API Management offers the following benefits:

- Improved API standardization through enabling management of multiple APIs from a single administrative interface.
- Enhanced centralization of all API operations by bringing multiple APIs under a single administrative umbrella.
- Tightened API security resulting from permissions<!-- Can we say what kind of permissions? For example, "standardized permissions?" -->, access control policies, and attack surface reduction.

However, you also learned that some organizations might not benefit from using Azure API Management if they have:

- A relatively small number of deployed APIs.
- APIs that are mostly static or require few revisions.
- APIs that require few, if any, administrative extras such as policies, users, and analytics.

<!-- 3. Describe the business impact ----------------------------------------------------

    Goal: explain how choosing the right product is important

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "The criteria help you evaluate whether your business processes are a good match for Logic Apps. First, they let you assess how well Logic Apps will solve your problem. Second, they give you an idea of the amount of customization effort involved in using them for your task. This process should give you enough information to choose the right product for your work."
 -->
The criteria help you evaluate whether your organization's APIs would benefit from being gathered under the umbrella of Azure API Management. <!-- These two sentences don't flow together. Can we either add a sentence to transition them, or make this second sentence a new pgph? If you do the latter, you'll need to add a second sentence to this first sentence so as to avoid a single-sentence pgph. -->Today's connected world is increasingly being driven by the *API economy*&mdash;how API usage by developers and their consumers generates important revenue streams for the companies that publish the APIs. If you want to maximize your API economy, you need to use this module's criteria to assess how well Azure API Management would improve your organization's ability to adapt its APIs to satisfy consumers, follow business trends, and take advantage of new opportunities.<!-- This sentence is too long for Acrolinx. Can we break it into two? --> The process you went through here should give you enough information to choose the correct API lifecycle management solution for your organization.

<!-- 4. References (optional) ----------------------------------------------------

    Goal: Provide a few recommendations for further study via a bulleted list of links. This is optional and intended to be used sparingly.
        - use the target page title as the text for your link
        - do not include other text such as a description
        - prefer other first-party sites like Docs reference pages
        - link to third-party sites only when they are trusted and authoritative
        - do not link to other Learn content ("next steps" recommendations are generated automatically)
        - avoid linking to opinion sites such as blog posts

    Heading: "## References"

    Example:
        "References
        * [Administrator role permissions in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
        * [What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/azure/role-based-access-control/overview)
        * [Manage access to billing information for Azure](https://docs.microsoft.com/azure/billing/billing-manage-access)"
 -->

## References
<!-- Please fix the last two links in this list - I think they just need an "https://" in front of them, but I cannot change them. -->
- [Azure API Management](https://azure.microsoft.com/services/api-management/?azure-portal=true)
- [Azure API Management pricing](https://azure.microsoft.com/pricing/details/api-management/?azure-portal=true)
- [Feature-based comparison of the Azure API Management tiers](/azure/api-management/api-management-features?azure-portal=true)
- [Azure API Management FAQs](/azure/api-management/api-management-faq?azure-portal=true)

<!-- Do not include any other content -->
