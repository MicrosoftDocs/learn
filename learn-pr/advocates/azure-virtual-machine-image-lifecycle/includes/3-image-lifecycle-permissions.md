Building an image, publishing it, approving it, and deploying a VM are different jobs. Identify who performs each job and which resources they need to reach. That distinction helps you diagnose a failed build without granting broader access when the real problem is a blocked network path.

Permission to write a gallery version isn't permission to approve it. Azure role-based access control (RBAC) grants a **principal** (a person or service identity) a set of actions at a **scope** (the resource or group where those actions apply). A **managed identity** lets an Azure service authenticate without storing a password in a script.

The important distinction is who performs each operation:

| Who | What they need | Where to grant it |
|---|---|---|
| Setup and role administrators | Create the agreed resources; assign roles through an authorized administrator. | The required resource and role-assignment scopes. An operator who receives a denial shouldn't elevate their own account. |
| Template submitter | Deploy and read the image template, start it (`Microsoft.VirtualMachineImages/imageTemplates/run/action`), and assign the selected managed identity to it. | The build resource group and the selected identity. |
| Image Builder | Use the template's user-assigned managed identity to read image inputs and write the output version. Grant Contributor in the precreated staging group so the service can manage temporary build resources there. | The required image resources and the dedicated staging group in the template's region, not the subscription. |
| Image Builder template identity attaching a build VM identity | **Managed Identity Operator** on each identity listed in `vmProfile.userAssignedIdentities`. | Each listed user-assigned identity resource. An authorized role administrator grants this permission. |
| Image Builder template identity using an existing virtual network (VNet) | `Microsoft.Network/virtualNetworks/read` and `Microsoft.Network/virtualNetworks/subnets/join/action`. | Read the selected VNet and join the build VM subnet and any supplied Azure Container Instances (ACI) subnet. Scope the grants to the required network resources or an approved dedicated networking resource group. |
| Process reading private build files | Read the files, not administer the storage account. For Azure Blob Storage, grant **Storage Blob Data Reader** to the identity that actually reads them. | The specific container. A recipe containing only inline content doesn't need that role. |
| Release approver | Change the protected release record. | The release store; approval doesn't require guest administrator access or the Azure RBAC Owner role. |
| Consumer deployment identity | Read the version and create the VM, disks, and network resources it owns. To use managed Run Command (execute a script through the guest agent), it also needs the `read` and `write` actions for `Microsoft.Compute/virtualMachines/runCommands`. | The permitted image and consumer resources, separate from the build resources. |

Contributor in the staging group isn't a reason to grant Contributor in the gallery group. For gallery output, a custom role can grant read access to the gallery and definition and read/write access to versions. Include managed-image read, write, and delete actions where the build needs them for intermediate images; don't grant permission to delete gallery versions just to publish one.

Contributor in the staging group also doesn't authorize a VNet in another resource group. Grant VNet read at the VNet or a suitable containing scope; an assignment only on a child subnet doesn't grant access to read its parent VNet. Check the template identity's network actions separately from the guest identity's storage access, name resolution, routes, and traffic rules.

The identity on the template isn't automatically available to scripts inside the temporary build VM. If a script must authenticate from inside that VM, list a user-assigned identity under `vmProfile.userAssignedIdentities`. An authorized role administrator must grant the template identity Managed Identity Operator on each listed identity so Image Builder can attach it to the VM.

Separately, grant the build VM identity only the data access its script needs, such as Storage Blob Data Reader on the artifact container. Permission to attach an identity isn't permission to read the blob, and blob-read permission doesn't authorize identity attachment. Using the same identity for both jobs shares that identity's permissions; it doesn't isolate the jobs. The inline-only recipe doesn't need a build VM identity just to execute inline shell.

When diagnosing a denial, identify the caller, denied action, and scope. Allow time for a new role assignment to take effect before changing it.

:::image type="content" source="../media/3-build-identity-scopes.svg" alt-text="Diagram that shows separate identity permissions for gallery publication, build VM identity attachment, and private blob access.":::

## Check the network path as well as the role

