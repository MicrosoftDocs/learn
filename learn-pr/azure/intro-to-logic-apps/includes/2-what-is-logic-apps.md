Let's start with a few definitions and a quick tour around the core features of the Azure Logic Apps service. This overview should help you see whether Azure Logic Apps might be a good fit for your work.

## What is a business process?

A *business process* or *workflow* is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification.

One of the shoe-company scenarios is monitoring social media for reaction to a new product. The sequence of tasks would be: detect tweets about the product, analyze the sentiment, store a link to positive tweets, and email customer service for negative tweets.

Since the steps occur in a specific order, you often describe them with a flowchart. The following illustration shows a sample flowchart for the social-media monitor process. Notice how there are three types of operations: an event that starts the flow, processing steps that do most of the work, and a conditional operator that makes a decision.

![Diagram showing a detailed flowchart for the way the fictional shoe company processes tweets written about their product.](../media/social-media-monitor-workflow.png)

## What is Azure Logic Apps?

Azure Logic Apps is a cloud service that automates the execution of your business processes. You use the workflow designer to arrange premade components into the sequence you need. The designer sends a definition of your workflow to the Azure Logic Apps execution engine. The execution engine launches your app when conditions are right and manages the compute resources needed to run it. The following illustration shows a high-level view of the steps.

![Diagram of the steps to define and run a logic app workflow: select the components, use the designer to arrange them, then save your work.](../media/app-design-process.png)

The power of Azure Logic Apps comes from the diversity of the prebuilt components and their ability to work together. The components let you connect to hundreds of external services. The following illustration shows a few of the services you can use in your logic app workflow.

![Diagram of services available in a logic app workflow. The services are shown in four groups: data storage, data processing, communication, and social media.](../media/external-services.png)

You build your app from the services you use in your business processes. The components can be connected in any pattern you need. You can add conditional statements and loops to add decision making to your app. The following illustration shows how you would combine external services to implement the social-media monitor workflow.

:::image type="complex" source="../media/service-use.png" alt-text="Diagram showing the mapping of the tweet-analysis business process to a logic app workflow.":::
Diagram showing a flowchart for a business process and a logic app workflow that implements that process. For each step in the business process, there's a corresponding component used in the logic app workflow to implement it. For example, the process uses the Twitter component to watch for tweets about a new product.
:::image-end:::

The Azure Logic Apps model is extensible. If there isn't a prebuilt component for the service you need, you can create your own. You can also run custom code in an Azure function that you invoke from your app.

If we had to describe the goal of Azure Logic Apps in one word, we'd choose *integration*. Azure Logic Apps helps you join disparate services to implement a workflow. Your job is to use the workflow designer to arrange the components into the sequence you need. For most apps, you don't need to write any code and you can be up and running in minutes.
