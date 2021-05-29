<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'evaluate' learning objective.

    Pattern:
        One paragraph of 2 sentences:
            Sentence 1: State that this unit addresses ("when to use it").
            Sentence 2: State that this unit targets this learning objective: "Evaluate whether <product> is appropriate to <general product use case>."
        Decision criteria as a bulleted list.

    Heading: none

    Example: "Here, we'll discuss how you can decide whether Logic Apps is the right choice for a workflow. We'll list some criteria that indicate whether Logic Apps will meet your performance and functional goals.
        * Integration
        * Performance
        * Conditionals
        * Connectors"
-->
Now we'll discuss some scenarios that illustrate when it's appropriate to use Azure API Management. Using the food delivery service as an example, we'll investigate API lifecycle management with respect to standardizing APIs, centralizing API management and exposure, and enhancing API security. Here are the criteria we'll use to help you decide whether Azure API Management is a suitable choice for managing and exposing your organization's inventory of APIs:

- Number of APIs
- Rate of API changes
- API administration load

<!-- 2. Decision criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the criteria discussion.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: describing the negative ("when not to use") at a high level.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Decision criteria"

    Example:
        "Decision criteria"
         "Logic Apps helps you coordinate the flow of data through disparate systems. The cases where Logic Apps might not be the best option typically involve real-time requirements, complex business rules, or use of non-standard services. Here's some discussion of each of these factors."
-->

## Decision criteria

Azure API Management helps you administer and expose your organization's APIs when you're dealing with a large number of deployed APIs that you revise often and that require significant administrative overhead. The use cases where Azure API Management might not be the correct choice typically involve small, static, or simple API deployments. Let's take a closer look at these decision criteria.

<!-- 3a. Decision criteria (for simple criteria) ----------------------------------------------------

    Note:
        Choose either 3a or 3b for your content; do not do both.
        This pattern is for simple criteria where the analysis is brief and does not require a visual element.

    Goal: Describe in detail each criterion that helps the "when to use it" decision.

    Heading: none, this content will be the 'body' for the "Decision criteria" heading above.

    Pattern:
        No heading.
        Place both the criteria and analysis into a table.

    Example:
        | | |
        | --- | --- |
        | **Criteria** | **Analysis**|
        | **Integration** | The key question to ask when you're considering Logic Apps is "do I need to integrate services?".... |
        | **Performance** | The next consideration is performance. The Logic Apps execution engine scales your apps automatically.... |
        | **Conditionals** | Logic Apps provides control constructs like Boolean expressions, switch statements, and loops.... |
        | **Connectors** | The last consideration is whether there are pre-built connectors for all the services you need to access. |
        |   |   |
-->
| **Criteria** | **Analysis**|
| --- | --- |
| **Number of APIs** | The key consideration when you're evaluating Azure API Management is the number of APIs that you manage. The more APIs you've deployed, the greater the need for standardization of those deployments and centralization of API control. |
| **Rate of API changes** | The next consideration is the rate at which your organization implements API revisions and versions. The faster you create API revisions and publish new API versions, the greater the need for a robust and flexible versioning control system. |
| **API administration load** | The last consideration is how much policy overhead you apply to your APIs. This includes usage quotas, call rate limits, request transformations, and request validation. The more configurations and options your APIs require, the greater the need for standardized and centralized policy implementations. |
|   |   |

<!-- 3b. Decision criteria (for complex criteria) ----------------------------------------------------------

    Note:
        Choose either 3a or 3b for your content; do not do both.
        This pattern is for complex criteria where the analysis of each criterion needs both and a visual element.

    Goal: Describe in detail each criterion that helps the "when to use it" decision.

    Pattern:
        For each criterion, repeat this pattern:
            1. H3 of the criterion.
            2. 1-3 paragraphs of discussion/analysis.
            3. Visual like an image, table, list, code sample, or blockquote.
            
    Example:
        H3: "Integration"
        Prose: The key question to ask when you're considering Logic Apps is _"do I need to integrate services?"_ Logic Apps work well when you need to get multiple applications and systems to work together. That's what they were designed to do. If you're building an app with no external connections, Logic Apps is probably not the best option."
        Visual: <image preferred>
-->

<!-- 4. Apply-the-criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the example applications of the criteria.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: Acknowledge that there are cases for which <product> won't work and/or there are edge cases that are difficult to decide.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Apply the criteria"

    Example:
        "Apply the criteria"
         "Logic Apps works best when you're integrating multiple services with some added control logic. The decision is often a judgment call though. Let's think about how to apply these criteria to our example processes."
-->

## Apply the criteria

Azure API Management is the correct choice for managing APIs through their lifecycles when there is a large API deployment that changes frequently and requires significant policy overhead. However, these criteria don't apply equally to all use cases. Let's see how these criteria apply to our scenario's use cases.

