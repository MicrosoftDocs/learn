Confidential virtual machines provide hardware-enforced isolation for workloads processing highly sensitive data. When you enable confidential disk encryption on these VMs, the OS disk encryption key binds to the virtual machine's Trusted Platform Module (vTPM), creating protection that prevents disk access even by privileged administrators with physical hardware access.

## What makes a VM confidential

Azure confidential VMs run on DCasv5-series and ECasv5-series hardware with AMD EPYC processors supporting Secure Encrypted Virtualization-Secure Nested Paging (SEV-SNP). This technology encrypts VM memory at the hardware level using a key inaccessible to the hypervisor, Azure operators, or other VMs on the same physical host.

Unlike standard VMs where Azure operators can theoretically access memory during maintenance operations, confidential VMs maintain cryptographic isolation enforced by the CPU. The processor generates attestation reports proving the VM runs in a protected environment without tampering or unauthorized access. For Contoso Manufacturing, this protection matters for systems processing trade secrets, proprietary chemical formulas, or intellectual property subject to industrial espionage concerns.

## Security types in Azure

When creating a virtual machine, you select a security type that determines available protection features:

| Security type | Boot integrity | Memory encryption | Disk encryption options |
|---------------|----------------|-------------------|------------------------|
| Standard | None | None | SSE, Encryption at host, ADE |
| Trusted launch | Secure Boot, vTPM, integrity monitoring | None | SSE, Encryption at host, ADE |
| Confidential | Secure Boot, vTPM required | Hardware-enforced (SEV-SNP) | Confidential disk encryption, Encryption at host |

Confidential VM is a distinct security type that you must select at VM creation. You can't convert a Standard or Trusted launch VM to a Confidential VM after deployment. This restriction exists because confidential computing requires specific CPU features and firmware configurations initialized during VM provisioning.

## How confidential disk encryption works

Confidential disk encryption binds the OS disk encryption key to the VM's vTPM. The vTPM is a virtualized Trusted Platform Module that stores cryptographic keys in a hardware-protected environment isolated from the guest operating system and Azure management plane.

When the VM boots, the vTPM releases the disk encryption key only after verifying the boot chain integrity. If an attacker modifies boot components, copies the disk to another VM, or attempts offline access to the encrypted volume, decryption fails because the vTPM key binding validation fails.

This protection differs fundamentally from encryption at host. Encryption at host encrypts data flows between the VM and storage but uses keys accessible to the Azure storage platform. Confidential disk encryption uses keys that only the specific VM instance can access, providing defense against disk theft scenarios including unauthorized copies by privileged insiders or government agencies with legal access to datacenter infrastructure.

## Supported disk types and configuration

Confidential disk encryption applies specifically to the OS disk on confidential VMs. Azure supports several OS disk encryption configurations:

**Confidential OS disk encryption**: The OS disk uses a vTPM-bound key. This provides the strongest protection but limits some platform features like disk snapshots and some backup solutions that require offline disk access.

**Confidential OS disk encryption with customer-managed key**: The vTPM-bound key is itself encrypted with a customer-managed key stored in Azure Key Vault. This configuration gives you organizational control over the root key while maintaining vTPM binding for the active encryption key.

For data disks attached to confidential VMs, use encryption at host. Confidential disk encryption doesn't extend to data disks, but encryption at host on a confidential VM provides comprehensive protection: hardware memory encryption (SEV-SNP) + vTPM-bound OS disk + encrypted data disks and temp storage.

## Create a confidential VM with confidential disk encryption

Through the Azure portal, confidential disk encryption configuration starts with security type selection:

1. Navigate to **Virtual machines** > **Create**
2. Select a supported region and a DCasv5 or ECasv5 VM size
3. In the **Basics** tab, under **Security type**, select **Confidential virtual machines**
4. Navigate to the **Disks** tab
5. Under **OS disk**, choose **Confidential disk encryption**
6. Optionally enable **Encryption at host** for data disks and temp storage
7. Select **Customer-managed keys** if organizational key control is required
8. Choose a Disk Encryption Set linked to your Key Vault
9. Complete VM creation

