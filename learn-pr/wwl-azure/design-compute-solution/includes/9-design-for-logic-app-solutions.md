[Azure Logic Apps](https://azure.microsoft.com/services/logic-apps) is another type of serverless compute solution that offers a cloud-based platform for creating and running automated _workflows_. Workflows are step-by-step processes that integrate your applications, data, services, and systems. With Azure Logic Apps, you can quickly develop highly scalable integration solutions for your enterprise and business-to-business (B2B) scenarios. 

### Things to know about Azure Logic Apps

Let's review some characteristics of Azure Logic Apps and scenarios for using the compute solution to build new workloads.

:::image type="content" source="../media/select-azure-logic-apps.png" alt-text="Flowchart for selecting Azure Logic Apps solutions to build new workloads." border="false":::

- Azure Logic Apps is a component of [Azure Integration Services](https://azure.microsoft.com/product-categories/integration/). Logic Apps simplifies the way you connect legacy, modern, and cutting-edge systems across cloud, on-premises, and hybrid environments.

- With Logic Apps, you can schedule and send email notifications by using Office 365 when a specific event happens, such as a new file uploaded.

- Use Logic Apps to route and process customer orders across on-premises systems and cloud services.

- Implement Logic Apps to move uploaded files from an SFTP or FTP server to Azure Storage.

- Monitor tweets and analyze sentiment with Logic Apps, and create alerts or tasks for items that need review.

#### Compare Azure Logic Apps and Azure Functions

Azure Logic Apps is similar to Azure Functions as a compute service, but there are basic differences. Azure Functions is a **code-first** technology that uses durable functions. Azure Logic Apps is a **design-first** technology. Review the following flowchart and table to compare the two solutions.

:::image type="content" source="../media/select-logic-apps.png" alt-text="Flowchart that shows the decision tree for when to use Azure Functions and Azure Logic Apps." border="false":::

| Compare | Azure Functions | Azure Logic Apps |
| --- | --- | --- |
| **Development** | Code-first | Design-first |
| **Method** | Write code and use the durable functions extension | Create orchestrations with a GUI or by editing configuration files |
| **Connectivity** | - [Large selection of built-in binding types](/azure/azure-functions/functions-triggers-bindings) <br> - Write code for custom bindings | - [Large collection of connectors](/azure/connectors/apis-list) <br> - [Enterprise Integration Pack for B2B scenarios](/azure/logic-apps/logic-apps-enterprise-integration-overview) <br> - [Build custom connectors](/azure/logic-apps/custom-connector-overview) |
| **Monitoring** | Azure Application Insights | Azure portal, Azure Monitor Logs (Log Analytics) |

### Things to consider when using Azure Logic Apps

There are several points to consider when deciding whether Azure Logic Apps is the ideal compute solution for your infrastructure. Review the following considerations, and think about how Azure Logic Apps can enhance the compute strategy for Tailwind Traders.

- **Consider integration**. Use Logic Apps to provide the critical infrastructure component of integration with services. Logic Apps is a good option when you need to get multiple applications and systems to work together. If you're building an app with no external connections, Logic Apps is probably not the best option.

- **Consider performance**. Scale your apps automatically with the Logic Apps execution engine. Logic Apps can process large datasets in parallel to let you achieve high throughput. However, fast activation time isn't always guaranteed, nor enforcement of real-time constraints on execution time.

- **Consider conditional expressions**. Build highly complex and deeply nested conditionals into your Logic Apps. Logic Apps provides control constructs like Boolean expressions, switch statements, and loops so your apps can make decisions based on your data. 

- **Consider connectors**. Investigate whether prebuilt connectors are available for all the services you need to access. You might need to create custom connectors. If a service has an existing REST or SOAP API, you can make the custom connector in a few hours without writing any code. Otherwise, you need to create the API first before making the connector.

- **Consider mixing compute solutions**. Take advantage of diverse features by mixing and matching services when you build an orchestration. You can call functions from Logic Apps, and call logic apps from an Azure function. Build each orchestration based on the service capabilities or your personal preference. 

- **Consider other options**. Know when _not_ to use Azure Logic Apps. There are cases where Logic Apps might not be the best option. Logic Apps isn't an ideal solution for real-time requirements, complex business rules, or if you're using nonstandard services.

#### Business application

Take a few minutes to learn how [Azure Logic Apps](https://customers.microsoft.com/story/1567549472346870706-eon-esmartsystems-azure-en) distributes data from drones inspecting power lines. 

You can use the following flowchart for other questions to ask as you plan for using Azure Logic Apps.

:::image type="content" source="../media/investigate-logic-apps-thumbnail.png" alt-text="Flowchart that shows a detailed decision tree for when to use Azure Logic Apps." border="false" lightbox="../media/investigate-logic-apps.png":::