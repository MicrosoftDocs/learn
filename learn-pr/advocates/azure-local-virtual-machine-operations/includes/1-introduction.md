Azure Local is an on-premises infrastructure platform that you manage through Azure. It combines compute, storage, and networking on supported hardware in your own environment, where it hosts Windows and Linux VMs. Hyper-V provides the hypervisor that runs and isolates the VMs, while Azure Arc connects the platform to Azure management. You can use the Azure portal and Azure CLI to provision Azure Local VMs enabled by Azure Arc and perform supported lifecycle operations rather than relying solely on local Hyper-V tools. The management experience comes from Azure, but the VMs and their workloads run on your on-premises hardware, not in an Azure datacenter.

Azure Local also makes it easier to integrate Azure services into the management environment for the virtualization fabric and the VMs it hosts. Through Azure Arc, you can configure Azure Monitor, Azure Policy, and Microsoft Defender for Cloud for supported monitoring, governance, and security scenarios while workloads stay local. With standalone Hyper-V, VM deployment and hardware changes typically use local tools or a separate management platform. Azure Local deployment sets up an Azure Arc resource bridge and a custom location so you can deploy VMs and their associated resources through Azure Resource Manager templates, then delegate supported management operations through Azure role-based access control (RBAC). Hyper-V guests can also use Azure services after separate Arc onboarding, but that guest connection alone doesn't provide Azure-managed VM provisioning or hardware lifecycle operations. Individual services still require configuration, permissions, and any required guest agents or extensions.

## Azure Local virtual machine platform

Imagine that you operate an Azure Local cluster for a manufacturing organization. A production application runs in `app01`, a Linux VM hosted on your Azure Local instance which you manage from Azure. The application owner requests more memory. At the same time, a monitoring extension reports an error, and another team wants GPU acceleration for an inspection workload.

These requests involve different parts of the platform. Increasing startup memory changes the VM's hardware configuration. Repairing a monitoring extension changes software inside the guest. Adding a GPU changes hardware allocation and can constrain where the VM can run during maintenance or recovery. Treating all three as ordinary Hyper-V edits creates unnecessary risk.

An Azure Local VM has several related identities and lifecycles: 

- Azure records the resource, permissions, and requested configuration.
- Hyper-V executes the VM on the local cluster. 
- Agents support guest configuration and management. 
- The application maintains its own services, data, and dependencies.

The central operating principle is to use the appropriate supported interface for each operation and validate the result at the layer that matters. A successful cloud request doesn't prove an application is healthy. A working application doesn't prove the cloud-management path is available.

Throughout the module, we'll use this decision sequence:

- Identify ownership
- Confirm support
- Inspect dependencies
- Perform the approved operation
- Verify the outcome.
