Azure landing zones provide cloud adoption teams with a well-managed environment for their workloads. Each of the following options applies a predetermined set of design considerations for landing zones to provide an implementation and architecture to guide your environment configuration.

## Azure landing zone accelerator

The Azure landing zone accelerator is a deployment from the Azure portal that provides a full implementation of a chosen architecture. The Azure landing zone accelerator provides configurations for key components such as management groups, policies. and management functions. For each section of the deployment, the accelerator provides options for modifying the implementation to include or exclude specific capabilities, depending on what the business needs. Using the Azure landing zone accelerator can enable organizations to start with a smaller footprint and add capabilities over time, in line with the methodologies in the Cloud Adoption Framework.

## Customized implementation options

The Azure landing zone accelerator is the recommended starting point for all customers, but it does assume full alignment with the conceptual architecture, adherence to the design principles, and tooling for cloud-native operations. For customers who need to customize their experience with Azure landing zones, the following implementation options may be more appropriate:

- Azure landing zone Terraform modules are a third-party path for multicloud operating models. This path can limit Azure-first operating models. Review the design principles or deploy this solution to your Azure environment.
- Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure that you want to deploy to Azure. You then use that file throughout the development lifecycle to repeatedly deploy your infrastructure. Your resources are deployed in a consistent way.
- Enterprise-scale Azure Resource Manager (ARM) templates can be deployed and customized by infrastructure teams as part of infrastructure-as-code pipelines to deliver the full conceptual architecture.

## Deploying the Azure OpenAI Chat Baseline Landing Zone

You can find instructions on how to deploy the Azure OpenAI Chat Baseline Landing Zone on GitHub at the following address: <https://github.com/Azure-Samples/azure-openai-chat-baseline-landing-zone>. Note: This reference landing zone when fully deployed is likely to cost more than $100 a day, based on the costs of Azure DDoS protection and Azure AI Foundry's managed network firewall. The landing zone's GitHub page also provides tools that you can use to remove the example deployment.
