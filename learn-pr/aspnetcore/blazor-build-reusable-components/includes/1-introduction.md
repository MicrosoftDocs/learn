<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: orient the learner to the area covered in this module

    Heading: none

    Example: "Azure Logic Apps let you automate your business processes and run them in the cloud."

    Recommended: visual like an image, table, list, etc. that supports the topic sentence(s)

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->
Razor Class Libraries let you share and reuse user-interface components between Blazor applications.  In this module, we're going to focus on building and sharing components for Blazor applications

![Razor Class Library used in Blazor Server and Blazor Web Assembly](../media/blazor-class-library-usage.png)
<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: describe the real-world scenario this module will use to illustrate the concepts

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company on the marketing team. You're launching a new basketball shoe created by a celebrity athlete. Previous launches resulted in a social media frenzy as people shared stories and photos of themselves wearing their new shoes. The marketing team wants to monitor hundreds of social media sites, blogs, and websites to determine consumer reaction. There will be more data than you can process manually. You would like a cloud-hosted system that automates monitoring, text analytics, database storage, and email notifications."

    Recommended: an image that visualizes the scenario, use the image markdown extension (https://review.docs.microsoft.com/help/contribute/markdown-reference?branch=master#images)

    Optional: a "scenario video" that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
    [Scenario video guidance](TBD)
 -->
## Example scenario

Suppose you work for a consulting firm where you build web applications for your various clients.  You've got a collection of web features like a modal window component that you make available to your clients.  To save time, you want to be able to reuse these features across applications.  With Razor Class Libraries, you can share that feature across the applications you build for your customers.

![Example Modal Window component that could be shared among Blazor applications](../media/modal-window.png)

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "Here, you'll create a business workflow using Azure Logic Apps to automate the processing of tweets:
                * **Launch**: when a new tweet is available
                * **Process**: determine if the sentiment of the tweet is positive or negative
                * **Route**: branch based on the sentiment score"

 -->
## What will we be doing?

You'll create a Razor Class Library to accomplish the following goals:

- Present a modal dialog box with default theming
- Use and customize the Modal dialog in a Blazor Application
- Package the Modal dialog for use with other applications


<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: This is a restatement of the module title into a complete sentence. You have more room here to convey the main goal than in a space-limited title. Make it outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to create workflows which route and process data using Azure Logic Apps and its built-in connectors."

 -->
## What is the main goal?
By the end of this session, you'll design and share a modal window component.  That component can then be used and customized in other Blazor applications.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->