<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly orient the learner to the product; what category of problem does it solve?

    Heading: none

    Example: "Implementing a business process can be challenging because you typically need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Microsoft 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products? Azure Logic Apps gives you pre-built components to connect to hundreds of services. You use a graphical design tool to put the pieces together in any combination you need and Logic Apps will run your process automatically in the cloud."

    Recommended: visual like an image (preferred), table, list, etc.

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->
Publishing an application programming interface (API) is a great way to increase market share, generate revenue, and foster innovation. However, maintaining even a single API brings significant challenges on various fronts such as:

- Onboarding users
- Handling revisions
- Implementing security
- Running analytics

Now imagine that, like many of today's leading companies, your organization publishes multiple APIs for different types of users, including partners, developers, and employees. These APIs are used in multiple settings, including mobile apps, web apps, and IoT devices.

:::image type="content" source="../media/1-introduction-before.png" alt-text="Multiple APIs connecting to multiple servers, where each API maintains its own set of users, security policies, and analytics data.":::

How do you reduce the complexity inherent in having a large number of APIs? Azure API Management acts as a "front door" for all your APIs. Azure API Management not only manages all your API traffic, but also offers intuitive portals for managing your APIs and surfacing them to developers. It also provides tools for implementing security, handling revisions, and performing analytics.

:::image type="content" source="../media/1-introduction-after.png" alt-text="Depiction of how Azure API Management acts as a front door for all of an organization's APIs, which are then routed to the server where the API is deployed.":::

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: Describe the real-world scenario you'll use to illustrate the product. Include 2-3 customer tasks that represent the most-common use cases for the product.

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company that is launching a new product. You sell the shoes on your website, manage your cloud-hosted advertising videos, and monitor social media to gauge reactions to the launch. The following illustration shows these processes. Notice how the tasks include both customer-facing processes like direct sales and administrative tasks like auto-archiving old videos. Here, you'll see how Logic Apps automates these types of business processes."

    Recommended: an image that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
 -->

## Example scenario

Suppose you work at a company that operates a food-delivery platform. Consumers use your mobile app or website to browse the menus of multiple restaurants and place an order for the food they want, which your company then delivers. The backbone of your platform is a large collection of APIs. For example, you publish APIs that are used by your mobile app, your web app, your partner restaurants, the IoT devices on your delivery vehicles, your in-house development team, and your employees (such as business analysts). Each published API resides on a different server, has its own process for onboarding users, and has its own policies for security, revisions, analytics, and more. You've been tasked to find a way to reduce this complexity. Here you'll learn how Azure API Management can standardize, centralize, and help secure all the aspects of publishing and maintaining APIs across the full API lifecycle.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do. This differs from the learning objectives. The learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "We’ll analyze the capabilities of Logic Apps to help you decide when to use them:
                * **Launch**: what conditions can you set to launch your app?
                * **Connect**: which services can you connect to?
                * **Branch**: what types of business logic can you add to your app?"

 -->

## What will we be doing?

We'll examine Azure API Management to help you decide if it's the correct solution to reduce your company's API complexity. We'll study the following three main angles:

- Gateway. A single endpoint for all your API calls, which eases the implementation of security, rate limits, caching, and transformations.
- Administrators. A single interface for all your APIs where you can manage users, set policies, create API products, and run analytics.
- Developers. A portal that brings all your APIs into a single location for developers to read documentation, test APIs, review code samples, get API keys, and run analytics.

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: The title of an "Introduction to <product>" module tells our customers that this is a good place to start their learning. This helps our customers find the right content quickly. The trade-off is that the title does not reflect the terminal learning objective of the module. Here, you explain that this module teaches the 'evaluate' task. To do this, you:
        - Start with your 'evaluate' learning objective
        - Make it a complete sentence if it's not already
        - Use plain language so it sounds conversational
        - Include the lead-in shown below ("By the end...")

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to decide whether Logic Apps is a good choice to automate your business processes."

 -->

## What is the main goal?

By the end of this session, you'll be able to evaluate whether Azure API Management is the correct solution for collecting your organization's many APIs under a single management umbrella.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->
