Failures can vary in the scope of their impact. The following table describes types of failures that can affect your applications. It isn't exhaustive, but it provides a starting point for failure analysis.

| **Failure type** | **Description** |
|:---|:---|
| **Hardware failure** | Any hardware component failure including compute, network, or storage hardware. |
| **Datacenter failure** | An entire datacenter is affected by issues such as a power grid outage. |
| **Regional failure** | An event, such as a natural disaster, affects multiple datacenters in a region and causes a regional outage. |
| **Transient failure** | An intermittent issue causes requests between components to fail. If it isn't handled properly, user requests can fail. |
| **Dependency service** **failure** | A service that the application depends on isn't functioning correctly. |
| **Heavy load** | A sudden spike in incoming requests exceeds the application's ability to process them. |
| **Accidental data deletion or** **corruption** | Critical data can often be deleted accidentally by the customer, or the data can be corrupted due to unforeseen reasons. |
| **Application deployment failure** | Failure caused by an issue while updating the production application deployments. |

During the design phase, you should perform a failure mode analysis (FMA). The goal of an FMA is to identify possible points of failure and define how the application will respond to those failures. Depending on your application's resiliency and availability requirements, you can design response strategies for various types of failure. Use the following questions to guide your resiliency design:

- How will the application detect this type of failure?
- How will the application respond to this type of failure?
- How will you log and monitor this type of failure?

The FMA should be part of the architecture and design phases so that you can build failure recovery into the system from the beginning.

To conduct an FMA:

1. Identify all the components in the system. Include external dependencies, such as identity providers and third-party services. Map these components and dependencies to the critical user and system flows they support.
1. For each component, identify potential failures that could occur. A single component may have more than one failure mode. For example, you should consider read failures and write failures separately, because the impact and possible mitigations will be different.
1. Rate each failure mode according to its overall risk. Consider these factors:

    - What is the likelihood of the failure? You don't need exact numbers; the purpose is to rank the priority.
    - What is the impact on the application, in terms of availability, data loss, monetary cost, and business disruption?

1. For each failure mode, determine how the application will detect, respond, and recover.
1. Consider tradeoffs in cost and application complexity.
1. Document the effect on each critical flow, including partial failures, shared dependencies, and failures that could spread to other components. Revisit the analysis when the architecture changes or incidents reveal new failure modes.
