
To determine whether your environment is working as expected, it's important to monitor your application's health and the key metrics of the Azure resources it uses. Health modeling is a design exercise that augments raw data logs and metrics with key business requirements. The goal is to quantify application health and drive automated evaluation of the health states.

## Advantages of health modeling

To evaluate the overall health of your workload, you need a holistic understanding of all metrics. You also need to identify and resolve reliability issues quickly. 

Health modeling focuses on thorough instrumentation and monitoring, but it also **adds a layer of context** to give you critical insight into your application's health. A well-designed health model should clearly indicate the overall health of the workload instead of only raw data metrics.

Because of the complex nature of mission-critical applications, they are expected to generate high volumes of operational data. It can be challenging to evaluate the health state of the application and figure out the right action that will resolve the identified issues.

Health model **uses set indicators to represent health status**, which makes it intuitive to understand and respond quickly to any issues that might arise. Health status typically is presented by using *traffic light* indicators, such as green, yellow, and red.

## How to get started

To do the health modeling exercise, you must have a deep understanding of the system and its expected performance. You will build a _layered model_ to reflect the health of the application. The layers represent the hierarchical application structure and its dependencies. 

The process of modeling health is a top-down design activity that starts by defining all user flows, mapping dependencies, and quantifying heath states to the flows. 

Here are the high-level steps:

1. Think about how the user will interact with the application. **Identify the components** of user flows, which has the individual application components, such as Azure resources. **Map the dependencies** between functional and logical components. Also, map the dependencies between Azure resources.
1. Combine the components with key non-functional requirements to **define business-contextualized flows**. 
1. **Quantify health state**s for each component by using performance metrics in the context of key business requirements.
1. **Apply appropriate weights** to each flow based on business criticality to build a meaningful definition of overall flow health. Financially significant flows and customer-facing user flows are more important than others. 

    You can trace application health indicators to lower-level dependencies to quickly find the root cause of service degradation.

This image shows an example outcome of the preceding approach. The health model uses these layered health definitions to inform critical monitoring metrics across all system components and to validate operational subsystem composition.

:::image type="content" source="../media/layered-health-model-example.png" border="false" alt-text="Diagram that shows the architecture for a typical layered health model.":::

In the next exercise, we'll apply the high-level process to an example and build a layered health model. 

For more information about layered health models, see [Layered application health](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#layered-application-health). Also, see an [example of a layered health model](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#example---layered-health-model).