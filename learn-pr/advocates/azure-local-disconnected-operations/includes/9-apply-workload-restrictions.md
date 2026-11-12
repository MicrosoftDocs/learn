Workload readiness means that the application can be deployed, restarted, updated, and recovered using supported local capabilities. Showing that an already-running VM or container survives without internet tests only part of that requirement.

## Prepare local VM images and networks

The reviewed disconnected VM documentation lists Windows Server 2022 and 2025, Windows 10 Enterprise, and Ubuntu 22.04 and 24.04 LTS. Treat this as the disconnected VM documentation's list, not the Kubernetes node-image matrix or a guarantee of ongoing guest operating-system servicing. Guest support, licensing, activation, and update arrangements still need separate confirmation.

The documented image workflow uses a local share. Direct image creation from Marketplace, an Azure Storage account, or an existing Azure Local VM isn't supported by that workflow. A connected deployment template that references a Marketplace image therefore needs an approved local image resource and the corresponding preparation work.

The VM dependency sequence is storage path, prepared image, logical network, network interface, and VM. The image must be available on the documented cluster shared storage accessible to all machines. A file that exists only on the administrator's workstation isn't sufficient.

Prepare each image using its operating-system-specific procedure. Windows generalization isn't a Linux image-preparation procedure. Review the required generation, boot capabilities, guest-management support, and licensing for the image you actually plan to use.

Network interfaces require CLI creation in the reviewed disconnected VM guidance. Logical networks can be used even where their portal display is incomplete. Don't interpret a portal limitation as permission to substitute an unrelated connected workflow.

The VM guidance lists Azure Monitor Agent and Custom Script as supported extensions. That doesn't make the complete public Azure Monitor service local or guarantee that a script's public download URLs are reachable. Evaluate the extension package and its runtime destinations separately.

## Distinguish Kubernetes provisioning from Arc integration

Kubernetes schedules and manages containerized workloads across nodes. AKS on Azure Local provides supported Kubernetes cluster provisioning and management. Arc-enabled Kubernetes integration connects supported Cloud Native Computing Foundation (CNCF) Kubernetes clusters on Azure Local VMs to selected management capabilities. These are separate catalog entries, not interchangeable descriptions of one feature.

Release 2609 introduced general availability for disconnected AKS and Windows node-pool support. Don't carry an older preview restriction forward as a permanent limitation. Equally, a release announcement doesn't establish that every Windows image or public AKS feature is supported.

The reviewed disconnected AKS overview lists Kubernetes **1.33.4** and **1.33.5**. Record the exact supported node operating-system and image combination with the chosen Kubernetes version. Resolve an unlisted combination before deployment.

The same overview identifies the following specific restrictions.

| Area | Disconnected boundary | Design consequence |
| --- | --- | --- |
| Authentication | Microsoft Entra ID authentication isn't supported for disconnected AKS | Use the documented local credential path and protect Kubernetes credentials. |
| Outbound connectivity | Arc gateway isn't supported for configuring outbound URLs | Don't apply connected Arc gateway instructions as an offline workaround. |
| Logical-network creation | The portal isn't supported for this operation | Use the documented CLI workflow. |
| Secure Shell (SSH) key creation | The portal isn't supported for this operation | Prepare keys through the documented CLI path and protect private keys. |
| Cluster creation | The disconnected guide links both portal and CLI workflows | Don't infer that every operation is CLI-only from the two preceding restrictions. |

A Kubernetes *kubeconfig* tells a client which cluster to contact and how to authenticate. Administrator kubeconfig material can grant powerful access. Don't put it in a transfer manifest, a general-purpose file share, or an application repository.

Azure resource RBAC and Kubernetes authorization protect different interfaces. Permission to manage a cluster resource doesn't by itself explain how an application or user is authorized inside Kubernetes. Document both boundaries.

## Validate local network and registry dependencies

Plan distinct address allocations for Kubernetes node VMs, the Kubernetes API endpoint, and application load-balancer services. Avoid collisions with each other and with infrastructure reservations. Confirm that the logical network maps to the correct VM switch and that DNS and required cross-network paths work.

*Image pull* is the download of a container image to a node before a container starts. A running pod can hide a missing registry dependency because the image is already cached on its node.

Test a controlled cold deployment on a suitable nonproduction node without the application images already cached. Verify all images, init containers, sidecars, Helm chart dependencies, and installation hooks. Check registry DNS, certificate trust, connectivity, and pull authorization from the workload network.

