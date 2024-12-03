A cloud environment is composed of different services distributed among geographies. These geographies are composed of multiple regions and datacenters. Ultimately, this means that even with all the levels of abstraction, your cloud environment is powered by datacenters that are managed by a cloud provider.

Datacenters require planned maintenance, hardware upgrades, failover tests, and much more to improve their resiliency. With that in mind, how can you be aware of the health of Azure Services within datacenters? Azure Service Health is your answer. Azure Service Health provides a personalized view of your Azure services' status and regions and includes information about planned maintenance and current incidents. It also offers rich functionality including alerting, health advisories, and root-cause analysis.

:::image type="content" source="../media/1-azure-service-health.png" alt-text="Screenshot of Azure Service Health showing the overall information provided" lightbox="../media/1-azure-service-health-expanded.png":::

## Example scenario

As an IT Administrator, you start to receive inquiries from your developer team regarding slowness on applications inside some virtual machines running on Azure.

You start investigating the service looking for issues. You check the application components, message queues, connectivity, logs, and alerts, but you can't find anything that can explain the slow-response behavior.

After spending many hours on your investigation, you discover an issue with your cloud service provider. The identified issue is causing a delay over the virtual machines that are deployed in a specific region.

This is an example of where using Azure Service Health could've helped you to identify, in advance, the source of the issue and start an action plan to solve it. Instead, you had to spend many hours of investigation to identify the root cause. A simple health alert created to track your virtual machines' health in a specific Azure region would notify you as soon the issue started.

## What will we be doing?

In this module, we'll evaluate what kind of information is available from Azure Service Health to help you understand the health of your cloud resources.

## What is the main goal?

By the end of this session, you'll be able use Azure Service Health to create awareness of service issues, planned maintenance, health, and security advisories related to your resources. You'll also learn how to create health alerts.
