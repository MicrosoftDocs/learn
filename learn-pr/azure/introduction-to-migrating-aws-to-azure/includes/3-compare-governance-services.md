Your organization has many users engaged in producing, gathering, manipulating, and transferring information across various data stores. It's crucial to ensure these activities safeguard your customers' interests, comply with all relevant laws, and remain cost-effective.

In your global clothing retailer, you use AWS Config, CloudFormation, Cost Explorer, and other tools to create strict governance that implements high-quality data usage in your company. With the aquisition of your competitor, you now have complex systems in Azure with their own governance implemented. To ensure consistent implementation of your company's policies, you need to understand how governance is set up in Azure and alter policies to match your AWS behavior.

In this unit, you'll compare the tools available in AWS and Azure for data governance.

:::image type="content" source="../media/governance-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Amazon AWS.":::

## Comparing governance in Azure and AWS

Governance describes the tools you use to implement control of data and resource usage. You implement governance to comply both with your company's information usage policies and with legislation in all the jurisdictions in which you operate.

If you're familiar with governance from AWS, you’ll find that Azure offers a range of governance features that are similar. There are, however, differences that you should be aware of. Let's examine and compare analogous tools:

## Policy management

[Azure Policy](/azure/governance/policy/overview) enables you to create, assign, and manage policies to enforce rules and effects over your resources. Policies help you to ensure compliance with corporate standards and service level agreements. For example, you can create an Azure Policy assignment that prevents Storage Accounts from being publicly accessible.

Similar configurations can be achieved in AWS with AWS Config.

## Management of resources

[Azure Resource Manager (ARM)](/azure/azure-resource-manager/management/overview) is a management layer that enables you to create, update, and delete resources in your Azure subscription. You can use ARM templates to deploy resources in a consistent and repeatable manner. For example, you could create an ARM template that deploys three containers and a Azure SQL Database to host an Internet site.

This functionality is comparable to AWS CloudFormation.

## Cost control

[Azure Cost Management](/azure/cost-management-billing/costs/overview-cost-management) and [Billing](/azure/cost-management-billing/cost-management-billing-overview) are tools that enable you to monitor and control Azure spending and optimize your resource use. They provide detailed insights into your costs and usage and help you to get the best value from your Azure investment.

In AWS, Cost Explorer presents analogous information for similar purposes.

## Security and protection

[Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) is a Cloud-Native Application Protection Platform (CNAPP) designed to prevent diverse cyber attacks and close well-known vulnerabilities. If offers unified security management and advanced threat protection across hybrid cloud workloads.

AWS Security Hub provides similar protection.

## Observability

You can use [Azure Monitor](/azure/azure-monitor/overview) to maximize the availability and performance of your applications and services. It collects, analyzes, and summarizes telemetry from your cloud and on-premises environments. You can use its reports to audit the behavior of your users and applications and diagnose security breaches such as inappropriately controlled sensitive data.

Additionally, Azure offers [Prometheus](/azure/azure-monitor/essentials/prometheus-metrics-overview) and [Azure Managed Grafana](/azure/managed-grafana/overview) solutions for those with existing investments in those services.

In AWS, CloudWatch collects and displays similar data.

## Best practice advice

Use [Azure Advisor](/azure/advisor/advisor-overview) to view personalized best practice recommendations that can optimize your Azure deployments, improve performance, security, and raise availability.

AWS Trusted Advisor is the equivalent tool.

## Learn more

* [Microsoft Azure Fundamentals: Describe Azure management and governance](/training/paths/describe-azure-management-governance/)
* [Governance, security, and compliance in Azure](/azure/cloud-adoption-framework/ready/azure-setup-guide/govern-org-compliance)
* [Describe features and tools for managing and deploying Azure resources](/training/modules/describe-features-tools-manage-deploy-azure-resources)
* [Describe features and tools in Azure for governance and compliance](/training/modules/describe-features-tools-azure-for-governance-compliance/)
* [Design governance](/training/modules/design-governance/)
* [Introduction to Azure Policy](/training/modules/intro-to-azure-policy/)
* [Describe monitoring tools in Azure](/training/modules/describe-monitoring-tools-azure/)
