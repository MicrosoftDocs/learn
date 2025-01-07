Failures can vary in the scope of their impact. The below table lists out various types of failures that can occur for your applications. This list isn't exhaustive, but a good directional guidance to think about various failures.

| **Failure type** | **Description** |
|:---|:---|
| **Hardware failure** | Any hardware component failure including compute, network, or storage hardware. |
| **Datacenter failure** | Entire data center impacted by issues such as power grid outage. |
| **Regional failure** | Any natural disaster-like event impacting multiple data centers in a region, causing the entire region to go down. |
| **Transient failure** | An intermittent issue causing the request between various components to fail intermittently. If not handled properly, end user requests fail. |
| **Dependency service** **failure** | Any service that the application is dependent on not functioning correctly. |
| **Heavy load** | Sudden spike in the incoming requests makes the application unable to service the requests. |
| **Accidental data deletion or** **corruption** | Critical data can often be deleted accidentally by the customer, or the data can be corrupted due to unforeseen reasons. |
| **Application deployment failure** | Failure caused by an issue while updating the production application deployments. |

During the design phase, you should perform a failure mode analysis (FMA). The goal of an FMA is to identify possible points of failure and define how the application will respond to those failures. Depending on your application's resiliency and availability requirements, you can design response strategies for various types of failure. Below are the questions to help define your application's design for resiliency.

- How will the application detect this type of failure?
- How will the application respond to this type of failure?
- How will you log and monitor this type of failure?

The FMA should be part of the architecture and design phases so that you can build failure recovery into the system from the beginning.

To conduct an FMA:

1. Identify all the components in the system. Include external dependencies, such as identity providers and third-party services.
2. For each component, identify potential failures that could occur. A single component may have more than one failure mode. For example, you should consider read failures and write failures separately, because the impact and possible mitigations will be different.
3. Rate each failure mode according to its overall risk. Consider these factors:

    - What is the likelihood of the failure? You don't need exact numbers; the purpose is to rank the priority.
    - What is the impact on the application, in terms of availability, data loss, monetary cost, and business disruption?

4. For each failure mode, determine how the application will detect, respond, and recover.
5. Consider tradeoffs in cost and application complexity.
