| :::image type="icon" source="../media/goal.svg"::: Ensure that there's enough supply to keep up with what you expect people will need. |
| :----------------------------------------------------------------------------------------------------------------------------- |

It's a good idea to stay ahead by keeping an eye on performance early. You should measure a baseline and have a rough idea of which parts of the system might cause trouble. You don't need to run a full performance test or dive into detailed optimization to do this. Just taking these early steps helps set you up for good performance management right from the start of the development lifecycle.

Try to look at the system as a whole instead of focusing on individual parts. Now is not the time for fine-tuning. Getting too detailed with performance tweaks this early can lead to trade-offs in other areas. As you move further along, like when you begin user acceptance testing or get closer to production, you'll be able to identify which areas really need that extra optimization.

**Example scenario**

Contoso Manufacturing built a Java Spring-based microservices app that helps them keep an eye on and fine-tune their manufacturing processes. Right now, the development and operations team is working on moving the app from their on-premises setup over to Azure.

The Azure-hosted app will be built on Azure Spring Apps, Azure Database for MySQL, and Azure IoT Hub. Contoso has an Azure ExpressRoute connection to Azure.

## Design the workload effectively

**Choose the right resources across your technology stack so you can reach your performance goals and make sure everything works well together. Look for features that can handle your scalability needs, and try to strike a good balance between how much you're allocating and what the system actually needs. These considerations help you handle unexpected surges efficiently.**

When you analyze what each resource can do, you ensure that every part of the system is pulling its weight and helping with overall performance. It also helps you find any built-in scaling features to take advantage of.

Rightsizing your resources means that you can handle changes in demand without over-provisioning, which leads to cost savings.

*Contoso's challenge*

- Right now, Contoso is fully managing the on-premises app environment, and it's putting a lot of pressure on the team. They're handling everything from setting up and maintaining servers, networks, and storage to configuring and updating the Java Spring service runtime and all its dependencies.

- The team is looking forward to migrating to a PaaS model by using Azure Spring Apps, which will allow the team to focus more of their energy on making sure their application delivers the intended business value and less time on managing the infrastructure.
- This application plays a big role in Contoso's business and has strict performance requirements. So, as part of the migration, the team needs to be sure that the technology choices they make will support those requirements.

*Applying the approach and outcomes*

- After comparing the different plans, the team opts for the Azure Spring Apps Standard plan, which provides a fully managed service for Spring Boot apps and is optimized for production traffic. With support for up to 500 instances per application, the Standard plan gives them plenty of compute capacity to cover their highest expected usage.

- The service can be set up to scale out when demand goes up and scale back in when that extra compute capacity isn't needed.
- The team looked at the Enterprise plan too, since it can scale up to 1,000 instances per application. But they decided that kind of capacity isn't necessary right now. They also feel confident that they don't need the level of support or the extra features that come with the Enterprise plan at this stage.

## Properly forecast capacity needs

**Plan your capacity based on both the demand that you expect and what your chosen resources can actually handle to build a stronger performance model. Use predictive modeling to get ahead of any changes, whether they're expected or unexpected. And make sure you have clear performance targets that you can translate into technical requirements that the team can work with.**

Taking this approach helps you use your resources more efficiently and meet demand without over-provisioning, which means you avoid spending more than you need to. It also gives you a better view of how your design decisions affect performance.

*Contoso's challenge*

- To get the most out of their production machinery, Contoso runs the production line on a rotating schedule. They can make different products at different times throughout the day and keep everything running efficiently.

- Each product on the line needs different operations, which means the control application has to handle different levels of compute demand. When the production line switches from one product to another, the control application has to take on several extra tasks that require increased compute capacity, like analyzing data from the last run and updating the control algorithms for the machines.

*Applying the approach and outcomes*

- To handle the higher demand during changeovers, the team starts by pinpointing the flows that manage that part of the process. They document what kind of performance those flows need and estimate how much traffic they'll get by using data from the on-premises version of the application. With that information in hand, they move on to estimating how much compute capacity the microservices in those flows will need.

- Autoscaling is set up for these components so that extra resources are ready to go before the switch period starts, and then scaled back after those tasks are done.
- The team plans to fine-tune the autoscaling settings before rolling the application out to production, based on how it actually performs in the new environment.

## Proof of concept deployment

**Implement a proof of concept (POC) that validates your technical requirements and design choices.**

A POC is a great way to check if your design can actually meet the performance targets, and whether those targets make sense in the first place. Based on the load that you expect, you can see if the planned capacity is enough to meet those goals.

Also, verify how your design choices affect cost.

*Contoso's challenge*

- While the application is still in development, the team is running extensive load and performance tests by using device simulators. They're using what they learn from those tests to fine-tune the autoscaling setup.

- One thing that might affect how well autoscaling works is the potential network latency between the Azure Spring Apps environment and the IoT devices on the manufacturing floor. Those devices connect to Azure through ExpressRoute. The team suspects that latency could be higher in Azure compared to the on-premises setup. They also think latency might vary depending on the time of day or where the devices are located.
- If latency goes up, it'll probably affect how many transactions each microservice instance can handle.

*Applying the approach and outcomes*

- To test their assumptions and gather metrics to fine-tune the setup, the team decides to roll out a POC in Azure. They build a test Azure Spring app that communicates with IoT devices spread across the manufacturing floor. These devices are connected to the on-premises network and registered with IoT Hub. Throughout the day, the test app randomly pings the devices and logs how long it takes to get a response.

- The data collected during this POC, along with the results from the load testing, will give the team a much clearer picture of how much compute capacity they'll actually need for the initial production launch.
- Based on the learnings from the POC, the team is also working on ways to improve their load test cases by making them better reflect real-world response times.

