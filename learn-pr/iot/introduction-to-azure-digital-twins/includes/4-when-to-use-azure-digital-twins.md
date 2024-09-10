Azure Digital Twins is used to build a digital representation of a real-world environment that organizes IoT and business data, and is queriable to enable business insights.

Recall that in the factory production scenario for this module, you're designing a digital solution to monitor overall environment efficiency, and identifying specific machines that are under-performing so they can receive maintenance.

In this unit, you'll learn how to verify that Azure Digital Twins is a good fit for this scenario.

## Decision criteria

Use the following table to help you evaluate if Azure Digital Twins is an appropriate tool for your situation.

| Criteria | Use Azure Digital Twins when... | DON'T use Azure Digital Twins when... |
| --- | --- | --- |
| Role in IoT solution | Your focus is on processing device data in the cloud. | Your focus is on device management. This might include the need for device control capabilities, such as sending Commands back to IoT devices (Azure Digital Twins doesn't support Commands). |
| Completeness | You want a full representation of your environment that reflects its current state. You want to see a 2D or 3D visual of your environment, and query your environment on-demand or over time. You may want to enhance this representation with business data pulled from external sources. | You don't need visual or query capabilities, or aren't interested in reviewing your environment as a complete digital picture. |
| DTDL modeling | You want to define your own modeling vocabulary, or use of one of the DTDL ontologies provided by Microsoft for your industry. You can also bring models from other systems as long as they can be converted into DTDL. | You're already modeling your environment in another language and you don't want to convert your models to DTDL. |
| Collaboration with other Azure services | You're already representing devices in IoT Hub, or are willing to start. You're also willing to use additional resources for compute functionality (Azure Functions) and messaging functionality (Service Bus, Event Hubs, or Event Grid). You're considering taking advantage of optional Azure resources for advanced storage and processing (Azure Storage, Azure Data Explorer). | You don't want to use other Azure services as part of your solution. |

## Application to example

Now, let's consider the decision criteria from the previous section when applied to the factory example for this module.

| Criteria | Use Azure Digital Twins? |
| --- | --- |
| Role in IoT solution | Yes, because your goal has to do with collecting and processing data in order to draw conclusions about the state of your environment. This solution doesn't need to directly manage or control devices. |
| Completeness | Yes, because you need to digitally represent the full distribution center and get data about all the robotic arms that it contains. You need data from the entire environment to draw comprehensive conclusions, and you probably want to contextualize that data with knowledge of how the factory is organized in order to aggregate data appropriately. Once you've collected the data, you'll want to query that data for its current state, as well as historical values over time. You may want to incorporate visualization into your final solution for factory operators. |
| DTDL modeling | Yes, because you want to define modeling fields based on the information that's important to you, to build a customized solution. You can create fields based on properties of the robotic arms in order to help monitor them, as well as fields representing aggregate properties on the floor or distribution center as a whole. |
| Collaboration with other Azure services | Yes, you can use the same Azure subscription and resource group used for your Azure Digital Twins instance to incorporate other Azure resources that extend compute and processing capabilities. |

Using the decision criteria, you can determine that Azure Digital Twins is an appropriate choice for meeting your goals for IoT data analysis.
