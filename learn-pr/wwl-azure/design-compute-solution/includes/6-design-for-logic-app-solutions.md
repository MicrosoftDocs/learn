[Azure Logic Apps](https://azure.microsoft.com/services/logic-apps) is another type of serverless compute solution. Azure Logic Apps is a cloud-based platform for creating and running automated workflows. Workflows are step-by-step processes that integrate your apps, data, services, and systems. With Azure Logic Apps, you can quickly develop highly scalable integration solutions for your enterprise and business-to-business (B2B) scenarios. 

Logic Apps is a member of [Azure Integration Services](https://azure.microsoft.com/product-categories/integration/). Logic Apps simplifies the way that you connect legacy, modern, and cutting-edge systems across cloud, on premises, and hybrid environments. The following list describes just a few example tasks, business processes, and workloads that you can automate using the Logic Apps service.

- Schedule and send email notifications using Office 365 when a specific event happens. For example, a new file is uploaded.

- Route and process customer orders across on-premises systems and cloud services.

- Move uploaded files from an SFTP or FTP server to Azure Storage.

- Monitor tweets, analyze the sentiment, and create alerts or tasks for items that need review.

### How are Azure Logic Apps and Azure Functions different?

Azure Logic Apps and Azure Functions may seem similar but there are basic differences. Azure Functions is a code-first technology. Azure Logic Apps is a design-first technology. 

:::image type="content" source="../media/select-logic-apps.png" alt-text="Flowchart comparing Azure function and Azure Logic Apps solutions.":::



Here are some other differences. 

| Comparison area| Durable Functions| Logic Apps |
| - | - | - |
| Development| Code-first| Designer-first |
| Method| Write code and use the durable functions extension| Create orchestrations by using a GUI or editing configuration files |
| Connectivity| [Large selection of built-in binding types](/azure/azure-functions/functions-triggers-bindings), write code for custom bindings| [Large collection of connectors](/azure/connectors/apis-list), [Enterprise Integration Pack for B2B scenarios](/azure/logic-apps/logic-apps-enterprise-integration-overview), [build custom connectors](/azure/logic-apps/custom-connector-overview) |
| Monitoring| Azure Application Insights| Azure portal, Azure Monitor logs |
| Execution context| Can be run locally or in the cloud| Runs only in the cloud |


> [!TIP]
> You can mix and match services when you build an orchestration. You can call functions from logic apps and call logic apps from functions. Build each orchestration based on the services' capabilities or your personal preference. 

### Decision criteria for Logic Apps

When designing for Logic Apps consider integration, performance, conditionals, and connectors. 

- **Integration.** The key question to ask when you're considering Logic Apps is "do I need to integrate services?" Logic Apps work well when you need to get multiple applications and systems to work together. That's what they were designed to do. If you're building an app with no external connections, Logic Apps is probably not the best option.

- **Performance**. The next consideration is performance. The Logic Apps execution engine scales your apps automatically. Logic Apps can process large datasets in parallel to let you achieve high throughput. However, fast activation time is not always guaranteed, nor enforcement of real-time constraints on execution time.

- **Conditionals**. Logic Apps provides control constructs like Boolean expressions, switch statements, and loops so your apps can make decisions based on your data. You can build highly complex and deeply nested conditionals into your Logic Apps. 

- **Connectors**. The last consideration is whether there are pre-built connectors for all the services you need to access. If so, then you're ready to go. If not, then you'll need to create a custom connector. If the service has an existing REST or SOAP API, you can make the custom connector in a few hours without writing any code. If not, then you'll need to create the API first before making the connector.

> [!TIP]
> Knowing when not to use Logic Apps is also important. The cases where Logic Apps might not be the best option include real-time requirements, complex business rules, or use of non-standard services.

### Summary of design criteria for logic apps

 

:::image type="content" source="../media/investigate-logic-apps.png" alt-text="Flowchart to select Azure Logic Apps.":::


> [!NOTE]
> Take a few minutes to learn about how [Cramo is using Logic Apps](https://customers.microsoft.com/story/cramo-professional-services-azure) in their new integration platform. 