For Contoso, a chart might use the local registry for its main application but still reference a public registry for a database-initialization job. The Kubernetes API can be healthy while that deployment fails. Fix the incomplete artifact set rather than changing the cluster's authentication model or opening unrestricted internet access.

The local registry supports images and artifacts such as Helm charts. Don't assume every public registry feature, replication mode, or metric is implemented. The reviewed registry guidance lists viewing registry metrics as unsupported.

Some registry examples still use public image sources and older client-version wording. Such an example isn't an air-gap transfer procedure and doesn't override the dedicated CLI requirements. Use authenticated local endpoints, the approved client build, and the controlled artifact process.

## Keep licensing and external services distinct

The disconnected billing guidance distinguishes Azure Hybrid Benefit for the Azure Local infrastructure service from the benefit for Windows Server guest VMs. The infrastructure benefit isn't available for disconnected operations, while eligible Windows Server VM licensing can use the documented guest benefit. Confirm license eligibility, allocation, and activation independently of VM deployment.

Similarly, a Windows desktop VM isn't an offline Azure Virtual Desktop service. Azure Virtual Desktop can place session hosts on Azure Local, but its brokering service still requires Azure connectivity. Hosting a desktop guest locally doesn't relocate that broker.

The same reasoning applies to external identity, monitoring ingestion, package repositories, and application APIs. Accept a workload only after every required service has a supported local implementation or an explicitly approved and viable external dependency.

For VM deployment, associate the storage path, image, and network resources with the intended workload cluster's custom location, and use the local `autonomous` location. Create network interfaces through Azure CLI. Trusted launch VM creation also requires CLI, with the trusted launch security type, Secure Boot, and virtual Trusted Platform Module (vTPM) settings. Boot integrity verification isn't supported in this disconnected workflow. Outbound internet proxy servers aren't supported either. Delete a storage path only after its dependent VMs, images, and disks have been deleted through the approved retirement process.

For AKS, distinguish release capabilities from authentication and tooling limits. Release 2609 makes disconnected AKS generally available and adds Windows node pools. It also introduces Workload Identity Federation for Arc-enabled Kubernetes, but that capability doesn't establish Microsoft Entra ID user-authentication support for disconnected AKS. Keep the approved Kubernetes version and node-image combination, use CLI for logical-network and SSH-key creation, and don't use Arc gateway as a substitute for the local control plane.

Before creating a local container registry, register `Microsoft.ContainerRegistry` in the intended local subscription. In the local portal, select **Create a resource > Containers > Container Registry**, choose **Autonomous** for the location and **Standard** for the pricing plan, and assign local RBAC permissions such as **AcrPull** for image retrieval. Read the actual **Login server** value from the deployed registry rather than assuming an `azurecr.io` address. Use the registry resource name with `az acr login --name`, but use the login-server address when tagging, pushing, or pulling images.

The registry can store OCI images and artifacts such as Helm charts and can trigger webhooks for repository events. Keep webhook destinations reachable through approved network paths. Use supported commands such as `az acr repository list`, `az acr manifest list-metadata`, and `az acr show-usage` to inspect content and storage use. Registry metrics aren't supported. A public-source `az acr import` example doesn't make that source reachable across an air gap, so acquire and transfer the complete artifact set before publishing it locally.

Disconnected operations capacity charges cover the purchased physical cores managed by the service, including the cores that run the control plane. The annual commitment is billed monthly. Changing the number of VMs or their virtual cores doesn't change this physical-core charge. Adding managed physical cores during the term increases the billed capacity for the remainder of that term. This infrastructure charge is separate from Windows Server guest licensing, and Azure Hybrid Benefit doesn't waive the disconnected Azure Local infrastructure charge.

To use Azure Hybrid Benefit for Windows Server guests, hold eligible Standard or Datacenter licenses with active Software Assurance or an active subscription. Allocate at least eight core licenses per VM, even for a four-core VM, and cover the full core count for larger VMs. For example, a 12-core VM needs 12 core licenses. Standard licenses can't be used simultaneously for the source on-premises workload and the disconnected VM except during a one-time 180-day migration allowance. Eligible Datacenter licenses permit simultaneous use for VM licensing indefinitely under the documented benefit. Confirm the applicable agreement and license allocation with the licensing owner before deployment.