A **staging resource group** holds temporary infrastructure that Image Builder uses during a build. If you supply an existing group, it must be empty when assigned, dedicated to one template, and in the same subscription and region as that template: East US for this build. Record the build subscription separately from any consumer subscription. The template identity needs Contributor on the staging group. Before the first template submission, confirm that the group doesn't already carry the `imageTemplateName` or `imageTemplateResourceGroupName` association tags; let Image Builder establish that association. Replication to West US 2 doesn't change these staging-group requirements.

Treat the staging group as a sensitive build environment, not just temporary infrastructure. It contains copies of customization artifacts, and its resources use privileges delegated through the template identity and any explicitly attached build VM identities. Access that permits changing those resources can affect the image being produced; access to staged artifacts can expose their contents.

Review direct and inherited permissions on the staging resources, including grants from the subscription or management group, and restrict access to the principals needed for the service and authorized administration. A dedicated group doesn't cancel inherited access. Preserve Image Builder's required Contributor and cleanup permissions while protecting the build environment and its retained evidence.

Current Image Builder builds use **Isolated Image Builds**. An ACI resource runs the build tools in your subscription and communicates with the build and validation VMs. The backend Image Builder platform doesn't connect directly to those VMs over a public IP.

Choose the network topology before submitting the template. An existing VNet must be in the build region:

| Subnets supplied to Image Builder | What Image Builder creates or uses |
|---|---|
| Neither subnet | Creates a VNet with separate ACI and build VM subnets. It doesn't create the old direct public-IP connection to the build VM. |
| Only the build VM subnet | Uses that subnet and creates an ACI network with a Private Link/proxy path to the build VM. This option also needs the Private Link service subnet setting and proxy-port allowances described below. |
| Both subnets | Uses the supplied ACI and build VM subnets without the extra proxy path. This gives the team more control over networking. |

For the two-subnet design, use Image Builder API version `2024-02-01` or later. Set `vmProfile.vnetConfig.subnetId` for the build and validation VMs and `containerInstanceSubnetId` for ACI. These must be different subnets in the same VNet. Delegate the ACI subnet to `Microsoft.ContainerInstance/containerGroups`. Don't specify only the ACI subnet or combine a supplied ACI subnet with `proxyVmSize`.

When you supply the ACI subnet, its VNet must also be in the image template's subscription. Image Builder creates the container group in the staging group, and Azure Container Instances requires the container group and its subnet to share a subscription. Because the ACI and build subnets must share one VNet, both supplied subnets follow that placement requirement. The VNet can be in a separate networking resource group in the build subscription.

Granting access to a VNet in another subscription doesn't remove this service restriction. These build prerequisites don't prevent an authorized consumer from using a shared gallery version across subscriptions.

For the ACI subnet you supply, verify the **NAT gateway** configuration required by Azure Container Instances for outbound connectivity from a container group in a VNet. A NAT gateway provides outbound address translation through a public IP. Check its public IP configuration and effective routing with the network owner. This is an outbound path for ACI, not a public IP on the build VM. Keep the existing NSG and destination restrictions; a NAT gateway doesn't override them or fix name resolution.

If you supply only the build VM subnet and omit `containerInstanceSubnetId`, set `privateLinkServiceNetworkPolicies` to `Disabled` on the supplied build subnet. This setting affects Private Link service, not the subnet's **network security group (NSG)**, which filters traffic.

For the build-subnet-only topology, check load-balancer health probes separately from the traffic used to customize the VM. The `AzureLoadBalancer` service tag identifies health probes; allowing that tag doesn't by itself allow the application traffic passing through the load balancer. Have the network owner confirm access on the deployed probe port as well as the application ports.

Private Link service translates the incoming connection's source to its provider-side NAT addresses. Allow those effective source addresses to reach the proxy on TCP 60001 for Linux, or TCP 60000 for Windows. These are Private Link service private addresses, not the public outbound addresses of an Azure NAT gateway. Derive the addresses and effective rules from the deployed configuration rather than assuming the proxy sees the original ACI address.

