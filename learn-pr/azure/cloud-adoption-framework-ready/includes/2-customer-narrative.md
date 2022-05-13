In the getting-started module, we shared the narrative for Tailwind Traders. The central operations team and platform team at Tailwind Traders are experienced at managing its existing datacenters. The ongoing project to migrate two of the datacenters to Azure is already exposing a few critical learning curves that the company's current skill sets can't address.

## Important constraints

Business priorities: At this time, the business has placed a high priority on migration & meeting the time constraints to get out of their data center. Because of that business priority, the business and IT teams have deprioritized longer term security and compliance requirements until they can complete development of their core cloud platform.

Current state of the cloud teams: Since Tailwind is new to the cloud, very few members of operations, platform, or IT admin teams are experienced with the cloud. The team wants to slowly move into modern operations, security, and governance but still needs a cloud foundation that can scale to meet those needs as they become more important. Historically, Tailwind has operated from a purely Central Operations perspective, meaning that workload teams don’t have the ability to interact with production environments. As such, the team doesn’t have an easy way of mapping assets (VM, Data, & Apps) to defined workloads, so the boundaries of each workload can be unclear at times.

## Alignment to Azure landing zone

The impacted teams have decided to use Azure landing zones as the baseline and future state target for the environmental configuration. The operations and platform teams have agreed to the following alignment.

- The Azure landing zone conceptual architecture will serve as the long-term vision for the future state of the cloud environment. All impacted teams will use that architecture as a basis for building cloud skills & configuring their cloud environment.
- The Azure landing zone accelerator will be used to “get started” with their environmental configuration.
- If they need to customize their environment in the future, they will use one of the custom implementations options which align to or extend the initial accelerator-based deployment.

## Deviation from standard Azure landing zone guidance

Tailwind needed to use Azure landing zones in a way that met them where they are today. The following outlines how their constraints cause them to deviate from some of the Azure landing zone design principles & the impact of each decision.

- Policy-driven governance: Tailwind hasn’t historically automated their corporate policies. Given the pressure to migrate their data center quickly, they chose to minimize the amount of governance including in their initial landing zone deployment. The team has also committed to completing the CAF Govern learn module once the initial environment is configured. Limitations in IT staff dedicated to the cloud migration are a big driver for this deviation. This deviation was further enforced by Business and IT resistance to full blown cloud governance or “Azure Ops”.
- Subscription democratization: The Central operations team will maintain production operations accountability for all workloads. They will seldom allow a workload team to have access to a production environment, so they are not following the design principle of subscription democratization. If a workload team requires a deviation, the operations team will consider a dedicated landing zone for individual workloads on a case-by-case basis. Otherwise, Tailwind is firmly committed to maintaining central operations & would have limited instances of workloads in isolated production environments (or application landing zones).
- Application-centric service model: Outage related processes may consider workloads, especially for assets supporting mission-critical workloads. However, aside from outages, the Central operations team doesn’t differentiate between workloads or applications for operations management processes. Their primary processes operate, manage, make changes, and optimize all resources the same ways regardless of the workload boundaries/architecture. Given the time constraints for this migration, it’s not feasible for the Tailwind team to define app boundaries & establish an app-centric service model.

Many of the terms in the above bullets will be explained in the following units of this Learn module. You will see several of them reflected in notes to create teaching opportunities.

These deviations don’t take away from the alignment section above. However, these deviations will impact some options when deploying the Azure landing zone accelerator. These deviations will also impact the design for individual application landing zones, which are deployed once you start to migrate assets to the cloud.

These deviations will also require the Tailwind team to complete the CAF Manage, Secure, and Govern Learn modules after the initial environment is deployed.

## Additional constraints

The remainder of this customer narrative describes additional constraints that may impact Tailwinds decisions.

## Operations

The central operations team has organically built a set of processes and controls to manage the overall portfolio. The team depends on System Center Operations Manager and System Center Configuration Manager for its operations baseline.

The team has also integrated best-of-breed tools for virtual machine management, incident and configuration management tracking, network monitoring, security operations, and governance controls, among other tools. Most of these tools have built-in integration with Azure, which influenced the decision to use Azure as the company's primary cloud provider. Operating these tools requires significant people power and operating capital.

