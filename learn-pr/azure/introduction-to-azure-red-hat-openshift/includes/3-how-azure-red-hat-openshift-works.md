Azure Red Hat OpenShift operates on a managed cluster model, where the underlying infrastructure is provisioned and maintained by Azure and Red Hat. The platform leverages multiple availability zones in each region to ensure high availability and resilience. A default Azure Red Hat OpenShift deployment includes three Azure VMs for master nodes and three Azure VMs for worker nodes. In regions with multiple availability zones, Azure Red Hat OpenShift adjusts this default to create a machine set for each zone, provisioning a single machine in each set. This distribution across several physical locations minimizes the risk of service interruptions due to hardware failures or network issues.

:::image type="content" source="../media/aro-availability-zones.png" alt-text="Diagram showing three different Azure Red Hat OpenShift availability zones.":::

When a cluster is deployed, it's automatically configured to ensure that both control and worker nodes are available across different zones, which is essential for service continuity. Developers using Azure Red Hat OpenShift have access to an intuitive user interface that allows them to effectively manage their applications and clusters.

## Deployment and resource management

When you deploy Azure Red Hat OpenShift, resources are allocated to two distinct resource groups within your Azure subscription:

- **Cluster resource group:** Contains the OpenShift cluster itself. You have full access and permissions over these resources, allowing you to manage your applications and workloads. By default, when you create the Azure Red Hat OpenShift cluster from the Azure portal, this resource and the new virtual network (if you chose to create one instead of using a pre-existing one) will be placed in the selected resource group.

- **Managed resource group:** Includes the underlying infrastructure such as virtual machines, network security groups, load balancers, network interfaces, public ip addresses, private endpoints, disks, and storage accounts. Permissions in this group are restricted to ensure that Microsoft and Red Hat can manage and support the infrastructure without interference. This design follows the principles of managed applications in Azure, where two resource groups are utilized to separate customer resources from managed resources. For more details, you can refer to the managed applications resource groups overview.

You can specify existing virtual networks (VNets) and your own network security groups (NSGs) for granular control over network configuration and security. <!-- Note that some custom deployment options are available only through the CLI. -->

## API server visibility
You can set the visibility of the API server:

- **Public API server:** Accessible from external networks, allowing for broader accessibility.

- **Private API server:** Restricted to access only from hosts within the virtual network you created or from a peered virtual network, adding an extra layer of security.

## Ingress visibility

Ingress visibility can be configured based on your requirements:

- **Public:** Routes default to a public Standard Load Balancer, facilitating external access to your applications, but this can be changed if necessary.

- **Private:** Routes default to an internal load balancer, restricting access to your applications within your virtual network. This default can also be modified.


## Automated cluster configuration

The setup and configuration of the OpenShift cluster are automated, simplifying the deployment process. Azure Red Hat OpenShift automatically configures necessary components, such as the control plane, worker nodes, and networking settings, reducing the complexity typically associated with Kubernetes environments.

## Integrated identity and access management

Access to the managed resource group can be granted to identities within the publisher’s tenant, allowing Microsoft and Red Hat to provide ongoing support and maintenance without compromising your environment's security. Role-based access control (RBAC) and Microsoft Entra ID integration ensure secure and appropriately managed access. All accesses are done via the Azure Red Hat OpenShift RP (an API used to manage the resources) and only to resources that are used by the cluster, not customer workloads/data.

## Cost and billing

You'll receive a unified bill within your Azure subscription for both Red Hat and Azure solutions and you can also leverage your Azure monetary commits, besides allowing you to use Azure Reservations and Azure Sport Instances. The transparent pricing model allows you to understand and predict costs associated with running OpenShift workloads on Azure.

## Automation and maintenance

Automation is a core principle of Azure Red Hat OpenShift. The Managed Upgrade Operator allows teams to schedule cluster upgrades at times that minimize operational impact. This ensures that the cluster is always up to date with the latest OpenShift versions, while the SRE team oversees the process to ensure best practices are followed. Updates are conducted regularly, with minor versions being released approximately every three months and security patches made available weekly.

Azure Red Hat OpenShift integrates seamlessly with monitoring and logging tools, allowing teams to track the health of the cluster and the performance of their applications. By integrating Azure Monitor and utilizing operators such as the EFK (Elasticsearch, Fluentd, and Kibana) stack, organizations can implement robust logging solutions that ensure all operations are recorded and auditable. This enhances visibility into cluster operations and enables development teams to quickly identify and resolve issues.

## Security and compliance

The architecture of Azure Red Hat OpenShift is designed to facilitate compliance with security and governance standards. Azure provides a range of compliance certifications that businesses can utilize to meet specific regulatory requirements. Security features such as RBAC and Microsoft Entra ID integration ensure that only authorized users can access cluster resources. This, combined with Red Hat’s security practices, provides a robust solution that meets the security and compliance needs of organizations across sensitive sectors.

By leveraging Azure Red Hat OpenShift, you benefit from a robust, enterprise-grade Kubernetes platform with the simplicity and efficiency of a managed service. This dual resource group setup ensures you maintain control over your application workloads while Microsoft and Red Hat manage the underlying infrastructure. The options for API and ingress visibility further enhance your ability to tailor the deployment to fit your organization's needs, offering a seamless and secure operational experience.
