In this exerciste we will deploy a containerized Linux and Windows application on the AKS Edge Essentials cluster.

## Verify AKS Edge Essentials deployment

> [!NOTE]
> The following commands are executed in the PowerShell command line of the VM.

1. Confirm that the deployment was successful by running the following command:

    ```powershell
    kubectl get nodes -o wide
    kubectl get pods -A -o wide
    ```

    The following example output shows the Linux and Windows nodes are ready and the pods are running:

    ```output
    PS C:\Users\azureuser> kubectl get nodes -o wide
    NAME         STATUS   ROLES                       AGE   VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION     CONTAINER-RUNTIME
    myvm-ledge   Ready    control-plane,etcd,master   46m   v1.26.6+k3s-   192.168.0.2   <none>        CBL-Mariner/Linux                5.15.133.1-1.cm2   containerd://1.7.1-k3s1
    myvm-wedge   Ready    <none>                      33m   v1.26.6+k3s-   192.168.0.3   <none>        Windows Server 2022 Datacenter   10.0.20348.2031    containerd://1.7.1-k3s1
    
    PS C:\Users\azureuser> kubectl get pods -A -o wide
    NAMESPACE     NAME                               READY   STATUS    RESTARTS      AGE   IP            NODE         NOMINATED NODE   READINESS GATES
    kube-system   coredns-866448bdfb-8s26b           1/1     Running   0             47m   10.42.0.3     myvm-ledge   <none>           <none>
    kube-system   kube-vip-cloud-provider-ds-n8l6t   1/1     Running   0             46m   10.42.0.2     myvm-ledge   <none>           <none>
    kube-system   kube-vip-ds-rjl8v                  1/1     Running   2 (43m ago)   46m   192.168.0.2   myvm-ledge   <none>           <none>
    ``````

    :::image type="content" source="../media/5-aks-ee-deploysuccess-inline.png" alt-text="Screenshot of Windows VM with powershell commands output demonstrating a successful deployment of AKS Edge Essentials." lightbox="../media/5-aks-ee-deploysuccess-expanded.png":::

## Deploy a Linux application

We will deploy a [sample application](https://github.com/Azure-Samples/azure-voting-app-redis) that is a simple voting app, consisting of a front and back end, which is based on Microsoft's **azure-vote-front** image. The container image for this application is hosted on Azure Container Registry (ACR). See [linux-sample.yaml](https://github.com/Azure/AKS-Edge/blob/main/samples/others/linux-sample.yaml) in the GitHub repo package for the deployment manifest. Note that in the YAML we specified a `nodeSelector` tag as **Linux**.

1. Deploy the application

To deploy your application, use the [kubectl apply][kubectl-apply] command. This command parses the manifest file and creates the defined Kubernetes objects. Specify the YAML manifest file, as shown in the following example:

```powershell
kubectl apply -f  https://raw.githubusercontent.com/Azure/AKS-Edge/main/samples/others/linux-sample.yaml
```

### Step 3: verify the pods

Wait a few minutes for the pods to be in the **running** state:

```powershell
kubectl get pods -o wide
```

<!-- TODO: ADD IMAGE of Running PODS  -->