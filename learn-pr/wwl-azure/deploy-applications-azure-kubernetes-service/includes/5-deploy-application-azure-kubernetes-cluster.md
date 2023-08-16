In this exercise, you step through the process of configuring a persistent volume for a pod on an AKS cluster. You use the AKS cluster provisioned in the first exercise of this module.

> [!NOTE]
> To complete this exercise, you need an [Azure Subscription](https://azure.microsoft.com/free/).

### Create a custom storage class in an AKS cluster

In this task, you create a custom storage class in the target AKS cluster.

1.  In the Azure portal, in the Bash session of Azure Cloud Shell, use the built-in editor to create a file named *premium-storage-class.yaml* and copy into it the following YAML manifest:
    
    <!--- raw content start --->
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: managed-premium-retain
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_LRS
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion:
<!--- raw content end --->
    
    > [!NOTE]
    > The `reclaimPolicy` is set to **Retain**.
2.  Save the changes to the file and close it to return to the Bash prompt.
3.  To create the custom storage class, from the Bash session in the Azure Cloud Shell, run the following command:
    
    ```azurecli
    kubectl apply -f premium-storage-class.yaml
    ```

### Create a persistent volume claim in an AKS cluster

In this task, you create a persistent volume claim in the target AKS cluster.

1.  From the Bash session in the Azure Cloud Shell, use the built-in editor to create a file named *persistent-volume-claim-5g.yaml* and copy into it the following YAML manifest:
    
    <!--- raw content start --->
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
<!--- raw content end --->
    
    > [!NOTE]
    > The `storageClassName` is set to **managed-premium-retain**.
2.  Save the changes to the file and close it to return to the Bash prompt.
3.  To create the persistent volume claim, from the Bash session in the Azure Cloud Shell, run the following command:
    
    ```azurecli
    kubectl apply -f persistent-volume-claim-5g.yaml
    ```

### Deploy a pod with a persistent volume mount in an AKS cluster

In this task, you deploy a pod with a persistent volume mount in the target AKS cluster.

1.  From the Bash session in the Azure Cloud Shell, use the built-in editor to create a file named *pod-with-storage-mount.yaml* and copy into it into the following YAML manifest:
    
    <!--- raw content start --->
kind: Pod
apiVersion: v1
metadata:
  name: nginx
spec:
  containers:
    - name: myfrontend
      image: mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
      volumeMounts:
      - mountPath: "/mnt/azure"
        name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: azure-managed-disk
<!--- raw content end --->
    
    > [!NOTE]
    > The `mountPath`is set to **/mnt/azure** and `claimName`is set to **azure-managed-disk**.

2.  Save the changes to the file and close it to return to the Bash prompt.
3.  To deploy the pod, from the Bash session in the Azure Cloud Shell, run the following command:
    
    ```azurecli
    kubectl apply -f pod-with-storage-mount.yaml
    ```

### Validate the effect of the volume mount

In this task, you validate that the volume mount was successful.

1.  To verify that the nginx pod was provisioned, from the Bash session in the Azure Cloud Shell, run the following command:
    
    ```azurecli
    kubectl get pods
    ```

2.  To list the content of the **/mnt/azure** directory, run the following command:
    
    ```azurecli
    kubectl exec -i nginx -- sh -c "ls /mnt/azure"
    ```

3.  To create a file named *hello* containing a single line of text '*Hello world*', run the following command:
    
    ```azurecli
    kubectl exec -i nginx -- sh -c "echo 'Hello world' > /mnt/azure/hello"
    ```

4.  To list the content of the /mnt/azure directory (this time including the newly created *hello* file, run the following command:
    
    ```azurecli
    kubectl exec -i nginx -- sh -c "echo 'Hello world' > /mnt/azure/hello"
    ```

5.  To list the content of the /mnt/azure directory (this time including the newly created *hello* file, run the following command:
    
    ```azurecli
    kubectl exec -i nginx -- sh -c "ls /mnt/azure"
    ```

6.  To delete the nginx pod, run the following command:
    
    ```azurecli
    kubectl delete pod nginx
    ```

7.  Now, re-create the nginx pod by running the following command:
    
    ```azurecli
    kubectl apply -f pod-with-storage-mount.yaml
    ```

8.  Finally, verify that the content of the mount is intact by running the following command:
    
    ```azurecli
    kubectl exec -i nginx -- sh -c "ls /mnt/azure"
    ```

### Delete the resources provisioned in the exercise

In this task, you delete the resources you provisioned in this exercise.

1.  To list and delete the persistent volume claim, from the Bash session in the Azure Cloud Shell, run the following commands:
    
    ```azurecli
    kubectl get pvc
    kubectl delete pvc azure-managed-disk
    ```
    
    > [!NOTE]
    > Alternatively, you could run kubectl delete -f persistent-volume-claim-5g.yaml

2.  To list and delete the storage class, run the following commands:
    
    ```azurecli
    kubectl get sc
    kubectl delete sc managed-premium-retain
    ```
