<!-- 1. Goal and criteria-----------------------------------------------------------------------------

    Goal: Recap that this module's goal is 'evaluate' using the provided decision criteria.

    Format: Short text followed by a bulleted list of the decision criteria developed in the "When to use (product)" unit.

    Heading: none

    Example: "Our goal was to help you evaluate whether Logic Apps would be a good choice for your business process. We developed some criteria you can use to guide your decision:
    * Integration
    * Performance
    * Conditionals
    * Connectors"

-->
Our goal was to help you understand the purpose, concepts, and schools of thought behind testing and how they can help you improve your code quality.

* **Explored concepts**: We explored the concept of testing is and how it can help catch bugs before release.
* **Explained benefits of testing**. Testing helps validate code changes, improve architecture, and improve code health.
* **Learned about different types of testing**.  Different types of testing can address different needs in a code base.
* **Discovered different schools of thought**. We explained the testing schools of thought that help guide good practices across teams.

<!-- 2. Show how you solved the scenario problem(s)---------------------------------------------------

    Goal: Briefly summarize how you applied the decision criteria to the scenario problem(s). Ideally, discuss two scenarios, one where the product was appropriate and one where it wasn't.

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "We applied these criteria to our fictional shoe company. The analysis helped us see how difficult it would be to use Logic Apps for each process. Both the social-media monitor and the video archive utility used only the built-in connectors. This characteristic made them perfect for Logic Apps. The online sales portal required more work because it had complex conditionals and needed custom connectors."
 -->
You saw how testing can both document and verify behavior in the phone number example. Tests enable you to automatically check functionality with out needing to consciously walk through every supported scenario. Any app that is constantly growing can make use of tests to verify that new functionality doesn't break old behavior.

<!-- 3. Describe the business impact ----------------------------------------------------

    Goal: explain how choosing the right product is important

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "The criteria help you evaluate whether your business processes are a good match for Logic Apps. First, they let you assess how well Logic Apps will solve your problem. Second, they give you an idea of the amount of customization effort involved in using them for your task. This process should give you enough information to choose the right product for your work."
 -->
Learning about the different types of tests can open up new ways of verifying your code. Maybe the validity of some changes are confirmed by your unit tests, but a performance test catches that a function is now taking twice as long to execute. Maybe the unit tests and performance tests pass, but your UI tests catch strange behavior when it actually comes to rendering your UI. Testing from multiple different perspectives improves the quality of your app before it reaches customers.
The testing schools of thought recommend different styles of testing that can drive teams towards better architecture and higher code coverage. While you don't have to follow them to-the-letter, it's good to know there is plenty of guidance out there for people wanting to evolve their testing practices.

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

* [Create tests C# tutorial](../../visual-studio-test-tools/resources/design-doc.md)
* [Run tests in Azure DevOps](../../../azure-devops/run-functional-tests-azure-pipelines/includes/1-introduction.md)

<!-- Do not include any other content -->
