Azure landing zones provide cloud-adoption teams with a well-managed environment for their workloads. Each of the following implementation options applies a predetermined set of design considerations for landing zones to provide an implementation and architecture to guide your environment configuration.

## Implementation options

As outlined in the customer narrative, Tailwind Traders are looking to start with a smaller implementation footprint, with the intention to iterate on it over time with guidance from the Govern, Manage and Secure methodologies. It’s important to choose an implementation that, wherever possible, keeps you towards even if the business requires this to be delivered in multiple phases.

**Azure Landing Zone Accelerator**: For organizations where this conceptual architecture fits with the operating model and resource structure they plan to use, there's a ready-made deployment experience called the Azure landing zone accelerator.

The accelerator is an Azure-portal-based deployment that will provide a full implementation of the conceptual architecture, along with opinionated configurations for key components such as management groups, policies and management functions.

The Azure Landing Zone Accelerator provides options for each section of the deployment in order to provide a level of modification to the implementation in order to include or exclude specific capabilities, depending on what the business requires. 
This can enable organizations to start with a smaller footprint, and decide to add additional capabilities over time, in line with the Govern, Manage and Secure methodologies in the Cloud Adoption Framework.

The Tailwind team from the customer narrative will use the Azure Landing Zone accelerator to configure their initial environment. In the next unit, we will walk through a step-by-step deployment based on their decisions. The Tailwind deployment doesn’t take full advantage of the operations management or governance components of the accelerator, so that unit will also outline how to deploy with those options.

## Customized Azure Landing Zone implementation options

Alongside the Azure landing zone accelerator, there are two further reference implementations made available that address specific tooling requirements, if needed by the organization:

While the accelerator is the suggested starting point for all customers, it does assume full alignment with the conceptual architecture, adherence to the design principles, & cloud-native operations tooling. For customers who need to customize their Azure landing zone experience, the following implementation options may be a better fit:

**Azure Landing Zone Terraform modules**: A third-party path for multiple-cloud operating models. This path can limit Azure-first operating models. Review the [design principles](/azure/cloud-adoption-framework/ready/landing-zone/terraform-landing-zone#design-decisions?azure-portal=true) or [deploy](/azure/cloud-adoption-framework/ready/landing-zone/terraform-landing-zone#customize-and-deploy-your-first-landing-zone?azure-portal=true) this solution to your Azure environment.

**Bicep**: [Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure you want to deploy to Azure, and then use that file throughout the development lifecycle to repeatedly deploy your infrastructure. Your resources are deployed in a consistent manner. Bicep provides concise syntax, reliable type safety, and support for code reuse. Bicep offers a first-class authoring experience for your infrastructure-as-code solutions in Azure.

**Enterprise-scale Azure Resource Manager (ARM) templates** offer a comprehensive set of customizable templates that can be taken and deployed by infrastructure teams as part of Infrastructure-as-code pipelines to deliver the full conceptual architecture

For more detail, review the [Interactive Guide: Prepare your cloud environments with Cloud Adoption Framework](https://mslabs.cloudguides.com/en-us/guides/Cloud%20Adoption%20Framework).

## Partner implementation options

Configuration of your cloud environment can be one of the biggest enablers for cloud success. It can also be one of the biggest blockers if the configuration is misaligned with how you want to operate workloads in the cloud. If the success of your adoption project is critical and your team isn't sure how to proceed, [consult with a partner](https://www.microsoft.com/azure/partners/adopt?filters=ready&azure-portal=true) about how to move forward.

Many of the top Microsoft partners provide offerings aligned to the Ready methodology of the Cloud Adoption Framework. Those offerings typically include a partner's own customized implementation of an Azure landing zone.

Before you engage a partner, review the guide to evaluating [partner implementation options for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/partner-landing-zone).
