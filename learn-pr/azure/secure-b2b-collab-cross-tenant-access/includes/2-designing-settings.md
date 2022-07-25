<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
Organizations often need to collaborate on projects with people outside of their company, but they want to do so in a secure way. With Azure AD B2B collaboration, an organization can invite external people to sign in to only those applications and services they want to share. In this unit, we'll discover how cross-tenant access settings give you the granular controls you need to allow or block B2B collaboration with other users, groups, and organizations.

In our scenario, the employees of a financial firm need to collaborate regularly with people from outside the organization. For example, employees in the marketing group frequently work with partner marketing firms organizations and free-lance designers. They need to be able to share Microsoft apps and other internal resources with external users through B2B collaboration.


To support collaboration, the IT admin wants to enable B2B collaboration by default, both inbound and outbound. However, the firm's accounting app manages sensitive data and is only allowed to be accessed by specific employees. So, the IT admin needs to limit access to specific organizations and individuals.

With cross-tenant access settings, the IT admin can enable all inbound and outbound B2B collaboration by default, *except* for the firm's accounting app.

[Diagram]

The default settings would look
To summarize, the IT admin needs to make sure that B2B collaboration is allowed by default for all of the firm's applications except for the accounting app.

With cross-tenant access settings, the IT admin can enable all inbound and outbound B2B collaboration with other Azure AD organizations

make sure this application is not available for B2B collaboration by default. needs to be restrict  generally wants to allow employees to collaborate with external  partners on marketing and communications projects, so you want to allow B2B collaboration with external users. However, your accounting application contains highly sensitive data, so you want to strictly control access to this application.




<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
Default settings vs. organizational settings

If you 

Default cross-tenant access settings apply to all Azure AD organizations external to your tenant. This means that , except those for which you've configured organizational settings. You can change your default settings, but the initial default settings for B2B collaboration and B2B direct connect are as follows:

B2B collaboration: All your internal users are enabled for B2B collaboration by default. This means your users can invite external guests to access your resources and they can be invited to external organizations as guests. MFA and device claims from other Azure AD organizations aren't trusted.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->