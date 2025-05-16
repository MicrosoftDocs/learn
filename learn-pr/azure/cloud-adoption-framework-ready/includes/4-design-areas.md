Before you deploy an Azure landing zone, it's important to understand what you'll need from your cloud environment to support your chosen operating model. 

## Design areas

Each implementation option for Azure landing zones provides a deployment approach and defined design principles. Before you choose an implementation option, you should carefully consider each design area. Your decisions affect the platform foundation on which each landing zone depends.

| Design area                                                                                                                           | Objective                                                                                                                                                                   | Relevant methodology |
|---------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| [Azure billing and Active Directory tenant](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant)   | Proper tenant creation, enrollment, and billing setup are important early steps.                                                                                            | Ready                |
| [Identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access)                      | Identity and access management is a primary security boundary in the public cloud. It's the foundation for any secure and fully compliant architecture.                     | Ready                |
| [Network topology and connectivity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) | Networking and connectivity decisions are an important foundational aspect of any cloud architecture.                                                               | Ready                |
| [Resource organization](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)                                  | As cloud adoption scales, considerations for subscription design and management group hierarchy affect governance, operations management, and adoption patterns. | Govern               |

### Compliance design areas

Security, governance, and compliance are key topics when you're designing and building an Azure environment. These topics help you start from strong foundations and ensure that solid ongoing processes and controls are in place.

The tools and processes that you implement for managing environments play an important role in detecting and responding to issues. These tools work alongside the controls that help maintain and demonstrate compliance.

As the organization's cloud environment develops, these compliance design areas will be the focus for iterative refinement. This refinement might be due to new applications that introduce specific new requirements or to changing business requirements. For example, refinement might be in response to a new compliance standard.

| Design area                                                                                                                 | Objective                                                                                                                                                          | Relevant methodology |
|-----------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| [Security](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security)                                         | Implement controls and processes to help protect your cloud environments.                                                                                               | Secure               |
| [Management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management)                                     | For stable, ongoing operations in the cloud, develop a management baseline to provide visibility and operations compliance, and to help protect and recover capabilities. | Manage               |
| [Governance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance)                                     | Automate auditing and enforcement of governance policies.                                                                                                          | Govern               |
| [Platform automation and DevOps](/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops) | Align the best tools and templates to deploy your landing zones and supporting resources.                                                                          | Ready                |

> [!NOTE]
> Tailwind Traders has chosen to focus only on the environmental design areas at this time. It will address compliance design areas in a future effort. Again, this is not the recommended path for most customers because it will require more effort later in the process.

## Process for design areas
The design areas describe what to consider before you deploy a landing zone. Together, they establish a process to aid in exploring otherwise complex topics. These topics are typically involved in making critical decisions about your environment. Evaluate each design area to help you understand any changes that you might need to make to the implementation options for Azure landing zones.

Evaluating each design area sequentially provides a process that simplifies the design of any complex environment. If you've already addressed one or more of the design areas to your satisfaction, move on to the next area.

In this process, you'll get a list of roles or functions that are typically required to make design decisions. You'll also see a series of considerations, recommendations, and scope boundaries to help shape the discussion and decision-making process.

You can implement these design areas over time so that you can grow into your cloud operating model. Review the methodologies related to each design area to understand in more detail the considerations and decisions involved with implementing a landing zone. These considerations include guidance to help align your journey to the conceptual architecture of Azure landing zones.

With an understanding of the modular design areas, your next step is to choose a landing zone implementation that best aligns with your cloud adoption plan and requirements.