### Operations tools

Licensing for the operations-management tooling (including hypervisors) consumes more than 20 percent of IT's budget for hard costs. The new Chief Information Officer (CIO) has challenged the team to reevaluate those tools and processes to find cloud-first or unified operations alternatives. The CIO will watch for reduction of tooling expenses as an early indicator of success in this migration.

### Operations processes

The IT manager has requested two new hires to support the central operations team. They'll help balance the load on the overstressed team. In particular, they'll support business continuity and disaster recovery (BCDR) practices and patch compliance processes.

Collectively, the business isn't ready for a full-scale shift to cloud-native operations, especially for mission-critical applications. The CIO believes that some investment in cloud-native operations tools would help reduce strain on the team by shifting some of those responsibilities to the cloud provider.

The CIO will watch for operational shifts to improve employee satisfaction and reduced load across the central operations team. The CIO will also request frequent updates on how the adoption plan will affect BCDR and patching efforts.

### Service-level agreement

In spite of all the hard work and costs associated with operations, the team periodically fails to meet the service-level agreement (SLA) of 90 percent uptime for mission-critical systems in the primary datacenter. This is a costly concern for the CIO and Chief Executive Officer (CEO). Outdated hardware and an overdue refresh cycle in the datacenter have resulted in frequent but brief outages.

Although the company has begrudgingly accepted this SLA, the new CIO is not impressed. Regardless of the financial savings, the CIO expects the operations team to deliver a much higher SLA after the migration.

### Retail innovation

The customer narrative from the getting-started module introduced you to the retail innovation team within Tailwind Traders. That team was originally a startup that Tailwind Traders acquired. The startup's original CEO is now Tailwind's Chief Technology Officer (CTO). The CTO still runs that division like a startup, prioritizing experimentation and innovation.

The current operations-management processes require that all new innovations from that team go through a release process. The central operations team within IT reviews the architecture for security, governance, and operations-management concerns. After the team is comfortable with the solution, it releases the solution into a centrally managed production environment. This process is expected to continue in the cloud.

## Identity management

Active Directory is the identity store and the primary tool for authentication and access control across the Tailwind Traders datacenters. The company has used some best-of-breed systems to extend identity into a multifactor authentication solution. The company has also federated identities to deploy its Microsoft 365 solution. But even with those, Active Directory is how Tailwind Traders manages identity.

In the cloud, the company now has more options, like Azure Active Directory or Azure Active Directory Domain Services running in an infrastructure as a service (IaaS) infrastructure. The central operations team is struggling to compare options and choose the best identity solution for its cloud adoption plans.

## Network topology and connectivity

Tailwind Traders uses Multiprotocol Label Switching (MPLS) lines to connect its datacenters and physical stores. All internet traffic is funneled through the primary datacenter. Due to Internet Protocol (IP) conflicts between two of the datacenters, traffic is isolated and routing is dependent on complex routing tables. External connectivity into the datacenter or corporate office is delivered via virtual private network. That connectivity is limited and discouraged.

The primary and secondary datacenters have consistent IP address schemas that are maintained and organized clearly. The third datacenter includes 50 different IP blocks with little consistency and no clear organization or segmentation plan. The continuous innovation cycles are limited to the third datacenter, but might present problems with defining the network topology and routing in the cloud.

## Resource organization

Segmentation of resources between each datacenter treated each collection of workloads as a big block of assets. Each collection was then divided by risk profile to create isolated and controlled segments to allow limited networking flow between workloads. Workloads that require any ingress network connection from any unprotected network are isolated into one or more perimeter network segments of each datacenter.

Beyond that basic organization, there are inconsistencies in the configuration management database, so it's hard to tell which assets are associated with which workloads. Workload owners and incident escalation chains are well defined for mission-critical workloads, but are missing for most other workloads.

For less critical workloads, it's common for the identified owner to be an ex-employee of Tailwind Traders. The configuration mapping often references virtual machines that have been terminated. Likewise, more than 30 percent of the supported assets are not clearly mapped to a single workload. You will require practice during migration to ensure a dependency analysis and proper resource organization.
