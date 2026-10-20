Host-based encryption encrypts data at rest on the hosts running your AKS agent node VMs. The data stays encrypted as it moves to Azure Storage. Temporary disks use platform-managed keys for encryption at rest. OS and data disk caches use platform-managed or customer-managed keys for encryption at rest. The key type depends on each disk's encryption settings.

By default, AKS uses server-side encryption and platform-managed keys to encrypt OS and data disks. The caches for these disks are encrypted at rest with platform-managed keys. You can specify your own managed keys using *bring your own keys* (BYOK) with Azure disks in Azure Kubernetes Service. The caches for these disks are also encrypted using the key you specify.

Azure Storage uses server-side encryption (SSE). Host-based encryption works differently. Azure-managed disks use Azure Storage to automatically encrypt data at rest when saving data. Host-based encryption uses the host of the VM to handle encryption before the data flows through Azure Storage.

### Limitations

- Enable host-based encryption only when you create a cluster or node pool.
- This feature can only be enabled in Azure regions that support server-side encryption of Azure managed disks and only with specific [supported VM sizes](/azure/virtual-machines/disk-encryption#supported-vm-sizes).
- This feature requires an AKS cluster and node pool based on Virtual Machine Scale Sets as *VM set type*.

### Register encryption at host

Use a current Azure CLI, sign in, and select the subscription that contains or will contain your AKS cluster. The examples require an existing resource group. The existing-cluster example also requires an existing AKS cluster. Registration alone doesn't satisfy the requirements in the [Limitations](#limitations) section.

Before using either example, ensure that the `Microsoft.Compute/EncryptionAtHost` feature is [registered for that subscription](/azure/aks/enable-host-encryption#enable-encryption-at-host-for-your-aks-cluster). If registration is needed, run:

```azurecli
az feature register --namespace Microsoft.Compute --name EncryptionAtHost
```

Check the feature's registration state:

```azurecli
az feature show --namespace Microsoft.Compute --name EncryptionAtHost --query "properties.state" --output tsv
```

Repeat the state check until it returns `Registered`. The `show` command only shows the current state. It doesn't wait for registration to finish.

After the feature is registered, refresh the resource-provider registration and wait for completion:

```azurecli
az provider register --namespace Microsoft.Compute --wait
```

The [`--wait` option](/cli/azure/provider#az-provider-register) is a conservative choice for this walkthrough, not a general requirement for provider registration to finish in every region. The `EncryptionAtHost` feature-state check remains a separate prerequisite.

> [!NOTE]
> Feature and provider registration require suitable permissions in the subscription. If you can't complete registration, ask an administrator to do so before continuing. Skip feature registration only if `EncryptionAtHost` is already `Registered`. After newly registering the feature, refresh `Microsoft.Compute` even if that provider was already registered. You don't need to repeat these steps if feature registration and the subsequent provider refresh are both complete for this subscription.

Use the following Azure CLI examples to enable host-based encryption on new and existing clusters.

### Use host-based encryption on new clusters

 -  Create a new cluster and configure the cluster agent nodes to use host-based encryption by using the `--enable-encryption-at-host` flag.
    
    ```azurecli
    az aks create --name myAKSCluster --resource-group myResourceGroup -s Standard_D4ds_v5 -l westus2 --enable-encryption-at-host --generate-ssh-keys
    ```

    > [!NOTE]
    > The initial node pool is a system node pool. For this example, choose an AKS-supported system-pool size with at least four vCPUs and 4 GB of memory, following the [system-node-pool guidance](/azure/aks/use-system-pools#system-and-user-node-pools). `Standard_D4ds_v5` has four vCPUs and 16 GiB of memory.
    >
    > Check the [AKS VM-size restrictions and regional availability](/azure/aks/quotas-skus-regions). Separately, confirm that you have enough [regional and VM-family vCPU quota](/azure/virtual-machines/quotas). Also verify that the selected size's `EncryptionAtHostSupported` capability is `True`, as described in [Finding supported VM sizes](/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli#finding-supported-vm-sizes). If necessary, select another AKS-supported system-pool size that meets the sizing and encryption requirements and update `-s`. SKU availability and sufficient quota don't guarantee real-time allocation capacity.
    >
    > `--generate-ssh-keys` generates SSH public and private key files if they're missing. To use an existing public key stored elsewhere, replace this flag with `--ssh-key-value "<path-to-public-key-file>"`, substituting the path to your public key file.

### Use host-based encryption on existing clusters

Adding an encrypted node pool affects only the new pool; it doesn't retroactively encrypt existing node pools.

 -  Enable host-based encryption on an existing cluster by adding a new node pool using the `--enable-encryption-at-host` flag.
    
    ```azurecli
    az aks nodepool add --name hostencrypt --cluster-name myAKSCluster --resource-group myResourceGroup -s Standard_DS2_v2 --enable-encryption-at-host
    ```
