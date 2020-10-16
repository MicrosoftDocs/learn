In the getting started module, we shared the narrative for Tailwind Traders. The central operations/infrastructure team at Tailwind Traders is experienced at managing their existing datacenters. The ongoing project to migrate two of their datacenters to Azure is already exposing a few critical learning curves that their current skillsets can't address.

## Operations

The central operations team has organically built a set of processes and controls to manage the overall portfolio. The team depends on System Center Operations Manager and System Center Configuration Manager for their operations baseline. They have also integrated a number of best-of-breed tools for virtual machine management, incident and configuration management tracking, network monitoring, security operations, governance controls, and other tools. Most of these tools have built-in integration with Azure, which influenced the decision to use Azure as their primary cloud provider. Operating these tools requires significant people power and operating capital.

### Operations tools

Licensing for the operations management tooling (including hypervisors) consumes more than 20 percent of IT's budget for hard costs. The new Chief Information Officer (CIO) has challenged the team to reevaluate those tools and processes to find cloud-first or unified operations alternatives. She will be watching for reduction of tooling expenses as an early indicator to success in this migration.

### Operations processes

Additionally, the IT manager has requested two new hires to support the central operations team. That staff would help balance the load on the over-stressed team. In particular, additional staff is requested to support business continuity and disaster recovery (BCDR) practices and patch compliance processes.

Collectively, the business isn't ready for a full-scale shift to cloud-native operations, especially for mission critical applications. The CIO believes that some investment in cloud-native operations tools would help reduce strain on the team by shifting a number of those responsibilities to the cloud provider. She will be watching for operational shifts to improve employee satisfaction and reduced load across the central operations team, and she will frequently request updates on how the adoption plan will impact BCDR and patching efforts.

### Low service-level agreement

In spite of all the hard work and costs associated with operations, the team periodically fails to meet the 90 percent uptime service level agreement (SLA) for mission-critical systems in the primary datacenter. This is a costly concern for the CIO and Chief Executive Officer (CEO). Outdated hardware and an overdue refresh cycle in the datacenter have resulted in frequent but brief outages. While the company has begrudgingly accepted this SLA, the new CIO is not impressed. Regardless of the financial savings, she expects the operations team to deliver a much higher SLA after the migration.

### Retail innovation

In the customer narrative from the getting started module, you were introduced to the retail innovation team within Tailwind Traders. That team was originally a startup that was acquired by Tailwind Traders. Their original CEO is now Tailwind's Chief Technology Officer (CTO). He still runs that division like a startup, prioritizing experimentation and innovation.

The current operations management processes require that all new innovations from that team must go through a release process. The central operations team within IT reviews the architecture for security, governance, and operations management concerns. Once they are comfortable with the solution, it's released into a centrally managed production environment by the central operations team. This process is expected to continue in the cloud.

## Identity management

Active Directory is the identity store and primary tool for authentication and access control across the Tailwind Traders datacenters. They've used some best of breed systems to extend identity into a multifactor authentication solution. They've also federated identities to deploy their Office 365 solution. But even with those, Active Directory is how they manage identity.

In the cloud, they now have additional options, like Azure Active Directory or Active Directory Domain Services running in IaaS infrastructure. The team is struggling to compare options and choose the best identity solution for their cloud adoption plans.

## Network topology and connectivity

Tailwind Traders uses MPLS lines to connect their datacenters and physical stores. All internet traffic is funneled through the primary datacenter. Due to IP conflicts between two of the datacenters, traffic is isolated and routing is dependent on complex routing tables. External connectivity into the datacenter or corporate office is delivered via virtual private network is limited and discouraged.

The primary and secondary datacenters have consistent IP address schemas that are maintained and organized clearly The third datacenter includes 50 different IP blocks with little consistency and no clear organization or segmentation plan. The continuous innovation cycles are limited to the third datacenter but could present problems when defining the network topology and routing in the cloud.

## Resource organization

Segmentation of resources between each datacenter treated each collection of workloads as a big block of assets. They were then divided by risk profile to create isolated and controlled segments to allow limited networking flow between workloads. Workloads that require any ingress network connection from any unprotected network are isolated into one or more demilitarized zone segments of each datacenter.

Beyond that basic organization, there are inconsistencies in the configuration management database, so it's difficult to tell which assets are associated with which workloads. Workload owners and incident escalation chains are well defined for mission-critical workloads but are missing for most other workloads. For less critical workloads, it's common for the identified owner to be an ex-employee of Tailwind Traders. The configuration mapping often references virtual machines that have been terminated. Likewise, over 30 percent of the supported assets are not clearly mapped to a single workload. Practices will be required during migration a dependency analysis and proper resource organization.
