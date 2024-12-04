Let's start with a few definitions and a quick tour around the core features in Azure Logic Apps. This overview helps you determine whether Azure Logic Apps is a good fit for your business scenario.

## What is a business process?

A *business process* is usually a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification.

One scenario at our shoe company is monitoring industry news for market reactions. This business process includes the following sequence of tasks:

- Detect news articles about the industry.
- Analyze the sentiment.
- Store a link to positive articles.
- Email public relations for negative articles.

These steps happen in a specific order, so you can often describe them as a flowchart. The following diagram shows a sample flowchart for the news article monitoring process. Notice that three types of operations exist:

- An event that starts the flow.
- Processing steps that do most of the work.
- A control operation that makes a decision.

:::image type="content" source="../media/news-monitoring-workflow.png" alt-text="Diagram shows flowchart for how a fictional shoe company processes industry news articles." border="false" lightbox="../media/news-monitoring-workflow.png":::

## What is Azure Logic Apps?

Azure Logic Apps is a cloud platform that helps you automate running your business process as a *logic app workflow*. You create and deploy a logic app resource in Azure and use the workflow designer to arrange prebuilt components in the sequence that you need.

When the workflow runs, the designer sends your workflow's definition to the Azure Logic Apps execution engine. The execution engine launches your workflow when the specified condition is met and manages the compute resources needed to run the process. The following diagram shows a high-level view of the steps:

:::image type="content" source="../media/app-design-process.png" alt-text="Diagram shows the steps to define and run a logic app workflow: select the components, use the designer to arrange them, then save your work." border="false" lightbox="../media/app-design-process.png":::

The power of Azure Logic Apps comes from the diversity of prebuilt components and their ability to work together. These components let you connect to 1,000+ services, systems, and other data sources. Not just Azure and Microsoft, but external products too. The following diagram shows only some of the products that you can integrate in your workflow:

:::image type="content" source="../media/external-services.png" alt-text="Diagram shows services available in a logic app workflow. The services are shown in four groups: data storage, data processing, communication, and industry news monitoring." border="false" lightbox="../media/external-services.png":::

You build your workflow from the components that you use in your business process. You can connect the components in any pattern or order that you need. You can add decision making and other control components to your workflow by adding conditions and loops. The following diagram shows how you can combine external products to implement the industry news monitoring workflow:

:::image type="content" source="../media/service-use.png" alt-text="Diagram shows mapping the news article analysis business process to a logic app workflow." border="false" lightbox="../media/service-use.png":::

The Azure Logic Apps model is extensible. If no prebuilt component exists for the service, system, or API that you need, you can create your own. You can also run custom code in Azure Functions, which you can call from your workflow, or code snippets and scripts using the components for those purposes.

If we have to use one word to describe the focus of Azure Logic Apps, that word is *integration*. This platform helps you join disparate services and systems to implement a workflow that supports a business process. Your role is to use the workflow designer to arrange the components into the sequence that you need. For most workflows, you don't have to write any code, so you can get a workflow ready and running in minutes.

> [!TIP]
>
> If you have Microsoft Copilot installed, you can ask Copilot these questions:
>
> - *What are the top useful scenarios in Azure Logic Apps?*
> - *Tell me about prebuilt connectors in Azure Logic Apps?*
