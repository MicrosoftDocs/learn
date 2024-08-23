

Updating a system with data from another location can be complex, typically requiring code. You’ve been working in Synapse up until this point, with a foray into Power BI. You’ve developed some insight around your data and now you want to enable others to act on it.

One way to simplify complex processes involves a low-code environment such as Microsoft Power Platform. Power Platform provides a rapid development environment for custom apps. Power Apps and Power Automate are two of the four key, integrated products that comprise Microsoft Power Platform. The others are Power BI - which you’re also using in this scenario - and Power Virtual Agents.

- Power Apps is what you’ll use to build a custom business app.
- Your app also requires Power Automate. When a purchaser searches on a part number, the search triggers a Power Automate flow.
- The flow brings in the Power BI data visualization you created based on your predictive dataset in the dedicated SQL pool. In this case, the flow brings in the ratings for the top relevant vendors.
- Power Automate then helps automate the decision approval process for each parts order made in your app and writes the order to your SAP system.

:::image type="content" source="../media/sample-power-apps.png" alt-text="Screenshot of sample Power Apps app that displays a prediction graph." lightbox="../media/sample-power-apps.png":::

## Building a Power Apps app with Power Automate workflows

Now that you’ve learned about Power Platform components and considered your process requirements, you’re ready to create your Power Apps app:

1. Start with a Power Apps canvas.
1. Drag and drop the controls you need onto your canvas, including Power BI controls.
1. Drag and drop Power Automate controls to build workflows. Use workflows to bring in the Power BI report, to trigger the approval process, and to write to your SAP system.
1. If you like, embed your new Power Apps app within your organization’s Microsoft Teams instance.
One of the Power Automate controls will help you connect to your SAP system. In earlier units, you learned how to connect your Synapse workspace to multiple data sources. Now, you’ll learn the fundamental concepts that help you connect Power Platform with your SAP system.

## Securely connecting with your SAP system

There are multiple ways to connect Power Platform with SAP. The following diagram shows two of the most popular connectors.

:::image type="content" source="../media/sap-erp-connector-custom-connector.png" alt-text="Flowchart diagram illustrating two of the most popular connectors used with S A P and the Power Platform; S A P E R P Connector, and a Custom Connector with OData to connect to S A P.":::

In this scenario, use the SAP ERP connector for Power Apps and Power Automate. The connector allows you to integrate Power Automate flows and Power Apps applications to an SAP ERP system (either SAP ECC or SAP S/4HANA). It provides the following functionality:

- Creates a connection to an SAP ECC or S/4HANA Server using either SAP authentication or Windows authentication.
- Allows you to invoke any BAPI and custom RFCs.
- Provides dynamic schemas for the input and output parameters for an RFC or BAPI.

## Summary

With Power Apps and Power Automate, you can build a business app that enables decision makers to benefit from your prediction data. You can help decision makers turn insight into action by ordering new parts directly from your app.

It starts with connecting to multiple data sources, including SAP, and combining that data in Azure Synapse to uncover high-value predictive insight. Power BI then helps your team visualize the insight. Power Apps and Power Automate helps you turn that insight into action.
