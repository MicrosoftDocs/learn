One crucial part of building a cloud migration and modernization strategy is to identify the triggers for cloud adoption. Some triggers might prompt quick action, while others call for a more active, hands-on approach.

Business and IT-driven goals point to migration and modernization triggers, which determine the strategy for moving applications to the cloud. For IT-based triggers, *migration* of your workloads is best. When you're presented with business-focused goals, we recommend *modernizing* your applications.

:::image type="content" source="../media/migrate-or-modern-2.png" alt-text="Diagram showing the two migration and modernization choices.":::

With migration, the workloads are moved to the cloud unchanged. With modernization, the application code is changed or the application is rewritten or replaced to use new cloud technologies.

At Tailwind Traders, you could develop a decision tree to help you to evaluate your applications:

:::image type="content" source="../media/modernize-decision-tree.png" alt-text="Diagram of a decision tree showing PaaS or IaaS based on future development on an application.":::

As the solution architect on the Tailwind Traders team, you need to understand the triggers for your migration or modernization.

:::image type="content" source="../media/migration-triggers-2.png" alt-text="Diagram showing the triggers for a migration or modernization project.":::

## Migration triggers

Migration triggers are typically IT-oriented or based on timelines. The migration to the cloud is driven by the need to quickly reduce on-premises costs, stay secure, and simplify operations. These triggers include:

- Datacenter contract expiration
- Cash flow challenges and resource constraints
- Business continuity
- Cybersecurity threats

### Datacenter contract expiration

The expiration of datacenter contracts is an excellent opportunity to begin the cloud migration journey since many organizations might consider if it’s worth continuing to run their datacenter if they’re facing resource and cash flow challenges.

#### Eliminate recurring expenses

- Owning and managing physical datacenters can be expensive, both in terms of financial cost and effort.
- Datacenter contract expiration can be an inflection point to consider cloud migration, as it can provide almost immediate benefits in the form of cost reductions, better performance, and simpler management.
- Moving datacenter operations to the cloud frees you from recurring contract expenses, and provides built-in scalability and other key
management features that make it much easier to run your datacenter efficiently.

### Cash flow challenges and resource constraints

One of the most impactful incentives of the cloud and adopting a more flexible operating model is the opportunity to eliminate large upfront investments in physical infrastructure assets. Identifying areas to optimize costs and free up resources for growth and innovation is critical to establishing your business case for migrating to the cloud. Companies often struggle to meet their growth needs or can't provide the resources requested by IT teams. The cloud changes this with an almost infinite scale of the Azure datacenters.

#### Shift from CAPEX to OPEX

Maintaining a physical datacenter can cause serious cash flow challenges with investments reserved for infrastructure. Moving to the cloud helps you shift from capital expenses (CAPEX) to an operational expenditures (OPEX) model since you no longer pay for physical datacenter costs or the associated hardware and software. Instead, you only pay for the resources you use on the cloud, and you can scale up or down as needed, providing more cash flow flexibility across an organization.

:::image type="content" source="../media/capex-to-opex.png" alt-text="Diagram showing the shift from CAPEX to OPEX.":::

### Business continuity

Moving to the cloud can help ensure security and resilience for business-critical workloads, as having day-to-day operations interrupted by issues like network connectivity and data loss can result in productivity losses and increased risk of losing critical data.

> [!IMPORTANT]
> Customers see a 66% reduction in recovery time on average for data hosted in Azure.

#### Resilient apps and operations

- By moving core business applications to the cloud, you can minimize the number of disruptions and more easily maintain operations, which
are often among the top concerns for organizations.
- By taking advantage of native disaster recovery and high availability services, you can ensure that applications are not only resilient, but can also scale up or down to meet performance demands.
- Azure provides options for replicating key workloads across different regions, so their uptime is maximized, and built-in recovery options so the risk of losing important apps or data is severely reduced, if not eliminated entirely.

Azure was designed for business continuity and disaster recovery with solutions built into the regions (datacenters) and many of services including:

