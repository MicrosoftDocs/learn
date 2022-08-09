<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
After enabling a registration campaign for Microsoft Authenticator, administrators want to validate the new sign-in experience works as expected before running the campaign production. 



<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
You want to apply the new policy to a test user and confirm Microsoft Authenticator is the new default sign-in method. 

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
You'll create a new user account in Azure AD and enable it for Microsoft Authenticator. Then you'll sign in, perform MFA, and set up Microsoft Authenticator. After you confirm the new user account has Microsoft Authenticator as the new default sign-in method, you'll apply the policy to the remote employees group. 

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
:::image type="content" border="true" source="../media/setup.png" alt-text="Screenshot of Microsoft Authenticator setup.":::


<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->

## Validate the registration campaign

You want to see how the registration campaign works for a test user account. After you confirm it works as expected, you plan to run the campaign for the remote employees.  

### Create a test user


### Perform MFA as a test user 

Before users can get the prompt to set up Microsoft Authenticator, they need to perform MFA as they do normally. For remote employees in your company, they will need to sign in by using their currently preferred authentication methods: username and password with either an SMS message or voice call to complete MFA. After they perform MFA, they'll get nudged to set up Microsoft Authenticator.




### Confirm Microsoft Authenticator is the new default sign-in method 

Your goal is to switch users from SMS and voice call to Microsoft Authenticator push notifications for better security. After users install and register Microsoft Authenticator, push notifications will become their new default sign-in method. 



<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->