| :::image type="icon" source="../media/goal.svg"::: Provide enough supply to address anticipated demand. |
| :----------------------------------------------------------------------------------------------------------------------------- |

It's important to proactively measure performance. Measuring performance involves measuring baselines and having a preliminary understanding of which components of the system are likely to pose challenges. You can achieve it without conducting a full performance test or through granular optimization. By taking these initial steps, you establish a foundation for effective performance management early in the development lifecycle.

Examine the system as a whole, rather than focusing on individual components. Avoid fine-tuning at this stage. Making granular performance improvements results in tradeoffs in other areas. As you progress through the lifecycle and begin user acceptance testing or move toward production, you can quickly identify which areas require further optimization.

**Example scenario**

Contoso Manufacturing has developed an internally used Java Spring-based microservices app that is used to monitor and optimize their manufacturing processes. The workload team is in the process of migrating the app, currently hosted on-premises, to Azure. 

The Azure-hosted app will be built on Azure Spring Apps, Azure Database for MySQL, and Azure IoT Hub. Contoso has an ExpressRoute connection to Azure.

## Design the workload effectively

**Choose the right resources across the technology stack, which enables you to meet performance goals and integrate with the system. Consider features that can fulfill the scalability requirements, and find the right balance between resource allocation and system requirements, to handle unexpected surges efficiently.**

By analyzing the varying capabilities of the resources, you ensure that each component contributes to the overall functionality and performance of the system, and you can identify scaling functionality that you can take advantage of.

Right-sizing resources can meet changes in demand without over-provisioning, which leads to cost savings.

*Contoso's challenge*

- The existing on-premises app environment infrastructure is fully managed by Contoso which puts a significant burden on the team. They currently provision and maintain servers, networks, and storage, as well as configure and update the Java Spring service runtime and all dependencies.
- The team is looking forward to migrating to a PaaS model with Azure Spring Apps, which will allow the team to focus more of their energy on making sure their application delivers the intended business value and dedicate less time on managing the infrastructure.
- This application is critical to Contoso’s business, and has strict performance requirements, so they need to make sure the technology choices they make as part of the migration will allow them to meet those requirements. 

*Applying the approach and outcomes*

- After comparing the different plans available, the team opts for the Azure Spring Apps Standard plan, which provides a fully managed service for Spring Boot apps, optimized for production traffic. With a maximum of 500 instances per App, the Standard plan is able to provide enough compute capacity for the maximum anticipated usage.
- Additionally, the service can be configured to scale out as needed and will scale-in compute resources when the extra capacity isn’t needed.  
- The team looked at the Enterprise plan, which is able to scale up to 1000 instances per App, but decided that they won't need that amount of capacity at this point. They are also confident they don’t need the level of support the Enterprise plan offers, or the rest of its exclusive features. 

## Properly forecast capacity needs

**Do capacity planning based on demand and the capability of selected resources to enrich your performance model. Use predictive modeling techniques to forecast anticipated changes in capacity that can occur with predictable and unexpected changes. Define performance targets that can be translated into technical requirements.**

By adopting this approach, you can efficiently use resources and meet the demand without overprovisioning, thereby avoiding unnecessary costs. Additionally, it will help you understand how the design choices affect performance.

*Contoso's challenge*

- To maximize the efficient use of the production machinery, Contoso’s production line operates on a cyclical schedule, producing different products at different times of the day.
- Each product requires different operations and thus different computational needs from the control application. During the changeover between products, the control application needs to perform a variety of tasks that require increased compute capacity, like analyzing data from the previous production run and updating the control algorithms for the machines.

*Applying the approach and outcomes*

- To meet the higher demand during the changeover periods, the team first identifies the flows that handle the changeover functionality, documenting their performance requirements, and estimating their transaction volumes based on the on-premises version of the application. Armed with this data, the team proceeds to estimate the compute capacity needed by the microservices that are part of the target flows.
- Autoscaling is configured for these components, ensuring that additional resources are provisioned before the switch period and released after the tasks are done. 
- The autoscaling settings will be adjusted before deploying the app to production, based on the actual performance in the new environment. 

## Proof of concept deployment

**Implement a proof of concept (POC) that validates the technical requirements and design choices.**

A proof of concept is instrumental in validating the design to determine if the system can meet the performance targets and if those targets are realistic. Based on the anticipated load, you can validate whether anticipated capacity can meet the performance targets.

Also, verify the cost implications of the design choices.

*Contoso's challenge*

- During development, the team is performing extensive load and performance testing of the application functionality using device simulators and is using this information to optimize the autoscaling configuration. 
- One aspect that may affect the effectiveness of the autoscaling configuration is the potential network latency communicating from the Azure Spring Apps environment to the IoT devices in the manufacturing floor, which is connected to Azure via ExpressRoute. The team speculates that latency will be higher in Azure than it is for the on-premises version if the app, and that latency might also be affected by other factors, like time of day or device location.
- An increase in latency would likely have an impact on the transaction volume each microservice instance would be able to process.  

*Applying the approach and outcomes*

- The team decides to do deploy a POC to Azure to validate their hypotheses and to gather metrics that can be used to optimize the configuration. They build a test Azure Spring App to communicate with IoT devices spread across the manufacturing floor. The IoT devices are connected to the on-premises network and are registered with Azure IoT Hub. The test application randomly connect to the devices throughout the day by sending a simple ping and records the time it takes to receive a response.
- The data captured during this POC, combined with the results of the load testing, will enable the team to more accurately estimate the compute capacity needed, as they prepare for the initial production launch.
- The team is also looking at ways to further improve the test cases used for load testing to simulate more realistic response times based on the learnings from the POC. 
