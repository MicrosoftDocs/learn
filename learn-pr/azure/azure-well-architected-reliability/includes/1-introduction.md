The Azure Well-Architected Framework is a design framework that can improve the quality of a workload by helping it to:

- **Be resilient, available, and recoverable.**
- Deliver a sufficient return on investment.
- Support responsible development and operations.
- Accomplish its purpose within acceptable timeframes.

Outages and malfunctions are serious concerns for all workloads. A reliable workload must survive those events and **continue to consistently provide its intended functionality**. It must be **resilient** so that it can detect, withstand, and recover from failures within an acceptable time period. It must also be **available** so that users can access the workload during the promised time period at the promised quality level.

Workload architectures should have **reliability assurances in application code, infrastructure, and operations**. Design choices shouldn't change the intent that's specified by business requirements. Such changes should be considered significant tradeoffs.

The concepts described in this module are not all-inclusive of reliability in a workload, but they represent the core principles and some of their key approaches when you're designing a workload. For a complete perspective, across all of the Well-Architected Framework pillars, visit the [Azure Well-Architected Framework](/azure/well-architected) as you start planning and designing your architecture.

Each unit in this module focuses on one [design principle](/azure/well-architected/reliability/principles) and three approaches associated with that principle. The approaches in each unit are supported through the use of examples to help demonstrate how they can be applied to real-world scenarios. The examples are all based on a fictional company.

## Learning objectives

By the end of this module, you'll understand the five principles of the Reliability pillar and learn three approaches for each of the following:

- Determine the reliability requirements from the business and apply those requirements to your workload design.
- Design your workload to be fault-tolerant and able to degrade gracefully.
- Design your workload to recover from malfunctions ranging from component-level faults to disasters.
- Build observability and testing into your workload design and operations practices.
- Design your workload with a focus on simplicity to minimize risks.

## Prerequisites

- Experience with core infrastructure technologies such as data storage, computing, and networking.
- Experience building or operating technology systems to solve business problems.
