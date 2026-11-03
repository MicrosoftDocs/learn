The *deployment contract* is the combination of approved design, selected deployment workflow, template version, parameter values, identities, and readiness evidence. It expresses not just what the orchestrator should create, but the assumptions under which that creation is supported.

## Choose the deployment interface and template

The Azure portal guides an operator through supported choices and readiness findings. Azure Resource Manager (ARM) templates make deployment inputs repeatable and reviewable. Resource Manager is Azure's resource-management layer, and resource providers implement operations for specific resource types.

Templates don't bypass product prerequisites. A syntactically valid template can still target an unsupported topology, the wrong nodes, or an identity with insufficient access.

For the AD DS-based hyperconverged workflow in this baseline, use the `create-cluster` template. **Local Identity has a separate template workflow.** For Local Identity with external DNS, select `create-adless-cluster-external-dns-public-preview` and its matching `azuredeploy.parameters.json` file. Don't insert Local Identity values into the AD DS template. ARM deployment is intended for experienced administrators deploying at scale. First complete a system through the Azure portal to establish familiarity with the workflow.

In the Local Identity parameter set, set `identityProvider` to `LocalIdentity` and `dnsServerConfig` to `UseDnsServer`. Supply the DNS server addresses in `dnsServers` and the external DNS zone in `dnsZones`, with an empty `dnsForwarder` array for that zone. Provide the nodes' static addresses, matching non-built-in local administrator credentials, Arc resource IDs, and the tenant-specific Azure Local resource provider service principal object ID in `hciResourceProviderObjectID`. The object ID isn't the application's client ID. Complete the vault, diagnostic storage, networking, and storage parameters before submitting `Validate`, then transition to `Deploy` only after validation succeeds.

This template uses external DNS, not internal-DNS. The `public-preview` text is part of its published name. That text doesn't, by itself, establish the support status of every identity feature or make different DNS workflows interchangeable.

Pin the template repository revision or template-spec version, parameter schema, resource application programming interface (API) versions, and compatible Az.Resources version in the change record. A *template spec* is a versioned Azure resource that stores an ARM template for reuse. A resource API version determines the request schema and operations exposed by its provider. If a parent template references linked templates, include those dependencies in the version review.

> [!WARNING]
> Downloading a mutable "latest" template after approval changes the deployment contract. Compare and approve the new revision instead of assuming that identical parameter filenames mean identical behavior.

## Translate the design into parameter families

Review parameters by their operational effect. A nonempty string can be valid JSON while still naming the wrong Azure Local node or an unavailable DNS server.

The following table groups deployment parameters by what they control and provides a review question for each family.

| Parameter family | What it controls | Review question |
| --- | --- | --- |
| Identity and secrets | Host identity branch, administrator credentials, and vault references | Does each credential match its intended identity and supported workflow? |
| Addresses and DNS | Infrastructure address allocation, resolvers, and system naming | Are the addresses available, correctly routed, and reserved for this purpose? |
| Network intents | Adapter selection and the desired management, compute, or storage configuration | Do adapter names and physical switch settings match the design on every node? |
| Storage | Infrastructure and workload volume creation | Are workload volumes created now or intentionally deferred? |
| Witness | Quorum witness selection and dependent Azure storage | Is this witness supported for the topology and node count? |
| Naming and placement | Cluster name, Arc machine identifiers, Azure region, and resource group | Does this target exactly the approved resources? |
| Manufacturer integration | Extension family, publisher, version, and partner properties | Does the package match the hardware and operating system baseline? |

## Distinguish the network allocations

The **node management addresses** identify the Azure Local nodes. The **infrastructure address pool** supplies addresses for cluster and management infrastructure. A **workload logical network** describes network connectivity for workload virtual machines. These aren't interchangeable allocations.

For the documented static infrastructure allocation, reserve at least six available contiguous IP addresses on the management subnet, excluding addresses already assigned to the nodes. The first infrastructure address is used by failover clustering. Apply any additional requirements for the actual deployment size and type.

