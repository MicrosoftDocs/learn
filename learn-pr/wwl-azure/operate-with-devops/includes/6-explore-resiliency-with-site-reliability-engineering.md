One of the primary objectives of DevOps is increasing reliability and efficiency of software delivery through the integration between the development and operations practices and through collaboration between the development and operations teams. In this context, DevOps shares its goals and principles with Site Reliability Engineering (SRE). By combining them, the organizations that develop and maintain software solutions (like the one described in the sample scenario of this module), will be able to increase their resiliency and availability. To better understand how this can be accomplished, this unit describes the correlation between SRE and DevOps and provides high-level guidance regarding implementing SRE.

## What is the correlation between SRE and DevOps?

SRE, pioneered by Google in early 2000s but widely adopted since then, promotes the application of software engineering practices to operations tasks. These practices guide you through the process of building, deploying, and operating reliable, scalable, and highly efficient software systems. You probably noticed that DevOps offers similar guidance. What distinguishes SRE from DevOps is its focus on *reliability engineering*. The *engineering* part of this term is meant to convey the use of specific, well-defined practices to accomplish its goals.

## How to implement SRE?

Implementing SRE requires following these well-defined practices. However, SRE implementations might also involve broader cultural and organizational changes.
To start, review the core concepts of SRE and define them according to your own specific requirements. SRE relies on explicit definition and measurement of reliability through quantifiable *Service Level Objectives* (*SLOs*) that determine the acceptable level of service characteristics, such as availability, latency, or error rates. *Service Level Indicators (SLIs)* are used to measure different aspects of the service's behavior that affect reliability. *Service Level Agreements (SLAs)* reference *SLIs* to define the acceptable performance. The *SLAs* serve as the foundation for *SLOs*.

SRE also introduces the concept of error budgets, which represents the acceptable degree of service degradation within a specified timeframe. The intention behind this concept is to optimize, rather than maximize reliability. This is important for two reasons:

- Increased reliability translates into more effort and a higher cost.
- High pace of changes tends to be disruptive and, as a result, might negatively affect reliability.

Using error budgets facilitates finding a balance between reliability, cost, and the pace of changes.

The initial steps of your implementation should include defining SLOs, establishing SLIs and SLAs, and setting up error budgets. The remaining steps include:

- Applying automation throughout software delivery process (although the focus of SRE is on automation of operational tasks, such as scaling, monitoring, and incident response).
- Setting up comprehensive monitoring and observability processes.
- Defining incident management processes.
- Defining change management processes.
- Planning proactively for capacity needs.
- Promoting continuous learning and continuous improvement through regular post-incident reviews and root cause analysis. Regularly review SLOs, error budgets, and operational practices.
- Integrating SRE practices with development processes.
- Fostering communication between the SRE team and other stakeholders.
