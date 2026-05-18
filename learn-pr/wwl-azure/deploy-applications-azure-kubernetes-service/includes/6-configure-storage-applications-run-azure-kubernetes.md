In this exercise, you step through the process of configuring a persistent volume for a pod on an Azure Kubernetes Service (AKS) cluster. You use the AKS cluster provisioned in the first exercise of this module.

> [!NOTE]
> To complete this exercise, you need an [Azure Subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

### Create a custom StorageClass in an AKS cluster

In this task, you create a custom StorageClass in the target AKS cluster.

1. From the Azure portal, open a Bash session in Azure Cloud Shell. To make sure that the AKS cluster name and credentials are available in the current session (Cloud Shell variables don't persist between sessions), run the following commands:

    ```azurecli
    AKSRG='aks-01-RG'
    AKSNAME='aks-01'
    az aks get-credentials --resource-group $AKSRG --name $AKSNAME --overwrite-existing
    ```

1. In the Azure portal, in the Bash session of Azure Cloud Shell, use the built-in editor to create a file named *premium-storage-class.yaml* and copy into it the following YAML manifest:

    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: managed-premium-retain
    provisioner: disk.csi.azure.com
    parameters:
      skuName: Premium_LRS
    reclaimPolicy: Retain
    volumeBindingMode: WaitForFirstConsumer
    allowVolumeExpansion: true
    ```

    > [!NOTE]
    > The `provisioner` is set to **disk.csi.azure.com**, the Azure Disk CSI driver included with modern AKS clusters. The `skuName` value uses Premium SSD locally redundant storage (LRS). The `reclaimPolicy` is set to **Retain**, so the underlying Azure Disk isn't deleted automatically when the PersistentVolumeClaim is deleted.

1. Save the changes to the file and close it to return to the Bash prompt.
1. To create the custom StorageClass, from the Bash session in the Azure Cloud Shell, run the following command:

    ```bash
    kubectl apply -f premium-storage-class.yaml
    ```

### Create a PersistentVolumeClaim in an AKS cluster

In this task, you create a PersistentVolumeClaim in the target AKS cluster.

1. From the Bash session in the Azure Cloud Shell, use the built-in editor to create a file named *persistent-volume-claim-5g.yaml* and copy into it the following YAML manifest:

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: azure-managed-disk
    spec:
      accessModes:
      - ReadWriteOnce
      storageClassName: managed-premium-retain
      resources:
        requests:
          storage: 5Gi
    ```

    > [!NOTE]
    > The `storageClassName` is set to **managed-premium-retain**.
1. Save the changes to the file and close it to return to the Bash prompt.
1. To create the PersistentVolumeClaim, from the Bash session in the Azure Cloud Shell, run the following command:

    ```bash
    kubectl apply -f persistent-volume-claim-5g.yaml
    ```

### Deploy a pod with a persistent volume mount in an AKS cluster

In this task, you deploy a pod with a persistent volume mount in the target AKS cluster.

1. From the Bash session in the Azure Cloud Shell, use the built-in editor to create a file named *pod-with-storage-mount.yaml* and copy into it the following YAML manifest:

    ```yaml
    kind: Pod
    apiVersion: v1
    metadata:
      name: nginx
    spec:
      containers:
        - name: myfrontend
          image: mcr.microsoft.com/azurelinux/base/nginx:1.28
          volumeMounts:
          - mountPath: "/mnt/azure"
            name: volume
      volumes:
        - name: volume
          persistentVolumeClaim:
            claimName: azure-managed-disk
    ```

    > [!NOTE]
    > The `mountPath` is set to **/mnt/azure** and `claimName` is set to **azure-managed-disk**.

1. Save the changes to the file and close it to return to the Bash prompt.
1. To deploy the pod, from the Bash session in the Azure Cloud Shell, run the following command:

    ```bash
    kubectl apply -f pod-with-storage-mount.yaml
    ```

### Validate the effect of the volume mount

In this task, you validate that the volume mount was successful.

1. To verify that the nginx pod was provisioned and wait until it's ready, from the Bash session in the Azure Cloud Shell, run the following commands:

    ```bash
    kubectl get pods
    kubectl wait --for=condition=Ready pod/nginx --timeout=120s
    ```

1. To write a test file to the **/mnt/azure** directory and confirm it exists, run the following commands:

    ```bash
    kubectl exec -i nginx -- sh -c "echo 'persistent-volume-test' > /mnt/azure/test.txt"
    kubectl exec -i nginx -- sh -c "ls /mnt/azure"
    ```

1. To delete the nginx pod, run the following command:

    ```bash
    kubectl delete pod nginx
    ```

1. Now, re-create the nginx pod and wait until it's ready by running the following commands:

    ```bash
    kubectl apply -f pod-with-storage-mount.yaml
    kubectl wait --for=condition=Ready pod/nginx --timeout=120s
    ```

1. Finally, verify that the test file persisted on the underlying Azure Disk by running the following commands:

    ```bash
    kubectl exec -i nginx -- sh -c "ls /mnt/azure"
    kubectl exec -i nginx -- sh -c "cat /mnt/azure/test.txt"
    ```

### Delete the resources provisioned in the exercise

In this task, you delete the resources you provisioned in this exercise.

1. To delete the nginx pod, record the PersistentVolume and managed disk created for the claim, and then delete the PersistentVolumeClaim and retained PersistentVolume, from the Bash session in the Azure Cloud Shell, run the following commands:

    ```bash
    kubectl delete pod nginx
    kubectl wait --for=delete pod/nginx --timeout=120s
    PV_NAME=$(kubectl get pvc azure-managed-disk -o jsonpath='{.spec.volumeName}')
    DISK_ID=$(kubectl get pv $PV_NAME -o jsonpath='{.spec.csi.volumeHandle}')
    kubectl get pvc
    kubectl delete pvc azure-managed-disk
    kubectl delete pv $PV_NAME
    ```

    To wait for the retained Azure Disk to detach and then delete it, run the following commands:

    ```azurecli
    az disk wait --ids "$DISK_ID" --custom "managedBy==null" --timeout 600
    az disk delete --ids "$DISK_ID" --yes
    ```

    > [!NOTE]
    > Because the StorageClass uses the **Retain** reclaim policy, deleting the PersistentVolumeClaim doesn't delete the PersistentVolume or the underlying Azure Disk. Deleting the PersistentVolume object also doesn't delete the external Azure Disk — only `az disk delete` does that. To keep the disk for later manual recovery, skip only `az disk delete`; you can keep or delete the PV object independently based on your recovery plan.

1. To list and delete the StorageClass, run the following commands:

    ```bash
    kubectl get sc
    kubectl delete sc managed-premium-retain
    ```

    > [!NOTE]
    > This keeps the AKS cluster because you use it in the next exercise.
