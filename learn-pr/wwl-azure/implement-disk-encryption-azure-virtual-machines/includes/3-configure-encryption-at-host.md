Encryption at host addresses the specific gap in Contoso Manufacturing's environment: unencrypted temporary disks and caches. Configuring this protection involves enabling a VM-level property and, for compliance scenarios requiring organizational key control, creating a Disk Encryption Set linked to Azure Key Vault.

## What encryption at host protects

Server-side encryption (SSE) encrypts managed disks at the storage layer but leaves two critical data paths unprotected. Temporary disks (the D: drive on Windows VMs or /dev/sdb1 on Linux) use local SSD storage attached directly to the physical host. Applications frequently write cache files, page files, or temp databases to these high-speed volumes. Disk caches buffer I/O operations between VMs and persistent storage, accelerating read and write performance. Temp disks and caches don't undergo encryption in a standard SSE-only configuration.

With encryption at host enabled, Azure encrypts data at the compute host level before it reaches any storage medium. This protection covers:

- All managed disk I/O (OS and data disks)
- Temporary disk writes and reads
- Disk controller read and write caches
- Data in transit between the VM and storage subsystem

For Contoso's factory management systems, this means PLC configuration files temporarily staged to local storage and supply chain data cached during high-volume batch operations receive the same encryption protection as data persisted to managed disks.

## Platform-managed keys versus customer-managed keys

Encryption at host supports two key management approaches. Platform-managed keys (PMK) use encryption keys that Microsoft generates, stores, and rotates automatically. This approach requires no configuration beyond enabling encryption at host and provides immediate protection with zero administrative overhead.

Customer-managed keys (CMK) give your organization control over the encryption key lifecycle. You generate and store keys in Azure Key Vault or Azure Key Vault Managed HSM. Then you define rotation policies, set expiration dates, and maintain audit logs of every key access operation. Compliance frameworks like ISO 27001, PCI DSS, and FedRAMP often require documented evidence of organizational key control, making CMK essential for regulated workloads.

Contoso Manufacturing needs CMK to demonstrate key management governance during annual compliance audits. Their security policy requires encryption key rotation every 90 days with automated processes to prevent human error.

## Create a Disk Encryption Set

A Disk Encryption Set acts as the bridge between your encrypted VMs and Azure Key Vault. It references a specific key version, manages the system-assigned managed identity used for key access, and applies to all disks on VMs configured to use it.

To create a Disk Encryption Set through the Azure portal:

1. Navigate to **Disk Encryption Sets** and select **Create**
2. Choose the subscription and resource group (use the same region as your VMs)
3. Provide a name like `contoso-mfg-des-eastus2`
4. Select **Encryption type**: Choose "Encryption at rest with a customer-managed key"
5. Under **Key Vault**, select an existing vault or create a new one
6. Select or create an encryption key (RSA 2048-bit minimum)
7. Enable **Auto-key rotation** if your compliance policy requires automatic rotation
8. Review and create

After deployment completes, grant the Disk Encryption Set's managed identity access to your Key Vault:

```azurecli
# Get the Disk Encryption Set identity
desIdentity=$(az disk-encryption-set show \
  --name contoso-mfg-des-eastus2 \
  --resource-group contoso-security-rg \
  --query [identity.principalId] \
  --output tsv)

# Grant key permissions
az keyvault set-policy \
  --name contoso-mfg-vault \
  --resource-group contoso-security-rg \
  --object-id $desIdentity \
  --key-permissions wrapKey unwrapKey get
```

The Disk Encryption Set now has permission to retrieve and use your customer-managed key for encryption operations.

## Enable encryption at host on new VMs

When creating a new virtual machine through the Azure portal, enable encryption at host in the **Disks** configuration section:

1. After selecting VM size and image, navigate to the **Disks** tab
2. Check **Enable encryption at host**
3. Under **Key management**, select **Customer-managed keys**
4. Choose your Disk Encryption Set from the dropdown
5. Complete VM creation

