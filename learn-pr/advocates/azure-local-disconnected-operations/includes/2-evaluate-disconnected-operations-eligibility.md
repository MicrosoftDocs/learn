Disconnected operations for Azure Local has its own eligibility, hardware, and commercial requirements. 

## Eligibility for disconnected operations

Eligibility for disconnected operations depends on both why your organization needs to run without Azure connectivity and whether it can meet the service's commercial, support, and operational requirements. Access requires approval based on a valid business need, such as regulatory restrictions or connectivity limitations. Owning Azure Local hardware doesn't automatically qualify an organization to use disconnected operations. For Contoso, the starting point is to document the facility's isolation requirements and explain why a connected deployment can't satisfy them.

The documented eligibility criteria include an eligible Microsoft agreement, a valid need to operate disconnected, an active Standard-or-higher Microsoft support plan or an eligible partner arrangement, and staff or a partner able to deploy and operate the environment. The Microsoft online subscription program isn't eligible.

Work with the account team to confirm eligibility and access. Identify the workloads, isolation requirement, operational owner, and support route before selecting equipment. For an isolated site, a support contract is useful only if staff can also open a case and transfer approved diagnostics when necessary.

Hardware must meet the disconnected capability requirements in the Azure Local catalog. The overview specifies Premier Solutions. Check the selected solution's capability details, including whether the particular configuration is validated for the management-cluster role.

## Separate management from tenant workloads

Production requires a dedicated three-node Azure Local management cluster. It hosts the disconnected control plane and its supporting management components. Deploy tenant VMs and applications on separate Azure Local workload clusters.

This separation prevents workload demand from consuming the capacity needed to manage the environment. It also improves resilience by reducing the impact of workload-cluster maintenance and failures on management services. A workload cluster might have spare memory while the management cluster has failed. That spare memory doesn't automatically make the portal or resource providers available.

The documented production configurations provide a starting point for hardware discussions.

| Management-cluster specification | Standard configuration | Datacenter configuration |
| --- | --- | --- |
| Minimum node count | 3 | 3 |
| Memory per node | 128 GB | 512 GB |
| Physical cores per node | 24 | 24 |
| Data storage per node | 6 SSD or NVMe drives, each at least 2 TB | 8 SSD or NVMe drives, each at least 2 TB |
| Listed boot-drive capacity | 960 GB SSD or NVMe | 960 GB SSD or NVMe |

Plan usable capacity after resiliency overhead, and preserve room for updates, temporary files, growth, and node repair. Capacity that's available only when every node is healthy isn't sufficient maintenance headroom.

> [!NOTE]
> A one-node management proof of concept can demonstrate features, but it doesn't establish production resilience or support. Contoso should test the intended production topology if the goal is to demonstrate production readiness.

## Distinguish commercial registration from local resource management

Microsoft grants access to disconnected operations through a qualification review. Before applying, work with your Microsoft account team to confirm an eligible agreement and review the product terms. Your organization must justify why it needs to operate disconnected, for example because of sovereignty requirements, a remote site without regular internet access, or restrictions on sending data to the cloud. It must also meet the access, identity, hardware, and networking prerequisites, use supported Azure Local Premier Solutions, and confirm that the available billing and support regions meet its requirements.

You or your account team submits the qualification application to Microsoft. Prepare your organization's contact details and website, a work email address, the Azure subscription ID, agreement type, Microsoft contact, business justification, experience with Azure Local or Azure Stack Hub, and support-plan details. Applications using personal email addresses aren't accepted.

Microsoft documents a response window of 10 business days. The status can be approved, rejected, queued, or a request for more information, so a response doesn't necessarily mean approval. If approved, Microsoft provides documentation and instructions for accessing the service.

After your Azure subscription is approved for disconnected operations, create a disconnected-operations resource in the Azure portal to represent your on-premises appliance. Select the pricing model and the number of physical cores you plan to manage, then download the licensing manifest and appliance installation files. Creating this Azure resource doesn't deploy the local management cluster.

The paid capacity option uses an annual commitment for the total managed Azure Local physical cores, paid monthly. Billing begins after creating that commercial appliance resource, not only after completing the local deployment. Trial terms differ. Confirm expansion, guest operating-system licensing, and retirement obligations instead of importing assumptions from connected Azure Local billing or Azure benefits.

After deployment, the documented self-attestation flow submits hardware and deployment information from an internet-connected administrative machine. Information includes the managed core count, node count, hardware details, deployment version, and device identity.

This exchange is different from managing a VM in a local subscription. A *local subscription* is a scope for organizing resources and assigning access inside the disconnected environment. It isn't an arbitrary public Azure subscription that an administrator has made offline.

> [!NOTE]
> Keep the connected commercial administrator's role separate from the local operator's role. Record which information can leave the facility, who approves the self-attestation, and which machine performs it. Don't connect the production management cluster merely to perform an administrative task that has a documented external-machine flow.

Complete the procurement checks before you acquire the service. Access requires approval through the qualification process, which you or your account team can initiate. In the Azure Local catalog, select **Disconnected operations** under **Solution capability**, then confirm that the chosen configuration supports the management-cluster role. For production, use the dedicated three-node design described earlier rather than treating a one-node evaluation configuration as a production option.

After deploying the management cluster, perform self-attestation from an internet-connected administrative machine with Azure CLI and Azure PowerShell installed. Identify the commercial resource by its cloud, subscription ID, resource group, and resource name. Submit total managed cores and nodes, management-cluster disk capacity and memory, OEM and hardware SKU, deployment version, Solution Builder Extension version, and device ID. You can obtain the device ID by running `Get-ApplianceInstanceConfiguration` in the deployed environment. Successful registration populates the commercial resource's hardware properties and removes its registration banner in the Azure portal. It doesn't require connecting the management cluster to Azure.
