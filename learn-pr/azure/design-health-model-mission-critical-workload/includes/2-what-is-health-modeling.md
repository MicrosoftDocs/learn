
To determine whether your environment is working as expected, it's important to monitor your application's health and the key metrics of the Azure resources it uses. Health modeling is a design exercise that augments raw data logs and metrics with key business requirements. The goal is to quantify application health and drive automated evaluation of the health states.

## Advantages of health modeling

To evaluate the overall health of your workload, you need holistic understanding of all metrics. You also need to identify and resolve reliability issues quickly. 

Health modeling focuses on thorough instrumentation and monitoring, but it also **adds a layer of context** to give you critical insight into your application's health. A well-designed health model should clearly indicate the overall health of the workload instead of raw data metrics.

Because of the complex nature of mission-critical applications, they are expected to generate high volumes of operational data. It can be challenging to evaluate the health state of the application and figure out the right action that will resolve the identified issues.

Health model uses set indicators to represent health status, which makes it intuitive to understand and respond quickly to any issues that might arise. Health status typically is presented by using *traffic light* indicators, such as green, yellow, and red. You can trace application health scores to **quickly find the root cause of service degradation**.

## How to get started

To do the health modeling exercise, you must have a deep understanding of the system and its expected performance. A _layered model_ is recommended to reflect the overall health of the application _and_ at a granular level. The layers represent the hierarchical workload structure that includes the application and its dependencies. 

- At the top layer, health represents user interaction or flows within the application. Think about the flows that are on the critical path and the ones that aren't. 
- At lower layers, health of the individual application components must be defined keeping in mind the key non-functional requirements. **Map the dependencies** between functional and logical components. Also, map the dependencies between Azure resources that application components use.
- At the foundational layer, health represents the Azure resources, which are used by the application.

The process of modeling health is a top-down design activity that starts by defining all user flows, mapping dependencies, and quantifying heath states to the flows.

Here are the recommended steps for the approach:

1. **Quantify health states for each component** so that each component indicates a health score. The health score can be an aggregate of various performance metrics taking into consideration the key business requirements.
1. **Quantify health states for each flow** by combining the health score of individual components to indicate health of the flow. Factor in the non-functional requirements to set context in terms of criticality.
1. Based on business criticality, **apply appropriate weights** at all layers to build a meaningful definition of overall health. For example, at the top layer, financially significant flows and customer-facing user flows are more important than others. 

This image shows an example outcome of the preceding approach. The health model uses these layered health definitions to inform critical monitoring metrics across all system components and to validate operational subsystem composition.

:::image type="content" source="../media/layered-health-model-example.png" border="false" alt-text="Diagram that shows the architecture for a typical layered health model.":::

In the next exercise, we'll apply the high-level process to an example and build a layered health model. 

For more information about layered health models, see [Layered application health](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#layered-application-health). Also, see an [example of a layered health model](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#example---layered-health-model).