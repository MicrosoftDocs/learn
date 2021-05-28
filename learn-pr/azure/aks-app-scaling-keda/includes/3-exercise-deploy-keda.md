In this exercise, you'll deploy KEDA to an Azure Kubernetes Service (AKS) cluster to autoscale a sample component for your video rendering service. You'll deploy KEDA with deployment manifests using `kubectl`.  This is one of several options to deploy KEDA. For our purposes, using the default deployment files method is most appropriate.

> [!TIP]
> For more detailed information about installation options view KEDA's [official documentation](https://keda.sh/docs/2.2/deploy/).

## Deploy KEDA

1. Execute the `kubectl get nodes` command to check that you can connect to your cluster and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

    You should receive a list similar to what you see here:

    ```output
    NAME                                STATUS   ROLES   AGE    VERSION
    aks-nodepool1-68128804-vmss000000   Ready    agent   10d   v1.19.9
    ```

2. Use `kubectl` to deploy the KEDA manifest files.

    ```bash
    kubectl apply -f https://github.com/kedacore/keda/releases/download/v2.2.0/keda-2.2.0.yaml
    ```

3. Use `kubectl` to verify the installation of KEDA.

    ```bash
    kubectl get pods --namespace keda
    ```

    You should see something similar to the following:

    ```output
    NAME                                      READY   STATUS    RESTARTS   AGE
    keda-metrics-apiserver-55dc9f9498-qswbh   1/1     Running   0          4m54s
    keda-operator-59dcf989d6-5kqfx            1/1     Running   0          4m53s
    ```

> [!NOTE]
> At this point KEDA is up and running; however, no workload is currently under KEDA scaling control. KEDA still needs to be configured to monitor your workload for scaling.  This will be done in a future step.
