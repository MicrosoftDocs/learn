In this unit, you review how to determine whether Azure Database for MySQL fits into your application architecture and development process. As developers, focusing on the core application rather than on the intricacies of database management, such as VM characteristics, versioning, and security configurations, can accelerate development cycles. Azure Database for MySQL, a managed service, enables this focus shift by handling the complex database management tasks, thereby aligning developer efforts with productivity and innovation goals.

For scenarios requiring specific MySQL versions not supported by Azure Database for MySQL - Flexible Server or if greater control over the database environment is crucial, MySQL running on Azure VMs provides a valuable alternative. This Infrastructure as a Service (IaaS) solution allows for detailed customization and management of the database, making it suitable for specialized or legacy applications that rely on particular MySQL features.

Let's evaluate these options in detail against key decision criteria, such as administrative effort, cost, and high-availability options, to identify the most suitable choice for your specific needs.

## Decision criteria

To decide between using MySQL on Azure VMs or Azure Database for MySQL, it's essential to understand how each option aligns with your organizational needs in terms of administrative effort, cost, and high-availability options. A detailed comparison to help guide your decision appears in the following table:

| Criteria | Azure Database for MySQL | MySQL on Azure VMs |
| --- | --- | --- |
| Administrative effort | Requires minimal administrative effort as it is a fully managed service. Azure handles all maintenance, updates, and backups, freeing up developers to focus on application development rather than database management. Despite being fully managed, you still have flexibility and control over database management functions, configuration settings, and scheduled maintenance windows. | Requires considerable administrative effort as it involves managing the VM, OS, and the database engine. This includes tasks like system updates, security patches, and backups, providing complete control and customization but also increasing responsibility. |
| Cost | Offers a range of pricing tiers suitable for different needs, from lightweight applications to enterprise-grade solutions. Costs vary based on the chosen tier, and resources are billed on an as-used basis, potentially offering cost savings through managed services. Azure Database for MySQL offers a free trial with an Azure free account. It also offers cost control features such as the ability to stop the server when not in use and autoscaling of IOPS. | Typically involves the cost of VMs, storage, and additional overhead for maintaining the infrastructure. Additionally, implementing features like high availability (HA), backups, and other management tasks incurs extra costs, unlike Azure Database for MySQL, where these features are built-in. |
| High-availability options | Provides built-in high-availability solutions, including zone-redundant deployments without additional configuration. This simplifies achieving high availability as it is managed by Azure, ensuring that the database is resilient to failures with minimal downtime. | High availability must be manually configured and maintained, involving setting up failover mechanisms and potentially additional Azure services. This provides flexibility and customization at the cost of increased complexity and potential setup and maintenance challenges. |

## Comparative insights

### Administrative effort

- **Control vs. convenience**: MySQL on Azure VMs is suited for organizations that require deep control over their database environment for compliance, legacy compatibility, or specific performance tuning. This model is preferable where customization and direct administrative control are prioritized over operational convenience.
- **Reduced administrative burden**: Azure Database for MySQL offers a managed environment where Azure handles the operational burden of maintaining physical servers, operating systems, and basic database management tasks, which can significantly reduce administrative time and resources, allowing teams to concentrate on strategic tasks that add more value to the business.
- **Flexibility and scalability**: Both models provide scalability options, though the mechanisms differ. Azure VMs offer the flexibility to scale and adjust resources manually as needed, while Azure Database for MySQL provides easy scalability options that are managed through the Azure portal, reducing the complexity involved in resource management. Additionally, Azure Database for MySQL flexible server allows for granular control and flexibility over database management functions and configuration settings, offering a key advantage in fine-tuning performance and behavior.

Choosing between these models depends on your organization's needs, expertise, and priorities. If extensive control and customization are required, MySQL on Azure VMs might be the better choice. Conversely, if ease of management and reduced administrative overhead are more critical, Azure Database for MySQL would be advantageous.

### Cost

Choosing Azure Database for MySQL typically reduces administrative costs and complexity as it eliminates the need for direct management of the database software and the operating system. This managed service model is generally more cost-effective for businesses that do not require the deep customization options that running MySQL on a VM provides.

On the other hand, MySQL on Azure VMs might incur higher costs due to the need for more hands-on management, but it offers greater control over the database and OS, which is beneficial for specialized needs that are not supported by the managed platform.

Both options provide scalability, but a flexible server's ability to dynamically adjust resources and only charge for actual usage can provide cost benefits under variable workload conditions. Understanding these differences will help you choose the best option based on your specific requirements and budget constraints.

### High availability

High availability (HA) ensures that your applications remain accessible with minimal downtime, even during system failures or maintenance events.

Implementing high availability in Azure VMs involves a considerable degree of manual setup. You are responsible for configuring multiple components, such as setting up failover clustering, replication, and load balancing. This approach offers a high level of customization, allowing you to tailor the HA architecture to meet specific requirements. However, it requires a deep understanding of both Azure infrastructure and MySQL, and it typically incurs higher costs due to the complexities of managing additional VMs and networking components needed for a robust HA setup.

On the other hand, Azure Database for MySQL provides built-in high availability with no additional setup or cost. This service automatically handles failover to standby replicas in different availability zones, ensuring your database services remain operational even if one zone goes down. The managed HA solution provided by Azure Database for MySQL significantly reduces administrative overhead, as the replication, failover, and network configurations are all handled by Azure, allowing developers to focus more on application development rather than infrastructure management.

## Summary

The choice between Azure Database for MySQL and MySQL on Azure VMs often comes down to the specific requirements of your applications and organizational preferences regarding control, cost, and administrative overhead. For applications where standard MySQL features are sufficient and ease of management is valued, Azure Database for MySQL is typically the best choice. Conversely, if your application requires specific MySQL configurations or you need to optimize the database environment to an extensive degree, MySQL on Azure VMs might be more suitable.

When making your decision, consider not only the current needs but also the potential scale and evolution of your applications to ensure that your chosen database solution can grow and adapt with your business.

In summary, see the following guidance.

Choose **MySQL on Azure VMs** when you:

- Want to avoid the time and expense of acquiring new on-premises hardware.
- Need specific MySQL versions that are not supported by Flexible Server.
- Require full control and customization of the MySQL engine that the Azure Database doesn't support for MySQL service.

Choose **Azure Database for MySQL** when you:

- Want zone-redundant or same-zone high availability.
- Require maximum control with the ability to select your scheduled maintenance window.
- Need data protection using automatic backups and point-in-time restore for up to 35 days.
- Prefer automated patching and maintenance for underlying hardware, operating system, and database engine to keep the service secure and up to date.
- Require predictable performance with inclusive pay-as-you-go pricing.
- Need elastic scaling within seconds.
- Seek cost optimization with low-cost burstable SKU and the ability to stop/start the server.
- Demand enterprise-grade security, industry-leading compliance, and privacy to protect sensitive data at rest and in motion.
- Want monitoring and automation to simplify management and monitoring for large-scale deployments.
- Require better control and customization over app development.
- Need to implement horizontal scaling with minimal overhead by using read replicas.
- Value an industry-leading support experience.