An address pool is usable only if the addresses aren't assigned elsewhere, aren't offered to other clients by Dynamic Host Configuration Protocol (DHCP), and have the required subnet, gateway, and routing configuration. DHCP automatically supplies network settings to clients. Exclude reserved infrastructure addresses from its allocation range. Six addresses listed in a spreadsheet aren't six available addresses if two are already node addresses.

DNS also needs to work from the Azure Local nodes and infrastructure services, not only from an administrator's laptop. Verify the configured resolvers, expected records, and forwarding to required external names. Treat DNS settings as design commitments: the current prerequisite guidance restricts post-deployment DNS changes and excludes specific address ranges for DNS servers.

*Network ATC* applies intent-based host networking. An *intent* declares how selected adapters should serve management, compute, or storage traffic, allowing the system to configure and maintain the corresponding host settings. It doesn't configure an incorrectly cabled physical switch.

If the design uses remote direct memory access (RDMA), which permits efficient memory-to-memory network transfer, validate its required adapter, driver, and switch settings end to end. Don't assume that a normal IP ping proves the storage fabric meets its requirements.

Azure Arc gateway reduces the number of outbound endpoints needed for deployment and management. Each node's **Azure Arc Proxy** service forwards supported HTTPS traffic through the gateway's Azure endpoint. HTTP traffic isn't supported by the gateway, and HTTPS traffic to unsupported endpoints still needs a route through the enterprise proxy or firewall. Proxies that terminate Transport Layer Security (TLS) sessions aren't supported.

Enable the gateway during new deployments running Azure Local version 2506 or later. In this baseline, gateway support for Azure Local infrastructure and VMs is generally available, while enabling it on an existing instance and using it with AKS on Azure Local are preview scenarios. If an instance and its workloads share one gateway, that gateway must be in the instance's subscription. A separate workload gateway can be in another subscription within the same tenant.

Gateway use doesn't eliminate direct endpoint access during bootstrap, registration, or operations. The following global-default endpoints still need to be allowed through the enterprise proxy or firewall. HTTPS uses port 443 unless another port is shown. The certificate-revocation endpoints use HTTP on port 80. Replace the region and resource placeholders with the actual deployment values.

| Purpose | Required endpoints outside the gateway tunnel |
| --- | --- |
| Bootstrap | `aka.ms`, `azurestackreleases.download.prss.microsoft.com` |
| Arc registration | `login.microsoftonline.com`, `<region>.login.microsoft.com`, `management.azure.com`, `gbl.his.arc.azure.com`, `<region>.his.arc.azure.com` |
| Gateway connection | `<gateway-id>.gw.arc.azure.com` |
| Vault and cloud witness | `<vault-name>.vault.azure.net`, `<witness-storage-account>.blob.core.windows.net` |
| Certificate revocation | `ocsp.digicert.com`, `s.symcd.com`, `ts-ocsp.ws.symantec.com`, `ocsp.globalsign.com`, `ocsp2.globalsign.com`, `oneocsp.microsoft.com`, `crl.microsoft.com/pkiinfra`, `www.microsoft.com/pkiops` |
| Certain AKS workload extensions, when used | `<region>.obo.arc.azure.com:8084` |

Endpoint mappings can differ by Azure region, and workload services can require additional destinations. Have the network owner reconcile this baseline with the chosen region and workload inventory, and test access from the actual nodes and infrastructure services rather than assuming that a reachable gateway proves all required connectivity.

## Storage configuration and quorum

Storage Spaces Direct combines eligible drives into a *storage pool*. A *virtual disk* uses capacity from that pool with a selected resiliency layout. A *volume* provides a file system, and a *storage path* exposes a supported storage location to Azure Local VM management. These layers explain why raw disks, healthy volumes, and workload-ready storage paths are different acceptance observations.

The template's `configurationMode` controls the documented storage-creation behavior:

- `Express` creates infrastructure storage and workload volumes/storage paths.
- `InfraOnly` creates the required infrastructure storage but leaves workload volumes and storage paths for later creation.
- `KeepStorage` is for the specifically supported preservation workflow. It isn't a general way to preserve arbitrary existing clusters or a substitute for backup.