Using Azure CLI, specify security type and OS disk configuration explicitly:

```azurecli
az vm create \
  --resource-group contoso-research-rg \
  --name formula-vault-vm-01 \
  --image Ubuntu2204 \
  --size Standard_DC4as_v5 \
  --security-type ConfidentialVM \
  --os-disk-security-encryption-type DiskWithVMGuestState \
  --enable-vtpm true \
  --enable-secure-boot true \
  --encryption-at-host true \
  --admin-username azureuser \
  --generate-ssh-keys
```

The `DiskWithVMGuestState` value encrypts the OS disk along with the VM Guest State blob (vTPM and UEFI state), providing full confidential OS disk encryption with vTPM binding. Use `VMGuestStateOnly` only when you want a confidential VM without OS disk confidential encryption—it protects only the VM Guest State blob and leaves the OS disk using standard server-side encryption. Combine `DiskWithVMGuestState` with `--encryption-at-host` to protect both the OS disk (confidential encryption) and data disks and temp storage (encryption at host) comprehensively.

## Key management for confidential disk encryption

When using customer-managed keys with confidential disk encryption, create a Disk Encryption Set configured for confidential VM use:

```azurecli
# Create a Disk Encryption Set for confidential VMs
az disk-encryption-set create \
  --resource-group contoso-security-rg \
  --name contoso-confidential-des \
  --location eastus2 \
  --encryption-type ConfidentialVmEncryptedWithCustomerKey \
  --key-url https://contoso-mfg-vault.vault.azure.net/keys/confidential-vm-key/abc123 \
  --source-vault /subscriptions/{subscription-id}/resourceGroups/contoso-security-rg/providers/Microsoft.KeyVault/vaults/contoso-mfg-vault
```

The `ConfidentialVmEncryptedWithCustomerKey` encryption type indicates this Disk Encryption Set applies to confidential VM OS disks with CMK. After creation, grant the Disk Encryption Set managed identity appropriate Key Vault permissions (Get, WrapKey, UnwrapKey) as described in the previous unit.

## Limitations and considerations

Confidential VMs with confidential disk encryption have specific operational constraints:

**No disk snapshots**: Because the encryption key binds to the vTPM, you can't create snapshots of confidential OS disks using standard Azure snapshot tools. Plan backup strategies using application-level backups or Azure Backup solutions that support confidential VMs.

**No cross-VM disk movement**: You can't detach a confidential OS disk from one VM and attach it to another. The vTPM binding ensures only the original VM can decrypt the disk.

**Regional availability**: Confidential VMs require specific hardware. Verify your target Azure region supports DCasv5 or ECasv5 series before planning deployments.

**Size selection**: Confidential VM sizes typically cost more than equivalent standard sizes due to specialized hardware. Balance security requirements against budget constraints.

For Contoso Manufacturing, these limitations require careful workload selection. Systems processing proprietary formulas justify confidential VM costs and operational constraints, while general factory management systems use standard encryption at host.

## When to use confidential disk encryption

Choose confidential disk encryption when your workload requires:

**Regulatory protection against privileged access**: Compliance frameworks like ITAR (International Traffic in Arms Regulations) or specific healthcare regulations can require technical controls preventing cloud provider access to sensitive data.

**Defense against physical theft**: Industries with extremely high-value intellectual property (pharmaceutical research, defense applications, financial algorithms) benefit from hardware-enforced protection that remains effective even if encrypted disks fall into adversary possession.

**Attestation requirements**: Applications needing cryptographic proof that they run in an uncompromised environment use the attestation capabilities built into confidential VMs.

**Zero Trust architecture**: Organizations implementing Zero Trust principles apply confidential VMs to protect high-value assets from both external attackers and insider threats, reducing the trusted perimeter to only the workload itself.

For Contoso's factory systems processing publicly known manufacturing processes, encryption at host provides adequate protection. Confidential disk encryption applies to any future Azure workloads handling research data for proprietary chemical compounds or next-generation product formulas.

Now that confidential disk encryption is configured, your most sensitive workloads benefit from hardware-enforced isolation.
