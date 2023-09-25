Many organizations are interested in moving to the cloud, but the benefits aren't always clear. Moving to the cloud is a fundamental shift in how systems are purchased, designed, deployed, and secured. As a solution architect for Tailwind Traders, you need to understand the cloud's benefits, and align your business and technical goals to enjoy them.

The cloud delivers fundamental technology benefits that can help your enterprise execute on multiple goals:

- Modernize applications
- Optimize costs
- Build resilience and security
- Move what you want, when you want with hybrid flexibility
- Scale applications and workloads on demand
- Innovate faster with a managed platform

## Optimize costs

Datacenters are expensive. The costs of real estate, power, servers, storage, networks, and operations staff affect a company's bottom line. When customers migrate to modernize workloads in Azure, they convert upfront capital expenditures to operating expenditures that can be paid over time. Your cash flow improves by only paying for what you need. You can also achieve cost savings and efficiency.

:::image type="content" source="../media/optimize-it-spend.png" alt-text="Graph showing the difference between pay as you go Azure resources and reserved instance pricing.":::

In a [Forrester study](https://azure.microsoft.com/resources/forrester-economic-impact-azure-iaas/?azure-portal=true), customers report a 25 percent increase in productivity of IT staff, $10M in savings from avoided hardware, software, and staff costs, and a 478 percent return on investments.

### Pay less with Azure

If you have existing SQL Server or Windows Server licenses, you can reuse your licenses in the cloud by using the Azure hybrid benefit for exclusive savings. You can be confident you’re getting the best price on any cloud as Azure costs 5x less than AWS for Windows Server and SQL Server.

:::image type="content" source="../media/azure-vs-aws.png" alt-text="Two bar graphs showing AWS vs Azure costs for Windows and SQL Server with Azure being less expensive than AWS.":::

Azure hybrid benefit is a licensing benefit that helps you to significantly reduce the costs of running your workloads in the cloud. It works by letting you use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit also applies to RedHat and SUSE Linux subscriptions.

## Build resilience and security

Resilience is a core tenet of Azure trusted cloud commitments, alongside compliance, security, privacy, and transparency. Microsoft is committed to providing a trusted set of cloud services, which gives you the confidence to unlock the cloud's potential.

### High-availability network design

Unlike many other public cloud providers, traffic between Azure datacenters stays on our network and doesn't flow over the internet. This includes all traffic between Microsoft services anywhere in the world. For example, within Azure, traffic between virtual machines, storage, and SQL communication traverses only the Microsoft network, regardless of the source and destination region. Intra-region VNet-to-VNet traffic, and cross-region VNet-to-VNet traffic, stay on the Microsoft network, giving us more control.

The Microsoft global wide area network (WAN) plays an essential part in delivering a great cloud service experience. It offers near-perfect availability, high capacity, and the flexibility to respond to unpredictable demand spikes. In addition to having more datacenter regions than any of our competitors, Microsoft’s network is also one of the largest in the world.

:::image type="content" source="../media/network.png" alt-text="Diagram of the world with the Azure network shown with connections under the ocean.":::

### Availability zones

An [availability zone](/azure/availability-zones/az-overview?azure-portal=true) is a unique physical location within an Azure region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking.

To ensure resiliency, there's a minimum of three separate zones in all enabled regions. The physical separation of availability zones within a region protects applications and data from datacenter failures. Zone-redundant services replicate your applications and data across availability zones to protect from single-points-of-failure. With availability zones, Azure offers an industry best 99.99% VM uptime. The complete [Azure service-level agreement (SLA)](https://azure.microsoft.com/support/legal/sla/?azure-portal=true) explains the guaranteed availability of Azure as a whole.

:::image type="content" source="../media/zones.png" alt-text="Diagram showing a web application and SQL servers in three availability zones.":::

### Maintenance and Service Health alerts

Azure has invested in improving zero-impact and low-impact update technologies including hot patching, live migration, and in-place migration. The Azure operations team deploys dozens of security and reliability patches to host infrastructure each year, many of which were implemented with no customer impact or downtime.

### Machine learning-driven failure prediction

Microsoft uses predictive techniques to determine when a server might fail, so that operations can migrate virtual machines away from failing servers. Machine learning and artificial intelligence are used to collect and analyze data to learn the patterns that signal a server might fail. We apply these predictive techniques to disk failures, memory failures, and other types of hardware failures.

### Azure Service Health alerts and status

Azure has a full service health dashboard and sends alerts when issues occur. You can connect to the dashboard to receive information about the [status](https://status.azure.com/status/?azure-portal=true) of the Azure infrastructure and your services. Azure Service Health provides tailored information for your resources in the Azure portal.

:::image type="content" source="../media/azure-status.png" alt-text="Screenshot of Azure Status dashboard showing the current status of services in the Americas, Europe, and Asia Pacific.":::

### Security

Azure provides a secure foundation to strengthen your security posture across operations, technology, and partnerships. Microsoft invests 1 billion USD annually in cybersecurity and has more than 3,500 global security experts to monitor and secure the environment Azure resources. The Microsoft Intelligent Security Graph uses trillions of signals from Microsoft services and systems around the globe to identify new and evolving threats.

These ongoing investments protect workloads across your hybrid environments with intelligent security services. Customers enjoy reduced costs and complexity with a highly secure cloud foundation managed by Microsoft. Azure also has more compliance certifications than any other cloud provider. View the [comprehensive list](/azure/compliance).

#### Microsoft Defender for Cloud

Microsoft uses a wide variety of physical, infrastructure, and operational controls to help secure Azure, but there are more actions you need to take to help safeguard your workloads. Use [Microsoft Defender for Cloud](https://azure.microsoft.com/products/defender-for-cloud) to protect your hybrid cloud workloads.

:::image type="content" source="../media/security-portal.png" alt-text="Screenshot of the security portal in Defender for Cloud with recommendations.":::

#### Start with a secure foundation

Take advantage of the multi-layered security provided by Microsoft across physical datacenters, infrastructure, and operations in Azure. Gain from the state-of-art security delivered in Azure data centers globally. Rely on a cloud that's built with customized hardware, has security controls integrated into the hardware and firmware components, and added protections against threats such as DDoS.

#### Simplify security with built-in controls

Protect your workloads quickly with built-in controls and services in Azure across identity, data, networking, and apps. Get continuous protection with deeper insights from Microsoft Defender for Cloud. Extend protections to hybrid environments and easily integrate partner solutions in Azure.

#### Detect threats early with unique intelligence

Identify new threats and respond quickly with services that are informed by real-time global cybersecurity intelligence delivered at cloud scale. These actionable insights are developed by analyzing vast sources including 18 billion Bing web pages, 400 billion emails, 1 billion Windows device updates, and 450 billion monthly authentications. Using machine learning, behavioral analytics, and application-based intelligence, Microsoft data scientists analyze the flood of data in the Microsoft Intelligent Security Graph. The resulting insights inform services in Azure and help you detect threats faster.

## Hybrid flexibility

Hybrid configurations deployed to Azure provide flexibility in the timing of migration or modernization of workloads. Tailwind Traders isn't required to move everything at once and might have both an on-premises and Azure environment running side-by-side for the foreseeable future. With the hybrid tools, you can gain better management and governance of your workloads on-premises, in addition to migrating workloads to Azure and modernizing those workloads. This positions you to gradually continue updating workloads over an extended period of time and to manage both on-premises and Azure workloads within a single, modern environment.

## Scale applications and workloads on demand

Migrating to the cloud also allows for more flexibility and scalability and the ability to command growing or diminishing resources to capably meet business demands. When you plan for peak usage through on-premises systems, your servers are typically under-utilized, as you need more capacity than average to accommodate spikes when they occur. The cloud releases you from this model, enabling a scale-when-you-need-it approach.

Increase agility with best-in-class Azure infrastructure that scales to your business needs. With almost limitless scale, customers can scale up or out using [infrastructure as a service (IaaS)](https://azure.microsoft.com/overview/what-is-azure/iaas/?azure-portal=true) or [platform as a service (PaaS)](https://azure.microsoft.com/overview/what-is-paas/?azure-portal=true).

:::image type="content" source="../media/paas-iaas.png" alt-text="Diagram showing Paas or Iaas services from Azure.":::

### Azure autoscale

Most Azure solutions can be manually scaled up or down, with many also allowing for autoscale. Autoscale is a built-in feature of [App Services](/azure/azure-monitor/autoscale/autoscale-overview?azure-portal=true), [Azure Kubernetes Services](/azure/aks/cluster-autoscaler?azure-portal=true), [Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview?azure-portal=true), and [Azure Cosmos DB](/azure/cosmos-db/provision-throughput-autoscale?azure-portal=true).

Scaling helps applications perform their best when demand changes. Performance means different things for different applications. Some apps are CPU-bound, others memory-bound. For example, you could have a web app that handles millions of requests during the day and none at night. Autoscale can scale your service by any of these or by a custom metric you define. An Azure administrator can scale other services such as Azure Database or Azure SQL to increase the size or responsiveness.

### Increase performance

The benefits of migration can be immediate in terms of performance. Azure is available in 60 regions worldwide, more than any other cloud provider. Azure has one of the largest global networks, over 130,000 miles of fiber on land and below the sea. With 160+ edge sites, pairing points, and over 200 [Azure ExpressRoute](https://azure.microsoft.com/services/expressroute?azure-portal=true) partners, network speed and connectivity is unparalleled.

## Application innovation

Innovation can provide great business value by supporting both current development efforts and visions for future products. The key to innovation is understanding customer needs so you can create inventions that shape how they interact with your products. Intelligent cloud services like AI and machine learning make continuous innovation possible and can help to unlock new technical skills and expand business capabilities.
