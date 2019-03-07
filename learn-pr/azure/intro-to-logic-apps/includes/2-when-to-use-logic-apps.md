Let's start by discussing the type of business tasks that Logic Apps is designed to solve. We'll list some of Logic Apps' core features to get a better idea of where they're a good fit and where they aren't. This knowledge will help you analyze your own business processes to determine if Logic Apps will meet your performance and functional goals.

## What is a business process?

A *business process* or *workflow* is a sequence of tasks that produce a specific outcome such as a service, some data, or a decision. Notice that the definition includes the word *sequence*, which implies the tasks happen in a specific order.

One of shoe-company scenarios is monitoring social media for reaction to a new product. The sequence of tasks would be: detect tweets about the product, analyze the sentiment, store a link to positive tweets, and email customer service for negative tweets.

The fact that processes are ordered means you will often describe them with a flowchart. The following illustration shows a sample flowchart for the social-media monitor process. Notice how there are three types of operations: an event that starts the flow, evaluation and storage steps that do the processing, and a conditional operator that makes a decision.

![An illustration showing a detailed flowchart for the way the fictional shoe company processes tweets written about their product.](../media-drafts/2-social-media-monitor-workflow.png)

## What is Azure Logic Apps?

Azure Logic Apps is a cloud service that automates the execution of your business processes. You use a graphical design tool called the *Logic Apps Designer* to arrange pre-made components into the sequence you need. The Designer sends a definition of your workflow to the Logic App execution engine. The execution engine launches your app when conditions are right and manages the compute resources needed to run it. The following illustration shows a high-level view of the steps.

![An illustration showing three main steps to define and run a Logic App: select the components you need, use the Logic Apps Designer tool to arrange them, then save your work.](../media-drafts/2-app-design-process.png)

The power of Logic Apps comes from the diversity of the pre-built components and their ability to work together. There are components to let you interact with hundreds of external services. When Logic Apps doesn't have a pre-built component for the service you need to use, then you can write your own. If you need to run custom code in your workflow, you can put the code in an Azure Function and call the function from your Logic App.

All the components have standard interfaces so you can connect them in any combination you need. You can even add conditional statements and loops to add decision making to your app. The following video shows how the pre-built components and the control operations work together to implement your workflow.

<!-- TODO: add final video link when available -->
![A video overview of the capabilities of Logic Apps.]()

**Draft video link: https://microsoft.sharepoint.com/:v:/t/CE_APEX/EbBSOox5qb9FhLWTT9kx5KABcSukRFN_WFePd0nGQS5Jdg?e=7cClvA

## When to use Logic Apps

Logic Apps helps you coordinate the flow of data through disparate systems. The edge cases where Logic Apps might not be the best option typically involve requirements like low latency, complex logic, or use of non-standard services. Here's some discussion of each of these factors.

| | |
| --- | --- |
| **Integration** | The key question to ask when you're considering Logic Apps is _"do I need to integrate services?"_ Logic Apps work well when you need to get multiple applications and systems to work together. That's what they were designed to do. If you're building an app with no external connections, Logic Apps is probably not the best option. |
| **Performance** | The next consideration is performance. Logic Apps scale automatically and can process large data-sets in parallel. This means they let you achieve very high throughput. However, they don't guarantee super-fast activation or real-time constraints on execution time. If you're looking for low sub-second response time, then Logic Apps may not be the best fit. |
| **Conditionals** | Logic Apps provides control constructs like Boolean expressions, switch statements, and loops so your apps can make decisions based on your data. This means you can build highly-complex and deeply nested conditionals into your Logic Apps. If you need complex expressions, it might be simpler to write an Azure Function that encapsulates the conditional logic and invoke the Function from your Logic App. In you have conditions that represent business rules, you might be better off building those into a code library that you share across your software products. This criteria is really a judgement call. Logic Apps can certainly handle complex and deeply nested conditionals; however, sometimes code is easier to write and maintain. |
| **Components** | The last consideration is whether there are pre-built components for all the services you need to integrate. If so, then you're ready to go. If not, then you'll need to create a custom component. If the service has an existing REST or SOAP API, you can make the custom component in a few hours without writing any code. If not, then you'll need a developer to create the API for you. |
|   |   |

Putting these factors all together indicates that Logic Apps is best when you're integrating multiple services and adding in some control logic. If Logic Apps already has the components you need, you can be up and running in minutes. If you need to create custom components, Logic Apps are often still be a good choice but you'll have to spend some time up-front creating the components you need.