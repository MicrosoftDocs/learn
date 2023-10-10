In the _Getting Started_ module, we shared the narrative for Tailwind Traders. The central operations team and platform team at Tailwind Traders are experienced at managing the company's existing datacenters. The ongoing project to migrate two of the datacenters to Azure is already exposing a few critical learning curves that the company's current skill sets can't address.

## Important constraints

At this time, the business has placed a high priority on migration and meeting the time constraints to get out of the datacenter. Because of that business priority, the business and IT teams have deprioritized longer-term security and compliance requirements until they can complete development of their core cloud platform.

Because Tailwind Traders is new to the cloud, few members of operations, platform, or IT admin teams are experienced with the cloud. The company wants to slowly move into modern operations, security, and governance, but it still needs a cloud foundation that can scale to meet those needs as they become more important. 

Historically, Tailwind Traders has operated purely from the perspective of central operations. As a result, the workload teams can't interact with production environments. The company doesn't have an easy way of mapping assets (virtual machines, data, and apps) to defined workloads, so the boundaries of each workload can be unclear at times.

## Alignment to Azure landing zones

The operations and platform teams have agreed to the following alignment:

- The conceptual architecture of Azure landing zones will serve as the long-term vision for the future state of the cloud environment. All affected teams will use that architecture as a basis for building cloud skills and configuring their cloud environment.
- The teams will use the Azure landing zone accelerator to get started with their environmental configuration.
- If the teams need to customize their environment in the future, they'll use one of the custom implementation options that align to or extend the initial accelerator-based deployment.

## Deviation from standard Azure landing zone guidance

The following list outlines how constraints have caused Tailwind Traders to deviate from the design principles for Azure landing zones, along with the impact of each decision:

- **Policy-driven governance**: Tailwind Traders hasn't historically automated its corporate policies. Because of the pressure to migrate the datacenter quickly, the company chose to minimize the amount of governance—including in its initial deployment of a landing zone. 

  The company has also committed to completing the [Learn module about the Govern methodology of the Cloud Adoption Framework](/azure/cloud-adoption-framework/govern/) after it configures the initial environment. Limitations in IT staff dedicated to the cloud migration are a big driver for this deviation. This deviation is further enforced by business and IT resistance to full cloud governance or "Azure Ops."
- **Subscription democratization**: The central operations team will maintain accountability for production operations for all workloads. That team will seldom allow a workload team to have access to a production environment, so it isn't following the design principle of subscription democratization. 

  If a workload team requires a deviation, the central operations team will consider a dedicated landing zone for individual workloads on a case-by-case basis. Otherwise, Tailwind Traders is firmly committed to maintaining central operations and will have limited instances of workloads in isolated production environments (or application landing zones).
- **Application-centric service model**: Outage-related processes might consider workloads, especially for assets that support mission-critical workloads. However, aside from outages, the central operations team doesn't differentiate between workloads and applications for operations management processes. The team's primary processes operate, manage, make changes, and optimize all resources the same way, regardless of the workload boundaries or architecture. Given the time constraints for this migration, it's not feasible for Tailwind Traders to define app boundaries and establish an app-centric service model.

Many of the terms in the preceding list will be explained in later units of this Learn module. Several of them are reflected in notes to create teaching opportunities.

These deviations don't take away from the alignment agreement. However, these deviations will affect some options in deploying the Azure landing zone accelerator. These deviations will also affect the design for individual application landing zones, which are deployed after you start to migrate assets to the cloud.

These deviations will also require the Tailwind Traders teams to complete Learn modules about management, security, and governance in the Cloud Adoption Framework after the initial environment is deployed.

## Additional constraints

The following additional constraints might affect Tailwind's decisions.

### Operations

The central operations team has organically built a set of processes and controls to manage the overall portfolio. The team depends on System Center Operations Manager and Microsoft Configuration Manager for its operations baseline.

The team has also integrated best-of-breed tools for virtual machine management, incident and configuration management tracking, network monitoring, security operations, and governance controls, among other tools. Most of these tools have built-in integration with Azure, which influenced the decision to use Azure as the company's primary cloud provider. Operating these tools requires significant people power and capital.

