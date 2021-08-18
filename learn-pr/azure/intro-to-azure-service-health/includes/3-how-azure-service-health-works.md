<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how (features) of (product) work to (solve problem)."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"

TODO: add your topic sentences(s)
TODO: add your bulleted list of key things covered
* TODO
* TODO
* TODO
-->
<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of (product) and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->
## How Azure Service Health works

Each one of the three services of which Azure Service Health is composed, has different ways to work.

### Azure Status

The Azure Status Page is where you can find public information about the health of Azure services across all regions. 

At the page, you can set the automatic refresh period to:
* 2 minutes
* 5 minutes
* 10 minutes
* 30 minutes

This should be useful especially if you want have this information displayed in monitors at your NOC (Network Operation Center).

This page has all products and services listed by geographies and regions, with four types of status to allows you easily identify if everything is good, if has some specific information or warning available, or a critical issue.

On this page also is possible get the RSS feed to receive updates on this page, as well check the status history from services and regions.

:::image type="content" source="../media/3-azure-status.png" alt-text="Screenshot of Azure Service Status Page":::

### Service Health

Service Health is what you will be using to get information on outages, planned maintenance, health and security advisories.

It allows you to create customized views, filtering among subscription, region and services. See below what kind of information will be available to you for each case:

* Service issues: Issue name; subscription, service and region impacted; start time; last update status and root cause analysis; downloadable PDF with explanations.
* Planned maintenance: Issue name; tracking id; service and region impacted; start and end time; summary and issue updates; downloadable PDF with explanations.
* Health advisory: Issue name; tracking id; service and region impacted; start time; any required action from you (if needed); summary and issue updates; downloadable PDF with explanations.
* Security advisory: Issue name; tracking id; service and region impacted; start time; any required action from you (if needed); summary and issue updates; downloadable PDF with explanations.

Also Service Health will allow you to create health alerts to notify you when something happens. 

### Resource Health

The Resource Health execute some checks minute by minute across the resources and made the information available to you. Please note that there is a specify type of resources where resource health run those checks. You can see the [full list here](https://docs.microsoft.com/en-us/azure/service-health/resource-health-checks-resource-types).

As an example, for Virtual Machines the type of checks executed are like below:

* Is the server hosting this virtual machine up and running?
* Has the host OS booting completed?
* Is there ongoing planned maintenance?
* Is the host hardware degraded and predicted to fail soon?

The Resource Health is available through "Support + troubleshooting" blade at Azure Portal for some specific resource types on Azure. 

:::image type="content" source="../media/3-azure-resource-health.png" alt-text="Screenshot of Azure Resource Health":::

<!-- Pattern for complex topic 
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list, code sample, blockquote)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->