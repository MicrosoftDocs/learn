Azure landing zones provide cloud adoption teams with a well-managed environment for their workloads. Each of the following options applies a predetermined set of design considerations for landing zones to provide an implementation and architecture to guide your environment configuration.

## Basic implementation option

As outlined in the customer narrative, Tailwind Traders wants to start with a smaller implementation footprint. The company will then iterate on the implementation over time, with guidance from the Govern, Manage, and Secure methodologies. 

For organizations where the conceptual architecture fits with the operating model and resource structure that they plan to use, there's a ready-made deployment experience called the *Azure landing zone accelerator*.

The accelerator is a deployment from the Azure portal that provides a full implementation of the conceptual architecture. It also provides opinionated configurations for key components such as management groups, policies. and management functions.

For each section of the deployment, the accelerator provides options for modifying the implementation to include or exclude specific capabilities, depending on what the business needs. This can enable organizations to start with a smaller footprint and add capabilities over time, in line with the methodologies in the Cloud Adoption Framework.

The Tailwind Traders team from the customer narrative will use the Azure landing zone accelerator to configure the initial environment. In the next unit, we'll walk through a step-by-step deployment based on the team's decisions. The Tailwind Traders deployment doesn't take full advantage of the operations management or governance components of the accelerator, so that unit will also outline how to deploy with those options.

## Customized implementation options

Although the accelerator is the suggested starting point for all customers, it does assume full alignment with the conceptual architecture, adherence to the design principles, and tooling for cloud-native operations. For customers who need to customize their experience with Azure landing zones, the following implementation options might be a better fit:

- *Azure landing zone Terraform modules* are a third-party path for multicloud operating models. This path can limit Azure-first operating models. Review the [design principles](/azure/cloud-adoption-framework/ready/landing-zone/terraform-landing-zone#design-decisions?azure-portal=true) or [deploy](/azure/cloud-adoption-framework/ready/landing-zone/terraform-landing-zone#customize-and-deploy-your-first-landing-zone?azure-portal=true) this solution to your Azure environment.

- [Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure that you want to deploy to Azure. You then use that file throughout the development lifecycle to repeatedly deploy your infrastructure. Your resources are deployed in a consistent way. 
 
  Bicep provides concise syntax, reliable type safety, and support for code reuse. Bicep offers an efficient authoring experience for your infrastructure-as-code solutions in Azure.

- *Enterprise-scale Azure Resource Manager (ARM) templates* can be deployed and customized by infrastructure teams as part of infrastructure-as-code pipelines to deliver the full conceptual architecture.

For more detail, see [Interactive guide: Prepare your cloud environments with Cloud Adoption Framework](https://mslabs.cloudguides.com/en-us/guides/Cloud%20Adoption%20Framework).

## Partner implementation options

Configuration of your cloud environment can be one of the biggest enablers for cloud success. It can also be one of the biggest blockers if the configuration is misaligned with how you want to operate workloads in the cloud. If the success of your adoption project is critical and your team isn't sure how to proceed, [consult with a Microsoft partner](https://www.microsoft.com/azure/partners/adopt?filters=ready&azure-portal=true).

Many of the top Microsoft partners provide offerings aligned to the Ready methodology of the Cloud Adoption Framework. Those offerings typically include a partner's own customized implementation of an Azure landing zone.

Before you engage a partner, review the [guide to evaluating partner implementation options for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/partner-landing-zone).
