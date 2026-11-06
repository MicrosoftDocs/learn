Contoso operates a research facility whose workloads and routine management must stay within an isolated network. The facility runs Windows and Linux VMs, plus containerized analysis services. Approved staff can acquire software on a separate connected administrative station and transfer it through a controlled process. The facility can't depend on public Azure being reachable to create or manage local workloads.

Your task is to decide whether Contoso's design is ready for production. A three-node cluster and a successful portal sign-in aren't enough. You also need to know how administrators obtain access, how new software enters the environment, how security events remain visible, and how the team recovers after losing management services.

## Azure Local disconnected

Azure Local can run without a connection to the Azure public cloud when you deploy it with the purpose-built *disconnected operations* capability. This model is intended for organizations that can't connect to Azure because of regulatory restrictions, sovereignty requirements, or connectivity constraints. Disconnecting an ordinary connected Azure Local cluster doesn't turn it into a supported disconnected deployment.

Before choosing this model, confirm that your organization can meet the following conditions:

- **Eligibility and support**: You need approval to access disconnected operations, an eligible Microsoft agreement, and a valid business need to operate disconnected. The Microsoft online subscription program isn't eligible. You also need an active Standard-or-higher Microsoft support plan, or a partner with an active support plan, and staff or a partner able to deploy and operate the environment.
- **Validated hardware and dedicated capacity**: Use supported Azure Local Premier Solutions and confirm that the selected configuration is validated for disconnected operations. Production requires a dedicated three-node management cluster for the local control plane and supporting management services. Tenant VMs and applications run on separate workload clusters. A one-node management configuration is for evaluation, not production.
- **Locally available dependencies**: The environment needs reachable identity services, local name resolution, trusted certificates, reliable time, and correctly configured networking. Active Directory and Active Directory Federation Services (AD FS) are the validated identity solutions. These dependencies must remain available inside the isolation boundary rather than rely on an inaccessible public-cloud service.
- **Supported workloads and features**: Use only the services and capabilities supported by disconnected operations for your deployed release. A familiar Azure interface doesn't mean every public Azure feature is available locally. Check application dependencies too, including image repositories, licensing services, and external APIs that might require internet access.
- **Controlled administration and maintenance**: Establish approved processes for importing software and updates, exporting diagnostics, maintaining security, and recovering the environment. Acquisition and post-deployment self-attestation use a separate internet-connected administrative machine. This doesn't require connecting the production management cluster to Azure.

The appliance can operate in an air-gapped environment or with approved limited connectivity for observability and diagnostics. Limited connectivity can simplify support, but routine local management doesn't depend on a public-cloud connection. In either arrangement, the organization remains responsible for maintaining the local services and operating procedures that replace those external dependencies.

## Understand what moves locally

A *control plane* receives management requests, checks authorization, records resource configuration, and coordinates changes. Creating a VM, assigning a role, and requesting a cluster update are control-plane operations.

Clients submit management requests through an *application programming interface* (API), a defined interface for exchanging commands and responses. A portal provides an interactive interface over those capabilities, while a command-line interface (CLI) lets you invoke supported operations from a terminal or automation.

The *data plane* provides the execution and data-processing capabilities that workloads use. Azure Local workload clusters supply compute, networking, and storage. A running application reading its database is performing workload activity, not creating an Azure resource.

Disconnected operations hosts selected control-plane capabilities locally. It provides a familiar portal and Azure Resource Manager (ARM) experience without requiring public-cloud connectivity for routine local management. It doesn't install the entire Azure public cloud in your datacenter.

The following comparison helps you identify the operating model rather than judge it only by whether a network cable is connected.

| Situation | Where management depends on services | What it means for your design |
| --- | --- | --- |
| A connected Azure Local deployment experiences an internet outage | Its management model still depends on public Azure services | Existing workloads might continue, but the outage doesn't create a local portal, resource manager, or artifact service. |
| A connected deployment uses a proxy, private path, or Azure Arc gateway | The path to cloud services changes | A gateway routes connectivity. It doesn't replace the cloud control plane. |
| Disconnected operations runs with approved limited connectivity | Selected management capabilities run locally, with specific external exchanges permitted | Document exactly which support or diagnostic traffic can leave and why. |
| Disconnected operations runs in an air-gapped environment | Routine management and its dependencies are local | Software import, commercial administration, and recovery prerequisites still need explicitly approved procedures. |

An *air gap* is a controlled separation from external networks. It doesn't mean that software never changes or that information can never cross the boundary. Removable media, an acquisition station, and a support-package export process are all potential boundary crossings that need ownership and review.

For Contoso, the architectural question is therefore not "Can the VMs run without internet?" It's "Can the organization operate and recover a supported local cloud without an unapproved external dependency?"