The proxy then connects to the build or validation VM on Secure Shell (SSH) port 22 for Linux, or Windows Remote Management (WinRM) over HTTPS port 5986 for Windows. Confirm that this second connection is allowed too. Existing rules may already satisfy these requirements; don't remove the NSG or open unrestricted inbound access. These proxy-specific checks don't apply when both subnets are supplied, because that topology connects ACI to the VMs without a proxy.

A successful role assignment doesn't create a route to storage. Trace each download from its caller: template-referenced scripts and files need access from ACI; commands inside a build or validation VM need access from that VM's subnet and the identity the command uses. Successful access from one path doesn't prove the other works.

For template artifacts behind an Azure Storage firewall, use the two-subnet topology and allow the ACI subnet through the storage account's virtual network rule. This public-endpoint subnet-rule path also requires a **Storage service endpoint** on the ACI subnet. Confirm that endpoint even if the network rule already exists: the portal can configure it while adding the rule, but CLI and PowerShell workflows must configure or verify it separately.

Choose the supported endpoint for the storage account locations: `Microsoft.Storage` for the documented regional scope or `Microsoft.Storage.Global` for cross-region access where required. A subnet can have only one of these endpoint types. Don't allow-list assumed Image Builder service IP addresses.

A service endpoint and a private endpoint are different designs; the subnet rule above controls access to the storage account's public endpoint. Where the design uses private endpoints, verify private name resolution and routing from every component that must reach them. Network access doesn't replace blob data permission. Keep private artifacts on encrypted connections and compare their hashes; making a container public isn't a fix for a missing route or role.

Provide the documented ACI outbound connectivity, including HTTPS on port 443 and Azure Files connectivity on port 445. When both subnets are supplied, allow the ACI subnet to reach the build and validation subnet on TCP 22 for Linux SSH, or TCP 5986 for Windows WinRM over HTTPS. For the build-subnet-only option, preserve the probe allowance and both application-traffic connections described above. Scope these flows to the required destinations and approved paths. An NSG allow rule doesn't itself supply internet egress.

Apply the supported NAT gateway outbound configuration to the ACI subnet you supply. Configure explicit outbound connectivity where required for new private subnets, and assess the build and validation VMs' access separately, including package repositories. Don't assume that a working guest-VM route proves that ACI can start or reach its required dependencies.

Before scheduling a build, register the Azure resource providers (services that manage resource types) required by the design, including `Microsoft.VirtualMachineImages`, `Microsoft.ManagedIdentity`, `Microsoft.Compute`, `Microsoft.Storage`, `Microsoft.Network`, `Microsoft.KeyVault`, and `Microsoft.ContainerInstance`. ACI registration is required for Isolated Image Builds. Confirm that policy permits ACI and the temporary network resources and that ACI quota is available, separately from VM-family quota.

Check the effective policies on the staging group separately from the network rules on your artifact account. Image Builder's documented prerequisites include creating a staging storage account without a firewall and using Azure Files. Allowing the ACI subnet to read your firewall-protected artifact account doesn't satisfy those separate staging requirements. Review the resources created by the selected topology and any policies that could deny them or add unintended extensions or tag changes to the build environment.

If a policy conflicts with a documented service requirement, have the authorized policy owner assess the supported configuration and any narrowly scoped exception. Keep the build on hold if the conflict can't be resolved within the organization's requirements; don't silently disable the policy.

For example, Image Builder documents a policy-related failure when its deployment uses a Key Vault with public access disabled. Apply that limitation to the affected service-created deployment, not to every customer vault that a guest script might access. Public network reachability isn't anonymous data access: retain authentication, authorization, encrypted connections, and the existing protections on customer artifacts.

Check **quota**, the subscription's allowance, separately from **capacity**, the hardware Azure can supply in the region. Budget for ACI, build and validation VMs, any topology-dependent proxy VM, disks, networking, and consumer tests. Builds and replication can take hours. Failed builds, stored replicas, and cross-region transfers can still incur charges.

:::image type="content" source="../media/3-image-network-readiness.svg" alt-text="Diagram that shows Image Builder network paths, staging access, storage rules, and policy, provider, quota, and capacity checks.":::
