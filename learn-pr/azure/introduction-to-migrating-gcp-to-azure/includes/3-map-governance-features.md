Complex systems such as cloud computing platforms give users powerful functionality and a broad range of features. Meanwhile many jurisdictions have been implementing data protection legislation that you must comply with when you handle customer data. To ensure that you operate legally and securely, you must take control of your users' actions. Including, the data that they store and manipulate. This control is known as governance.

In your global cycling manufacturer, you have a set of policies for the governance of information that enforce your company policies and relevant legislation in your Google Cloud systems. The competitor you recently merged with has different policies implemented in their Azure subscriptions. You need to understand the Azure settings and review them to ensure continued compliance.

In this unit, you examine governance tools in Azure and compare them to Google Cloud.

:::image type="content" source="../media/governance-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Google Cloud." border="false":::

## Comparing governance in Azure and Google Cloud

Governance includes the Identity and Access Management (IAM) that you saw in the previous module. However it also includes compliance, resource allocation, security, and cost management to ensure that your cloud usage aligns with organizational goals and regulatory requirements. Effective governance promotes transparency, accountability, and risk management, and enables companies to use cloud services while they maintain control over data integrity, security, and resource utilization.

But Azure and Google Cloud have governance tools with analogous features. Let's investigate and compare them.

## Deploying Resources

A complete custom system deployed on a cloud service often consists of multiple resources of different types. For example, to implement a web app, you might need to deploy an HTML server, a database, several containers, and other components. Both Google Cloud and Azure have declarative deployment tools that you can use to ease the management of multiple resources and associate them into a single group of resources.

In Google Cloud, this functionality is in Deployment Manager. You write configuration YAML files and Jinja template files to define a set of resources. Terraform is another popular tool used in Google Cloud Platform (GCP) for infrastructure as code.

In Azure, you can use Azure Resource Manager (ARM) to complete the same task. ARM templates are written in JSON format. You can alternatively choose to write Bicep files - Bicep is a domain specific language with a user-friendly syntax. For a cloud agnostic approach, Terraform is a great option as well.

> [!NOTE]
> At the time of writing, Azure Blueprints define a repeatable set of Azure resources that implement and adhere to an organization's standards, patterns, and requirements. However, Blueprints are to be deprecated in July 2026. Consider using ARM templates or Bicep files instead.

## Using policy

In Google Cloud, you use policies in IAM to apply permissions to roles. In Azure policies, you not only enforce IAM but also enforce specific rules and regulations across cloud resources. They allow administrators to define and apply rules to ensure compliance with organizational standards and regulatory requirements. Policies are defined in JSON format and can be applied to various scopes, such as subscriptions or resource groups.

## Managing subscriptions

In Azure, many companies have a single subscription to contain all their resources. However, it's also possible to associate multiple subscriptions into a single object called a management group and then use it to assign permissions and complete other governance tasks. For example, Azure policies can be applied to all the subscriptions in a management group.

## Managing costs

With limited budgets and tight margins, it's critical to ensure that you're getting the best value from your cloud services. Microsoft provides the [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) and [Billing](/azure/cost-management-billing/cost-management-billing-overview) tools to enable you to monitor and control Azure spending and optimize your resource use. They provide detailed insights into your costs and usage and help you to get the best value from your Azure investment.

## Security

[Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) is a Cloud-Native Application Protection Platform (CNAPP) designed to prevent diverse cyber attacks and close well-known vulnerabilities. It offers unified security management and advanced threat protection across hybrid cloud workloads.

## Monitoring activity

In governance, it's vital to investigate what users and services are doing, and restrict their actions ahead of time. By monitoring your resources and users, you can spot when permissions, roles, and policies might be incomplete or inappropriate.

Azure Monitor provides this functionality. In Google Cloud, the Operation Suite has similar tools.

## Learn more

- [What is Azure Resource Manager?](/azure/azure-resource-manager/management/overview)
- [What is Azure Blueprints?](/azure/governance/blueprints/overview)
- [What is Azure Policy?](/azure/governance/policy/overview)
- [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction)
- [Azure Monitor overview](/azure/azure-monitor/overview)
