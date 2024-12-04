Here, we discuss how you can decide whether Azure Logic Apps is the right choice for your scenario. Let's start by listing some criteria that indicate whether Azure Logic Apps meets your performance and functional goals.

## Decision criteria

Azure Logic Apps helps you coordinate the flow of data through disparate systems. The cases where Azure Logic Apps might not be the best option typically involve real-time requirements, complex business rules, or use of nonstandard services. Here's some discussion of each of these factors.

| Factor | Description |
|--------|-------------|
| **Integration** | The key question to ask when you're considering Azure Logic Apps is *"do I need to integrate services?"* Azure Logic Apps works well when you need to get multiple applications and systems to work together. If you're building an app with no external connections, Azure Logic Apps probably isn't the best option. |
| **Performance** | The next consideration is performance. The Azure Logic Apps execution engine automatically scales your apps. Azure Logic Apps can process large data sets in parallel so that you can achieve high throughput. However, the service doesn't guarantee super fast activation or enforce real-time constraints on execution time. If you're looking for low subsecond response time, Azure Logic Apps might not be the best fit. |
| **Control** | Azure Logic Apps provides control constructs such as conditions (Boolean expressions), switch actions, and loops so that your apps can make decisions based on your data. You can build highly complex and deeply nested control structures in your logic app workflows. <br><br>However, there are two reasons you might not want to. <br><br>- Conditional logic is often easier to write in code, rather than in the workflow designer. <br><br>- Embedded business rules aren't easily sharable with your other apps. <br><br>Some people like to include complex business rules directly in their logic app workflows. Others think it's simpler to write something like an Azure function to encapsulate the conditional logic and invoke that function from all their apps. |
| **Connectors** | Your last consideration is whether prebuilt connectors exist for all the services or systems that you need to access. If they exist, you're ready to go. If not, you need to create custom connectors. If the service has an existing REST or SOAP API, you can make the custom connector in a few hours without writing any code. If not, you need to create the API first before making the connector. |

## Apply the criteria

Azure Logic Apps works best when you're integrating multiple services with some added control logic. Let's think about how to apply these criteria to our example processes.

Our fictional shoe company needs to monitor industry news, move old videos to archive storage, and sell shoes online. Our goal is to decide whether Azure Logic Apps is a good candidate to handle these tasks. To make our decision, we analyze each task using the four criteria that we developed: integration, performance, control, and connectors. The following table summarizes the results:

| | **Integration** | **Performance** | **Control** | **Connectors** | **Use Azure Logic Apps?** |
|-|-----------------|-----------------|-------------|----------------|---------------------------|
| **News monitor** | Integrates multiple services | Don't need near real-time low latency | One condition simple action | Built-in connectors available for all needed systems | Yes |
| **Video archive utility** | *Only needs to access one service, cloud storage* | Don't need near real-time low latency | Two simple condition actions | Prebuilt connectors available for all needed systems | Yes |
| **Direct online sales** | Integrates multiple services | Don't need near real-time low latency | *Multiple complex conditions* | *Multiple custom connectors needed* | *Maybe* |

This analysis produces a few interesting things to consider:

- The video archive task is a good fit for Azure Logic Apps even though the task doesn't integrate multiple systems.

  Azure Logic Apps has a built-in timer trigger and an Azure Blob Storage connector, which are perfect to implement this process.

- The online sales process likely includes complex business logic.

  For example, we might have different approval processes based on the purchase amount, or different shippers based on the destination. Azure Logic Apps can easily handle these conditions. We just need to choose whether to embed these business rules in our app.

- The online sales process likely uses a mix of prebuilt and custom connectors.

  We can use prebuilt connectors for email notifications and database access but probably need a custom connector to communicate with our payment processing service.

- The performance of Azure Logic Apps works well for all the tasks.

  Some tasks might process large amounts of data, but Azure Logic Apps automatically scales to handle high throughput or spikes in demand. None of these tasks require low latency response time. For this aspect to be an issue, we'd need to have near real-time requirements.

Azure Logic Apps could work for all these tasks, and the online sales process is the only task where we want to weigh all our options. Azure Logic Apps is a good choice if we have the resources to build the custom connectors that we need.

## Guidance summary

The following flowchart summarizes the key questions to ask when you're considering using Azure Logic Apps.

:::image type="content" source="../media/decide-whether-to-use-logic-apps-flowchart.png" alt-text="Flowchart shows key questions to ask when evaluating Azure Logic Apps for your work." border="false" lightbox="../media/decide-whether-to-use-logic-apps-flowchart.png":::
