<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
Let's start with an introduction to Azure Monitor. This overview will help you understand what Azure Monitor is and why it is an important part of your Azure deployments.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is <concept>?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<concept> is..." (ensure this is a definition, do not give use cases like "<concept> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->
## What is monitoring?
Monitoring is a task that involves collecting and reviewing data about the activity of some process or behavior. In the world of Azure, monitoring is used to collect insights into the operation, performance, and behavior of your applications and services.

You can perform monitoring as a real-time event or collect data and store the data in log files for later review. Whatever your preferred method, Azure Monitor is ready to help you collect the necessary information that you need.

:::image type="content" source="../media/monitoring.png" alt-text="Depiction of data sources on the left feeding into a metrics and/or log database destinations on the right.":::

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## <product> definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<product> is..." (ensure this is a definition, do not give use cases like "<product> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->
## Azure Monitor definition
Azure Monitor is a service for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments. Azure Monitor is used by IT Operations, DevOps, and Developer teams to maximize the availability and performance of applications and services.

Azure Monitor provides a broad set of capabilities with a varying set of prerequisites depending on your specific monitoring goal. On one end of the spectrum, getting started with Azure Monitor metrics requires no incoming experience because metric collection is on by default for Azure resources and viewing metrics in Metric Explorer is straightforward in the Azure portal UI. However, when using Azure Monitor Log Analytics for trend analysis and pattern recognition, familiarity with query languages would be helpful.

:::image type="content" source="../media/azure-monitor.png" alt-text="Azure monitor capabilities showing data sources feeding into metrics and logs, providing insights, visualizations, and analysis options from the data collected.":::

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the <product> solves one of the customer tasks in your <scenario>.
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to <solve scenario>"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the <product> solved the <scenario>.
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->
## How to monitor your web application
The scenario for a back-to-school campaign impact on your web application, requires an evaluation of where and when the web app experiences demand. Azure Monitor can collect performance and availability telemetry for all of the layers in your stack, from applications, infrastructure, the Azure platform, and any custom sources you integrate.

Azure Monitor is enabled by default. As soon as you create an Azure subscription and start adding resources such as web apps, Azure Monitor starts collecting data. Activity logs record when resources are created or modified. Metrics tell you how the resource is performing and the resources that it's consuming.

TODO: Add your visual element