For the deployment at Contoso, you'd choose to set the storage-creation behavior to `InfraOnly` to create only the storage required by Azure Local itself during platform deployment. The physical disks are already installed in the nodes. You aren't postponing hardware installation. Instead, the platform or storage team creates the workload volumes and storage paths later. The volumes hold VM files and virtual disks, and the storage paths make those locations available to Azure Local VM management. Deployment can therefore succeed without workload volumes or storage paths. Their absence isn't a deployment failure. However, the team must create and verify them before declaring the system ready to host workload VMs.

*Quorum* is the cluster's mechanism for determining which participating members can continue operating safely. It helps prevent separate parts of a partitioned cluster from acting independently. A *witness* contributes to quorum decisions, but it isn't a copy of the workload data.

For the two-node hyperconverged template described here, use the documented `Cloud` witness configuration. A cloud witness uses Azure Storage to support quorum. It doesn't back up the virtual machines. Disk-witness guidance for storage area network (SAN) or other disaggregated deployments doesn't override this hyperconverged requirement. Disaggregated designs separate compute from storage rather than pooling the compute nodes' local drives.

Your plan for the deployment at Contoso is to use a dedicated witness storage account. 

> [!NOTE]
> Check current witness requirements rather than assuming that an account-sharing example applies to every deployment procedure.

## Reference Key Vault secrets in deployment parameters

Use Azure Key Vault references to supply deployment credentials, such as the local administrator password, without writing the secret values into the parameter file. Resource Manager retrieves the referenced secret during an authorized deployment and passes it to the template's secure parameter. Keeping password values out of the file reduces the risk of exposing them during review, sharing, or source control. It also keeps secret storage and access control in Key Vault instead of spreading credential copies across deployment files.

The following valid JSON fragment illustrates a review boundary. It omits required parameters and isn't a deployable parameter pack. Replace angle-bracketed placeholders only when constructing a complete, approved file using the correct template schema.

```json
{
  "parameters": {
    "deploymentMode": { "value": "Validate" },
    "clusterName": { "value": "local-site01" },
    "configurationMode": { "value": "InfraOnly" },
    "witnessType": { "value": "Cloud" },
    "localAdminPassword": {
      "reference": {
        "keyVault": {
          "id": "<approved-vault-resource-id>"
        },
        "secretName": "<approved-secret-name>",
        "secretVersion": "<approved-secret-version>"
      }
    }
  }
}
```

`deploymentMode` selects an Azure Local workflow phase: `Validate` or `Deploy`. It isn't Resource Manager's `Incremental` or `Complete` resource-deployment mode.

The password parameter must be declared as a secure parameter by the template. The `reference` object tells Resource Manager to retrieve an existing Key Vault secret rather than taking plaintext from `value`. `secretVersion` is optional in the ARM reference syntax. This example includes it to make the approved input explicit. Coordinate version pinning with credential rotation so that the selected secret still matches the node account.

On the input-secret vault, set `enabledForTemplateDeployment` to `true`. The deploying identity needs `Microsoft.KeyVault/vaults/deploy/action` on a scope that includes that vault, as well as permission to deploy the target resources. Contributor and Owner include the vault deployment action, but a custom role containing that action can provide narrower access when those broader roles aren't needed. The vault can be in another subscription, but authorization must still cover the vault and the target deployment at their respective scopes.

Resource Manager checks this deployment authorization before retrieving the referenced secret. The operator doesn't need a separate secret access policy solely to pass the secret into the template, and deployment access doesn't grant direct read or write access to secrets. An operator or running service that retrieves a secret directly needs its own data-plane authorization through the vault's configured permission model. This distinction lets you authorize a deployment without granting the human operator general access to secret values.

Don't confuse the vault supplying an input password with every vault or secret store created or used by the deployment. For each secret, document its consumer, access method, rotation owner, and recovery requirements.

Keep credentials out of source control, shell history, screenshots, and transcripts. Resource identifiers, physical addresses, and topology aren't passwords, but they still belong in access-controlled records. Review empty arrays and inherited defaults explicitly. An empty intent array isn't a substitute for a reviewed networking design.

> [!NOTE]
> **Contract decision:** Approve a complete, versioned parameter set with explained defaults and secret references. Record intentional outcomes, such as deferred workload volumes, so that acceptance doesn't misclassify them as failures.
