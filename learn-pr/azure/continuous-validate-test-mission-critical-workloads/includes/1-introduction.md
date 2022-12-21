**Continuous Validation (CV)** is one of the concepts of the **Azure Mission-Critical** design methodology that helps to ensure that a mission-critical solution stays operational even when failures and exceptional situations occur. This is done by testing changes and releases in a controlled environment under production-like conditions such as sustained user load and by injecting faults to test the workloads resiliency and measures to handle faults.

Continuous Validation is implemented as a set of processes and tools, embedded into a pipeline or workflow to enable developers and ops teams to do CV on a regular basis for example prior to every release or major code changes and helps to ensure a solution's performance and resiliency before it gets rolled out to production.

In Continuous Validation, you:

- Run tests under production-like conditions
- Define tests based on user and system flows and their expected performance
- Establish baselines for different scenarios and stages
- Evaluate and adjust baselines and thresholds on a regular basis
- Implement automated Continuous Validation pipelines

Microsoft Azure provides the following services to implement load testing and chaos engineering:

- [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) is a managed service used to generate synthetic traffic to test the application and underlying infrastructure and services.
- [Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a managed service that provides chaos engineering capabilities to systematically inject failures into key components of the application.

To validate the impact of application changes under realistic conditions at any time of the development cycle, you can run these two services simultaneously by embedding them in an Azure DevOps CI/CD pipeline.

## Example scenario

Contoso Shoes migrated its on-premises deployments to the cloud two years ago. Although they saw improvements in operations, it was challenging to keep their availability and uptime within the service level agreement (SLA). Previous product launches led to outages because the system wasn't able to meet the increase in load and they weren't able to anticipate the issues and their impact earlier in the development cycle. It resulted in significant financial loss. Based on that experience, Contoso Shoes has successfully applied the [principles of mission-critical architecture](/azure/architecture/framework/mission-critical/mission-critical-design-principles) in their main customer-facing application.

Now that Contoso Shoes has applied the mission-critical design methodology to their deployments, it:

- Has expanded to two regions to serve clients faster with lower latency
- Now operates two AKS clusters in two regions with Azure Front Door for global traffic distribution.
- Is still facing outages from time to time due to unexpected spikes in traffic and erroneous releases

To prevent performance bottlenecks and to increase confidence in new releases, Contoso Shoes has decided to implement [continuous validation](/azure/architecture/guide/testing/mission-critical-deployment-testing).

## Learning objectives

By the end of this module, you'll be able to:

- Understand the importance of user and system flows as the foundation for defining load tests and chaos experiments for your workload.
- Establish a baseline with expected thresholds for the system.
- Define requirements for load testing and chaos experiments.
