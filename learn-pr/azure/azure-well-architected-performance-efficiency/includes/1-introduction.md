The Azure Well-Architected Framework is a design framework that can improve the quality of a workload by helping it to:

- Be resilient, available, and recoverable.
- Be as secure as you need it to be.
- Deliver a sufficient return on investment.
- Support responsible development and operations.
- Accomplish its purpose within acceptable timeframes.

Performance efficiency is the ability of your workload to adjust to changes in demands. A workload must be able to handle an increase in load without compromising user experience. Conversely, when there's a decrease in load, the workload must conserve its resources. Capacity, which indicates resource availability (CPU and memory), is a significant factor.

The workload design shouldn't just rely on pre-provisioned capacity, which guarantees performance up to a certain limit. If that limit is exceeded, the workload might have performance issues or even experience outages. When load is under that limit, resources continue to run unnecessarily, incurring costs.

You need a comprehensive strategy to sustain performance targets over time. Performance considerations shouldn't be an afterthought in the design process, only to be addressed when issues arise in production. Instead, adopt a mindset where performance is a key consideration from the early stages of design.

The concepts described in this module are not all-inclusive of performance efficiency in a workload, but they represent the core principles and some of their key approaches when you're designing a workload. For a complete perspective, across all of the Well-Architected Framework pillars, visit the [Azure Well-Architected Framework](/azure/well-architected) as you start planning and designing your architecture.

Each unit in this module focuses on one design principle and three approaches associated with that principle. The approaches in each unit are supported through the use of examples to help demonstrate how they can be applied to real-world scenarios. The examples are all based on a fictional company.

## Learning objectives

By the end of this module, you'll understand the four principles of the Performance Efficiency pillar and learn three approaches for each of the following:

- Define realistic performance targets for your workload, based on agreements between the business stakeholders and the workload owners.
- Choose the design that best meets your performance requirements.
- Operate your workload to continuously track its performance efficiency.
- Continuously improve the workload's performance efficiency through optimizations.

## Prerequisites

- Experience building or operating solutions by using core infrastructure technology such as data storage, compute, and networking
- Experience building or operating technology systems to solve business problems
