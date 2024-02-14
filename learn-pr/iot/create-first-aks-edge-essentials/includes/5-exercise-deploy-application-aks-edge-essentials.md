In this exercise, we deploy a containerized Linux and Windows application on the AKS Edge Essentials cluster.

## Verify AKS Edge Essentials deployment

> [!NOTE]
> The following commands are executed in the PowerShell command line of the VM.

1. Confirm that the deployment was successful by running the following command:

    ```powershell
    kubectl get nodes -o wide
    kubectl get pods -A -o wide
    ```

    The following example screenshot shows the Linux and Windows nodes are ready and the pods are running:

    :::image type="content" source="../media/5-aks-edge-deploy-success-inline.png" alt-text="Screenshot of Windows VM with PowerShell commands output demonstrating a successful deployment of AKS Edge Essentials." lightbox="../media/5-aks-edge-deploy-success-expanded.png":::

## Deploy a Linux application

Deploy a [sample application](https://github.com/Azure-Samples/azure-voting-app-redis) that is a simple voting app, consisting of a front and back end, which is based on Microsoft's **azure-vote-front** image. The container image for this application is hosted on Azure Container Registry (ACR). See [linux-sample.yaml](https://github.com/Azure/AKS-Edge/blob/main/samples/others/linux-sample.yaml) in the GitHub repo package for the deployment manifest. In the YAML, we specified a `nodeSelector` tag as **linux**.

1. To deploy your application, use the [kubectl apply](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply) command. This command parses the manifest file and creates the defined Kubernetes objects. Specify the YAML manifest file, as shown in the following example:

    ```powershell
    kubectl apply -f  https://raw.githubusercontent.com/Azure/AKS-Edge/main/samples/others/linux-sample.yaml
    ```

1. Wait a few minutes for the pods to be in the **running** state:

    ```powershell
    kubectl get pods -o wide
    ```

    The following example output shows the application pods are running:

    ```output
    PS C:\Users\azureuser> kubectl get pods -o wide
    NAME                                READY   STATUS    RESTARTS   AGE   IP          NODE         NOMINATED NODE   READINESS GATES
    azure-vote-back-66c88ccc8-fjwfq     1/1     Running   0          46s   10.42.0.6   myvm-ledge   <none>           <none>
    azure-vote-front-85dc674b97-xp8d8   1/1     Running   0          46s   10.42.0.7   myvm-ledge   <none>           <none>
    ```

1. To monitor progress, use the [kubectl get services](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command with the `--watch` parameter:

    ```powershell
    kubectl get services --watch
    ```
    
    Initially, the `EXTERNAL-IP` for the `azure-vote-front` service is shown as `pending`. When the `EXTERNAL-IP` address changes from `pending` to an actual public IP address, you can use the IP address assigned to the service.

    ```output
    PS C:\Users\azureuser> kubectl get services --watch
    NAME               TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
    azure-vote-back    ClusterIP      10.43.208.68   <none>        6379/TCP       4m52s
    azure-vote-front   LoadBalancer   10.43.125.83   192.168.0.4   80:31032/TCP   4m52s
    kubernetes         ClusterIP      10.43.0.1      <none>        443/TCP        16m
    ```

    To stop watching press <kbd>CTRL + C</kbd>.

1. To view the application, open a browser and navigate to the IP address and port assigned to the `azure-vote-front` service. In the previous example, the IP address and port assigned to the service is **192.168.0.4:31032**.

    :::image type="content" source="../media/5-aks-edge-linux-app-inline.png" alt-text="Screenshot of Windows VM with linux sample application running in the browser." lightbox="../media/5-aks-edge-linux-app-expanded.png":::

## Deploy a Windows application

Deploy a sample ASP.NET Core application based on [Microsoft's sample image](https://hub.docker.com/_/microsoft-dotnet-samples/). See [win-sample-aspnetcore.yaml](https://github.com/Azure/AKS-Edge/blob/main/samples/others/win-sample-aspnetcore.yaml) in the GitHub repo package for the deployment manifest. In the YAML, we specified a `nodeSelector` tag as **windows**.

1. Use the [kubectl apply](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply) command to deploy the application:

    ```powershell
    kubectl apply -f https://raw.githubusercontent.com/Azure/AKS-Edge/main/samples/others/win-sample-aspnetcore.yaml
    ```

1. Wait a few minutes for the pod to be in the **running** state:

    ```powershell
    kubectl get pods -o wide
    ```

    The following example output shows the application `sample-aspnetcore-786fb44bb-k449c` pod is running:

    ```output
    PS C:\Users\azureuser> kubectl get pods -o wide
    NAME                                READY   STATUS    RESTARTS   AGE     IP          NODE         NOMINATED NODE   READINESS GATES
    azure-vote-back-66c88ccc8-fjwfq     1/1     Running   0          8m      10.42.0.6   myvm-ledge   <none>           <none>
    azure-vote-front-85dc674b97-xp8d8   1/1     Running   0          8m      10.42.0.7   myvm-ledge   <none>           <none>
    sample-aspnetcore-786fb44bb-k449c   1/1     Running   0          2m56s   10.42.1.3   myvm-wedge   <none>           <none>
    ```

1. Verify that the sample service is running:

    ```powershell
    kubectl get services
    ```

    Then take a note of the `PORT` for the `sample-aspnetcore` service. In this example, it's **31767**.

    ```output
    PS C:\Users\azureuser> kubectl get services
    NAME               TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)         AGE
    azure-vote-back    ClusterIP      10.43.208.68   <none>        6379/TCP        10m52s
    azure-vote-front   LoadBalancer   10.43.125.83   192.168.0.4   80:31032/TCP    10m52s
    kubernetes         ClusterIP      10.43.0.1      <none>        443/TCP         26m
    sample-aspnetcore  NodePort       10.43.237.30   <none>        8080:31767/TCP  6m40s
    ```

1. Retrieve the IP address of the Kubernetes node on which the application is running to append the port of the **NodePort**:

    ```powershell
    Get-AksEdgeNodeAddr -NodeType Windows
    ```

    ```output
    PS C:\Users\azureuser> Get-AksEdgeNodeAddr -NodeType Windows

    [01/16/2024 14:44:22] Querying IP and MAC addresses from virtual machine (myvm-wedge)
    
     - Virtual machine MAC: 00:15:5d:02:7c:eb
     - Virtual machine IP : 192.168.0.3 retrieved directly from virtual machine
    
    Name                           Value
    ----                           -----
    IpAddress                      192.168.0.3
    MacAddress                     00:15:5d:02:7c:eb
    ```

1. To view the application, open a browser and navigate to the IP address and port assigned to the `sample-aspnetcore` service. In the previous example, the IP address and port assigned to the service is **192.168.0.3:31767**.

    :::image type="content" source="../media/5-aks-edge-windows-app-inline.png" alt-text="Screenshot of Windows VM with windows sample application running in the browser." lightbox="../media/5-aks-edge-windows-app-expanded.png":::
