Let's start by discussing the type of business tasks that Logic Apps is designed to solve. We'll list some of Logic Apps' core features to get a better idea of where they're a good fit and where they aren't. Once you know what Logic Apps can do, you can analyze your own business processes and determine if Logic Apps will meet your performance and functional goals.

## What is a business process?

A *business process* or *workflow* is a sequence of tasks that produce a specific outcome such as a service, some data, or a decision. Notice that the definition includes the word *sequence*, which implies the tasks happen in a specific order.

One of the processes in the shoe-company scenario is monitoring social media for reaction to a new product. The sequence of tasks in this process would be: detect tweets about the product, analyze the sentiment, store a link to positive tweets, and email customer service for negative tweets.

The fact that processes are ordered means that they're often described using a flowchart. The following illustration shows the flowchart for the social-media monitor process. Notice how there are three types of operations: an event that starts the flow, evaluation and storage steps that do the processing, and a conditional operator that makes a decision.

![An illustration showing a detailed flowchart for the way the fictional shoe company processes tweets written about their product.](../media-drafts/2-social-media-monitor-workflow.png)

## What is Azure Logic Apps?

Azure Logic Apps is a cloud service that automates the execution of your business processes. You use a graphical design tool called the *Logic Apps Designer* to arrange pre-made components into the sequence you need. The Designer sends a definition of your workflow to the Logic App execution engine. The execution engine launches your app when conditions are right and manages the compute resources needed to run it. The following illustration shows a high-level view of the steps.

![An illustration showing three main steps to define and run a Logic App: select the components you need, use the Logic Apps Designer tool to arrange them, then save your work.](../media-drafts/2-app-design-process.png)

The power of Logic Apps comes from the diversity of the pre-built components and their ability to work together. There are components to let you interact with hundreds of external services. If there isn't a pre-built component for the service you need to use, then you can write your own. If you need to run custom code in your workflow, you can put the code in an Azure Function and call the function from your Logic App.

All the components have standard interfaces so you can connect them in any combination you need. You can even add conditional statements and loops to add decision making to your app. The following video shows how the pre-built components and the control operations work together to implement your workflow.

**_TODO: add video link when available_**
![A video overview of the capabilities of Logic Apps.](../media-drafts/TODO)

## When to use Logic Apps

Logic Apps helps you coordinate the flow of data through disparate systems. The edge cases where Logic Apps might not be the best option typically involve requirements like low latency, complex logic, or use of non-standard services. Here's some discussion of each of these factors.

| | |
| --- | --- |
| **Integration** | The key question to ask when you're considering Logic Apps is _do I need to integrate a bunch of services_? Logic Apps work well when you need to get multiple applications and systems to work together. That's what they were designed to do. If you're building an app with no external connections, Logic Apps is probably not the best option. |
| **Performance** | The next consideration is performance. Logic Apps scale automatically and can process large data-sets in parallel. However, they don't guarantee super-fast activation or real-time constraints on execution time. If you're looking for low-latency with subsecond response time, then Logic Apps may not be the best fit. |
| **Conditionals** | Logic Apps provides control constructs like Boolean expressions, switch statements, and loops so your apps can make decisions based on your data. Including a few conditionals in your Logic App is common and useful and the resulting apps are still easy to understand. However, highly complex or deep conditions can be difficult to build and maintain. Writing code is often a better option in this case. If you need complex logic and still want to use Logic Apps, you can write an Azure Function that encapsulates the conditional logic. You can then invoke the Function from your Logic App. |
| **Components** | The last consideration is whether there are pre-built components for all the services you need to integrate. If so, then you're ready to go. If not, then you'll need to create a custom component. If the service has an existing REST or SOAP API, you can make the custom component without writing any code. If not, then you'll need a developer to create the API for you. |
|   |   |

Putting these factors all together indicates that Logic Apps is best when you're integrating popular services using simple control logic. In this situation, you can be up and running in minutes. If you need to create custom components, Logic Apps can still be a good choice. With an existing REST or SOAP API, you can build each component in a few hours. Without that existing API, it typically takes a few days and some developer resources to implement each API and then create a custom component.