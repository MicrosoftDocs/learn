For a mission-critical workload, continuous validation ensures that a solution stays operational even when failures occur.

In this module you’ll learn how to plan, design and implement continuous validation by using Azure Load Testing and Azure Chaos Studio embedded into pipelines in Azure DevOps.

**Azure Load Testing** generates synthetic traffic to the application, while **Azure Chaos Studio** injects failure and can simulate outages of key components. Having the option to run these two services simultaneously, as part a pipeline in **Azure DevOps**, is key to validating the impact of application changes under realistic conditions at any time of the development cycle.

## Example scenario

Contoso Shoes migrated its on-premises deployments to the cloud two years ago. Although they saw improvements in operations, it was challenging to keep their availability and uptime within the service level agreement (SLA). Previous launches led to outages because the system wasn't able to meet the increase in load and they weren't able to anticipate the issues and their impact earlier in the development cycle. It resulted in significant financial loss. Based on that experience, Contoso Shoes has successfully applied the [principles of mission-critical architecture](/azure/architecture/framework/mission-critical/mission-critical-design-principles) in their main customer-facing application.

Now that Contoso Shoes has applied the mission-critical design methodology to their deployments, it:

- Has expanded to two regions to serve clients faster with lower latency
- Now operates two AKS clusters in two regions with Azure Front Door for global traffic distribution.
- Is still facing outages from time to time due to unexpected spikes in traffic and erroneous releases

To prevent performance bottlenecks and to increase confidence in new releases, Contoso Shoes has decided to implement [continuous validation](/azure/architecture/guide/testing/mission-critical-deployment-testing).

## Learning objectives

By the end of this module, you'll be able to:

- Understand the importance of user and system flows as the foundation for defining load tests and chaos experiments for your workload
- Establish a baseline with expected thresholds for the system  
- Define requirements for load testing and chaos experiments
