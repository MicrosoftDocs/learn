In the getting-started module, we shared the narrative for Tailwind Traders. The central operations team at Tailwind Traders is experienced at managing its existing datacenters. The ongoing project to migrate two of the datacenters to Azure is already exposing a few critical learning curves that the company's current skill sets can't address.

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

For less critical workloads, it's common for the identified owner to be an ex-employee of Tailwind Traders. The configuration mapping often references virtual machines that have been terminated. Likewise, more than 30 percent of the supported assets are not clearly mapped to a single workload. You will require practices during migration to ensure a dependency analysis and proper resource organization.
