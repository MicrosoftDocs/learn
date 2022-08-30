<!-- 1. Restate the scenario problem --------------------------------------------------------------------------------

    Goal: Summarize the challenge(s) posed in the introduction scenario; be brief (1-2 sentences)

    Heading: none

    Example: "You are writing the instruction manual for a new model fire extinguisher. The instructions must be quickly read and understood by a wide variety of people."

    [Summary unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-module-summary-unit?branch=main)
-->
The retail chain at which you work as a data scientist has been experiencing computer performance issues, which seem to be related to virtual machines with high CPU usage and insufficient free space.

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
You ran KQL queries in Azure Monitor Log Analytics to extract insights about your virtual machines from log data you collected. 
You applied several techniques in your analysis, including:

- Setting clear analysis goals.
- Examining log data.
- Assessing which KQL operations can help you use your log data to achieve your analysis goals.

<!-- 3. Describe the experience without the product ---------------------------------------------------

    Goal: Describe what would be required to solve the problem without using the product; be brief (1-2 sentences)

    Heading: none; typically this will be a new paragraph

    Example: "Fire extinguishers are critical safety equipment for both homes and businesses. Despite their importance, many customers don't read the instructions ahead of time. Confusing instructions could mean customers don't use the extinguisher correctly when they're needed. This can result in loss of property or life."

 -->
Log analysis is critical to managing monitored resources, discovering and responding to problems, and mitigating potential issues. Raw log data contains an overwhelming amount of information that is hard to understand and correlate in meaningful ways without tools like Log Analytics and KQL.  

<!-- 4. Describe the business impact ----------------------------------------------------

    Goal: explain the business impact of using the product to solve the problem

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "The test for effective instructions is whether customers can use your extinguishers correctly during an emergency. Users that fail might blame the instructions or the product. In either case, it's not good for business. On the other hand, successful customers are likely to share their stories and become advocates for your product."
 -->
Analyzing log data in Log Analytics using KQL lets you gain crucial insights and manage your IT environment effectively and proactively.

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
          * [Administrator role permissions in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
          * [What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/azure/role-based-access-control/overview)
          * [Manage access to billing information for Azure](https://docs.microsoft.com/azure/billing/billing-manage-access)"
 -->
## References

- [Log queries in Azure Monitor](/azure/azure-monitor/logs/log-query-overview)
- [Azure Monitor data reference](/azure/azure-monitor/logs/log-query-overview)
- [Query quick reference guide](/azure/data-explorer/kql-quick-reference)

<!-- Do not include any other content -->