- [Azure paired regions](/azure/best-practices-availability-paired-regions?azure-portal=true)
- [Azure Storage](/azure/storage/common/storage-redundancy?azure-portal=true) redundancy and replication
- [Azure Site Recovery](https://azure.microsoft.com/products/site-recovery/) for virtual machine replication and failover
- [Azure Backup](https://azure.microsoft.com/products/backup) for data protection and recovery

:::image type="content" source="../media/azure-site-recovery.png" alt-text="Diagram showing an Azure Site Recovery deployment to two regions.":::

### Cybersecurity threats

The growing evolution of cybersecurity threats, increased need to protect people and resources wherever they're located, and difficulty finding security talent has many security teams feeling overwhelmed. The cloud provides a suite of comprehensive security options that can address many of their challenges.

#### Suite of cloud security solutions

- Traditional IT solutions are incapable of keeping up with the evolving threat landscape of advanced cyber attacks, and many businesses feel more vulnerable. The cloud offers built-in security solutions, which provide comprehensive protection against advanced threats.
- Azure is secured with a various physical, infrastructure, and operational controls that allow organizations to take actions that ensure their applications and data are protected, backed up, and compliant.
  - [Azure Backup](https://azure.microsoft.com/products/backup) protects your environment from ransomware attacks and recovers maliciously or accidentally deleted backup data.
  - [Microsoft Defender for Cloud](https://azure.microsoft.com/products/defender-for-cloud) provides unified infrastructure security management to protect your resources.
  - [Microsoft Sentinel](https://azure.microsoft.com/products/microsoft-sentinel) provides intelligent security analytics across your entire enterprise.

## Modernization triggers

Modernization triggers are business-oriented and focus on future development or investment in the application. If you're going to continue investment into an application by modernizing for the cloud, new features and capabilities can be created to enable business growth or improve a customer experience.

These triggers include:

- Scaling web apps and infrastructure
- Focus on innovation
- Faster time to market
- Cost-optimizing applications
- Focus on innovation

### Scale web apps and infrastructure

The ability to meet surges in demand is one of the key priorities for businesses. However, many organizations lack the confidence or technical capacity to keep up with fluctuating demands. 

Azure allows you to scale for urgent capacity needs. When you plan for peak usage through on-premises systems, your servers are typically under-utilized, as you need more capacity than average to accommodate spikes when they occur. The cloud releases you from this model, enabling a scale-when-you-need-it approach. Moving to the cloud increases your agility with an infrastructure that scales to your business needs.

#### Built-in autoscaling

Industries such as healthcare, insurance, and banking are experiencing considerable growth, but many organizations within these verticals find it difficult to keep pace with significant surges in demand.

By moving to managed services in the cloud, organizations can modernize their business-critical applications and take advantage of managed services such as [Azure App Service](https://azure.microsoft.com/services/app-service/?azure-portal=true) and [Azure SQL Managed Instances](https://azure.microsoft.com/services/azure-sql/sql-managed-instance/?azure-portal=true) to reduce operational tasks and focus scarce resources on higher value work.

### Application innovation

The cloud presents new opportunities for innovation:

- Moving to the cloud can help to significantly reduce or eliminate operational responsibilities. For this reason, you can focus on innovating your products and offering new capabilities for customers.
- Azure provides a full set of AI services and capabilities to help you better understand and anticipate user needs. You can use these capabilities to infuse your apps, websites, and bots with intelligent algorithms. You can also gain instant and continuous insights that can help inform your decisions by taking advantage of cloud-native analytics services.
- With cloud-native applications, you can develop and deploy quickly, test safely, and iterate rapidly.
- You can gain time and resources by letting Microsoft take care of patching operating systems, upgrading operating system, and monitoring for vulnerabilities while you focus on innovation and performing tasks that can bring value to your business.

### Faster time to market

Application modernization can help you develop and bring applications to market much faster. By using Azure, developers aren't constrained by the lead time to procure and build on-premises systems and databases. These extended lead times for infrastructure slowed down your development efforts in the past. 

- You can stand up Azure App Service in a matter of minutes to start developing a website. Previously you might have had to create a new server, patch the servers, install Internet Information Services (IIS), and make any necessary configuration changes. Now you can start developing your application immediately rather than waiting for days to start.
- Modernizing applications using serverless in Azure once again provides the ability to bring solutions and updates to the market with even less infrastructure. Leveraging services like Azure Kubernetes Services, Azure Functions, Azure Logic Apps, Azure Cognitive Services, developers have many options for building applications. 
- Azure supports the use of DevOps tools, including GitHub, to build and deploy modern applications. Using GitHub actions, you build and release applications and updates faster to get ahead of the competition and keep your customers happy.

### Cost-optimizing applications

Modernizing your applications changes the cost structure of your applications. In traditional development, the infrastructure that services the application must be purchased and scaled for the busiest day possible for that application. With modernized cloud applications, Azure scales the infrastructure to meet the demand. Tailwind Traders only has to pay for the services consumed, thus optimizing the costs associated with delivering the service to customers.

Modernizing leads to cost savings on an application-by-application basis. Pay only for the resources that you need when you need them.
