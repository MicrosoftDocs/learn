Successful cloud adoption requires more than technical readiness. It requires a cloud adoption plan that converts your cloud strategy into actionable steps specific to your goals.

## Prepare your organization for the cloud

Organizations must align their structure and processes with cloud adoption goals to effectively deploy, manage, and optimize cloud resources while meeting business objectives.

1. **Map your cloud adoption journey based on your organization type.** Startups should build cloud-native solutions using CAF Plan, Ready, and Cloud-native development phases. Enterprises should evaluate their IT estate and follow the complete CAF Plan process plus Ready, Migrate, and Modernize phases.

2. **Choose the management model that fits your organizational structure.** Small organizations should select centralized operations for consistent policy enforcement. Mid-size enterprises should implement shared management where platform teams manage landing zones while workload teams operate autonomously. Organizations with skilled teams should adopt decentralized operations for full ownership.

3. **Plan cloud responsibilities across governance, security, and management functions.** Establish governance teams to assess risks and define policies. Embed security into every stage of the cloud lifecycle. Define operational processes that align with business goals. Develop your AI strategy and build appropriate teams for AI adoption.

4. **Document cloud responsibilities with clear ownership assignments.** Map responsibilities across governance, security, and operations with specific ownership. Define partner roles and communicate responsibilities to all stakeholders. Review responsibilities regularly as your environment evolves.

## Prepare your people for the cloud

Teams require specific skills to successfully adopt and operate cloud services, reducing implementation risks and accelerating time to value.

1. **Assess required skills for Azure adoption.** Teams need governance, security, identity, networking, and management fundamentals. Azure environment managers require RAMP model skills (Ready, Administer, Monitor, Protect). Cloud-native development teams need platform engineering, containerization, microservices, and AI development capabilities.

2. **Close the skills gap through structured training and expert support.** Train teams using Microsoft Learn, personalized training, and credentials like Microsoft Applied Skills and certifications. Use Microsoft specialists or trusted partners for workshops, architectural reviews, and hands-on guidance.

3. **Sustain cloud skills through continuous learning programs.** Create learning sandboxes using Azure Dev/Test subscriptions. Dedicate weekly time for Microsoft Learn modules, create recognition systems, participate in Azure community events, and maintain curated resource collections.

Startups skip to [Estimate total cost of ownership](#estimate-total-cost-of-ownership). If you have existing workloads, you need to discovery your existing inventory.

## Discover existing workload inventory

Organizations must understand their current application portfolio before planning cloud adoption to provide the foundation for migration planning and business case development.

1. **Discover workload inventory through systematic documentation.** Define workload boundaries and use automated tools like Azure Migrate for discovery. Include all components across environments and document assets manually when automation cannot access specific systems.

2. **Prioritize workloads based on business value and migration feasibility.** Evaluate workloads using business criticality, cloud readiness, dependencies, and strategic alignment. Create a prioritized migration backlog that balances business value with technical feasibility.

3. **Gather business details for each workload to guide migration decisions.** Document ownership, business function, criticality, data sensitivity, compliance requirements, operational constraints, and timelines. Use this information to guide migration strategies and ensure business alignment.

## Select migration strategies

Migration strategy selection determines the approach, timeline, and resources required for each workload and must align with business drivers and technical constraints.

1. **Identify your business drivers to establish migration priorities.** Define high-level business goals, perform gap analysis between current and desired states, and determine the specific business driver creating urgency for change.

2. **Match business drivers to appropriate migration strategies.** Select strategies based on business drivers: Retire for redundant workloads, Rehost for minimal disruption, Replatform for PaaS adoption, Refactor for code optimization, Rearchitect for cloud-native capabilities, Replace for SaaS alternatives, Rebuild for complete redevelopment, or Retain for stable workloads.

3. **Apply strategy-specific selection criteria to validate decisions.** Validate chosen strategies against workload stability, Azure compatibility, team skills, modernization timeline, technical debt levels, architectural limitations, and operational requirements.

4. **Make modernization timing decisions based on resource availability.** Evaluate whether to modernize during migration based on team skills, available time, compatibility requirements, and funding opportunities.

5. **Execute stakeholder communication plan to ensure alignment.** Define success metrics, document decisions for stakeholders, coordinate with cloud strategy teams, and create review cycles to update strategies as requirements evolve.

## Assess your workloads for cloud migration

Workload assessment identifies technical requirements, dependencies, and risks for successful cloud migration, informing architecture decisions and migration planning.

1. **Assess workload architecture to understand system structure and dependencies.** Use assessment tools like Azure Migrate to automate discovery. Validate findings with subject matter experts and document architecture diagrams and component lists.

2. **Assess application code to identify compatibility and modernization opportunities.** Use automated tools like AppCAT for .NET and Java applications. Validate framework and SDK compatibility with Azure. Avoid unnecessary framework changes unless strong business justification exists.

3. **Assess databases to understand data architecture and migration requirements.** Identify all databases including engine types and versions. Map inbound and outbound dependencies across applications and services. Determine whether to migrate databases as shared instances or split them by workload.

4. **Create and maintain a risk register to track and mitigate migration risks.** Establish a comprehensive risk register documenting technical, operational, and organizational risks. Define mitigation strategies with responsible parties and resolution timelines.

## Estimate total cost of ownership

Cost estimation provides the financial foundation for cloud adoption decisions and budget planning, enabling informed investment decisions and ongoing cost optimization.

1. **Plan your Azure architecture based on business and technical requirements.** Align architecture with business and technical requirements by documenting constraints and compliance needs. Plan your Azure landing zone architecture and workload architecture by identifying required Azure services, regions, and configurations.

2. **Estimate costs based on planned architecture and usage patterns.** Use the Azure Pricing Calculator to model architecture costs based on historical or projected usage data. Estimate operational costs including skills training and process changes. Reevaluate estimates when projections deviate from budget by identifying high-cost elements and adjusting architecture. Validate assumptions through test deployments and establish a cost baseline.

For the detailed Cloud Adoption Framework guidance, see [Plan cloud adoption](/azure/cloud-adoption-framework/plan/prepare-organization-for-cloud).
