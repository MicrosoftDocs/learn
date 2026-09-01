Consider Contoso Manufacturing, a company that operates multiple factories producing industrial equipment. Each production line relies on sensors to monitor machine performance and cameras to inspect products for defects during assembly.

In Contoso's current setup, much of this operational data is sent to centralized systems for processing. While this supports reporting and long-term analysis, it introduces challenges for real-time operations:

- Defects might only be identified after products have progressed further through the line, increasing rework and waste
- Equipment anomalies might not be detected until they begin affecting output
- Operators rely on alerts that depend on cloud-based processing
- Infrastructure is managed differently at each factory, increasing complexity

Contoso wants to improve how it processes data and responds to events by enabling real-time analysis directly within each facility. The company needs a solution that allows it to:

- Process production data locally to reduce the impact of cloud latency
- Detect defects and anomalies as they occur to reduce waste
- Continue operating during connectivity interruptions to reduce downtime
- Maintain consistent management across all factory locations

Small form factor deployments of Azure Local (preview) are designed for scenarios like this. They enable organizations to run workloads close to physical systems while maintaining centralized visibility and control through Azure.

In the following units, you'll learn what small form factor deployments of Azure Local (preview) are, how they work, and how to evaluate whether they're a good fit for scenarios like this one.

## What are small form factor deployments of Azure Local (preview)?

This approach combines local execution with centralized Azure management. Workloads run on compact hardware near physical systems, while Azure provides identity, governance, monitoring, and lifecycle management across all deployments.

Unlike conventional approaches that rely primarily on centralized cloud resources, this model allows organizations to place compute capabilities directly where data is generated. For Contoso Manufacturing, this means infrastructure can be deployed in or near production environments instead of relying solely on distant systems that introduce latency and the potential for inconsistent compliance.

At a high level, these small form factor deployments provide the following capabilities:

### Azure-managed infrastructure at the edge

Physical machines are provisioned and managed through Azure using familiar cloud-based tools and processes. This reduces the need for separate, site-specific management approaches.

**Why this matters:** IT teams can monitor and manage infrastructure across all factories from a central location instead of relying on local teams at each site.

### A consistent management experience

Organizations can apply identity, access control, compliance, and governance policies consistently across cloud and edge environments.

**Why this matters:** This consistency helps organizations reduce operational complexity and maintain a standardized approach to infrastructure management, even when systems are distributed across many physical locations.

### Support for local workloads on compact hardware

Applications and services can run close to the systems and data they depend on. This is particularly important in environments with limited space, such as factory floors or equipment control rooms.

**Why this matters:** Organizations can place infrastructure directly where it's needed—in Contoso's case, alongside production lines—without requiring large server installations.

### A path to local AI and operational intelligence

Workloads can run near physical systems to support faster data processing and real-time decision-making, enabling operational intelligence where it's needed.

**Why this matters:** Faster interpretation of data near its source means more flexible and resilient processes. For Contoso, local systems can analyze camera feeds to identify defects as products move through assembly, enabling immediate corrective action.

## How this approach differs from traditional models

In a cloud-only model, data must travel to centralized systems before decisions can be made. This can introduce delays and dependencies on connectivity.

Small form factor deployments take a different approach by combining local execution for real-time processing with centralized management through Azure. This table illustrates some of the key differences this approach can create:

| **Aspect** | **Cloud-only model** | **Azure Local small form factor** |
| :---: | :---: | :---: |
| **Processing location** | Centralized | Local + distributed |
| **Latency** | Higher | Low |
| **Connectivity dependence** | High | Reduced |
| **Management** | Centralized | Centralized (Azure) |
| **Real-time responsiveness** | Limited | Strong |

In practice, these differences mean organizations can respond to events as they happen, rather than after delays—reducing operational risk while maintaining centralized oversight.

The goal is to extend rather than replace the cloud—bringing cloud capabilities closer to where decisions need to happen. This shift reduces latency while enabling real-time decision-making in environments where delays directly impact operations.

This approach helps Contoso Manufacturing modernize its factory operations without sacrificing the centralized visibility and control provided by Azure.