When using Azure CLI, include the `--encryption-at-host` parameter and reference your Disk Encryption Set:

```azurecli
az vm create \
  --resource-group contoso-mfg-rg \
  --name plc-mgmt-vm-01 \
  --image Ubuntu2204 \
  --size Standard_D4s_v5 \
  --encryption-at-host true \
  --os-disk-encryption-set /subscriptions/{subscription-id}/resourceGroups/contoso-security-rg/providers/Microsoft.Compute/diskEncryptionSets/contoso-mfg-des-eastus2 \
  --admin-username azureuser \
  --generate-ssh-keys
```

The VM deploys with end-to-end encryption active from first boot.

## Enable encryption at host on existing VMs

Existing VMs require a stop/start cycle to enable encryption at host. The VM must be fully deallocated (stopped), not just shut down from within the guest OS.

Through Azure portal:

1. Navigate to the VM and select **Stop** (wait for full deallocation)
2. Go to **Disks** > **Additional settings**
3. Enable **Encryption at host**
4. Select your Disk Encryption Set under **Key management**
5. Save changes and start the VM

Using Azure CLI:

```azurecli
# Stop and deallocate the VM
az vm deallocate \
  --resource-group contoso-mfg-rg \
  --name legacy-factory-vm-03

# Enable encryption at host
az vm update \
  --resource-group contoso-mfg-rg \
  --name legacy-factory-vm-03 \
  --set securityProfile.encryptionAtHost=true

# Update OS disk to use customer-managed key
az vm update \
  --resource-group contoso-mfg-rg \
  --name legacy-factory-vm-03 \
  --set storageProfile.osDisk.managedDisk.diskEncryptionSet.id=/subscriptions/{subscription-id}/resourceGroups/contoso-security-rg/providers/Microsoft.Compute/diskEncryptionSets/contoso-mfg-des-eastus2

# Start the VM
az vm start \
  --resource-group contoso-mfg-rg \
  --name legacy-factory-vm-03
```

For Contoso's production environment, schedule this maintenance during planned outage windows to minimize challenges on manufacturing operations.

## Enforce encryption at host with Azure Policy

Rather than manually configuring each VM, use Azure Policy to automatically enable encryption at host on all new deployments. The built-in policy definition **Virtual machines should enable encryption at host** operates in DeployIfNotExists (DINE) mode.

Assign this policy at subscription scope:

1. Navigate to **Azure Policy** > **Assignments**
2. Select **Assign policy**
3. Search for "Virtual machines should enable encryption at host"
4. Set **Effect** to **DeployIfNotExists**
5. Optionally exclude specific resource groups (for example, test environments)
6. Create a remediation task to fix existing noncompliant VMs

The policy automatically enables encryption at host when new VMs deploy, ensuring Contoso maintains compliance as the environment grows without requiring manual verification of each deployment.

## Verify encryption is active

After enabling encryption at host, verify protection is active by checking the VM's security profile:

```azurecli
az vm show \
  --resource-group contoso-mfg-rg \
  --name plc-mgmt-vm-01 \
  --query securityProfile.encryptionAtHost
```

A `true` response confirms encryption at host is enabled. For disk-level verification, check the encryption settings on the OS disk:

```azurecli
az disk show \
  --resource-group contoso-mfg-rg \
  --name plc-mgmt-vm-01_OsDisk \
  --query [encryption.type,encryption.diskEncryptionSetId] \
  --output table
```

The output displays `EncryptionAtRestWithCustomerKey` and the Disk Encryption Set resource ID, confirming customer-managed key protection.

When encryption at host is configured, Contoso's VMs now encrypt temporary disks and caches alongside persistent storage, closing the compliance gap identified in their ISO 27001 audit. For workloads requiring hardware-level isolation, you next explore confidential disk encryption for confidential virtual machines.
