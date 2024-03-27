As explained earlier in the course, testing in application lifecycle management is essential to maximizing code quality and minimizing operational risk associated with deploying and updating software. This is the reason for applying the *shift-left* approach, which introduces testing activities as early as possible in the development phase. However, there are certain aspects of testing, which aren't effective when carried out in this manner. Instead, to fully serve their purpose, they need to be performed in the production environment. This is referred to as the *shift-right* approach. The organization in our sample scenario would need to use this in order to properly assess the reliability of their systems in combination with fault injection. In this unit, examine this and other criteria in which shift-right testing is justified.

## What are the reasons for shift-right testing?

While the shift-left testing is ideal for unit and smoke testing, it's performed under conditions that typically differ significantly from those applicable to intended delivery targets. Even quality assurance and staging environments rarely fully reflect the complexities of their production counterparts. Effectively, the best way to fully examine the behavior of a workload following its deployment is to test it at that point.

Testing in production provides the following benefits:

- Reflects the actual working conditions, including extra load associated with handling end-user requests.
- Takes into account factors, which would be difficult to simulate, such as connectivity to external systems.
- Reflects changes in workload demand over time.

## What are typical shift-right testing scenarios?

While the shift-right testing approach could be justified in many scenarios, there are few in which it's suitable. These scenarios include:

- **Microservices deployments**: the microservices architecture typically consists of a large number of independently developed components. A sheer number of combinations of these services might justify the shift-right testing in order to focus on the scenarios most relevant in the actual production environment (according to their real-life usage).
- **Evaluating impact of network bandwidth and latency conditions**: network conditions tend to be challenging to simulate, so if a workload's performance is highly latency or bandwidth dependent, the shift-right testing might be the most suitable option.
- **User acceptance testing**: the actual users' feedback might be essential to validate the workload's performance and usability.
- **Validation failover procedures in redundant configurations**: fault injection and disaster recovery testing are meant to assess resiliency of production workloads. Fault injection involves intentionally introducing failures into individual components of a workload during its execution in order to identify any weaknesses and mitigate them, increasing the overall reliability.

   > [!NOTE]
   > Chaos engineering is another concept in the area of DevOps reliability testing. As with fault injection, it involves simulating failures ( in this case, to create a controlled *chaos* in the system being tested). However, its scope is typically broader, targeting the entire system, rather than just its individual components, and its testing scenarios tend to be more comprehensive. Effectively, chaos engineering is typically limited to *canary* environments that have very limited or no production impact.

   > [!NOTE]
   > You can use Azure Chaos Studio to implement chaos engineering experiments that target solutions hosted in Microsoft Azure. You will step through an example of such experiments in the lab of this module.
