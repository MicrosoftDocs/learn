Contoso's classroom rollout illustrates why a successful build is only the first decision in an image's lifecycle. The validator tells you whether the application works, the gallery tells you where the image is ready, and the release manifest tells you which version the owner approved. After deployment, the VM's image reference establishes its origin, while a guest check establishes its behavior.

Withdrawal changes what the deployment workflow will allow next. It doesn't change yesterday's VMs. Keep the image until the people responsible for those VMs have a tested way to replace or rebuild them.

For recurring updates, publish each change as a new candidate. A failed canary leaves the approved version in place. If a defect appears after promotion, restore a still-supported known-good version for new deployments and handle affected VMs separately.

## More info

These official references cover the services, template settings, and commands discussed in the module:

- [Azure VM Image Builder overview and supported security types](/azure/virtual-machines/image-builder-overview)
- [Azure Compute Gallery definitions, versions, replicas, and end-of-life metadata](/azure/virtual-machines/shared-image-galleries)
- [Azure Compute Gallery replica sizing, replication, and high availability](/azure/virtual-machines/azure-compute-gallery)
- [Capture a VM as a gallery image version in the Azure portal](/azure/virtual-machines/capture-image-portal)
- [Create a gallery image definition and version from an existing source](/azure/virtual-machines/image-version)
- [Troubleshoot gallery image-version placement and replication](/azure/virtual-machines/troubleshooting-shared-images#creating-or-updating-image-versions)
- [Share gallery images across subscriptions and tenants](/azure/virtual-machines/share-gallery)
- [How Azure role assignments inherit scope from management groups and subscriptions](/azure/role-based-access-control/scope-overview)
- [Image Builder template: validation, distribution, and cleanup](/azure/virtual-machines/linux/image-builder-json)
- [Image Builder 2024-02-01 resource schema](/azure/templates/microsoft.virtualmachineimages/2024-02-01/imagetemplates)
- [Image Builder scoped permissions](/azure/virtual-machines/linux/image-builder-permissions-cli)
- [Image Builder best practices for staging resources and identities](/azure/virtual-machines/image-builder-best-practices)
- [Image Builder prerequisites, staging policies, and troubleshooting](/azure/virtual-machines/linux/image-builder-troubleshoot)
- [Managed Identity Operator: permission to attach a user-assigned identity](/azure/role-based-access-control/built-in-roles/identity#managed-identity-operator)
- [Image Builder networking options](/azure/virtual-machines/linux/image-builder-networking)
- [Azure Container Instances virtual network and outbound connectivity requirements](/azure/container-instances/container-instances-virtual-network-concepts)
- [Configure Storage virtual network rules and service endpoints](/azure/storage/common/storage-network-security#virtual-network-rules)
- [Configure Image Builder's existing-VNet proxy path and subnet prerequisites](/azure/virtual-machines/linux/image-builder-vnet)
- [Disable network policies specifically for Azure Private Link service](/azure/private-link/disable-private-link-service-network-policy)
- [Distinguish load-balanced application traffic from health probes in NSG rules](/azure/load-balancer/load-balancer-best-practices#configuration-guidance)
- [Azure Load Balancer health-probe source and service tag](/azure/load-balancer/load-balancer-custom-probe-overview#probe-source-ip-address)
- [Private Link service NAT addresses as provider-side traffic sources](/azure/private-link/private-link-service-overview#properties)
- [Isolated Image Builds: ACI connectivity, registration, and quota requirements](/azure/virtual-machines/security-isolated-image-builds-image-builder)
- [Image Builder reliability: retained replicas and independent regional build environments](/azure/reliability/reliability-vm-image-builder)
- [Image Builder release notes, including explicit outbound connectivity requirements](/azure/virtual-machines/image-builder-api-update-release-notes)
- [Linux Image Builder and gallery workflow](/azure/virtual-machines/linux/image-builder-gallery)
- [Build a new Linux gallery image version with Azure VM Image Builder](/azure/virtual-machines/linux/image-builder-gallery-update-image-version)
- [Configure scheduled triggers in Azure Pipelines](/azure/devops/pipelines/process/scheduled-triggers?view=azure-devops&preserve-view=true)
- [Protect promotion with Azure Pipelines approvals and checks](/azure/devops/pipelines/process/approvals?view=azure-devops&preserve-view=true)
- [Protect release-record updates with ETags and conditional writes in Blob Storage](/azure/storage/blobs/concurrency-manage#optimistic-concurrency)
- [Customize Windows Server VM images](/training/modules/customize-windows-server-iaas-virtual-machine-images/)
- [Create a Windows VM from an Image Builder template](/training/modules/customize-windows-server-iaas-virtual-machine-images/7a-create-virtual-machine-azure-image-builder-template-powershell)
- [Azure CLI image builder commands](/cli/azure/image/builder)
- [Azure CLI gallery image definitions](/cli/azure/sig/image-definition)
- [Azure CLI gallery image versions and replication status](/cli/azure/sig/image-version)
- [Gallery image version regional and aggregate replication states](/rest/api/compute/gallery-image-versions/get?view=rest-compute-2024-03-03&preserve-view=true)
- [Managed Run Command PowerShell parameters](/powershell/module/az.compute/set-azvmruncommand)
- [Use Azure CLI from PowerShell: quoting and argument handling](/cli/azure/use-azure-cli-successfully-powershell?view=azure-cli-latest&preserve-view=true)
- [GNU Coreutils: ownership and file and directory permission bits](https://www.gnu.org/software/coreutils/manual/html_node/Mode-Structure.html)
- [GNU Coreutils: test predicates and exit status](https://www.gnu.org/software/coreutils/manual/html_node/test-invocation.html)