#### Operations tools

Licensing for the operations management tooling (including hypervisors) consumes more than 20 percent of IT's budget for hard costs. The new chief information officer (CIO) has challenged the team to reevaluate those tools and processes to find cloud-first or unified operations alternatives. The CIO will watch for reduction of tooling expenses as an early indicator of success in this migration.

#### Operations processes

The IT manager has requested two new hires to support the central operations team. They'll help balance the load on the overstressed team. In particular, they'll support business continuity and disaster recovery (BCDR) practices and patch compliance processes.

The business isn't ready for a full-scale move to cloud-native operations, especially for mission-critical applications. The CIO believes that some investment in cloud-native operations tools would help reduce strain on the central operations team by shifting some of those responsibilities to the cloud provider.

The CIO will watch for operational shifts to improve employee satisfaction and reduce load across the central operations team. The CIO will also request frequent updates on how the adoption plan affects BCDR and patching efforts.

#### Service-level agreement

In spite of all the hard work and costs associated with operations, the team periodically fails to meet the service-level agreement (SLA) of 90 percent uptime for mission-critical systems in the primary datacenter. This is a costly concern for the CIO and the chief executive officer (CEO). Outdated hardware and an overdue refresh cycle in the datacenter have resulted in frequent but brief outages.

Although the company has grudgingly accepted this SLA, the new CIO is not impressed. Regardless of the financial savings, the CIO expects the central operations team to deliver a much higher SLA after the migration.

### Retail innovation

The customer narrative from the _Getting Started_ module introduced you to the retail innovation team within Tailwind Traders. That team was originally a startup that Tailwind Traders acquired. The startup's original CEO is now Tailwind's chief technology officer (CTO). The CTO still runs that division like a startup, by prioritizing experimentation and innovation.

The current processes for operations management require that all new innovations from that team go through a release process. The central operations team within IT reviews the architecture for security, governance, and operations management concerns. After the team is comfortable with the solution, it releases the solution into a centrally managed production environment. This process is expected to continue in the cloud.

### Identity management

Active Directory is the identity store and the primary tool for authentication and access control across the Tailwind Traders datacenters. The company has used some best-of-breed systems to extend identity into a multifactor authentication solution. The company has also federated identities to deploy its Microsoft 365 solution. But even with those, Active Directory is how Tailwind Traders manages identity.

In the cloud, the company now has more options, like Microsoft Entra ID or Microsoft Entra Domain Services running in an infrastructure as a service (IaaS) infrastructure. The central operations team is struggling to compare options and choose the best identity solution for its cloud adoption plans.

### Network topology and connectivity

Tailwind Traders uses Multiprotocol Label Switching (MPLS) lines to connect its datacenters and physical stores. All internet traffic is funneled through the primary datacenter. Due to Internet Protocol (IP) conflicts between two of the datacenters, traffic is isolated and routing is dependent on complex routing tables. External connectivity into the datacenter or corporate office is delivered via virtual private network. That connectivity is limited and discouraged.

The primary and secondary datacenters have consistent IP address schemas that are maintained and organized clearly. The third datacenter includes 50 different IP blocks with little consistency and no clear organization or segmentation plan. The continuous innovation cycles are limited to the third datacenter, but they might present problems with defining the network topology and routing in the cloud.

### Resource organization

Segmentation of resources between each datacenter treated each collection of workloads as a big block of assets. Each collection was then divided by risk profile to create isolated and controlled segments to allow limited networking flow between workloads. Workloads that require any ingress network connection from any unprotected network are isolated into one or more perimeter network segments of each datacenter.

Beyond that basic organization, there are inconsistencies in the configuration management database, so it's hard to tell which assets are associated with which workloads. Workload owners and incident escalation chains are well defined for mission-critical workloads, but they're missing for most other workloads.

For less critical workloads, it's common for the identified owner to be a former employee of Tailwind Traders. The configuration mapping often references virtual machines that have been terminated. Likewise, more than 30 percent of the supported assets are not clearly mapped to a single workload. The company will require practice during migration to ensure dependency analysis and proper resource organization.
