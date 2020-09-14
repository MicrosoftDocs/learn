In the getting started module, we shared the narrative for Tailspin Traders. The central operations/infrastructure team at Tailspin is experienced at managing their existing data centers. The on-going project to migrate 2 of their data centers to Azure is already exposing a few critical learning curves that their current skillsets can't address.

## Operations

The central operations team has organically built a set of processes and controls to manage the overall portfolio. The team depends on System Center Operations Manager (SCOM) and System Center Configuration Manager (SCCM) for their operations baseline. They have also integrate a number of best of breed tools for virtual machine management, incident and configuration management tracking, network monitoring, security operations, governance controls, etc... Most of these tools have built in integrations with Azure, which influenced the decision to use Azure as their primary cloud provider. Operating all of these tools requires significant people power & operating capital.

### Operations tools

Licensing for the operations management tooling (including hypervisors) consumes more than 20% of IT's hard cost budget. The new CIO has challenged the team to re-evaluate those tools and processes to find cloud-first or unified operations alternatives. She will be watching for reduction of tooling expenses as an early indicator to success in this migration.

### Operations Processes

Additionally, the IT Manager has requested two new hires to support the central operations team. That staff would help balance the workload on the over-stressed team. The CIO believes that cloud native operations tools would help reduce the workload by placing a number of those responsibilities on the cloud provider. She will be watching for operational shifts to improve employee satisfaction and reduce workload across the central operations team.

### Low SLA

In spite of all the hardwork & costs associated with operations, the team periodically fails to meet the 90% uptime SLA (Service Level Agreement) for mission critical systems in the primary data center. This is a costly concern for the CIO and CEO. Outdated hardware and an overdue refresh cycle in the data center have resulted in frequent but brief outages. While the company has begrudgingly accepted this SLA, the new CIO is not impressed. Regardless of the financial savings, she is expecting the operations team to deliver a much higher SLA after the migration. 

## Identity management

Active Directory is the identity store and primary tool for authentication and access control across Tailspin Trader's data centers. They've used some best of breed systems to extend identity into a multi-factor authentication solution. They've also federated identities to deploy their Office 365 solution. But even with those, Active Directory is how they manage identity.

In the cloud, they now have additional options, like Azure Active Directory or AD running in IaaS infrastructure. The team is struggling to compare options & choose the best identity solution for their cloud adoption plans.

## Network topology and connectivity

Tailspin Trader uses MPLS lines to connect their data centers and physical stores. All internet traffic is funneled through the primary data center. Due to IP conflicts between two of the data centers, traffic is isolated & routing is dependent on complex routing tables. External connections into the data center or corporate office is delivered via VPN (Virtual Private Network) is limited and discouraged.

The primary and secondary data centers have consistent IP address schemas that are well-maintained and intuitively organized. The third data center includes 50 different IP blocks with little consistency & no clear plan to organization or segmentation. The continuous innovation cycles are limited to the third data center, but could present problems when defining the network topology and routing in the cloud.

## Resource organization

Segmentation of resources between each data center treated each collection of workloads as a big block of assets. They were then divided by risk profile to create isolated and controlled segments to allow limited networking flow between workloads. Workloads that require any ingress network connection from any unprotected network are isolated into one or more de-millitarized zone (DMZ) segments of each data center.

Beyond that basic organization, there are inconsistencies in the CMDB so it's difficult to tell which assets are associated with which workloads. Workload owners and incident escalation chains are well-defined for mission critical workloads, but missing for most other workloads. For less critical workloads, it's common for the identified owner to be an ex-employee of Tailspin Traders. Often times the configuration mapping references VMs that have been terminated. Likewise, over 30% of the supported assets are not clearly mapped to a single workload. During migration a dependency analysis and proper resource organization practices will be required.