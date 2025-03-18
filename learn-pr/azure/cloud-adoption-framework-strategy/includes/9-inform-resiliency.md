[Resiliency](/azure/cloud-adoption-framework/strategy/inform/resiliency) is the ability of your infrastructure to maintain functionality and availability despite disruptions or failures. If a system supports a key process or is critical to your business operations, downtime can lead to significant financial losses, resource drain, or even a complete halt to your business activities. Not all systems require the same level of resiliency. Focus resiliency investments where they matter most.

Resiliency helps provide the following benefits:

- Maintains business continuity, meets regulatory requirements, and enhances customer trust

- Ensures operational continuity during disruptions, such as hardware failures or datacenter losses
- Supports agile service deployment so that you can quickly adjust to market demands while maintaining security and compliance
- Improves resource allocation, operational efficiency, and risk management
- Drives quality and innovation
- Supports long-term business objectives

## Understand the shared responsibility model

Resiliency is a joint responsibility between a cloud provider and its customers. The shared responsibility model defines the division of responsibilities and establishes boundaries for what the provider and customer manage.

Incorporate the shared responsibility model into your strategy to proactively address potential risks, ensure proper governance, and build a robust cloud environment that aligns with organizational goals and regulatory requirements.

For Azure, Microsoft manages the reliability of the cloud platform, while customers and partners manage the reliability of their cloud applications and infrastructure deployments.

:::image type="content" source="../media/shared-responsibility-resiliency.png" lightbox="../media/shared-responsibility-resiliency.png" alt-text="Chart that shows the division of responsibility for the shared responsibility model." border="false":::

#### Recommendations

- **Perform a business impact analysis.** Define the criticality of systems to prioritize recovery efforts. Repeat this analysis throughout cloud adoption.

- **Perform a risk assessment.** Identify threats and vulnerabilities to build mitigation strategies and inform resiliency plans.
- **Complete a cost-benefit analysis.** Align cloud investments with business continuity requirements and service-level agreements.
- **Understand business continuity, high availability, and disaster recovery.** Integrate these concepts into your cloud strategy to manage downtime and data loss. For more information, see [Business continuity, high availability, and disaster recovery](/azure/reliability/concept-business-continuity-high-availability-disaster-recovery).
- **Understand shared responsibility.** Include the shared responsibility model in your strategy to address reliability. For more information, see [Shared responsibility for reliability](/azure/reliability/concept-shared-responsibility).
- **Understand Azure reliability.** Use [Azure reliability documentation](/azure/reliability/overview) to learn about reliability and resiliency in Azure.
- **Understand Azure service reliability.** Review [reliability considerations for Azure services](/azure/reliability/overview-reliability-guidance) to inform your strategy.
- **Define realistic reliability targets.** Set and communicate reliability expectations with stakeholders and customers. For more information, see [Recommendations for defining reliability targets](/azure/well-architected/reliability/metrics).





