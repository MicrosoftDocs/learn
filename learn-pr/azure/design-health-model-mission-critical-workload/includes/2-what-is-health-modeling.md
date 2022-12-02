Health modeling and observability are essential concepts to maximize reliability, which focuses on robust and contextualized instrumentation and monitoring. These concepts provide critical insight into application health, promoting the swift identification and resolution of issues.

## Problem context

Most mission-critical applications are significant in terms of both scale and complexity and therefore generate high volumes of operational data, which makes it challenging to evaluate and determine optimal operational action.

Health modeling ultimately strives to maximize observability by augmenting raw monitoring logs and metrics with key business requirements to quantify application health and drive automated evaluation of health states.

### Layered application health

A layered health model enables application health to be traced back to its lower level dependencies, which helps to quickly find the root cause of service degradation. Each layer of the health model should capture what "healthy" and "unhealthy" states represent. 

For more information about layered application health, see [Layered application health](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#layered-application-health). For an example of a layered health model, see [Example - Layered health model](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#example---layered-health-model).

![Diagram showing the architecture for a typical layered health model.](../media/layered-health-model-example.png)

## Advantages of health monitoring

To help you determine whether your environment is working as expected, it's important to monitor your application's health and the key metrics of its Azure resources. To understand these metrics and evaluate the overall health of your workload, you need a holistic understanding of all of the data monitored. A health model can assist with the evaluation of the overall health status by displaying a clear indication of the health of the workload, as opposed to raw data metrics. Representation of a health model with set indicators makes it intuitive for an operator to understand the overall health of the workload and respond quickly to any issues that might arise. Health status is typically presented as "traffic light" indicators, such as red, green, or yellow.

## Who's responsible for health modeling?

Users with any of the following roles typically design and use a health model:

- Administrator
- Solution Architect
- Support Engineer
- DevOps Engineer
- Network Engineer
- Security Engineer

## How to get started

The process of modeling health is a top-down design activity. It starts with an architectural exercise to define all user flows and map dependencies between functional and logical components, thereby implicitly mapping dependencies between Azure resources.

To capture health states for an individual component, that component's distinct operational characteristics must be understood under a steady state that's reflective of the production load. Performance testing is therefore a key capability to define and continually evaluate application health.