<!-- 5. Apply the criteria examples -----------------------------------------------------------------------------

    Goal: Apply the criteria to the 2-3 customer tasks in the scenario described in your introduction unit.

    Pattern:
        For each customer task, repeat this pattern:
            1. "### Should <scenario subtask> use <product>?".
            2. 1-3 paragraphs of discussion/analysis (first sentence should answer yes/no about whether the product is suitable).
            3. Visual like an image, table, list, code sample, or blockquote.

    Example:
        H3: "Should the video-archive utility use Logic Apps?"
        Prose: "The video archive task is a good fit for Logic Apps even though it doesn't integrate multiple systems. Logic Apps has a built-in timer trigger and an Azure blob connector that are perfect to implement this process...."
        Visual: <image preferred>
-->

### Should you use Azure API Management to standardize APIs?

By enabling the management of multiple APIs from a single administrative interface, Azure API Management makes it easier to standardize your APIs. Standardizing APIs means creating consistency across multiple APIs. You can standardize many API features, including:

- **Specifications**. Standardizing API specs—such as using REST for all APIs and using a consistent naming scheme for JSON name-value pairs—reduces development time, decreases errors, and enables your organization to respond faster to customer suggestions and market forces.
- **Documentation**. Standardizing API documentation enables developers to get up to speed with an API quickly, reduces technical support queries, and encourages developers to use more of your APIs.
- **URLs**. Standardizing the base URL for your APIs reduces consumer errors and gives your API deployments a more professional look.
- **Analytics**. Standardizing API analytics enables management teams and engineers to compare usage and performance across multiple APIs.
- **Regulations**. For APIs that must meet government or industry rules and regulations, standardization helps ensure compliance across all APIs.

:::image type="content" source="../media/4-when-to-use-azure-api-management-standardization.png" alt-text="Several APIs with varying configurations that after being imported into Azure API Management, have been given standardized configurations.":::

In most cases, the need for standardization expands as the number of APIs grows, the rate at which the APIs are revised increases, and the API administration load gets larger. This need is true of the food delivery platform scenario, which requires consistency across the APIs for the mobile app, the web app, and the partner restaurants.

### Should you use Azure API Management to centralize API operations?

By bringing multiple APIs under a single administrative umbrella, Azure API Management enhances the centralization of all API operations. Without an API management service, each API is on its own in terms of administration, deployment, and developer access. This decentralized model often results in duplicated efforts and increased overhead. Centralizing API operations can lead to the following benefits:

- Administration. Centralizing API administrative tasks means being able to apply administrative operations such as policy creation, user management, and analytics in a single location, such as the administrative interface provided by Azure API Management. The centralization of admin tasks makes running these tasks simpler and more efficient.
- Deployment. Centralizing API means routing all API requests through a single base URL, such as the endpoint created by the Azure API Management gateway. Deployment centralization makes it easier to enforce policies and apply transformations.
- Developer access. Centralizing API developer access means putting all developer resources such as documentation, code samples, testing, and subscriptions in a single location, such as the developer portal in Azure API Management. Centralizing developer access makes it easier for developers to find and use your APIs.

The efficiencies that accrue from centralizing API operations tend to increase with the number of APIs and with the size of the overall administrative load you impose on your APIs. Having centralized APIs is a huge help where APIs are often updated because it enables a single versioning scheme for all products.

All of these factors apply strongly to our food delivery platform scenario. For example, centralized consumer access through the developer portal makes it easier to sign up new developers, which enhance the monetization of the platform's APIs.

### Should you use Azure API Management to secure access to your APIs?

Azure API Management was designed with API security in mind. With so many organizations relying on APIs for the internal and external exchange of data between apps and devices, a haphazard or inconsistent approach to security is just asking for trouble. A proper API security strategy covers the following bases:

- Permissions. Setting permissions enables you to control who can work with an API and what they can do with it. In Azure API Management, having all your API consumers as users and being able to organize those users into groups makes it easier and more efficient to apply permissions to control API access.
- Access. Controlling access to an API means only allowing authorized users to submit requests. With Azure API Management, the developer portal supplies users with subscription keys and you can restrict access to APIs by using multiple forms of authentication and JSON web tokens.
- Protection. API protection means securing the API from malicious usage. Azure API Management enables you to throttle API access by using rate limits and usage quotas to prevent consumer misuse (intentional or accidental) of the API.
- Compliance. API compliance means having your APIs satisfy all corporate or government security policies. Having all your APIs together in Azure API Management makes it easier to configure those APIs with security policies that achieve compliance.

The more APIs you manage, the greater the need for security, because more APIs means a greater attack surface and a greater risk of accidental data breaches or leaks. Also, the more often you revise your APIs, the greater the chance that a revision or new version can expose a security flaw.

These security concerns are paramount in our food delivery scenario, because this platform generates and stores a great deal of sensitive data, including restaurant payments, customer names and addresses, and delivery vehicle locations.

<!-- 6. Guidance summary (optional) ------------------------------------------------

    Goal: Job-aid for future use to help customers evaluate their own tasks against the criteria.

    Pattern:
        1. Heading "## Guidance summary"
        2. Lead-in sentence acknowledging that this is a summary/repeat of previous material.
        3. Visual like a flowchart (as an image) or rubric (as a table).

    Example:
        "The following flowchart summarizes the key questions to ask when you're considering using Logic Apps."
        <flowchart image>
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->