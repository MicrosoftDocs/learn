Complex systems such as cloud computing platforms give users powerful functionality and a broad range of features. Meanwhile, many jurisdictions implement data protection legislation that you must comply with when you handle customer data. To ensure that you operate legally and securely, you must take control of your users' actions--including the data that they store and manipulate. This control is called *governance*.

Governance includes the identity and access management (IAM) that the previous unit described. But it also includes compliance, resource allocation, security, and cost management to ensure that your cloud usage aligns with organizational goals and regulatory requirements. Effective governance promotes transparency, accountability, and risk management. It enables companies to use cloud services while they maintain control over data integrity, security, and resource utilization.

In your role at the global cycling retailer, you have a set of policies for the governance of information. These policies enforce your company's requirements and relevant legislation in your Google Cloud systems. The competitor that your company recently merged with has different policies implemented in its Azure subscriptions. You need to understand the Azure settings and review them to ensure continued compliance.

In this unit, you examine governance tools in Azure and compare them to Google Cloud.

:::image type="content" source="../media/governance-overview.png" alt-text="Diagram that shows the types of services provided by Microsoft Azure and Google Cloud, with governance highlighted." border="false":::

## Resource deployment

A complete custom system deployed on a cloud service often consists of various types of resources. For example, to implement a web app, you might need to deploy an HTML server, a database, several containers, and other components. Both Google Cloud and Azure have declarative deployment tools that you can use to ease the management of multiple resources and associate them into a single group of resources.

In Google Cloud, this functionality is in Deployment Manager. You write configuration YAML files and Jinja template files to define a set of resources. Terraform is another popular tool used in Google Cloud Platform (GCP) for infrastructure as code.

In Azure, you can use Azure Resource Manager templates (ARM templates) to complete the same task. ARM templates are written in JSON format. You can alternatively choose to write Bicep files. Bicep is a domain-specific language with a user-friendly syntax. For a cloud-agnostic approach, Terraform is also a great option.

> [!NOTE]
> In Azure Blueprints, blueprints define a repeatable set of Azure resources that implement and adhere to an organization's standards, patterns, and requirements. However, Azure Blueprints is scheduled to be deprecated in July 2026. Consider using ARM templates or Bicep files instead.

## Policies

In Google Cloud, you use policies in IAM to apply permissions to roles. In Azure policies, you not only enforce IAM but also enforce specific rules and regulations across cloud resources.

Policies enable administrators to define and apply rules to help ensure compliance with organizational standards and regulatory requirements. Policies are defined in JSON format and can be applied to various scopes, such as subscriptions or resource groups.

## Subscription management

In Azure, many companies have a single subscription to contain all their resources. But it's also possible to associate multiple subscriptions into a single object called a *management group*. Companies can use a management group to assign permissions and complete other governance tasks. For example, a company can apply Azure policies to all the subscriptions in a management group.

## Cost management

With limited budgets and tight margins, it's critical to ensure that you're getting the best value from your cloud services. You can use [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) and [Microsoft Billing](/azure/cost-management-billing/cost-management-billing-overview) to monitor and control Azure spending and optimize your resource use. These services provide detailed insights into your costs and usage to help you get the best value from your Azure investment.

## Security

[Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) is a cloud-native application protection platform (CNAPP) that's designed to prevent diverse cyberattacks and close well-known vulnerabilities. It offers unified security management and advanced threat protection across hybrid cloud workloads.

## Activity monitoring

In governance, it's vital to investigate what users and services are doing, and restrict their actions ahead of time. By monitoring your resources and users, you can spot when permissions, roles, and policies might be incomplete or inappropriate.

Azure Monitor provides this functionality. In Google Cloud, the operations suite has similar tools.

## Learn more

- [What is Azure Resource Manager?](/azure/azure-resource-manager/management/overview)
- [What is Azure Blueprints?](/azure/governance/blueprints/overview)
- [What is Azure Policy?](/azure/governance/policy/overview)
- [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction)
- [Azure Monitor overview](/azure/azure-monitor/overview)
