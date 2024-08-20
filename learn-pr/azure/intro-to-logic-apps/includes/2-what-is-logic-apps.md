Let's start with a few definitions and a quick tour around the core features of the Azure Logic Apps service. This overview should help you see whether Azure Logic Apps might be a good fit for your scenario.

## What is a business process?

A *business process* is often a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification.

One scenario at our shoe company is monitoring social media for the reactions to a new product. The sequence of tasks are the following:

- Detect tweets about the product.
- Analyze the sentiment.
- Store a link to positive tweets.
- Email customer service for negative tweets.

These steps happen in a specific order, so you often describe them as a flowchart. The following illustration shows a sample flowchart for the social media monitoring process. Notice that three types of operations exist: 

- An event that starts the flow.
- Processing steps that do most of the work.
- A conditional operator that makes a decision.

:::image type="content" source="../media/social-media-monitor-workflow.png" alt-text="Diagram shows detailed flowchart for how a fictional shoe company processes tweets written about their product." lightbox="../media/social-media-monitor-workflow.png":::

## What is Azure Logic Apps?

Azure Logic Apps is a cloud service that automates the execution of your business process as a *logic app workflow*. You create a logic app resource in Azure and use the workflow designer to arrange prebuilt components in the sequence that you need.

When the workflow runs, the designer sends your workflow's definition to the Azure Logic Apps execution engine. The execution engine launches your workflow when the specified condition is met and manages the compute resources needed to run the process. The following illustration shows a high-level view of the steps.

:::image type="content" source="../media/app-design-process.png" alt-text="Diagram shows the steps to define and run a logic app workflow: select the components, use the designer to arrange them, then save your work." lightbox="../media/app-design-process.png":::

The power of Azure Logic Apps comes from the diversity of prebuilt components and their ability to work together. These components let you connect to 1000+ services, not just Azure and Microsoft, but external services too. The following illustration shows only a few of the services that you can use in your workflow.

:::image type="content" source="../media/external-services.png" alt-text="Diagram shows services available in a logic app workflow. The services are shown in four groups: data storage, data processing, communication, and social media." lightbox="../media/external-services.png":::

You build your workflow from the services that you use in your business process. You can connect the components in any pattern or order that you need. You can add decision making and control components to your workflow by adding conditions and loops. The following illustration shows how you can combine external services to implement the social media monitor workflow.

:::image type="complex" source="../media/service-use.png" alt-text="Diagram shows the mapping of a tweet analysis business process to a logic app workflow." lightbox="../media/service-use.png":::
Diagram showing a flowchart for a business process and a logic app workflow that implements that process. For each step in the business process, there's a corresponding component used in the logic app workflow to implement it. For example, the process uses the X component to watch for tweets about a new product.
:::image-end:::

The Azure Logic Apps model is extensible. If no prebuilt component exists for the service you need, you can create your own. You can also run custom code in Azure Functions, which you can call from your workflow.

If we had to use one word to describe the goal of Azure Logic Apps, that word is *integration*. Azure Logic Apps helps you join disparate services to implement a workflow. Your job is to use the workflow designer to arrange the components into the sequence you need. For most logic app, you don't need to write any code, and you can your workflow up and running in minutes.
