You can use health modeling to quickly identify and resolve reliability issues in your application. Health modeling focuses on thorough instrumentation and monitoring, but it adds a layer of context to give you critical insight into your application's health.

## Problem context

Most mission-critical applications are substantial in scale and complexity. They typically generate high volumes of operational data. These characteristics can make it challenging to evaluate the state of a mission-critical application and to determine the optimal action to take to correct problems.

Health modeling maximizes observability by augmenting raw data logs and metrics with key business requirements to quantify an application's health and drive automated evaluation of its health states.

## Advantages of health modeling

To help you determine whether your environment is working as expected, it's important to monitor your application's health and the key metrics of the Azure resources it uses. To understand these metrics and evaluate the overall health of your workload, you need a holistic understanding of all monitored data. A health model can help you evaluate overall application health by displaying a clear indication of the health of the workload instead of only raw data metrics.

Using set indicators to represent health status makes it intuitive for an operator to understand the overall health of the workload and to respond quickly to any issues that might arise. Health status typically is presented by using *traffic light* indicators, such as green, yellow, and red.

## Layered health model

To build a health model, first define application health in the context of key business requirements. Quantify *healthy* and *unhealthy* states in a layered and measurable format. A layered health model reflects the application structure. You can trace application health indicators to lower-level dependencies and more quickly find the root cause of service degradation.

In a layered health model:

- The foundational layer should consider individual application components, such as Azure resources.
- Foundational components are aggregated alongside key non-functional requirements to build a business-contextualized lens of system flow health.
- System flows are aggregated with appropriate weights based on business criticality to build a meaningful definition of overall application health. Financially significant flows and customer-facing user flows are prioritized.
- Each layer captures what its healthy and unhealthy states represent. The health model uses these layered health definitions to inform critical monitoring metrics across all system components and to validate operational subsystem composition.

:::image type="content" source="../media/layered-health-model-example.png" border="false" alt-text="Diagram that shows the architecture for a typical layered health model.":::

For more information about layered health models, see [Layered application health](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#layered-application-health). Also, see an [example of a layered health model](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#example---layered-health-model).

## Who's responsible for health modeling?

Users who work in any of the following roles typically design and use a health model:

- Administrator
- Solution Architect
- Support Engineer
- DevOps Engineer
- Network Engineer
- Security Engineer

## How to get started

To do the health modeling exercise, you must have a deep understanding of the system and its expected performance. Start by defining all user flows and mapping dependencies between functional and logical components. Also, map the dependencies between Azure resources.
