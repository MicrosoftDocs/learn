Infrastructure as a service (IaaS) is the most flexible category of cloud services, as it provides you the maximum amount of control for your cloud resources. In an IaaS model, the cloud provider is responsible for maintaining the hardware, network connectivity (to the internet), and physical security. You’re responsible for everything else: operating system installation, configuration, and maintenance; network configuration; database and storage configuration; and so on. With IaaS, you’re essentially renting the hardware in a cloud datacenter, but what you do with that hardware is up to you.

Earlier, you learned how the shared responsibility model divides security and governance duties between you and the cloud provider. The following diagram zooms in on the technology stack itself — the individual infrastructure layers such as networking, storage, servers, and runtime — to show exactly which layers you operate in each service model.

:::image type="content" source="../media/cloud-service-types-comparison.png" alt-text="Diagram comparing IaaS, PaaS, and SaaS responsibility stacks showing which layers are managed by the customer versus the cloud provider.":::

## Responsibility focus in IaaS

In IaaS, the cloud provider is responsible for the physical infrastructure and connectivity to the internet. You manage most of the workload stack, including operating systems, patching, configuration, and many security controls. This model gives you maximum flexibility, and also the largest operational responsibility.

:::image type="content" source="../media/describe-infrastructure-service.png" alt-text="Diagram showing IaaS responsibility split with customer managing OS through applications and provider managing physical infrastructure, plus common scenarios.":::


## Scenarios

Some common scenarios where IaaS might make sense include:

 -  Lift-and-shift migration: You’re setting up cloud resources similar to your on-prem datacenter, and then simply moving the things running on-prem to running on the IaaS infrastructure.
 -  Testing and development: You have established configurations for development and test environments that you need to rapidly replicate. You can start up or shut down the different environments rapidly with an IaaS structure, while maintaining complete control.

