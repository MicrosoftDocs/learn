# Title

Design a holistic monitoring strategy on Azure

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Monitor
- Application Insights
- Security Center
- Azure Sentinel (Preview)

## Prerequisites

- Basic knowledge of Azure services
- Basic knowledge of operational concepts, such as monitoring, logging, and alerting

## Summary

Use monitoring services on Azure to bring operational excellence to your applications and infrastructure.

## Learning objectives

1. Select the appropriate monitoring solution based on use case
2. Integrate monitoring solutions to create a unified monitoring strategy

## Chunk your content into subtasks

Identify the subtasks of *Design a holistic monitoring strategy on Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtasks will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Introduce continuous monitoring | Provision of a monitoring strategy to encompass all solutions | N/A | 1 | Yes |
| The technology options available | A monitoring strategy that encompasses all solutions | N/A| 1 | Yes |
| Assess security center for monitoring your infrastructure | Provide monitoring, insights, and alerts | Knowledge Check| 1 | Yes |
| Assess application insights for monitoring your applications | Provide monitoring, insights, and alerts  | Knowledge Check | 1 | Yes |
| Use Azure Monitor to provide a unified monitoring strategy | Design of a monitoring strategy that encompasses all solutions | Knowledge Check & Exercise | 2 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    A financial organization is moving its systems to Azure, a mixture of IaaS and PaaS services. They have had several instances in their previous environment where systems failed, or issues arose, and extended delay to engage resources and resolve the issue as it occurred. This impacted customers ability to access their accounts, and has hurt customer satisfaction. They want to design a monitoring strategy that encompasses all solutions they use, provides insights and alerting into the log data they accumulate, and ensures they can quickly identify and minimize impact if and when systems fail in the future.

1. **Introduction to continuous monitoring in Azure**

    List the content that will enable the learner to *Continuous monitoring in Azure*:

    - Why use continuous monitoring?
    - Why monitor your applications?
        - Improve control over your development pipeline
        - Integration with DevOps projects
    - Why monitor your infrastructure?
        - Obtain platform metrics
        - Enable deeper monitoring of VMs and Azure Kubernetes clusters

1. **Monitoring options available in Azure**

    List the content that will enable the learner to *understand the monitoring technology options available in Azure*:

    - What is security center?
    - What are application insights?
    - What is Azure sentinel?
    - What is Azure monitor?

1. **Analyze infrastructure security using Azure Security Center**

    List the content that will enable the learner to *assess the usefulness of security center in their solution*:

    - Criteria for assessing security center
    - Understanding your architecture
    - Protecting against threats
    - Responding to threats

   **Knowledge check**

    What types of questions will test *the understanding of security center as a monitoring solution*?

    - Why would you use security center to monitor your infrastructure?
    - How would you use security center to protect your infrastructure?
    - What is the key tool for providing continuous monitoring?

1. **Analyze web applications using Azure Application Insights**

    List the content that will enable the learner to *access the viability of application insights as a monitoring solution*:

    - Criteria for assessing application insights
    - How application insights work
    - Simple integration into existing applications
    - Improved DevOp support, analytics, and response

   **Knowledge check**

    What types of questions will test *the understanding of application insights as a monitoring solution*?

    - Why would you use application insight?
    - How can you continuously monitor your applications from different geographic locations?
    - How would you continuously monitor your release pipelines?
   
1. **Analyze enterprise security using Azure Sentinel**

   List the content that will enable the learner to *access the viability of Azure Sentinel as a monitoring solution*:

   - Criteria for assessing Azure Sentinel
   - Connect data sources
   - Use alerts to monitor your enterprise
   - Investigate incidents
   - How to respond to threats with Azure Sentinel

   **Knowledge check**

    What types of questions will test *how Azure Sentinel can improve enterprise security monitoring*?

    - Why would you use Azure Sentinel?
    - How do you set up Azure Sentinel on Azure?
    - Sentinel has raised an incident. How can you investigate which users have been affected?

1. **Unifying monitoring solutions in Azure**

    List the content that will enable the learner to *understand how Azure Monitor can provide a unified monitoring solution*:

    - Criteria for assessing Azure Monitor
    - The benefits of Azure Monitor
    - Integration with Azure Security Center
    - Integration with Application Insights
    **Knowledge check**

    What types of questions will test *the understanding of Azure Monitor as a unifying monitoring solution?*:

    - You need to write queries to analyze your log data. How would you do this?
    - How can you automatically collect security-related data from all newly created virtual machines into one central location?
    - How can you analyze both security-related data, and application performance data, together?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - You gained an awareness of the available monitoring options available in Azure as part of a unified monitoring solution.
    - You accessed the merits of using security center to improve monitoring of your infrastructure and the tools available to respond to any incidents.
    - You accessed the viability of using application insights to provide robust application monitoring during DevOps and in live situations.
    - You explored Azure sentinel as a tool to improve security monitoring across your whole enterprise.
    - You saw how Azure monitor can consume data from other services to provide a single unified monitoring view of your enterprise and allow rapid response to any notifications and alerts.

## Notes

This one may not have a ton of interactivity, but should be focused on selecting the right services, how each plays into an overall monitoring strategy, and integrating them together to create a solid monitoring strategy.

https://docs.microsoft.com/azure/azure-monitor/continuous-monitoring

During design investigation, the following URLs were considered.

- Azure Application Insights: https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview
- Azure Sentinel: https://docs.microsoft.com/azure/sentinel/overview
- Azure Security Center: https://docs.microsoft.com/azure/security-center/security-center-intro
- Permission in Azure Security Center: https://docs.microsoft.com/azure/security-center/security-center-permissions

During the design, the following considerations were made

- Having reviewed the application insights service, this did not look suitable to include as an exercise, due to the need to have an application with which to add the insights code to.  If there is a standard Microsoft test application that can be used, please let me know.
- Azure Sentinel requires a specific configuration and set of permissions to run.  The user may not have been granted these permissions.  So it was decided to make a knowledge check rather than a hands-on exercise.