<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly orient the learner to the product; what category of problem does it solve?

    Heading: none

    Example: "Implementing a business process can be challenging because you typically need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Microsoft 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products? Azure Logic Apps gives you pre-built components to connect to hundreds of services. You use a graphical design tool to put the pieces together in any combination you need and Logic Apps will run your process automatically in the cloud."

    Recommended: visual like an image (preferred), table, list, etc.

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->
One of the many reasons you may be hosting your infrastructure or applications on Azure, may concern performance. Deploying to Azure is not a one-and-done action however. How do you know if you are gaining benefits with Azure hosting? How can you prove your return on investment? Are there aspects to your applications that are not giving the performance you, or your users, expect?

:::image type="content" source="../media/monitoring-panel-options.png" alt-text="Monitoring options for a web app on Azure portal showing options of metrics, logs, health check, etc.":::

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: Describe the real-world scenario you'll use to illustrate the product. Include 2-3 customer tasks that represent the most-common use cases for the product.

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company that is launching a new product. You sell the shoes on your website, manage your cloud-hosted advertising videos, and monitor social media to gauge reactions to the launch. The following illustration shows these processes. Notice how the tasks include both customer-facing processes like direct sales and administrative tasks like auto-archiving old videos. Here, you'll see how Logic Apps automates these types of business processes."

    Recommended: an image that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
 -->
## Example scenario
Consider a web application that you are hosting on Azure. You decided to move the application from your on-premises infrastructure due to performance issues.  During back-to-school campaigns, your web site is being overloaded and response times are causing users to leave. You don't want to spend more money on new server hardware just to support these limited engagements where load peaks.

Azure offers the ability to scale up your applications, or out, when needed, and then automatically scale them back when resource needs drop off. Initially, you may not know where the capacity issues are. Using the Azure Monitor capabilities, you can determine where your application scaling needs are and adjust those parameters in your scaling strategy, based on concrete metrics and log data.

:::image type="content" source="../media/monitor-web.png" alt-text="graphs depicting data in/out, request, and response time for monitoring a web app":::

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do. This differs from the learning objectives. The learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "We’ll analyze the capabilities of Logic Apps to help you decide when to use them:
                * **Launch**: what conditions can you set to launch your app?
                * **Connect**: which services can you connect to?
                * **Branch**: what types of business logic can you add to your app?"

 -->
## What will we be doing?

We'll take a look at the importance of monitoring your Azure applications and infrastructure by:
* Understanding the role of Azure Monitor.
* Discovering how Azure Monitor works, at a high level.
* Determine if Azure Monitor is appropriate for your needs.

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
By the end of this session, you'll be able to;

- Explain what Azure Monitor is
- Briefly describe how it works
- Explain sample scenarios where Azure Monitor is useful

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->