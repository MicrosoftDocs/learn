Infrastructure as a service (IaaS) is the most flexible category of cloud services. It provides the maximum amount of control for your cloud resources. In an IaaS model, the cloud provider is responsible for maintaining the hardware, network connectivity to the internet, and physical security. You're responsible for everything else, including:

- Operating system installation, configuration, and maintenance
- Network configuration
- Database and storage configuration

With IaaS, you're essentially renting the hardware in a cloud datacenter, but what you do with that hardware is up to you.

Earlier, you learned how the shared responsibility model divides duties between you and the cloud provider. The following diagram shows the individual infrastructure layers, such as networking, storage, servers, and runtime. It highlights which layers you operate in each service model.

:::image type="content" source="../media/cloud-service-types-comparison.png" alt-text="Diagram comparing IaaS, PaaS, and SaaS responsibility stacks showing which layers are managed by the customer versus the cloud provider.":::

## Responsibility focus in IaaS

In IaaS, the cloud provider is responsible for the physical infrastructure and internet connectivity. You manage most of the workload stack, including operating systems, patching, configuration, and many security controls. This model gives you maximum flexibility and the largest operational responsibility.

:::image type="content" source="../media/describe-infrastructure-service.png" alt-text="Diagram showing IaaS responsibility split with customer managing OS through applications and provider managing physical infrastructure, plus common scenarios.":::

## Scenarios

Common scenarios where IaaS might make sense include:

- **Lift-and-shift migration**: You set up cloud resources similar to your on-premises datacenter, and then move your workloads to the IaaS infrastructure.
- **Testing and development**: You need to rapidly replicate established configurations for development and test environments. You can start up or shut down different environments rapidly with an IaaS structure while maintaining complete control.